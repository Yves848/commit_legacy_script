unit mdlModuleTransfert;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, StrUtils,
  Dialogs, IniFiles, StdCtrls, Buttons, DB, ExtCtrls, Grids, uib, uibase, mdlODACThread,
  ComCtrls, mdlProjet, mdlModule, ActnList, JvXPBar, ImgList, mdlAttente,
  PdfDoc, PReport, Menus, JvMenus, mdlPIPanel, JvXPCore, JvXPContainer, mdlLectureFichierBinaire,
  JvWizard, JvWizardRouteMapNodes, mdlPIStringGrid, JvExControls, uibLib, SynHighlighterSQL,
  mdlModuleImport, Ora, mdlTypes, XMLIntf, Generics.Collections, mdlModuleTransfertPHA,
  VirtualTrees, JvExExtCtrls, JvNetscapeSplitter, Math, Sockets;

type
  TfrModuleTransfert = class(TfrModule)
    xpbKitMigration: TJvXPBar;
    actKitMigrationVisualisation: TAction;
    actKitMigrationInstallation: TAction;
    actAccesLGPIInitialisation: TAction;
    bvlSeparateur_3: TBevel;
    actKitMigrationAfficherErreurs: TAction;
    procedure actKitMigrationInstallationExecute(Sender: TObject);
    procedure actKitMigrationVisualisationExecute(Sender: TObject);
    procedure actAccesLGPIInitialisationExecute(Sender: TObject);
    procedure actKitMigrationAfficherErreursExecute(Sender: TObject);
    procedure wzDonneesActivePageChanged(Sender: TObject);
    procedure GrilleSurAppliquerProprietesCellule(Sender: TObject; ACol,
      ALig: Integer; ARect: TRect; var AFond: TColor; APolice: TFont;
      var AAlignement: TAlignment; AEtat: TGridDrawState);
    procedure frModuleTransfert_SurConnecter(Sender : TObject);
    procedure frModuleTransfert_SurDeConnecter(Sender : TObject);
    procedure actAccesBDParametresExecute(Sender: TObject);
  private
    { Déclarations privées }
    function VerifierTables : Boolean;
  protected
    procedure SetMode(const Value: TModeTraitement); override;
    procedure RenvoyerParametresConnexion; override;
    procedure StockerParametresConnexion; override;
    function RenvoyerClasseTraitement: TClasseTraitement; override;
    procedure TraiterDonnee(ATraitement: TTraitement); override;
    procedure TraiterDonneesPraticiens; override;
    procedure TraiterDonneesOrganismes; override;
    procedure TraiterDonneesClients; override;
    procedure TraiterDonneesProduits; override;
    procedure TraiterDonneesEncours; override;
    procedure TraiterAutresDonnees; override;
  public
    { Déclarations publiques }
    constructor Create(AOwner: TComponent; AModule: TModule); override;
    procedure Connecter; override;
  end;

const
  C_INDEX_PAGE_CARTES_FIDELITES = 7;

var
  frModuleTransfert : TfrModuleTransfert;

implementation

uses mdlOracleConnexionServeur, mdlModuleTransfertInstallationScriptsSQL,
  mdlVisualisationScriptSQL, mdlModuleTransfertErreursOracle,
  mdlModuleTransfertConnexion;

{$R *.dfm}

{ TfrModuleTransfert }

procedure TfrModuleTransfert.frModuleTransfert_SurConnecter(Sender: TObject);
begin
  inherited;

  if FConnecte then
  begin
   actAccesLGPIInitialisation.Enabled := True;
    actKitMigrationInstallation.Enabled := False;
  end;
end;

procedure TfrModuleTransfert.frModuleTransfert_SurDeConnecter(Sender: TObject);
begin
  inherited;

  actAccesLGPIInitialisation.Enabled := False;
  actKitMigrationInstallation.Enabled := True;
end;

procedure TfrModuleTransfert.GrilleSurAppliquerProprietesCellule(
  Sender: TObject; ACol, ALig: Integer; ARect: TRect; var AFond: TColor;
  APolice: TFont; var AAlignement: TAlignment; AEtat: TGridDrawState);
var
  t : TTraitementTransfert;
begin
  inherited;

  if ALig > 0 then

  with (Sender as TPIStringGrid) do
  begin
    t := TTraitementTransfert(Objects[0, ALig]);
   
    if Assigned(t) then
    begin
      if (Mode = mtFusion) and not t.Fusion and ((t.TypeTraitement <> ttProcedure) or (t.Fichier = 'pk_autres_donnees.completer_histo_client')) then
      begin
        APolice.Style := APolice.Style + [fsItalic, fsStrikeOut];
        APolice.Color := clInactiveCaption;
      end
    end;
  end;
end;

procedure TfrModuleTransfert.Connecter;
begin

  if PHA.ParametresConnexion.Values['utilisateur'] = '' then
  begin
    PHA.ParametresConnexion.Values['utilisateur'] := 'migration';
    PHA.ParametresConnexion.Values['mot_de_passe'] := 'migration';
  end;

  inherited;
end;

constructor TfrModuleTransfert.Create(AOwner: TComponent; AModule: TModule);
begin
  FInterfaceConnexion := TfrmModuleTrasfertConnexion;
  ModeConnexion := mcServeurSQL;

  inherited;

  SurApresConnecter := frModuleTransfert_SurConnecter;
  SurDeConnecter := frModuleTransfert_SurDeConnecter;
end;

procedure TfrModuleTransfert.TraiterAutresDonnees;
begin
  inherited;

  if VerifierTables then Exit;
end;

procedure TfrModuleTransfert.TraiterDonnee(ATraitement: TTraitement);
const
  C_LIGNES_A_TRANSFERER = 50000;
var
  lIntNbLignes : Integer;
  i, lIntNbBoucle : Integer;
  sql, sqlSkip : string;
begin
  if not Annulation
     and ((Mode = mtFusion)
           and ((TTraitementTransfert(ATraitement).Fusion) or ((ATraitement.TypeTraitement = ttProcedure) and (ATraitement.Fichier <> 'pk_autres_donnees.completer_histo_client')))
           or (Mode <> mtFusion))
     and not dmModuleTransfertPHA.BaseAlteree then
  begin
    try
      TraitementEnCours := ATraitement;
      if TraitementEnCours.TypeTraitement = ttProcedure then
        TraitementEnCours.Fait := not (dmModuleTransfertPHA.ExecuterPS('TRAITEMENT_' + Module.NomModule, TraitementEnCours.Fichier, null, True, True) in [rcdErreur, rcdErreurSysteme])
      else
      begin
        TraitementEnCours.Fait := False;

        lIntNbLignes := dmModuleTransfertPHA.InitialiserTraitement(TTraitementTransfert(ATraitement), Mode);
        lIntNbBoucle := IfThen(lIntNBLignes > C_LIGNES_A_TRANSFERER, (lIntNBLignes div C_LIGNES_A_TRANSFERER) + 1, 1);
        for i := 0 to lIntNBBoucle -1 do
        begin
           if lIntNBBoucle > 1 then
          begin
            dmModuleTransfertPHA.qryPHA.Close(etmCommitRetaining);
            sqlSkip := 'select first ' + IntToStr(C_LIGNES_A_TRANSFERER) + ' skip ' + IntToStr(i * C_LIGNES_A_TRANSFERER) + ' ';
            sql := sqlSkip + Copy(dmModuleTransfertPHA.qryPHA.SQL.Text, Pos('ps.*', dmModuleTransfertPHA.qryPHA.SQL.Text), Length(dmModuleTransfertPHA.qryPHA.SQL.Text));
            dmModuleTransfertPHA.qryPHA.SQL.Clear;
            dmModuleTransfertPHA.qryPHA.SQL.Add(sql);
          end;

          dmModuleTransfertPHA.qryPHA.Open;
          while not dmModuleTransfertPHA.qryPHA.EOF and not Annulation and not dmModuleTransfertPHA.BaseAlteree do
          begin
            FResultat := dmModuleTransfertPHA.ExecuterPS(ATraitement.Fichier,
                                                         TTraitementTransfert(ATraitement).ProcedureCreation,
                                                         dmModuleTransfertPHA.qryPHA, False, ATraitement.Succes mod 20000 = 0);

            // Gestion du résultat
            if TTraitementTransfert(ATraitement).NouvelID then
              with dmModuleTransfertPHA, psLGPI do
                if (FResultat = rcdTransferee) and TTraitementTransfert(ATraitement).TableCorrespondance and not ParamByName('RESULT').IsNull then
                begin
                  qryTableCorres.Params.ByNameAsString['ACODEBASEPHA'] := qryPHA.Fields.AsString[0];
                  qryTableCorres.Params.ByNameAsInteger['ACODEBASETRF'] := ParamByName('RESULT').AsInteger;
                  qryTableCorres.ExecSQL;

                  if TTraitementTransfert(ATraitement).Avertissement then
                  begin
                    //CreerErreur(ATraitement.Fichier, , 100 + ATraitement.Index, ieBloquant, AValeurs);
                  end;
                end;

            case FResultat of
              rcdTransferee : TraitementEnCours.Succes := TraitementEnCours.Succes + 1;
              rcdErreur : TraitementEnCours.Erreurs := TraitementEnCours.Erreurs + 1;
            else
              Abort;
            end;
            dmModuleTransfertPHA.qryPHA.Next;
          end;
        end;
      end;
    except
      on E:Exception do
      begin
        Module.Projet.Console.AjouterLigne(E.Message);
        FResultat := rcdErreurSysteme;
      end;
    end;

    // Fin du traitement
    if ATraitement.fichier = 'DOCUMENTS SCANNES' then
      Module.Projet.Console.AjouterLigne('Si les documents scannés ont été traités manuellement , assurez vous de lancer le traitement Activation Migration MUSE (plus bas)');
    dmModuleTransfertPHA.DePreparerCreationDonnees(FResultat <> rcdErreurSysteme);
    if Assigned(TraitementEnCours) then
      TraitementEnCours.Fait := (FResultat <> rcdErreurSysteme) and not Annulation;
  end;
end;

procedure TfrModuleTransfert.TraiterDonneesClients;
begin
  inherited;

  if VerifierTables then Exit;
end;

procedure TfrModuleTransfert.TraiterDonneesEncours;
begin
  inherited;

  if VerifierTables then Exit;
end;

procedure TfrModuleTransfert.TraiterDonneesOrganismes;
begin
  inherited;

  if VerifierTables then Exit;
end;

procedure TfrModuleTransfert.TraiterDonneesPraticiens;
begin
  inherited;

  if VerifierTables then Exit;
end;

procedure TfrModuleTransfert.TraiterDonneesProduits;
begin
  inherited;

  if VerifierTables then Exit;
end;

function TfrModuleTransfert.VerifierTables : Boolean;
const
  C_NB_ENREG_TABLES = '%s : %d enregistrement(s)'#13#10;
var
  g : TStringGrid;
  i, j: Integer;
  t : TTraitementTransfert;
  ko : Boolean;
  msg : string;
  p : TPair<string, Integer>;
begin
  if not (Mode in [mtMAJ, mtFusion]) and not TraitementAutomatique then
  begin
    i := 0; g := nil;
    with wzDonnees.ActivePage do
      while (i < ControlCount) and not Assigned(g) do
        if Controls[i] is TStringGrid then
          g := Controls[i] as TStringGrid
        else
          Inc(i);

    if Assigned(g) then
    begin
      ko := True;
      for i := 0 to Traitements.Count - 1 do
      begin
        t := Traitements[i] as TTraitementTransfert;
        if (t.AffichageResultat.Grille = g) and (t.TablesAVerifier.Count > 0) then
        begin
          dmModuleTransfertPHA.VerifierTables(t.TablesAVerifier);
          if ko then
            for j in t.TablesAVerifier.Values do
              ko := ko and (j = 0);
        end;
      end;


      if not ko then
      begin
        msg := 'Certaines tables de la base de transfert ne sont pas vides :'#13#10#13#10;
        for i := 0 to Traitements.Count - 1 do
        begin
          t := Traitements[i] as TTraitementTransfert;
          if (t.AffichageResultat.Grille = g) and (t.TablesAVerifier.Count > 0) then
            for p in t.TablesAVerifier do
              if p.Value > 0 then
                msg := msg + Format(C_NB_ENREG_TABLES, [p.Key, p.Value]) + #13#10;
        end;
        msg := msg + #13#10'Voulez-vous continuer le transfert ?';
        Result := MessageDlg(msg, mtWarning, [mbYes, mbNo], 0) = mrYes;
      end
      else
        Result := True;
    end
    else
      Result := False;
  end
  else
    Result := True;
end;

procedure TfrModuleTransfert.wzDonneesActivePageChanged(Sender: TObject);
begin
  inherited;

  xpcOutils.Visible := wzDonnees.ActivePageIndex < wzDonnees.PageCount - 1;
end;

function TfrModuleTransfert.RenvoyerClasseTraitement: TClasseTraitement;
begin
  Result := TTraitementTransfert;
end;

procedure TfrModuleTransfert.RenvoyerParametresConnexion;
begin
  if PHA.ParametresConnexion.IndexOfName('serveur') = -1 then
    PHA.ParametresConnexion.Add('serveur=');
  if PHA.ParametresConnexion.IndexOfName('cip') = -1 then
    PHA.ParametresConnexion.Add('cip=');

  with Module.Projet.FichierProjet.DocumentElement.ChildNodes['modules'].ChildNodes['transfert'].ChildNodes['acces_base'] do
  begin
    if HasAttribute('serveur') then
      PHA.ParametresConnexion.Values['serveur'] :=  Attributes['serveur']
    else
      PHA.ParametresConnexion.Values['serveur'] := '192.168.0.100';

    if HasAttribute('cip') then PHA.ParametresConnexion.Values['cip'] :=  Attributes['cip'] ;


  end;
end;

procedure TfrModuleTransfert.StockerParametresConnexion;
begin
  with Module.Projet.FichierProjet.DocumentElement.ChildNodes['modules'].ChildNodes['transfert'].ChildNodes['acces_base'] do
  begin
    Attributes['serveur'] := PHA.ParametresConnexion.Values['serveur'];
    Attributes['cip'] := PHA.ParametresConnexion.Values['cip'];
  end;
end;

procedure TfrModuleTransfert.actKitMigrationInstallationExecute(Sender: TObject);
var
  lBoolDejaConnecte : Boolean;
  lStrScriptsSQL : string;
  lStrRepScriptSQL : string;
  lScriptSQL : TSearchRec;
  lBoolArret : Boolean;
begin
  inherited;

  //TODO recupere les infos de connexion AVANT
  with (Module.Projet.ModuleTransfert.IHM as TfrModule) do
  begin
    PHA.ParametresConnexion.Values['utilisateur'] := 'system';
    PHA.ParametresConnexion.Values['mot_de_passe'] := 'manager';
    ParametrerAccesBD(true);
    //Connecter;
  end;

  if FConnecte then
  begin
    TfrmModuleTransfertInstallationScriptsSQL.Create(Self, Module).ShowModal(lStrScriptsSQL);

    if lStrScriptsSQL <> '' then
    begin
      lStrRepScriptSQL := Module.RepertoireRessources + '\' + lStrScriptsSQL + '\';
      if FindFirst(lStrRepScriptSQL + '*.sql', faAnyFile, lScriptSQL) = 0 then
      begin
        lBoolArret := False;
        repeat
          with dmModuleTransfertPHA do
          begin
            scrLGPI.SQL.LoadFromFile(lStrRepScriptSQL + lScriptSQL.Name, TEncoding.UTF8);
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
              lBoolArret := MessageDlg('Une erreur est survenue durant l''installation des scripts !'#13#10'Voulez-vous continuer ?',
                                       mtWarning, [mbYes, mbNo], 0) = mrNo;
          end;
        until (FindNext(lScriptSQL) <> 0) or lBoolArret;
        FindClose(lScriptSQL);
        actKitMigrationAfficherErreursExecute(Self);
      end;
    end;

  end;
end;

procedure TfrModuleTransfert.actKitMigrationVisualisationExecute(Sender: TObject);
begin
  inherited;

  TfrmVisualisationScriptSQL.Create(Self, Module.Projet).ShowModal(Module.RepertoireRessources, sqlOracle);
end;

procedure TfrModuleTransfert.actAccesBDParametresExecute(Sender: TObject);
begin
  // remettre les login migration quand on ouvre la fenetre parametre
  //Module.Projet.ModuleTransfert.

  PHA.ParametresConnexion.Values['utilisateur'] := 'migration';
  PHA.ParametresConnexion.Values['mot_de_passe'] := 'migration';

  inherited;
end;

procedure TfrModuleTransfert.actAccesLGPIInitialisationExecute(Sender: TObject);

  function OKPourInit : Boolean;
  begin
    if not dmModuleTransfertPHA.dbLGPI.Connected then
    begin
      actAccesBDConnexion.Execute;
      Result := dmModuleTransfertPHA.dbLGPI.Connected;
    end
    else
      Result := True;

    Result := Result and (MessageDlg('L''initialisation va supprimer toutes les données du serveur de transfert ! Voulez-vous continuer ?', mtWarning, [mbYes, mbNo], 0) = mrYes);
  end;

begin
  inherited;

  if  (Mode in [mtMAJ, mtFusion]) then
    showmessage('Initialisation non autorisée en mode Fusion ou Mise à jour ')
  else
    if OKPourInit  then
      dmModuleTransfertPHA.InitialiserLGPI;
end;

procedure TfrModuleTransfert.actKitMigrationAfficherErreursExecute(
  Sender: TObject);
begin
  inherited;

  with dmModuleTransfertPHA do
  begin
    if qryErreurs.Active then
      qryErreurs.Close;

    qryErreurs.Open;
    if qryErreurs.RecordCount > 0 then
      TfrmModuleTransfertErreursOracle.Create(Self).ShowModal
    else
      begin
        MessageDlg('La (dernière) installation du kit de migration a réussi !', mtInformation,[mbOk], 0);

        if dmModuleTransfertPHA.dbLGPI.Connected then
          Deconnecter;

        PHA.ParametresConnexion.Values['utilisateur'] := 'migration';
        PHA.ParametresConnexion.Values['mot_de_passe'] := 'migration';
        Connecter;
      end;

    qryErreurs.Close;
  end;
end;

procedure TfrModuleTransfert.SetMode(const Value: TModeTraitement);
var
  i : Integer;
begin
  inherited;

  for i := 0 to wzDonnees.ActivePage.ControlCount - 1 do
    if wzDonnees.ActivePage.Controls[i] is TPIStringGrid then
      wzDonnees.ActivePage.Controls[i].Refresh;
end;

initialization
  RegisterClasses([TfrModuleTransfert, TdmModuleTransfertPHA]);

finalization
  UnRegisterClasses([TfrModuleTransfert, TdmModuleTransfertPHA]);

end.


