unit mdlTransfertUltimatePHA;

interface

uses
  Windows, Messages, SysUtils, Classes, Dialogs, mdlAttente, Forms, uibLib,
  mdlProjet, mdlPHA, uib, mdlModule, Ora, OraError, DB, MemDS, DBAccess, Variants,
  OraScript, Controls, mdlTypes, uibdataset, mdluibThread, mdlODACThread, mdlModuleTransfertPHA,
  StrUtils, XMLIntf, OraCall, DAScript, mydbunit, fbcustomdataset, Generics.Collections;

type
  TdmTransfertUltimatePHA = class(TdmModuleTransfertPHA)
    procedure DataModuleCreate(Sender: TObject);
    procedure scrLGPIError(Sender: TObject; E: Exception; SQL: String;
      var Action: TErrorAction);
    procedure dbLGPIError(Sender: TObject; E: EDAError; var Fail: Boolean);
  private
    FDernierMessageErreur : string;
    FBaseAlteree: Boolean;
    procedure CompilerObjets;
  public
    { Déclarations publiques }
    property BaseAlteree : Boolean read FBaseAlteree;
    function ExecuterPS(AFichierLOG, APS: string; AValeurs: TSQLDA;
      AThread: Boolean = False; ACommit: Boolean = False) : TResultatCreationDonnees; overload;
    function ExecuterPS(AFichierLOG, APS: string; AValeurs: Variant;
      AThread: Boolean = False; ACommit: Boolean = False) : TResultatCreationDonnees; overload;
    procedure CompleterInfoTraitements(ATraitements : TTraitements);
    function ConnexionLGPI(AChaineConnexion: string; ANet : Boolean): Boolean;
    procedure DeconnexionLGPI;
    procedure SupprimerDonnees(ADonneesASupprimer : TList<Integer>); override;
    procedure InitialiserTraitement(ATraitement : TTraitementTransfertUltimate;
      Mode : TModeTraitement);
    function FaireTraitementDonnees(ATraitement : TTraitementTransfertUltimate) : TResultatCreationDonnees;
    procedure DePreparerCreationDonnees(ACommit: Boolean); override;
    procedure InstallerScriptsSQL(var AScriptsSQL : string);
    procedure InstallerDump;
    procedure InitialiserLGPI;
    procedure AfficherErreurs;
    function RenvoyerDataSet : TDataSet;
    procedure ExecuterScript(AScript : TStrings);
    function RenvoyerTables : TStringList;
    procedure ChargerDataSet(ADataSet : TDataSet; ARequeteSQL : string);
    function GererExceptionDataSet(E : Exception) : Exception;
    procedure Commit;
    procedure Rollback;
    function LibererDataSet(ADataSet : TDataSet) : Boolean;
    function RenvoyerLignesAffectees(ADataSet : TDataSet) : Integer;
  end;

var
  dmTransfertUltimatePHA: TdmTransfertUltimatePHA;

implementation

uses Math, mdlActionTransaction, mdlTransfertUltimateErreursOracle;

{$R *.dfm}

procedure TdmTransfertUltimatePHA.DataModuleCreate(Sender: TObject);
var
  s : string;
begin
  inherited;

  // Configuration environnement Oracle
  s := GetEnvironmentVariable('NLS_LANG');
  if s = '' then
    SetEnvironmentVariable('NLS_LANG', PChar('FRENCH_FRANCE.WE8MSWIN1252'));
  OCIDLL := Module.Projet.RepertoireApplication + '\oci.dll';

  dmTransfertUltimatePHA := Self;

  qryTableCorres.Transaction := qryPHA.Transaction;
  qryTableCorres.DataBase := Module.Projet.PHAConnexion;
  qryBL.Transaction := qryPHA.Transaction;
  qryBL.Database := Module.Projet.PHAConnexion;

  Module.Projet.ERPConnexion := dbLGPI;
end;

procedure TdmTransfertUltimatePHA.CompleterInfoTraitements(ATraitements: TTraitements);
var
  lTraitement : TTraitementTransfertUltimate;
begin
  with qryPHA do
  begin
    Transaction.StartTransaction;
    SQL.Clear;
    SQL.Add('select *');
    SQL.Add('from v_TransfertUlti_traitement');
    Open;

    while not EOF do
    begin
      lTraitement := TTraitementTransfertUltimate(ATraitements.Traitements[Fields.ByNameAsString['NOM_FICHIER']]);
      if Assigned(lTraitement) then
      begin
        lTraitement.Index := Fields.ByNameAsInteger['T_TransfertUlti_TRAITEMENT_ID'];
        lTraitement.ProcedureSelection := Fields.ByNameAsString['PROCEDURE_SELECTION'];
        lTraitement.ProcedureCreation := Fields.ByNameAsString['PROCEDURE_CREATION'];
        lTraitement.TableCorrespondance := not Fields.ByNameIsNull['TABLE_CORRESPONDANCE'];
        lTraitement.Fusion := Fields.ByNameAsString['FUSION'] = '1';
      end;
      Next;
    end;

    Close(etmCommit);
  end;
end;

function TdmTransfertUltimatePHA.ConnexionLGPI(AChaineConnexion: string; ANet : Boolean): Boolean;
begin
  with dbLGPI do
  begin
    try
      if Connected then
        Disconnect;

      if AChaineConnexion <> '' then
      begin
        Options.Net := ANet;
        ConnectString := AChaineConnexion;
      end;
      Connect;

      if Copy(OracleVersion, 1, 2) <> '10' then
        raise Exception.Create('Version inférieure à 10g non-supportée !')
      else
      begin
        Result := True;
        FBaseAlteree := False;
      end;
    except
      on E:EOraError do
      begin
        MessageDlg('Impossible de se connecter à la base Ultimate !'#13#10#13#10 +
                   'Message : ' + E.Message + #13#10 +
                   'Erreur : ' + IntToStr(E.ErrorCode),
                   mtError, [mbOk], 0);

        Result := False;
      end;

      on E:Exception do
      begin
        MessageDlg('Impossible de se connecter à la base Ultimate !'#13#10#13#10 +
                   'Message : ' + E.Message + #13#10,
                   mtError, [mbOk], 0);

        Result := False;
      end;
    end;
  end;
end;

procedure TdmTransfertUltimatePHA.SupprimerDonnees(ADonneesASupprimer: TList<Integer>);
const
  C_LIBELLE_DONNEES_A_SUPPRIMER : array[TSuppression] of string = ('paramètres', 'praticiens', 'organismes', 'clients', 'produits', 'encours', 'données avantages', 'données location', 'historiques');
var
  i : TSuppression;
  j : Integer;
begin
  if not FBaseAlteree then
  begin
    if not dbLGPI.Connected then
      with (Module.Projet.ModuleEnCours.IHM as TfrModule) do
      begin
        ParametresConnexion.Values['utilisateur'] := 'migration';
        ParametresConnexion.Values['mot_de_passe'] := 'migration';
        Connecter;
      end;

    if ADonneesASupprimer.Count = 0 then
      for i := Low(TSuppression) to High(TSuppression) do
        ADonneesASupprimer.Add(Ord(i))
    else
    begin
      j := ADonneesASupprimer.IndexOf(Ord(suppEnCours));
      if (j <> -1) and (ADonneesASupprimer.IndexOf(Ord(suppHistoriques)) <> -1) then
        ADonneesASupprimer[j] := -1;
    end;

    with psLGPI do
    begin
      StoredProcName := 'pk_supprimerdonnees.supprimer_donnees';
      Prepare;

      for j := 0 to ADonneesASupprimer.Count - 1 do
        if ADonneesASupprimer[j] <> -1 then
        begin
          ParamByName('ATYPESUPPRESSION').AsInteger := ADonneesASupprimer[j];
          if Module.Projet.Thread then
            AttendreFinExecution(Self, taLibelle, TThreadPSORA, psLGPI, 'Suppression des ' + C_LIBELLE_DONNEES_A_SUPPRIMER[TSuppression(ADonneesASupprimer[j])] + ' ...')
          else
          begin
            ExecProc;
            Tag := 1;
          end;

          if psLGPI.Tag <> 0 then
          begin
            CompilerObjets;
            Application.ProcessMessages;
          end
          else
          begin
            Session.Rollback;
            if psLGPI.Prepared then
              psLGPI.UnPrepare;
            raise Exception.Create('Echec de la suppression !');
          end;
        end;

      if psLGPI.Tag = 1 then
      begin
        Session.Commit;
        psLGPI.UnPrepare;
      end;
    end;
  end
  else
    MessageDlg('Base ERP altérée : impossible d''effectuer le transfert !', mtError, [mbOk], 0);
end;

function TdmTransfertUltimatePHA.ExecuterPS(AFichierLOG, APS: string; AValeurs: TSQLDA;
  AThread: Boolean = False; ACommit: Boolean = False): TResultatCreationDonnees;
var
  i : Integer;
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
            if AValeurs.ByNameIsNull[Params[i].Name] then
              Params[i].Value := null
            else
              case Params[i].DataType of
                ftString, ftMemo :
                  Params[i].AsString := AValeurs.ByNameAsString[Params[i].Name];
                ftSmallint, ftInteger, ftWord :
                  Params[i].AsInteger := AValeurs.ByNameAsInteger[Params[i].Name];
                ftLargeint :
                  Params[i].AsInteger := AValeurs.ByNameAsInt64[Params[i].Name];
                ftFloat :
                  Params[i].AsFloat := AValeurs.ByNameAsDouble[params[i].Name];
                ftDate, ftDateTime, ftTime :
                  Params[i].AsDateTime := AValeurs.ByNameAsDateTime[Params[i].Name];
                ftBoolean :
                  Params[i].AsBoolean := StrToBool(AValeurs.ByNameAsString[Params[i].Name]);
              else
                Params[i].AsString := AValeurs.ByNameAsString[Params[i].Name];
              end;

      if AThread and Module.Projet.Thread then
      begin
        AttendreFinExecution(Application.MainForm, taLibelle, TThreadPSORA, psLGPI, 'Exécution de ' + APS + ' ...', False);
        if psLGPI.Tag = 1 then
          Result := rcdTransferee
        else
          Result := rcdErreurSysteme;
      end
      else
      begin
        Execute;

        Result := rcdTransferee;
      end;

      if ACommit then
      begin
        Session.Commit;
        UnPrepare;
      end;
    except
      on E:EOraError do
      begin
        CreerErreur(AFichierLOG, E.Message, E.ErrorCode, ieBloquant, AValeurs);
        Result := rcdErreur;
      end;

      on E:Exception do
      begin
        Module.Projet.Console.Ajouter(E.Message);
        Result := rcdErreurSysteme;
      end;
    end;
  end;
end;

procedure TdmTransfertUltimatePHA.InitialiserTraitement(
  ATraitement: TTraitementTransfertUltimate; Mode : TModeTraitement);
var
  lResultatInit : Boolean;
begin
  // Initialisation
  if Module.Projet.Thread then
  begin
    ParametresThreadRequeteFB.NomProcedure := 'ps_TransfertUlti_init_trait';
    ParametresThreadRequeteFB.NombreParametresProc := 2;
    ParametresThreadRequeteFB.ParametresProc[0] := ATraitement.Index;
    ParametresThreadRequeteFB.ParametresProc[1] := IntToStr(Ord(Mode = mtMAJ));
    lResultatInit := AttendreFinExecution(Application.MainForm, taLibelle, TThreadRequeteFB, ParametresThreadRequeteFB, 'Préparation au transfert des données ' + ATraitement.Fichier);

    lResultatInit := ParametresThreadRequeteFB.Erreur.Etat;
  end
  else
    with qryPHA do
      try
        Transaction.StartTransaction;
        BuildStoredProc('ps_TransfertUlti_init_trait');
        Params.ByNameAsInteger['ATRAITEMENTID'] := ATraitement.Index;
        Params.ByNameAsString['AMISEAJOUR'] := IntToStr(Ord(Mode = mtMAJ));
        Execute;
        Close(etmCommit);
        lResultatInit := True;
      except
        on E:Exception do
        begin
          Close(etmRollback);
          Module.Projet.Console.AjouterLigne(E.Message);
          lResultatInit := False;
        end;
      end;

  // Sélection des données
  if lResultatInit then
  begin
    with qryBL do
    begin
      Transaction.StartTransaction;
      SQL.Clear;
      SQL.Add('select ps.*, ' + QuotedStr(IfThen(Mode = mtFusion, '1', '0')) + ' AFusion from ' + ATraitement.ProcedureSelection + ' ps');
      Open;
    end;

    // Préparation procédure de corres
    if ATraitement.TableCorrespondance then
       qryTableCorres.BuildStoredProc('PS_TRANSFERTULTI_CREER_CORRES');

    // LGPI

    if not dbLGPI.Connected then
      with (Module.Projet.ModuleEnCours.IHM as TfrModule) do
      begin
        ParametresConnexion.Values['utilisateur'] := 'migration';
        ParametresConnexion.Values['mot_de_passe'] := 'migration';
        Connecter;
      end;

    with psLGPI do
      if not Prepared then
      begin
        SQL.Clear;
        StoredProcName := ATraitement.ProcedureCreation;
        Prepare;

        ATraitement.NouvelID := Assigned(FindParam('RESULT'));
        ATraitement.Avertissement := Assigned(FindParam('ACODEAVERTISSEMENT'));
      end;
  end
  else
    raise EModule.Create('Traitement non-initialisé !');
end;

procedure TdmTransfertUltimatePHA.DePreparerCreationDonnees(ACommit: Boolean);
begin
  if ACommit then
    psLGPI.Session.Commit
  else
    psLGPI.Session.Rollback;
  psLGPI.UnPrepare;

  qryPHA.Close(etmCommit);
end;

function TdmTransfertUltimatePHA.FaireTraitementDonnees(
  ATraitement: TTraitementTransfertUltimate): TResultatCreationDonnees;
begin
  if not FBaseAlteree then
  begin
    Result := ExecuterPS(ATraitement.Fichier,
                         ATraitement.ProcedureCreation,
                         qryPHA.Fields, False, ATraitement.Succes mod 20000 = 0);

    // Gestion du résultat
    if ATraitement.NouvelID then
      with psLGPI do
        if (Result = rcdTransferee) and ATraitement.TableCorrespondance and not ParamByName('RESULT').IsNull then
        begin
          qryTableCorres.Params.ByNameAsString['ACODEBASEPHA'] := qryPHA.Fields.AsString[0];
          qryTableCorres.Params.ByNameAsInteger['ACODEBASEULTI'] := ParamByName('RESULT').AsInteger;
          qryTableCorres.ExecSQL;

          if ATraitement.Avertissement then
          begin
            //CreerErreur(ATraitement.Fichier, , 100 + ATraitement.Index, ieBloquant, AValeurs);
          end;
        end;
  end
  else
  begin
    MessageDlg('Base ERP altérée : impossible d''effectuer le transfert !', mtError, [mbOk], 0);
    Result := rcdErreurSysteme;
  end;
end;

{ TTraitementLGPI }

procedure TTraitementTransfertUltimate.InitialisationResultat;
begin
  inherited;

  //PeriodeRafraichissement := 1;
end;

procedure TdmTransfertUltimatePHA.InstallerScriptsSQL(var AScriptsSQL : string);
var
  lStrRepScriptSQL : string;
  lScriptSQL : TSearchRec;
  lBoolArret : Boolean;
begin
  lStrRepScriptSQL := Module.Projet.RepertoireApplication + '\Modules\Transfert\Ressources\TransfertUltimate\' + AScriptsSQL + '\';
  if FindFirst(lStrRepScriptSQL + '*.sql', faAnyFile, lScriptSQL) = 0 then
  begin
    lBoolArret := False;
    repeat
      scrLGPI.SQL.LoadFromFile(lStrRepScriptSQL + lScriptSQL.Name);
      if Module.Projet.Thread then
        AttendreFinExecution(Self, taLibelle, TThreadScriptORA, scrLGPI, 'Execution du script ' + lScriptSQL.Name + '...')
      else
        try
          scrLGPI.Execute;
          scrLGPI.Tag := 1;
        except
          scrLGPI.Tag := 0;
        end;

      if scrLGPI.Tag = 0 then
        lBoolArret := MessageDlg('Une erreur est survenue durant l''installation des scripts nécéssaire au fonctionnement du module Ultimate !'#13#10'Voulez-vous continuer ?',
                                 mtWarning, [mbYes, mbNo], 0) = mrNo;
    until (FindNext(lScriptSQL) <> 0) or lBoolArret;
    FindClose(lScriptSQL);
  end;
  AfficherErreurs;
end;

procedure TdmTransfertUltimatePHA.scrLGPIError(Sender: TObject; E: Exception;
  SQL: String; var Action: TErrorAction);
begin
  inherited;

  Module.Projet.Console.AjouterLigne(SQL + ' : ' + E.Message);
  Action := eaException;
end;

procedure TdmTransfertUltimatePHA.InstallerDump;
begin
//  EnvoyerCommande('oracle', taMotDePasse);
//  EnvoyerCommande('oracle', taCommandeUtilisateur);
//  EnvoyerCommande('su', taMotDePasse);
//  EnvoyerCommande('pharmagest', taCommandeRoot);
//  EnvoyerCommande('/etc/init.d/oracle_base restart', taCommandeRoot);
//  EnvoyerCommande('exit', taCommandeUtilisateur);
//  EnvoyerCommande('sqlplus system/manager', taPromptSQL);
//  EnvoyerCommande('drop user erp cascade;', taPromptSQL);
//  EnvoyerCommande('create user erp identified by erp;', taPromptSQL);
//  EnvoyerCommande('grant connect, unlimited tablespace, role_dbdeveloppeur to erp;', taPromptSQL);
//  EnvoyerCommande('exit', taCommandeUtilisateur);
//  EnvoyerCommande('exit');
end;

procedure TdmTransfertUltimatePHA.InitialiserLGPI;
begin
  if ExecuterPS('INITIALISATION', 'pk_supprimer.initialiser_donnees', nil, True, True) = rcdErreurSysteme then
  begin
    MessageDlg('L''initialisation de la base de données de Ultimate a échouée !'#13#10#13#10'Message : ' + FDernierMessageErreur,
               mtError, [mbOk], 0);
    FBaseAlteree := True;
  end
  else
    if psLGPI.ParamByName('RESULT').AsInteger > 0 then
    begin
      MessageDlg('L''initialisation de la base de données de Ultimate a échouée !'#13#10#13#10'Nombre de contraintes désactivées : ' + IntToStr(psLGPI.ParamByName('RESULT').AsInteger),
                 mtError, [mbOk], 0);
      FBaseAlteree := True;
    end
    else
    begin
      CompilerObjets;
      psLGPI.Session.Commit;
      FBaseAlteree := False;
    end;
end;

procedure TdmTransfertUltimatePHA.dbLGPIError(Sender: TObject; E: EDAError;
  var Fail: Boolean);
begin
  inherited;

  FDernierMessageErreur := E.Message;
end;

procedure TdmTransfertUltimatePHA.DeconnexionLGPI;
begin
  dbLGPI.Disconnect;
end;

procedure TdmTransfertUltimatePHA.CompilerObjets;
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

procedure TdmTransfertUltimatePHA.ChargerDataSet(ADataSet: TDataSet;
  ARequeteSQL: string);
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

function TdmTransfertUltimatePHA.GererExceptionDataSet(E: Exception) : Exception;
begin
  Result := E;
end;

function TdmTransfertUltimatePHA.RenvoyerDataSet: TDataSet;
begin
  if not dbLGPI.Connected then
    with TfrModule(Module.Projet.ModuleEnCours.IHM) do
    begin
      with (Module.Projet.ModuleEnCours.IHM as TfrModule) do
      begin
        ParametresConnexion.Values['utilisateur'] := 'migration';
        ParametresConnexion.Values['mot_de_passe'] := 'migration';
        Connecter;
      end;
      Result := oraqry;
    end
  else
    Result := oraqry;
end;

function TdmTransfertUltimatePHA.RenvoyerTables: TStringList;
var
  i : Integer;
begin
  Result := TStringList.Create;
  dbLGPI.GetTableNames(Result, True);
  i := 0;
  while i < Result.Count do
    if (Pos('BEL', Result[i]) = 0) and (Pos('MIGRATION', Result[i]) = 0) then
      Result.Delete(i)
    else
      Inc(i);
end;

procedure TdmTransfertUltimatePHA.ExecuterScript(AScript: TStrings);
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

procedure TdmTransfertUltimatePHA.Commit;
begin
  dbLGPI.Commit;
end;

procedure TdmTransfertUltimatePHA.Rollback;
begin
  dbLGPI.Rollback;
end;

function TdmTransfertUltimatePHA.LibererDataSet(ADataSet: TDataSet): Boolean;
begin
  Result := True;
  if dbLGPI.InTransaction then
    case ActionTransaction('Ultimate') of
      mrOk : Commit;
      mrAbort : Rollback;
    else
      Result := False;
    end;

  if Result then
    if oraqry.Active then
      oraqry.Close;
end;

function TdmTransfertUltimatePHA.RenvoyerLignesAffectees(ADataSet: TDataSet): Integer;
begin
  Result := TOraQuery(ADataSet).RowsAffected;
end;

function TdmTransfertUltimatePHA.ExecuterPS(AFichierLOG, APS: string; AValeurs: Variant;
  AThread, ACommit: Boolean): TResultatCreationDonnees;
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
            Result := rcdTransferee
          else
            Result := rcdErreurSysteme;
        end
        else
        begin
          Execute;

          Result := rcdTransferee;
        end;

        if ACommit then
        begin
          Session.Commit;
          UnPrepare;
        end;
      except
        on E:Exception do
        begin
          Module.Projet.Console.Ajouter(E.Message);
          Result := rcdErreurSysteme;
        end;
      end;
    end;
end;

procedure TdmTransfertUltimatePHA.AfficherErreurs;
begin
  if qryErreurs.Active then
    qryErreurs.Close;

  qryErreurs.Open;
  if qryErreurs.RecordCount > 0 then
    TfrmTransfertUltimateErreursOracle.Create(Self).ShowModal
  else
    MessageDlg('La (dernière) installation du kit de migration a réussi !', mtInformation,[mbOk], 0);
  qryErreurs.Close;
end;

end.

