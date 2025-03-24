unit mdlPHA;

interface

uses
  SysUtils, Classes, mdlProjet, JvComponent, JvComponentBase, DB, Forms,
  Variants, mdlTypes, mdlAttente, Dialogs, StrUtils, Math, mdlUIBThread,
  UIB, UIBDataSet, UIBase, UIBSQLParser, UIBLib, mydbUnit, FBCustomDataSet, Generics.Collections;

type
  IRequeteur = interface
    ['{ED1846AE-61DE-47AE-B120-E438341D3859}']
    function RenvoyerDataSet : TDataSet;
    function RenvoyerTables : TStringList;
    procedure ChargerDataSet(ADataSet : TDataSet; ARequeteSQL : string);
    function RenvoyerLignesAffectees(ADataSet : TDataSet) : Integer;
    procedure ExecuterScript(AScript : TStrings);
    procedure Commit;
    procedure Rollback;
    function GererExceptionDataSet(E : Exception) : Exception;
    function LibererDataSet(ADataSet : TDataSet) : Boolean;
  end;

  TLibelleDonneesASupprimer = array[TSuppression] of string;

  TdmPHA = class(TDataModule)
    setErreurs: TUIBDataSet;
    trErreurs: TUIBTransaction;
    qry: TUIBQuery;
    setDonnees: TUIBDataSet;
    setErreursAOCCURENCE: TIntegerField;
    setErreursAMESSAGE: TWideStringField;
    setErreursAMESSAGESQL: TWideStringField;
    setDonneesDONNEES: TWideMemoField;
    setDonneesINSTRUCTION: TWideMemoField;
    procedure DataModuleCreate(Sender: TObject);
    procedure setErreursAfterScroll(DataSet: TDataSet);
    procedure setErreursBeforeClose(DataSet: TDataSet);
  private
    FModule: TModule;
    FParametresThreadRequeteFB : TParametresThreadRequeteFB;
    FqryPHA: TUIBQuery;
    FqryErreur: TUIBQuery;
    FParametresConnexion: TStringList;
  protected
    const LibelleDonneesASupprimer : TLibelleDonneesASupprimer = ('paramètres', 'praticiens', 'organismes', 'clients', 'produits', 'encours', 'données avantages', 'données location', 'historiques');
  public
    { Déclarations publiques }
    property Module : TModule read FModule;
    property ParametresConnexion : TStringList read FParametresConnexion;
    property qryPHA: TUIBQuery read FqryPHA;
    procedure ConnexionBD; virtual; abstract;
    function RenvoyerChaineConnexion : string; virtual; abstract;
    procedure DeconnexionBD; virtual; abstract;
    property ParametresThreadRequeteFB : TParametresThreadRequeteFB read FParametresThreadRequeteFB;
    constructor Create(Aowner : TComponent; AModule : TModule); reintroduce; virtual;
    destructor Destroy; override;
    procedure CreerErreur(AFichier,
      AMessageErreurSQL: string; ACodeErreurSQL: Integer;
      AImportance: TImportanceErreur; ADonnees: TSQLDA);
    procedure SupprimerDonnees(ADonneesASupprimer: TList<Integer>); virtual; abstract;
    function ExecuterPS(AFichierLOG, APS : string; AValeurs : Variant;
      AThread : Boolean = False; ACommit : TEndTransMode = etmStayIn) : TResultatCreationDonnees; overload;
    function ExecuterPS(AFichierLOG, APS : string; AValeurs : TFields; ACommit : TEndTransMode = etmStayIn;
      ARaiseErrSys : Boolean = False) : TResultatCreationDonnees; overload;
    procedure DePreparerCreationDonnees(ACommit: Boolean); virtual;
  end;
  TdmPHAClasse = class of TdmPHA;

  procedure AjouterWhere(AChaineSQL: TStrings; AWhere: string);
  

const
  C_CHAINE_CONNEXION_WINPHARMA = 'DRIVER=WinPharma;Channel=%s;UID=%s;PWD=%s';

var
  dmPHA : TdmPHA;

implementation

{$R *.dfm}

uses
  mdlModule;

procedure AjouterWhere(AChaineSQL: TStrings; AWhere: string);
var
  lIntPosWhere, lIntFin, lIntPosGroupBy, lIntPosOrderBy : Integer;
begin
  // Repérage
  lIntPosWhere := Pos('where', LowerCase(AChaineSQL.Text));
  lIntPosGroupBy := Pos('group by', LowerCase(AChaineSQL.Text));
  lIntPosOrderBy := Pos('order by', LowerCase(AChaineSQL.Text));

  if (lIntPosOrderBy = 0) and (lIntPosGroupBy > 0) then lIntFin := lIntPosGroupBy
  else
    if (lIntPosOrderBy > 0) and (lIntPosGroupBy = 0) then lIntFin := lIntPosOrderBy
    else
      lIntFin := Min(lIntPosOrderBy, lIntPosGroupBy);

  if lIntPosWhere = 0 then
    if lIntFin = 0 then
      lIntPosWhere := Length(AChaineSQL.Text) + 1
    else
      lIntPosWhere := lIntFin;

  // Changement du SQL
  if AWhere = '' then
  begin
    if lIntFin > 0 then
      AChaineSQL.Text := Copy(AChaineSQL.Text, 1, lIntPosWhere -1) + Copy(AChaineSQL.Text, lIntFin, Length(AChaineSQL.Text));
  end
  else
    if lIntFin > 0 then
      AChaineSQL.Text := Copy(AChaineSQL.Text, 1, lIntPosWhere - 1) + IfThen(AWhere <> '', ' where ' + AWhere) + ' ' + Copy(AChaineSQL.Text, lIntFin, Length(AChaineSQL.Text))
    else
      AChaineSQL.Text := Copy(AChaineSQL.Text, 1, lIntPosWhere - 1) + ' where ' + AWhere;
end;

{ TdmPHA }

constructor TdmPHA.Create(Aowner: TComponent; AModule: TModule);
begin
  FModule := AModule;

  inherited Create(Aowner);

  dmPHA := Self;
end;

destructor TdmPHA.Destroy;
begin
  if Assigned(FParametresConnexion) then FreeAndNil(FParametresConnexion);
  if Assigned(FqryErreur) then FreeAndNil(FqryErreur);
  if Assigned(FqryPHA) then FreeAndNil(FqryPHA);

  inherited;
end;

procedure TdmPHA.DataModuleCreate(Sender: TObject);
begin
  if not FModule.Projet.PHAConnexion.Connected then
    raise Exception.Create('Aucune connection Firebird 2.x trouvée !')
  else
  begin
    FParametresConnexion := TStringList.Create;
    FParametresThreadRequeteFB := TParametresThreadRequeteFB.Create(FModule.Projet.PHAConnexion, '', 0);

    // Objets requetes permanent
    FqryErreur := TUIBQuery.Create(nil);
    FqryErreur.DataBase := FModule.Projet.PHAConnexion;
    FqryErreur.Transaction := TUIBTransaction.Create(nil);
    FqryErreur.Transaction.DataBase := FModule.Projet.PHAConnexion;
    FqryErreur.Transaction.AutoStart := False;
    FqryErreur.Transaction.AutoStop := False;
    FqryErreur.Transaction.StartTransaction;
    FqryErreur.BuildStoredProc('PS_ERREUR');
    FqryErreur.Transaction.Commit;

    FqryPHA := TUIBQuery.Create(nil);
    FqryPHA.DataBase := FModule.Projet.PHAConnexion;
    FqryPHA.Transaction := TUIBTransaction.Create(nil);
    FqryPHA.Transaction.DataBase := FModule.Projet.PHAConnexion;
    FqryPHA.OnError := etmStayIn;
    FqryPHA.Transaction.AutoStart := False;
    FqryPHA.Transaction.AutoStop := False;
    FqryPHA.FetchBlobs := True;
  end;

  trErreurs.Database := FModule.Projet.PHAConnexion;
  qry.DataBase := FModule.Projet.PHAConnexion;
  setErreurs.Database := FModule.Projet.PHAConnexion;
  setDonnees.Database := FModule.Projet.PHAConnexion;
end;

procedure TdmPHA.CreerErreur(AFichier,
  AMessageErreurSQL: string; ACodeErreurSQL: Integer;
  AImportance: TImportanceErreur; ADonnees: TSQLDA);
const
  C_VALEUR_CHAMP_XML = '<donnee nom="%s" valeur="%s"/>'#13#10;
var
  s : string;
  lStrDonnees, lStrInstr : string;
  v : Variant;
  i : Integer;

  function FiltrerChaine(AFiltre : TSysCharSet; AChaine : string) : string;
  var
    i : Integer;
  begin
    for i := 1 to Length(AChaine) do
      if CharInSet(AChaine[i], AFiltre) then
        AChaine[i] := #32;
    Result := AChaine;
  end;

begin
  lStrDonnees := '';
  if Assigned(ADonnees) then
  begin
    if ADonnees is TSQLResult then
      for i := 0 to ADonnees.FieldCount - 1 do
        if not ADonnees.IsBlob[i] then
        begin
          s := FiltrerChaine(['"', '&'], ADonnees.AsString[i]);
          lStrDonnees := lStrDonnees + Format(C_VALEUR_CHAMP_XML, [(ADonnees as TSQLResult).SQLName[i],
                                                                   ifThen(ADonnees.IsNull[i], '{NULL}', s)]);
        end;

    if ADonnees is TSQLParams then
      for i := 0 to ADonnees.FieldCount - 1 do
        if not ADonnees.IsBlob[i] then
        begin
          s := FiltrerChaine(['"', '&'], ADonnees.AsString[i]);
          lStrDonnees := lStrDonnees + Format(C_VALEUR_CHAMP_XML, [(ADonnees as TSQLParams).FieldName[i],
                                                                   ifThen(ADonnees.IsNull[i], '{NULL}', s)]);
        end;
  end;

  lStrInstr := qryPHA.SQL.Text;
  for i := 0 to qryPHA.Params.ParamCount - 1 do
  begin
    if qryPHA.Params.IsNull[i] then
      v := 'null'
    else
      case qryPHA.Params.SQLType[i] of
        SQL_TEXT, SQL_VARYING :
          v := QuotedStr(qryPHA.Params.AsString[i]);
        SQL_SHORT, SQL_LONG :
          v := qryPHA.Params.AsInteger[i];
        SQL_INT64 :
          v := qryPHA.Params.AsInt64[i];
        SQL_FLOAT, SQL_DOUBLE, SQL_D_FLOAT :
          v := StringReplace(FloatToStr(qryPHA.Params.AsDouble[i]), ',', '.', [rfReplaceAll]);
        SQL_TYPE_DATE, SQL_TYPE_TIME, SQL_TIMESTAMP :
          v := QuotedStr(FormatDateTime('YYYY-MM-DD', qryPHA.Params.AsDateTime[i]));
      else
        v := QuotedStr(qryPHA.Params.AsString[i]);
      end;

    lStrInstr := StringReplace(lStrInstr, ':' + qryPHA.Params.FieldName[i], v, [rfReplaceAll]);
  end;

  with FqryErreur do
  begin
    Transaction.StartTransaction;
    Params.ByNameAsString['AFICHIER'] := AFichier;
    Params.ByNameAsString['ATYPEERREUR'] := IntToStr(Ord(FModule.Projet.ModuleEnCours.TypeModule));
    Params.ByNameAsString['AMESSAGEERREURSQL'] := AMessageErreurSQL;
    Params.ByNameAsInteger['ACODEERREURSQL'] := ACodeErreurSQL;
    Params.ByNameAsString['AIMPORTANCE'] := IntToStr(Ord(AImportance));
    ParamsSetBlob('ADONNEES', lStrDonnees);
    ParamsSetBlob('AINSTRUCTION', lStrInstr);
    Execute;
    Close(etmCommit);
  end;
end;

function TdmPHA.ExecuterPS(AFichierLOG, APS: string;
  AValeurs : Variant; AThread : Boolean = False; ACommit : TEndTransMode = etmStayIn): TResultatCreationDonnees;
var
  i, lIntNombreParametres : Integer;
  s : string;
  b : TFileStream;

  function RenvoyerFlux(AAdresse : Variant) : TFileStream;
  var
    i : Integer;
  begin
    if VarIsNull(AAdresse) then
      Result := nil
    else
    begin
      i := VarAsType(AAdresse, varLongWord);
      Result := TFileStream(Ptr(i)^);
    end;
  end;

begin
  lIntNombreParametres := -1;
  Result := rcdImportee;
  try
    // Thread
    if AThread and FModule.Projet.Thread then
    begin
      if not VarIsNull(AValeurs) then
        lIntNombreParametres := VarArrayHighBound(AValeurs, 1);

      with ParametresThreadRequeteFB do
      begin
        NomProcedure := APS;
        NombreParametresProc := lIntNombreParametres + 1;
        for i := 0 to lIntNombreParametres do
          ParametresProc[i] := AValeurs[i];

        AttendreFinExecution(Application.MainForm, taLibelle, TThreadRequeteFB, ParametresThreadRequeteFB, 'Exécution de ' + APS + ' ...');
        if not Erreur.Etat then
          raise Exception.Create(Erreur.Message);
      end;
    end
    // Pas thread
    else
      with qryPHA do
      begin
        // Préparation
        if (CurrentState < qsPrepare) or (Pos(APS, SQL.Text) = 0) or not Transaction.InTransaction then
        begin
          Transaction.StartTransaction;
          BuildStoredProc(APS, False);
          Prepare;
        end;

        // Paramètrage
        TransfererParametres(AValeurs, Params);

        // Traitement des BLOBS
        for i := 0 to Params.ParamCount - 1 do
          if Params.IsBlob[i] then
          begin
            b := RenvoyerFlux(AValeurs[i]);
            if Assigned(b) then
              ParamsSetBlob(i, b);
          end;

        // Execution
        Execute;
        if ACommit <> etmStayIn then
          Close(etmCommit);
        Result := rcdImportee;
      end;
  except
    on E:EUIBError do
    begin
      if AFichierLOG <> '' then
        CreerErreur(AFichierLOG, E.Message, E.SQLCode, ieBloquant, qryPHA.Params);
      Result := rcdErreur;
    end;

    on E:Exception do
    begin
      FModule.Projet.Console.AjouterLigne('/********************************/');
      FModule.Projet.Console.AjouterLigne('Procédure : ' + APS);
      FModule.Projet.Console.AjouterLigne(E.ClassName + ' : ' + E.Message);
      if not (AThread and FModule.Projet.Thread) then lIntNombreParametres := qryPHA.Params.ParamCount;
      if lIntNombreParametres > 0 then
      begin
        FModule.Projet.Console.AjouterLigne('Données en cours de traitement :');
        for i := 0 to lIntNombreParametres - 1 do
        begin
          if VarIsNull(AValeurs[i]) then
            s := '{NULL}'
          else
            s := VarAsType(AValeurs[i], varString);
          FModule.Projet.Console.AjouterLigne('Valeur ' + IntToStr(i) + ' = ' + s);
        end;
        FModule.Projet.Console.AjouterLigne('/********************************/');
      end;

      if E is EVariantError then
        Result := rcdErreur
      else
        Result := rcdErreurSysteme;
    end;
  end;
end;

function TdmPHA.ExecuterPS(AFichierLOG, APS: string;
  AValeurs: TFields; ACommit : TEndTransMode = etmStayIn;
  ARaiseErrSys : Boolean = False): TResultatCreationDonnees;
var
  i : Integer;
  //lFlux : TMemoryStream;
begin
  try
    with qryPHA do
    begin
      // Préparation
      if (CurrentState < qsPrepare) or (Pos(APS, SQL.Text) = 0) or not Transaction.InTransaction then
      begin
        Transaction.StartTransaction;
        BuildStoredProc(APS, False);
        Prepare;
      end;

      // Paramètrage
      TransfererParametres(AValeurs, Params);

      // Traitement des BLOBS
      //lFlux := TMemoryStream.Create;
      for i := 0 to AValeurs.Count - 1 do
        if AValeurs[i].IsBlob then
        begin
          if AValeurs[i].DataType in [ftMemo, ftWideMemo] then
            if Params.IsBlob[i] then
              ParamsSetBlob(i, AValeurs[i].AsString)
            else
              Params.AsString[i] := AValeurs[i].AsString
          else
          begin
            TBlobField(AValeurs[i]).SaveToFile(Module.Projet.RepertoireProjet + 'blob\' + FormatDateTime('DDMMYYYYhhnn', Date));
            //ParamsSetBlob(i, lFlux);
          end;
        end;
      //FreeAndNil(lFlux);

      // Execution
      Execute;
      Result := rcdImportee;
    end;
  except
    on E:EUIBError do
    begin
      CreerErreur(AFichierLOG, E.Message, E.SQLCode, ieBloquant, qryPHA.Params);
      Result := rcdErreur;
    end;

    on E:Exception do
    begin
      FModule.Projet.Console.AjouterLigne('/********************************/');
      FModule.Projet.Console.AjouterLigne('Procédure : ' + APS);
      FModule.Projet.Console.AjouterLigne(E.ClassName + ' : ' + E.Message);
      FModule.Projet.Console.AjouterLigne('Données en cours de traitement :');
//      for i := 0 to ParamCount - 1 do
      for i := 0 to AValeurs.Count - 1 do
        FModule.Projet.Console.AjouterLigne(AValeurs[i].FieldName + ' = <' + AValeurs[i].AsString + '>');
      FModule.Projet.Console.AjouterLigne('/********************************/');

      if ARaiseErrSys then
        raise
      else
        if E is EVariantError then
          Result := rcdErreur
        else
          Result := rcdErreurSysteme;
    end;
  end;
end;

procedure TdmPHA.setErreursAfterScroll(DataSet: TDataSet);
begin
  setErreursBeforeClose(nil);

  setDonnees.Params.ByNameAsInteger['AFICHIERID'] := setErreurs.Params.ByNameAsInteger['AFICHIERID'];
  setDonnees.Params.ByNameAsString['AMESSAGE'] := setErreursAMESSAGESQL.AsString;
  setDonnees.Open;
end;

procedure TdmPHA.setErreursBeforeClose(DataSet: TDataSet);
begin
  if setDonnees.Active then
    setDonnees.Close;
end;

procedure TdmPHA.DePreparerCreationDonnees(ACommit: Boolean);
begin
  FModule.Projet.FichierProjet.SaveToFile;
  if qryPHA.Transaction.InTransaction then
    if ACommit then
      qryPHA.Close(etmCommit)
    else
      qryPHA.Close(etmRollback);
end;

end.
