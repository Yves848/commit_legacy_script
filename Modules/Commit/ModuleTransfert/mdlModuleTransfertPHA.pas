  unit mdlModuleTransfertPHA;

interface

uses
  Windows, Messages, SysUtils, Classes, Dialogs, mdlAttente, Forms, uibLib,
  mdlProjet, mdlPHA, uib, mdlModule, Ora, OraError, DB, MemDS, DBAccess,
  Variants,
  OraScript, Controls, mdlTypes, uibdataset, mdluibThread, mdlODACThread, Grids,
  StrUtils, XMLIntf, OraCall, DAScript, mydbunit, fbcustomdataset,
  Generics.Collections;

type
  TSurAvantSelectionDonnees = procedure(Sender: TObject; ATraitement: TTraitement) of object;

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

  TdmModuleTransfertPHA = class(TdmPHA, IRequeteur)
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
  private
    FDernierMessageErreur: string;
    FSurAvantSelectionDonnees: TSurAvantSelectionDonnees;
    procedure CompilerObjets;
  protected
    FVersionLGPI: string;
    FRaisonSociale: string;
    FBaseAlteree: Boolean;
  public
    { Déclarations publiques }
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
  end;

var
  dmModuleTransfertPHA: TdmModuleTransfertPHA;

implementation

uses Math, mdlActionTransaction;
{$R *.dfm}

procedure TdmModuleTransfertPHA.DataModuleCreate(Sender: TObject);
var
  s: string;
begin
  inherited;

  // Configuration environnement Oracle
  s := GetEnvironmentVariable('NLS_LANG');
  if s = '' then
    SetEnvironmentVariable('NLS_LANG', PChar('FRENCH_FRANCE.WE8MSWIN1252'));
  // OCIDLL := Module.Projet.RepertoireApplication + '\oci.dll';

  dmModuleTransfertPHA := Self;

  qryTableCorres.Transaction := qryPHA.Transaction;
  qryTableCorres.DataBase := Module.Projet.PHAConnexion;

  Module.Projet.ERPConnexion := dbLGPI;
end;

procedure TdmModuleTransfertPHA.ConnexionBD;
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

  with dbLGPI do
    if not Connected then
    begin
        dbLGPI.Username := ParametresConnexion.Values['utilisateur'];
        dbLGPI.Password := ParametresConnexion.Values['mot_de_passe'];
        dbLGPI.Server := '(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=' + ParametresConnexion.Values['serveur'] +
                           ')(PORT=1521))(CONNECT_DATA=(SERVICE_NAME=PHAL1)))';
        try
          Connect;
        except
          on E: Exception do
          begin
            if E.ClassNameIs('EOraError') then
            begin
              OraEx := EOraError(E);

              case OraEx.ErrorCode of
                1:
                  begin
                    errMsg := 'Le serveur ' + ParametresConnexion.Values['serveur'] + ' est inaccessible !!';
                  end;
                1017: // user / mdp incorrect.
                  begin
                    case cMode of
                      0 : begin
                         errMsg := 'Vous devriez installer le "kit de migration" avant !';
                      end;
                      1 : begin
                         errMsg := 'C''est un serveur sécurisé, executez : ' + sLineBreak +
                         ' /home/pharmagest/lgpi-securisation/lgpi-securisation.sh --reset ';
                         Module.Projet.Console.AjouterLigne('/home/pharmagest/lgpi-securisation/lgpi-securisation.sh --reset ');
                      end;
                    end;

                  end;
              else
                begin
                  errMsg := inttostr(OraEx.ErrorCode) + ' : ' + OraEx.Message;
                end;
              end; // case
              raise Exception.Create(errMsg);
            end //if E.ClassNameIs('EOraError')
            else
            begin
              OutputDebugString(pWideChar(E.ClassName));
              if Module.pays = 'FR' then
              begin
                errMsg := 'Vous devriez installer le "kit de migration" avant !' + sLineBreak+sLineBreak;
                errMsg := errMsg + 'Si c''est un serveur sécurisé, executez : ' + sLineBreak +
                  ' /home/pharmagest/lgpi-securisation/lgpi-securisation.sh --reset ';
              end
              else
                errMsg := 'Vous devriez installer le "kit de migration" avant !';
              raise Exception.Create(errMsg);
            end; // else
          end; // if e.ClassNameIs('EOraError') then begin
        end; // try

        if Module.pays = 'FR' then
          u := 'ERP'
        else if Module.pays = 'BE' then
          u := 'bel';

        ExecSQLEx('begin select valeur into :valeur from ' + u + '.t_parametres where cle = ' + QuotedStr('pha.cip') + '; end;',
          ['valeur', '']);
        if ParamByName('valeur').AsString <> ParametresConnexion.Values['cip'] then
        begin
          Disconnect;
          raise Exception.Create('Le code CIP/APB que vous avez saisi ne correspond à celui du serveur !');
        end
        else
        begin
          ExecSQLEx('begin select valeur into :valeur from ' + u + '.t_parametres where cle = ' + QuotedStr('pha.raisonSociale')
              + '; end;', ['valeur', '']);
          FRaisonSociale := ParamByName('valeur').AsString;
          Module.Projet.Console.AjouterLigne
            ('Utilisateur "' + ParametresConnexion.Values['utilisateur'] + '" Connecté à :' + FRaisonSociale);
        end;

        if u = 'ERP' then
        begin
          if FVersionLGPI >= '2.6.3' then
          begin
             Module.Projet.Console.AjouterLigne('À la fin de la récupération, exécuter le script suivant : ');
             Module.Projet.Console.AjouterLigne('/home/pharmagest/sgbd/maj.sh');
          end;

          ExecSQLEx('begin select valeur into :valeur from ' + u + '.t_parametres where cle = ' + '''' + 'rpm_version_lgpi' + '''' +
              '; end;', ['valeur', '']);
          FVersionLGPI := ParamByName('valeur').AsString;

          if not VerifierVersion(FVersionLGPI, Module.pays) then
          begin
            raise Exception.Create('Version de lgpi/id. (' + FVersionLGPI + ') non supportée');
            Module.Projet.Console.AjouterLigne('Version ' + FVersionLGPI + ' non supportée !');
          end;

          Module.Projet.Console.AjouterLigne('Version de lgpi/id. détectée : ' + FVersionLGPI);

        end
        else
        begin
          req := 'begin select valeur into :valeur from ' + u + '.t_parametres where cle = ' + '''' + 'rpm_version_lgpi' + '''' + '; end;';
          ExecSQLEx(req, ['valeur', '']);
          FVersionLGPI := ParamByName('valeur').AsString;

          if not VerifierVersion(FVersionLGPI, Module.pays) then
          begin
            raise Exception.Create('Version de Ultimate (' + FVersionLGPI + ') non supportée');
            Module.Projet.Console.AjouterLigne('Version ' + FVersionLGPI + ' non supportée !');
          end;

          Module.Projet.Console.AjouterLigne(' version de Ultimate détectée : ' + FVersionLGPI);

        end;
    end;
end;

procedure TdmModuleTransfertPHA.DeconnexionBD;
begin
  FBaseAlteree := False;
  dbLGPI.Disconnect;
end;

function TdmModuleTransfertPHA.RenvoyerChaineConnexion: string;
begin
  result := ParametresConnexion.Values['serveur']
end;

procedure TdmModuleTransfertPHA.SupprimerDonnees(ADonneesASupprimer: TList<Integer>);
var
  i: TSuppression;
  j: Integer;
begin
  if not FBaseAlteree then
  begin
    if not dbLGPI.Connected or (dbLGPI.Connected and (ParametresConnexion.Values['utilisateur'] = 'system')) then
    begin
      ParametresConnexion.Values['utilisateur'] := 'migration';
      ParametresConnexion.Values['mot_de_passe'] := 'migration'; (Module.Projet.ModuleEnCours.IHM as TfrModule)
      .Connecter;
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
      StoredProcName := 'pk_supprimer.supprimer_donnees';
      Prepare;

      for j := 0 to ADonneesASupprimer.Count - 1 do
        if ADonneesASupprimer[j] <> -1 then
        begin
          ParamByName('ATYPESUPPRESSION').AsInteger := ADonneesASupprimer[j];
          if Module.Projet.Thread then
            AttendreFinExecution(Self, taLibelle, TThreadPSORA, psLGPI,
              'Suppression des ' + LibelleDonneesASupprimer[TSuppression(ADonneesASupprimer[j])] + ' ...')
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
    MessageDlg('Base altérée : impossible d''effectuer le transfert !', mtError, [mbOk], 0);
end;

procedure TdmModuleTransfertPHA.VerifierTables(ATables: TDictionary<string, Integer>);
var
  t: TPair<string, Integer>;
begin
  with TOraQuery.Create(nil) do
  begin
    Session := dbLGPI;
    for t in ATables do
    begin
      SQL.Clear;
      SQL.Add('select count(*) from ' + t.Key);
      try
        Open;
        ATables.Items[t.Key] := Fields[0].AsInteger;
      except
        on E: Exception do
          Module.Projet.Console.AjouterLigne(t.Key + ' ' + E.Message);
      end;
      Close;
    end;
    Free;
  end;
end;

function TdmModuleTransfertPHA.ExecuterPS(AFichierLOG, APS: string; AValeurs: TUIBQuery; AThread: Boolean = False;
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

function TdmModuleTransfertPHA.InitialiserTraitement(ATraitement: TTraitementTransfert; Mode: TModeTraitement): Integer;
var
  lResultatInit: Boolean;
  pays: string;
begin

  if Module.pays = 'FR' then
    pays := 'ERP'
  else if Module.pays = 'BE' then
    pays := 'bel';

  // Initialisation
  if Module.Projet.Thread then
  begin
    ParametresThreadRequeteFB.NomProcedure := 'ps_transfert_init_trait';
    ParametresThreadRequeteFB.NombreParametresProc := 2;
    ParametresThreadRequeteFB.ParametresProc[0] := ATraitement.Index;
    ParametresThreadRequeteFB.ParametresProc[1] := inttostr(Ord(Mode = mtMAJ));
    lResultatInit := AttendreFinExecution(Application.MainForm, taLibelle, TThreadRequeteFB, ParametresThreadRequeteFB,
      'Préparation au transfert des données ' + ATraitement.Fichier);

    lResultatInit := ParametresThreadRequeteFB.Erreur.Etat;
  end
  else
    with qryPHA do
      try
        Transaction.StartTransaction;
        BuildStoredProc('ps_transfert_init_trait');
        Params.ByNameAsInteger['ATRAITEMENTID'] := ATraitement.Index;
        Params.ByNameAsString['AMISEAJOUR'] := inttostr(Ord(Mode = mtMAJ));
        Execute;
        Close(etmCommit);
        lResultatInit := true;
      except
        on E: Exception do
        begin
          Close(etmRollback);
          Module.Projet.Console.AjouterLigne(E.Message);
          lResultatInit := False;
        end;
      end;

  // Vérification du nombre de contraintes désactivées
  dbLGPI.ExecSQL('begin select count(*) into :nb from all_constraints where owner = ''+pays +'' and status = ''DISABLED''; end;', ['nb']);
  if dbLGPI.ParamByName('nb').AsInteger > 0 then
  begin
    MessageDlg('Une précédente initialisation de la base de données LGPI a échoué !'#13#10#13#10'Nombre de contraintes désactivées : ' +
        dbLGPI.ParamByName('nb').AsString, mtError, [mbOk], 0);
    FBaseAlteree := true;
  end;

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

    // Préparation procédure de corres
    if ATraitement.TableCorrespondance then
      qryTableCorres.BuildStoredProc('PS_TRANSFERT_CREER_CORRES');

    // LGPI
    if not dbLGPI.Connected or (dbLGPI.Connected and (ParametresConnexion.Values['utilisateur'] = 'system')) then
      with (Module.Projet.ModuleEnCours.IHM as TfrModule) do
      begin
        if dbLGPI.Connected then
          Deconnecter;
        ParametresConnexion.Values['utilisateur'] := 'migration';
        ParametresConnexion.Values['mot_de_passe'] := 'migration';
        Connecter;
      end;

    with psLGPI do
      if not Prepared then
      begin
        if Assigned(FSurAvantSelectionDonnees) then
          FSurAvantSelectionDonnees(Self, ATraitement);

        if not FBaseAlteree then
        begin
          SQL.Clear;
          StoredProcName := ATraitement.ProcedureCreation;
          Prepare;

          ATraitement.NouvelID := Assigned(FindParam('RESULT'));
          ATraitement.Avertissement := Assigned(FindParam('ACODEAVERTISSEMENT'));
        end;
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

procedure TdmModuleTransfertPHA.DePreparerCreationDonnees(ACommit: Boolean);
begin
  if ACommit then
    psLGPI.Session.Commit
  else
    psLGPI.Session.Rollback;
  psLGPI.UnPrepare;

  qryPHA.Close(etmCommit);
end;

procedure TdmModuleTransfertPHA.scrLGPIError(Sender: TObject; E: Exception; SQL: String; var Action: TErrorAction);
begin
  inherited;

  Module.Projet.Console.AjouterLigne(SQL + ' : ' + E.Message);
  Action := eaException;
end;

procedure TdmModuleTransfertPHA.InstallerDump;
begin
  // EnvoyerCommande('oracle', taMotDePasse);
  // EnvoyerCommande('oracle', taCommandeUtilisateur);
  // EnvoyerCommande('su', taMotDePasse);
  // EnvoyerCommande('pharmagest', taCommandeRoot);
  // EnvoyerCommande('/etc/init.d/oracle_base restart', taCommandeRoot);
  // EnvoyerCommande('exit', taCommandeUtilisateur);
  // EnvoyerCommande('sqlplus system/manager', taPromptSQL);
  // EnvoyerCommande('drop user erp cascade;', taPromptSQL);
  // EnvoyerCommande('create user erp identified by erp;', taPromptSQL);
  // EnvoyerCommande('grant connect, unlimited tablespace, role_dbdeveloppeur to erp;', taPromptSQL);
  // EnvoyerCommande('exit', taCommandeUtilisateur);
  // EnvoyerCommande('exit');
end;

procedure TdmModuleTransfertPHA.InitialiserLGPI;
begin
  // if not dbLGPI.Connected or (dbLGPI.Connected and (ParametresConnexion.Values['utilisateur'] = 'system')) then
  with (Module.Projet.ModuleEnCours.IHM as TfrModule) do
  begin
    Deconnecter;
    ParametresConnexion.Values['utilisateur'] := 'migration';
    ParametresConnexion.Values['mot_de_passe'] := 'migration';
    Connecter;
  end;

  if ExecuterPS('INITIALISATION', 'pk_supprimer.initialiser_donnees', nil, true, true) = rcdErreurSysteme then
  begin
    MessageDlg('L''initialisation de la base de données LGPI a échoué !'#13#10#13#10'Message : ' + FDernierMessageErreur, mtError, [mbOk],
      0);
    FBaseAlteree := true;
  end
  else if psLGPI.ParamByName('RESULT').AsInteger > 0 then
  begin
    MessageDlg('L''initialisation de la base de données LGPI a échoué !'#13#10#13#10'Nombre de contraintes désactivées : ' + inttostr
        (psLGPI.ParamByName('RESULT').AsInteger), mtError, [mbOk], 0);
    FBaseAlteree := true;
  end
  else
  begin
    CompilerObjets;
    psLGPI.Session.Commit;
    showmessage('Initialisation Terminée');
    FBaseAlteree := False;
  end;
end;

procedure TdmModuleTransfertPHA.dbLGPIError(Sender: TObject; E: EDAError; var Fail: Boolean);
begin
  inherited;

  FDernierMessageErreur := E.Message;
end;

procedure TdmModuleTransfertPHA.CompilerObjets;
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

procedure TdmModuleTransfertPHA.ChargerDataSet(ADataSet: TDataSet; ARequeteSQL: string);
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

function TdmModuleTransfertPHA.GererExceptionDataSet(E: Exception): Exception;
begin
  result := E;
end;

function TdmModuleTransfertPHA.RenvoyerDataSet: TDataSet;
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

function TdmModuleTransfertPHA.RenvoyerTables: TStringList;
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

procedure TdmModuleTransfertPHA.ExecuterScript(AScript: TStrings);
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

procedure TdmModuleTransfertPHA.Commit;
begin
  dbLGPI.Commit;
end;

procedure TdmModuleTransfertPHA.Rollback;
begin
  dbLGPI.Rollback;
end;

function TdmModuleTransfertPHA.LibererDataSet(ADataSet: TDataSet): Boolean;
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

function TdmModuleTransfertPHA.RenvoyerLignesAffectees(ADataSet: TDataSet): Integer;
begin
  result := TOraQuery(ADataSet).RowsAffected;
end;

function TdmModuleTransfertPHA.ExecuterPS(AFichierLOG, APS: string; AValeurs: Variant; AThread, ACommit: Boolean): TResultatCreationDonnees;
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
