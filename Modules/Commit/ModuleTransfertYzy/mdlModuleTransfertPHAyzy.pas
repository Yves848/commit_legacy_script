unit mdlModuleTransfertPHAyzy;

interface

uses
  Windows, Messages, SysUtils, Classes, Dialogs, mdlAttente, Forms, uibLib,
  mdlProjet, mdlPHA, uib, mdlModule, Ora, OraError, DB, MemDS, DBAccess,
  Variants,
  OraScript, Controls, mdlTypes, uibdataset, mdluibThread, mdlODACThread, Grids,
  StrUtils, XMLIntf, OraCall, DAScript, mydbunit, fbcustomdataset,
  Generics.Collections, uYZYRecords;

type

  TSurAvantSelectionDonnees = procedure(Sender: TObject; ATraitement: TTraitement) of object;

  TtsfProduits = function(pYZYProduct : tYZYPOSTProducts; var Response : tYZYResponse) : pChar; stdcall;
  TFinalizeRestObjects = procedure; stdcall;
  TYZYLogger = procedure (pLog : tYZYLog); stdcall;


  TTraitementTransfert = class(TTraitementBD)
  private
    FAvertissement: Boolean;
    FNouvelID: Boolean;
    FTableCorrespondance: Boolean;
    FFusion: Boolean;
    FTablesAVerifier: TDictionary<string, Integer>;
  public
    property TableCorrespondance: Boolean read FTableCorrespondance write FTableCorrespondance;
    property NouvelID: Boolean read FNouvelID write FNouvelID;
    property Avertissement: Boolean read FAvertissement write FAvertissement;
    property Fusion: Boolean read FFusion write FFusion;
    property TablesAVerifier: TDictionary<string, Integer>read FTablesAVerifier;
    constructor Create(AFichier: string; ATypeTraitement: TTypeTraitement; AGrille: TStringGrid; ALigne: Integer; ALibelle: string);
      override;
    destructor Destroy; override;
    procedure CompleterTraitement(F: TSQLResult); override;
  end;

  TdmModuleTransfertPHAyzy = class(TdmPHA, IRequeteur)
    dbLGPI: TOraSession;
    psLGPI: TOraStoredProc;
    qryTableCorres: TUIBQuery;
    scrLGPI: TOraScript;
    qryErreurs: TOraQuery;
    qryErreursOWNER: TStringField;
    qryErreursNAME: TStringField;
    qryErreursLINE_POSITION: TStringField;
    qryErreursTEXT: TStringField;
    oraqry: TOraQuery;
    script: TOraScript;
    procedure DataModuleCreate(Sender: TObject);
    procedure scrLGPIError(Sender: TObject; E: Exception; SQL: String; var Action: TErrorAction);
    procedure dbLGPIError(Sender: TObject; E: EDAError; var Fail: Boolean);
    procedure DataModuleDestroy(Sender: TObject);
  private
    FDernierMessageErreur: string;
    FSurAvantSelectionDonnees: TSurAvantSelectionDonnees;
    DLLHandle: THandle;
    tsfProduits : TtsfProduits;
    FinalizeRestObjects : TFinalizeRestObjects;
    procedure CompilerObjets;
  protected
    FVersionLGPI: string;
    FRaisonSociale: string;
    FBaseAlteree: Boolean;
  public
    { Déclarations publiques }
    YZYLogger : TYZYLogger;
    property BaseAlteree: Boolean read FBaseAlteree;
    property versionLGPI: string read FVersionLGPI;
    property raisonSociale: string read FRaisonSociale;
    property SurAvantSelectionDonnees: TSurAvantSelectionDonnees read FSurAvantSelectionDonnees write FSurAvantSelectionDonnees;
    function ExecuterPS(AFichierLOG, APS: string; AValeurs: TUIBQuery; AThread: Boolean = False;
      ACommit: Boolean = False): TResultatCreationDonnees; overload;
    function ExecuterPS(AFichierLOG, APS: string; AValeurs: Variant; AThread: Boolean = False;
      ACommit: Boolean = False): TResultatCreationDonnees; overload;
    procedure ConnexionBD; override;
    procedure DeconnexionBD; override;
    function RenvoyerChaineConnexion: string; override;
    procedure SupprimerDonnees(ADonneesASupprimer: TList<Integer>); override;
    function InitialiserTraitement(ATraitement: TTraitementTransfert; Mode: TModeTraitement): Integer;
    procedure VerifierTables(ATables: TDictionary<string, Integer>);
    procedure DePreparerCreationDonnees(ACommit: Boolean); override;
    procedure InstallerDump;
    procedure InitialiserLGPI;
    function RenvoyerDataSet: TDataSet;
    procedure ExecuterScript(AScript: TStrings);
    function RenvoyerTables: TStringList;
    procedure ChargerDataSet(ADataSet: TDataSet; ARequeteSQL: string);
    function GererExceptionDataSet(E: Exception): Exception;
    procedure Commit;
    procedure Rollback;
    function LibererDataSet(ADataSet: TDataSet): Boolean;
    function RenvoyerLignesAffectees(ADataSet: TDataSet): Integer;
    Procedure FreeYzyDll;
    Procedure TransfertProduits;
  end;

var
  dmModuleTransfertPHAyzy: TdmModuleTransfertPHAyzy;

implementation

uses Math, mdlActionTransaction;
{$R *.dfm}

procedure TdmModuleTransfertPHAyzy.DataModuleCreate(Sender: TObject);
var
  s: string;
begin
  inherited;

  // Configuration environnement Oracle
  s := GetEnvironmentVariable('NLS_LANG');
  if s = '' then
    SetEnvironmentVariable('NLS_LANG', PChar('FRENCH_FRANCE.WE8MSWIN1252'));
  // OCIDLL := Module.Projet.RepertoireApplication + '\oci.dll';

  DLLHandle := LoadLibrary('pYzyRest.dll');
  // Assignation des méthodes

  @tsfProduits := GetProcAddress(DLLHandle, 'tsfProduits');
  @FinalizeRestObjects := GetProcAddress(DLLHandle, 'FinalizeRestObject');
  @YZYLogger := GetProcAddress(DLLHandle,'YZYLogger');
  dmModuleTransfertPHAyzy := Self;

  qryTableCorres.Transaction := qryPHA.Transaction;
  qryTableCorres.DataBase := Module.Projet.PHAConnexion;

  Module.Projet.ERPConnexion := dbLGPI;
end;

procedure TdmModuleTransfertPHAyzy.DataModuleDestroy(Sender: TObject);
begin
  FinalizeRestObjects;
//  FreeLibrary(DLLHandle);
  inherited;

end;

procedure TdmModuleTransfertPHAyzy.ConnexionBD;
const
  C_CHAINE_CONNEXION_ORACLE = '%s/%s@%s:1521:PHAL1';

var
  u, req: string;
  errMsg: String;
  OraEx: EOraError;
  cMode : integer;

  function VerifierVersion(var pVersionLGPI: string; pPays: string): Boolean;
  var
    i: Integer;
    VERSIONSLPGI, VERSIONSULTIMATE: TStrings;
    versionTarget,
    versionSource : String;
  begin
    result := False;
    i := 0;
    VERSIONSLPGI := TStringList.Create;
    VERSIONSULTIMATE := TStringList.Create;
    while (i <= Module.Projet.ValidVersions.Count - 1) do
    begin
      if TVersionObject(Module.Projet.ValidVersions.Objects[i]).pays = 'be' then
      begin
        VERSIONSULTIMATE.Add(TVersionObject(Module.Projet.ValidVersions.Objects[i]).Version)
      end
      else
      begin
        VERSIONSLPGI.Add(TVersionObject(Module.Projet.ValidVersions.Objects[i]).Version)
      end;
      inc(i);
    end;

    if pPays = 'FR' then
      for i := 0 to VERSIONSLPGI.Count - 1 do
      begin
        versionTarget := stringreplace(pVersionLGPI,'.','',[rfReplaceAll]);
        versionSource := stringreplace(VERSIONSLPGI[i],'.','',[rfReplaceAll]);

        if Pos(versionSource, versionTarget) > 0 then
        begin
          FVersionLGPI := VERSIONSLPGI[i];
          result := true;
        end;
      end
      else if pPays = 'BE' then
        for i := 0 to VERSIONSULTIMATE.Count - 1 do
        begin
          versionTarget := stringreplace(pVersionLGPI,'.','',[rfReplaceAll]);
          versionSource := stringreplace(VERSIONSULTIMATE[i],'.','',[rfReplaceAll]);
          if Pos(versionSource, versionTarget) > 0 then
          begin
            FVersionLGPI := VERSIONSULTIMATE[i];
            result := true;
          end;
        end;
    VERSIONSLPGI.Free;
    VERSIONSULTIMATE.Free;
  end;

begin
  //
  if uppercase(ParametresConnexion.Values['utilisateur']) = 'MIGRATION' then
    cMode := 0
  else
    cMode := 1;

      Module.Projet.Console.AjouterLigne(' Transfert YZY initialisé ');
end;

procedure TdmModuleTransfertPHAyzy.DeconnexionBD;
begin
  FBaseAlteree := False;
  dbLGPI.Disconnect;

end;

function TdmModuleTransfertPHAyzy.RenvoyerChaineConnexion: string;
begin
  result := ParametresConnexion.Values['serveur']
end;

procedure TdmModuleTransfertPHAyzy.SupprimerDonnees(ADonneesASupprimer: TList<Integer>);
var
  i: TSuppression;
  j: Integer;
begin

end;

procedure TdmModuleTransfertPHAyzy.TransfertProduits;
var
  result : pChar;
  Response : tYZYResponse;
  produit : tYZYPOSTProducts;
begin
  produit.sUrl := 'https://api-france-1.durnal.groupe.pharmagest.com/api/durnal-import/v1/jobs/start/repro-import';
  produit.sFile := 'd:\DB\export_csv_yzy\PRODUITS_2024_03_07-17-02.csv';
  result := tsfProduits(produit,Response);
  Module.Projet.Console.AjouterLigne(format('Id : %s',[Response.id]));

end;

procedure TdmModuleTransfertPHAyzy.VerifierTables(ATables: TDictionary<string, Integer>);
var
  t: TPair<string, Integer>;
begin

end;

function TdmModuleTransfertPHAyzy.ExecuterPS(AFichierLOG, APS: string; AValeurs: TUIBQuery; AThread: Boolean = False;
  ACommit: Boolean = False): TResultatCreationDonnees;
var
  i: Integer;
  s: string;
  ms: TMemoryStream;
begin
  with psLGPI do
  begin
    if not Prepared then
    begin
      StoredProcName := APS;
      Prepare;
    end;

    try
      if Assigned(AValeurs) then
        for i := 0 to Params.Count - 1 do
          if Params[i].ParamType in [ptInput, ptInputOutput] then
            if AValeurs.Fields.ByNameIsNull[Params[i].Name] then
              Params[i].Value := null
            else
              case Params[i].DataType of
                ftString, ftWideString, ftMemo:
                  Params[i].AsString := AValeurs.Fields.ByNameAsString[Params[i].Name];
                ftSmallint, ftInteger, ftWord:
                  Params[i].AsInteger := AValeurs.Fields.ByNameAsInteger[Params[i].Name];
                ftLargeint:
                  Params[i].AsInteger := AValeurs.Fields.ByNameAsInt64[Params[i].Name];
                ftFloat:
                  Params[i].AsFloat := AValeurs.Fields.ByNameAsDouble[Params[i].Name];
                ftDate, ftDateTime, ftTime:
                  Params[i].AsDateTime := AValeurs.Fields.ByNameAsDateTime[Params[i].Name];
                ftBoolean:
                  Params[i].AsBoolean := StrToBool(AValeurs.Fields.ByNameAsString[Params[i].Name]);
                ftOraBlob:
                  if AValeurs.Fields.ByNameIsBlobText[Params[i].Name] then
                  begin
                    AValeurs.ReadBlob(Params[i].Name, s);
                    Params[i].AsOraBlob.LoadFromFile(s);
                  end
                  else
                  begin
                    ms := TMemoryStream.Create;
                    AValeurs.ReadBlob(Params[i].Name, ms);
                    Params[i].AsOraBlob.LoadFromStream(ms);
                    FreeAndNil(ms);
                  end
                  else
                    Params[i].AsString := AValeurs.Fields.ByNameAsString[Params[i].Name];
              end;

      if AThread and Module.Projet.Thread then
      begin
        AttendreFinExecution(Application.MainForm, taLibelle, TThreadPSORA, psLGPI, 'Exécution de ' + APS + ' ...', False);
        if psLGPI.Tag = 1 then
          result := rcdTransferee
        else
          result := rcdErreurSysteme;
      end
      else
      begin
        Execute;

        result := rcdTransferee;
      end;

      if ACommit then
      begin
        Session.Commit;
        UnPrepare;
      end;
    except
      on E: EOraError do
      begin
        CreerErreur(AFichierLOG, E.Message, E.ErrorCode, ieBloquant, AValeurs.Fields);
        result := rcdErreur;
      end;

      on E: Exception do
      begin
        Module.Projet.Console.AjouterLigne(E.Message);
        result := rcdErreurSysteme;
      end;
    end;
  end;
end;

function TdmModuleTransfertPHAyzy.InitialiserTraitement(ATraitement: TTraitementTransfert; Mode: TModeTraitement): Integer;
var
  lResultatInit: Boolean;
  pays: string;
begin

  if Module.pays = 'FR' then
    pays := 'ERP'
  else if Module.pays = 'BE' then
    pays := 'bel';
  lResultatInit := True;
  // Sélection des données
  if not FBaseAlteree and lResultatInit then
  begin
    with qryPHA do
    begin
      Transaction.StartTransaction;
      SQL.Clear;
      SQL.Add('select count(*) from ' + ATraitement.RequeteSelection);
      Open;
      result := qryPHA.Fields.AsInteger[0];
      Close(etmCommitRetaining);

      SQL.Clear;
      SQL.Add('select ps.*, ' + QuotedStr(IfThen(Mode = mtFusion, '1', '0')) + ' AFusion from ' + ATraitement.RequeteSelection + ' ps');
    end;
  end
  else
  begin
    if FBaseAlteree then
      raise EModule.Create('Base altérée !');
    if not lResultatInit then
      raise EModule.Create('Traitement non-initialisé !');
  end;
end;

procedure TdmModuleTransfertPHAyzy.DePreparerCreationDonnees(ACommit: Boolean);
begin
  if ACommit then
    psLGPI.Session.Commit
  else
    psLGPI.Session.Rollback;
  psLGPI.UnPrepare;

  qryPHA.Close(etmCommit);
end;

procedure TdmModuleTransfertPHAyzy.scrLGPIError(Sender: TObject; E: Exception; SQL: String; var Action: TErrorAction);
begin
  inherited;

  Module.Projet.Console.AjouterLigne(SQL + ' : ' + E.Message);
  Action := eaException;
end;

procedure TdmModuleTransfertPHAyzy.InstallerDump;
begin
end;

procedure TdmModuleTransfertPHAyzy.InitialiserLGPI;
begin
  FBaseAlteree := False;
end;

procedure TdmModuleTransfertPHAyzy.dbLGPIError(Sender: TObject; E: EDAError; var Fail: Boolean);
begin
  inherited;

  FDernierMessageErreur := E.Message;
end;

procedure TdmModuleTransfertPHAyzy.CompilerObjets;
begin
  with TOraStoredProc.Create(Self) do
  begin
    Session := dbLGPI;

    StoredProcName := 'compiler_objets';
    Prepare;

    ParamByName('APROPRIETAIRE').AsString := 'BEL';
    Execute;
    ParamByName('APROPRIETAIRE').AsString := 'MIGRATION';
    Execute;

    UnPrepare;
  end;
end;

procedure TdmModuleTransfertPHAyzy.ChargerDataSet(ADataSet: TDataSet; ARequeteSQL: string);
begin
  with oraqry do
  begin
    if Active then
      Close;

    SQL.Text := ARequeteSQL;
    Prepare;
    if not IsQuery then
      ExecSQL
    else
      Open;
  end;
end;

function TdmModuleTransfertPHAyzy.GererExceptionDataSet(E: Exception): Exception;
begin
  result := E;
end;

function TdmModuleTransfertPHAyzy.RenvoyerDataSet: TDataSet;
begin
  if not dbLGPI.Connected or (dbLGPI.Connected and (ParametresConnexion.Values['utilisateur'] = 'system')) then
    with TfrModule(Module.Projet.ModuleTransfert.IHM) do
    begin
      ParametresConnexion.Values['utilisateur'] := 'migration';
      ParametresConnexion.Values['mot_de_passe'] := 'migration';
      Connecter;

      result := oraqry;
    end
    else
      result := oraqry;
end;

function TdmModuleTransfertPHAyzy.RenvoyerTables: TStringList;
var
  i: Integer;
begin
  result := TStringList.Create;
  dbLGPI.GetTableNames(result, true);
  i := 0;
  while i < result.Count do
    if (Pos('BEL', result[i]) = 0) and (Pos('MIGRATION', result[i]) = 0) then
      result.Delete(i)
    else
      inc(i);
end;

procedure TdmModuleTransfertPHAyzy.ExecuterScript(AScript: TStrings);
begin
  if oraqry.Active then
    oraqry.Close;

  with script do
  begin
    SQL.Clear;
    SQL.AddStrings(AScript);
    Execute;
  end;
end;

procedure TdmModuleTransfertPHAyzy.FreeYzyDll;
begin
  FinalizeRestObjects;
  FreeLibrary(DLLHandle);
  inherited;
end;

procedure TdmModuleTransfertPHAyzy.Commit;
begin
  dbLGPI.Commit;
end;

procedure TdmModuleTransfertPHAyzy.Rollback;
begin
  dbLGPI.Rollback;
end;

function TdmModuleTransfertPHAyzy.LibererDataSet(ADataSet: TDataSet): Boolean;
begin
  result := true;
  if dbLGPI.InTransaction then
    case ActionTransaction('LGPI') of
      mrOk:
        Commit;
      mrAbort:
        Rollback;
    else
      result := False;
    end;

  if result then
    if oraqry.Active then
      oraqry.Close;
end;

function TdmModuleTransfertPHAyzy.RenvoyerLignesAffectees(ADataSet: TDataSet): Integer;
begin
  result := TOraQuery(ADataSet).RowsAffected;
end;

function TdmModuleTransfertPHAyzy.ExecuterPS(AFichierLOG, APS: string; AValeurs: Variant; AThread, ACommit: Boolean): TResultatCreationDonnees;
begin
  if not FBaseAlteree then
    with psLGPI do
    begin
      if not Prepared then
      begin
        StoredProcName := APS;
        Prepare;
      end;

      try
        if not VarIsNull(AValeurs) then
          TransfererParametres(AValeurs, Params);

        if AThread and Module.Projet.Thread then
        begin
          AttendreFinExecution(Application.MainForm, taLibelle, TThreadPSORA, psLGPI, 'Exécution de ' + APS + ' ...', False);
          if psLGPI.Tag = 1 then
            result := rcdTransferee
          else
            result := rcdErreurSysteme;
        end
        else
        begin
          Execute;

          result := rcdTransferee;
        end;

        if ACommit then
        begin
          Session.Commit;
          UnPrepare;
        end;
      except
        on E: Exception do
        begin
          Module.Projet.Console.AjouterLigne(E.Message);
          result := rcdErreurSysteme;
        end;
      end;
    end;
end;

{ TTraitementTransfert }

procedure TTraitementTransfert.CompleterTraitement(F: TSQLResult);
var
  l: TStringList;
  i: Integer;
begin
  TableCorrespondance := not F.ByNameIsNull['TABLE_CORRESPONDANCE'];
  Fusion := F.ByNameAsString['FUSION'] = '1';

  // Récupération des tables à vérifier avant transfert
  l := TStringList.Create;
  ExtractStrings([';'], [], PChar(F.ByNameAsString['TABLES_A_VERIFIER']), l);
  for i := 0 to l.Count - 1 do
    FTablesAVerifier.Add(l[i], 0);
  FreeAndNil(l);
end;

constructor TTraitementTransfert.Create(AFichier: string; ATypeTraitement: TTypeTraitement; AGrille: TStringGrid; ALigne: Integer;
  ALibelle: string);
begin
  inherited;

  FTablesAVerifier := TDictionary<string, Integer>.Create;

end;

destructor TTraitementTransfert.Destroy;
begin
  if Assigned(FTablesAVerifier) then
    FreeAndNil(FTablesAVerifier);

  inherited;
end;

end.
