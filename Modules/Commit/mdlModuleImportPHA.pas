unit mdlModuleImportPHA;

interface

uses
  Windows, SysUtils, Classes, mdlPHA, DB, Contnrs, Messages,
  mdlAttente, Forms, mdlProjet, mdlLectureFichierBinaire,
  strutils, mdlModule, Dialogs, Variants, mdlTypes, mdlUIBThread,
  uib, mydbUnit, FBCustomDataSet, uibdataset, uibase, UIBLib,
  Generics.Collections, IniFiles, Registry;

type
  TParametresOuvertureDataset = class
  private
    FDataSet: TDataSet;
    FDataSources: TObjectList<TDataSource>;
  public
    property DataSet : TDataSet read FDataSet write FDataSet;
    property DataSources : TObjectList<TDataSource> read FDataSources write FDataSources;
    constructor Create;
    destructor Destroy; override;
  end;

  TThreadOuvertureDataset = class(TAttente)
  private
    FHandleFenetre : THandle;
    FDataSources : TObjectList<TDataSource>;
    procedure RetablirDataSources;
    procedure WindowProc(var Message : Messages.TMessage);
  protected
    procedure LancerExecution; override;
  public
    constructor Create(ACreateSuspended : Boolean; AParametres : Pointer); override;
  end;

  TdmModuleImportPHA = class(TdmPHA)
    setFichiersManquants: TFBDataSet;
    setFichiersManquantsAFICHIER: TFBAnsiField;
    setFichiersManquantsAREQUIS: TStringField;
    setFichiersManquantsAPRESENCE: TStringField;
    setFichiersManquantsAVALIDATIONABSENCE: TStringField;
    setConversionsOrganismesAMO: TFBDataSet;
    setConversionsOrganismesAMONOM: TFBAnsiField;
    setConversionsOrganismesAMONOM_REDUIT: TFBAnsiField;
    setConversionsOrganismesAMOT_REF_ORGANISME_AMO_ID: TIntegerField;
    setConversionsOrganismesAMOSANS_CENTRE_GESTIONNAIRE: TFBAnsiField;
    setConversionsOrganismesAMOIDENTIFIANT_NATIONAL: TFBAnsiField;
    setConversionsOrganismesAMORUE_1: TFBAnsiField;
    setConversionsOrganismesAMORUE_2: TFBAnsiField;
    setConversionsOrganismesAMOCODE_POSTAL_VILLE: TFBAnsiField;
    setConversionsOrganismesAMOCODE_POSTAL: TFBAnsiField;
    setConversionsOrganismesAMONOM_VILLE: TFBAnsiField;
    setConversionsOrganismesAMOCOMMENTAIRE: TFBAnsiField;
    setConversionsOrganismesAMOREPRIS: TStringField;
    setConversionsOrganismesAMONOMBRE_CLIENTS: TIntegerField;
    setConversionsOrganismesAMOT_ORGANISME_AMO_ID: TFBAnsiField;
    setConversionsCouverturesAMO: TFBDataSet;
    setConversionsCouverturesAMOT_ORGANISME_AMO_ID: TFBAnsiField;
    setConversionsCouverturesAMONOM_ORGANISME: TFBAnsiField;
    setConversionsCouverturesAMOT_COUVERTURE_AMO_ID: TFBAnsiField;
    setConversionsCouverturesAMOLIBELLE: TFBAnsiField;
    setConversionsCouverturesAMOCODE_COUVERTURE: TFBAnsiField;
    setConversionsCouverturesAMONATURE_ASSURANCE: TSmallintField;
    setConversionsCouverturesAMONOMBRE_CLIENTS: TIntegerField;
    setConversionsCouverturesAMOREPRIS: TStringField;
    setConversionsCouverturesAMOT_REF_COUVERTURE_AMO_ID: TIntegerField;
    setConversionsCouverturesAMOALD: TStringField;
    setOrganismesAMORef: TUIBDataSet;
    setOrganismesAMORefT_REF_ORGANISME_AMO_ID: TIntegerField;
    setOrganismesAMORefNOM: TWideStringField;
    setOrganismesAMORefREGIME: TWideStringField;
    setOrganismesAMORefCAISSE_GESTIONNAIRE: TWideStringField;
    setOrganismesAMORefCENTRE_GESTIONNAIRE: TWideStringField;
    setOrganismesAMORefCODE_POSTAL: TWideStringField;
    setOrganismesAMORefNOM_VILLE: TWideStringField;
    setCouverturesAMORef: TUIBDataSet;
    setConversionsCouverturesAMOIDENTIFIANT_NATIONAL: TFBAnsiField;
    setConversionsComptes: TFBDataSet;
    setConversionsComptesNOM: TFBAnsiField;
    setConversionsComptesCODE_POSTAL_VILLE: TFBAnsiField;
    setConversionsComptesCOLLECTIF: TStringField;
    setConversionsComptesNOM_PRENOM_CLIENT: TFBAnsiField;
    setConversionsComptesNOMBRE_ADHERENTS: TIntegerField;
    setConversionsComptesREPRIS: TStringField;
    setConversionsComptesT_COMPTE_ID: TFBAnsiField;
    setConversionsComptesT_CLIENT_ID: TFBAnsiField;
    setFichiersManquantsACOMMENTAIRE: TFBAnsiField;
    setFichiersManquantsATYPEFICHIER: TFBAnsiField;
    trModuleImport: TUIBTransaction;
    setListeClients: TUIBDataSet;
    setListeClientsT_CLIENT_ID: TWideStringField;
    setListeClientsNUMERO_INSEE: TWideStringField;
    setListeClientsNOM: TWideStringField;
    setListeClientsPRENOM: TWideStringField;
    setListeClientsDERNIERE_DATE_FIN_DROIT_AMO: TDateField;
    setListeClientsDATE_DERNIERE_VISITE: TDateField;
    setListeClientsORGANISME_AMO: TWideStringField;
    setListeClientsORGANISME_AMC: TWideStringField;
    setConversionsComptesCREDIT: TBCDField;
    setFichiersManquantsADATEHEURE: TDateTimeField;
    setConversionsFournisseurs: TFBDataSet;
    setConversionsRepartiteurs: TFBDataSet;
    setConversionsFournisseursAFOURNISSEUR: TFBAnsiField;
    setConversionsFournisseursANOM: TFBAnsiField;
    setConversionsFournisseursARUE: TFBAnsiField;
    setConversionsFournisseursACP: TFBAnsiField;
    setConversionsFournisseursALOCALITE: TFBAnsiField;
    setConversionsFournisseursATR_FOURNISSEUR: TFBAnsiField;
    setConversionsFournisseursACOUNT: TIntegerField;
    setFournisseursRef: TUIBDataSet;
    IBStringField1: TWideStringField;
    IBStringField2: TWideStringField;
    IBStringField3: TWideStringField;
    IBStringField4: TWideStringField;
    IBStringField5: TWideStringField;
    setRepartiteursRef: TUIBDataSet;
    setConversionsRepartiteursAREPARTITEUR: TFBAnsiField;
    setConversionsRepartiteursANOM: TFBAnsiField;
    setConversionsRepartiteursARUE: TFBAnsiField;
    setConversionsRepartiteursACP: TFBAnsiField;
    setConversionsRepartiteursALOCALITE: TFBAnsiField;
    setConversionsRepartiteursATR_REPARTITEUR: TFBAnsiField;
    setConversionsRepartiteursACOUNT: TIntegerField;
    setRepartiteursRefCODE: TWideStringField;
    setRepartiteursRefNOM: TWideStringField;
    setRepartiteursRefRUE: TWideStringField;
    setRepartiteursRefLOCALITE: TWideStringField;
    setRepartiteursRefCODEPOSTAL: TWideStringField;
    setPrestations: TUIBDataSet;
    setConversionsReferenceAnalytiques: TFBDataSet;
    setReferenceAnalytiquesRef: TUIBDataSet;
    REFERENCEANALYTIQUE: TWideStringField;
    NOM: TWideStringField;
    setConversionsReferenceAnalytiquesAREFERENCEANALYTIQUE: TFBAnsiField;
    setConversionsReferenceAnalytiquesATR_REFERENCEANALYTIQUE: TFBAnsiField;
    setConversionsCouverturesAMOJUSTIFICATIF_EXO: TStringField;
    setConversionsFournisseursANUMAPB: TFBAnsiField;
    procedure DataModuleCreate(Sender: TObject);
    procedure setConversionsCouverturesAMOBeforeClose(DataSet: TDataSet);
    procedure setConversionsCouverturesAMOAfterScroll(DataSet: TDataSet);
    procedure setConversionsOrgCouvAMOAfterPost(DataSet: TDataSet);
    procedure trInterneEndTransaction(Sender: TObject;
      var Mode: TEndTransMode);
    procedure setConversionsCouverturesAMOBeforeOpen(DataSet: TDataSet);
    procedure setConversionsOrganismesAMOBeforeOpen(DataSet: TDataSet);
    procedure setConversionsOrganismesAMOBeforeClose(DataSet: TDataSet);
    procedure setConversionsComptesBeforeOpen(DataSet: TDataSet);
    procedure setConversionsFournisseursBeforeOpen(DataSet: TDataSet);
    procedure setConversionsRepartiteursBeforeOpen(DataSet: TDataSet);
    procedure setConversionsReferenceAnalytiquesBeforeOpen(DataSet: TDataSet);
  private
    { Déclarations privées }
    FChangementDonneesConversion: Boolean;
    FDriver: string;
    FParametresODBC: TDictionary<string, string>;
  public
    { Déclarations publiques }
    destructor Destroy; override;
    property ChangementDonneesConversion : Boolean read FChangementDonneesConversion;
    procedure OuvrirListeClients;
    procedure ConvertirDonnees(AListeProcedures : TStringList);
    procedure ImpExpConversions(AImpExp : Boolean);
    function CreerDonnees(ADonnees : TDonneesFormatees): TResultatCreationDonnees; virtual;
    procedure SupprimerDonnees(ADonneesASupprimer: TList<Integer>); override;
    property Driver : string read FDriver;
    property ParametresODBC : TDictionary<string, string> read FParametresODBC;
  end;

var
  dmModuleImportPHA: TdmModuleImportPHA;

implementation

uses mdlLIsteClients;

{$R *.dfm}

{ TThreadOuvertureDataset }

constructor TThreadOuvertureDataset.Create(ACreateSuspended: Boolean;
  AParametres: Pointer);
var
  i : Integer;
begin
  inherited;

  FHandleFenetre := AllocateHWnd(WindowProc);
  FDataSources := TParametresOuvertureDataset(FParametres).DataSources;
  if FDataSources.Count > 0 then
    for i := 0 to FDataSources.Count - 1 do
      FDataSources[i].Dataset := nil;
end;

procedure TThreadOuvertureDataset.WindowProc(var Message: Messages.TMessage);
begin

end;

procedure TThreadOuvertureDataset.LancerExecution;
begin
  inherited;

  with TParametresOuvertureDataset(FParametres).DataSet do
  begin
    if Active then
      Close;
    Open;
  end;
  Synchronize(RetablirDataSources);
end;

procedure TThreadOuvertureDataset.RetablirDataSources;
var
  i : Integer;
begin
  if FDataSources.Count > 0 then
    for i := 0 to FDataSources.Count - 1 do
      FDataSources[i].Dataset := TParametresOuvertureDataset(FParametres).DataSet;
end;

constructor TParametresOuvertureDataset.Create;
begin
  inherited;

  FDataSources := TObjectList<TDataSource>.Create(False);
end;

destructor TParametresOuvertureDataset.Destroy;
begin
  if Assigned(FDataSources) then FreeAndNil(FDataSources);

  inherited;
end;

{ TdmModuleImportPHA }

function TdmModuleImportPHA.CreerDonnees(
  ADonnees: TDonneesFormatees): TResultatCreationDonnees;
begin

end;

procedure TdmModuleImportPHA.DataModuleCreate(Sender: TObject);
begin
  inherited;

  dmModuleImportPHA := Self;

  trModuleImport.Database := Module.Projet.PHAConnexion;

  setFichiersManquants.Database := Module.Projet.PHAConnexion;
  setConversionsOrganismesAMO.DataBase := Module.Projet.PHAConnexion;
  setConversionsCouverturesAMO.DataBase := Module.Projet.PHAConnexion;
  setPrestations.Database := Module.Projet.PHAConnexion;
  setListeClients.Database := Module.Projet.PHAConnexion;

  setOrganismesAMORef.Database := Module.Projet.PHAConnexion;
  setCouverturesAMORef.Database := Module.Projet.PHAConnexion;
  setFournisseursRef.Database := Module.Projet.PHAConnexion;
  setRepartiteursRef.Database := Module.Projet.PHAConnexion;
  setReferenceAnalytiquesRef.Database := Module.Projet.PHAConnexion;

  ShortDateFormat := 'YYYY/MM/DD';
  FChangementDonneesConversion := False;

  FParametresODBC := TDictionary<string, string>.Create;
end;

destructor TdmModuleImportPHA.Destroy;
begin
  if Assigned(FParametresODBC) then
    FreeAndNil(FParametresODBC);

  inherited;
end;

procedure TdmModuleImportPHA.setConversionsCouverturesAMOBeforeClose(
  DataSet: TDataSet);
begin
  inherited;

  if setListeClients.Active then setListeClients.Close;
 // if setPrestations.Active then setPrestations.Close;
end;

procedure TdmModuleImportPHA.setConversionsCouverturesAMOAfterScroll(
  DataSet: TDataSet);
var
  i : Integer;
begin
  inherited;

  if setConversionsCouverturesAMO.Active then
  begin
    setPrestations.Params.ByNameAsString['T_COUVERTURE_AMO_ID'] := setConversionsCouverturesAMOT_COUVERTURE_AMO_ID.AsString;
    setPrestations.Open;

    // Mise en forme
    setPrestations.FieldByName('T_COUVERTURE_AMO_ID').Visible := False;
    for i := 1 to setPrestations.FieldCount - 1 do
      setPrestations.Fields[i].DisplayWidth := 4;

  end;
end;

procedure TdmModuleImportPHA.SupprimerDonnees(
  ADonneesASupprimer: TList<Integer>);
var
  lQry : TUIBQuery;
  i : TSuppression;
  j : Integer;
begin
  inherited;

  lQry := nil;
  if ADonneesASupprimer.Count = 0 then
    for i := Low(TSuppression) to High(TSuppression) do
      ADonneesASupprimer.Add(Ord(i));

  with ParametresThreadRequeteFB do
  begin
      // Préparation
      if Module.Projet.Thread then
      begin
        NomProcedure := 'PS_SUPPRIMER_DONNEES_PHA';
        NombreParametresProc := 1;

        for j := 0 to ADonneesASupprimer.Count - 1 do
        begin
          ParametresProc[0] := ADonneesASupprimer[j];
          AttendreFinExecution(Self,
                               taLibelle,
                               TThreadRequeteFB,
                               ParametresThreadRequeteFB,
                               'Suppression des ' + IfThen(TSuppression(ADonneesASupprimer[j]) <= High(TSuppression), LibelleDonneesASupprimer[TSuppression(ADonneesASupprimer[j])], 'données (' + IntToStr(j) + ')') + ' ...');
          if not Erreur.Etat then
            raise EDatabaseError.Create(Erreur.Message);
        end
      end
      else
        try
          lQry := TUIBQuery.Create(nil);
          lQry.Database := Module.Projet.PHAConnexion;
          lQry.Transaction := TUIBTransaction.Create(nil);
          lQry.Transaction.Database := Module.Projet.PHAConnexion;
          lQry.Transaction.StartTransaction;
          lQry.BuildStoredProc('PS_SUPPRIMER_DONNEES_PHA');

          for j := 0 to ADonneesASupprimer.Count - 1 do
          begin
            lQry.Params.ByNameAsSmallint['ATYPESUPPRESSION'] := ADonneesASupprimer[j];
            lQry.Execute;
            lQry.Close(etmCommit);
          end;
        except
          lQry.Close(etmRollback);
          raise;
        end;
    end;

  Application.ProcessMessages;
end;

procedure TdmModuleImportPHA.ConvertirDonnees(AListeProcedures : TStringList);
var
  i : Integer;

  procedure ExecuterConversion(APS : string);
  begin
    if Module.Projet.Thread then
      with ParametresThreadRequeteFB do
      begin
        NomProcedure := APS;
        NombreParametresProc := 0;

        AttendreFinExecution(Self, taLibelle, TThreadRequeteFB, ParametresThreadRequeteFB, 'Exécution de ' + APS);
      end
    else
      with qryPHA do
        try
          qryPHA.Transaction.StartTransaction;
          BuildStoredProc(APS);
          Execute;
          Close(etmCommit);
          ParametresThreadRequeteFB.Erreur.Etat := True;
        except
          on E:Exception do
          begin
            Close(etmRollback);
            ParametresThreadRequeteFB.Erreur.Etat := False;
            ParametresThreadRequeteFB.Erreur.Message := E.Message;
          end;
        end;

    // Résultat
    if not ParametresThreadRequeteFB.Erreur.Etat then
      MessageDlg('Erreur durant les conversions automatiques de données !'#13#10#13#10'Message : '  + ParametresThreadRequeteFB.Erreur.Message,
                 mtError, [mbOk], 0);
  end;

begin
  if not (Module.Projet.ModuleEnCours.IHM as TfrModule).EnTraitement then
  begin
    if setConversionsOrganismesAMO.Active then setConversionsOrganismesAMO.Close;
    if setConversionsCouverturesAMO.Active then setConversionsCouverturesAMO.Close;
    trModuleImport.Commit;

    for i := 0 to AListeProcedures.Count - 1 do
      ExecuterConversion(AListeProcedures[i]);
  end
  else
    MessageDlg('Impossible d''éxécuter les conversions pendant un traitement !', mtWarning, [mbOk], 0);
end;

procedure TdmModuleImportPHA.setConversionsOrgCouvAMOAfterPost(
  DataSet: TDataSet);
begin
  inherited;

  FChangementDonneesConversion := True;
end;

procedure TdmModuleImportPHA.trInterneEndTransaction(Sender: TObject;
  var Mode: TEndTransMode);
begin
  inherited;

  if Mode = etmCommit then
    FChangementDonneesConversion := False;
end;

procedure TdmModuleImportPHA.setConversionsCouverturesAMOBeforeOpen(
  DataSet: TDataSet);
begin
  inherited;

  AjouterWhere(setListeClients.SQL, 't_couverture_amo_id = :T_COUVERTURE_AMO_ID');
end;

procedure TdmModuleImportPHA.setConversionsFournisseursBeforeOpen(
  DataSet: TDataSet);
begin
  inherited;

  AjouterWhere(setListeClients.SQL, 't_fournisseur = :T_FOURNISSEUR');
end;

procedure TdmModuleImportPHA.setConversionsRepartiteursBeforeOpen(
  DataSet: TDataSet);
begin
  inherited;

  AjouterWhere(setListeClients.SQL, 't_repartiteur = :T_REPARTITEUR');
end;

procedure TdmModuleImportPHA.setConversionsReferenceAnalytiquesBeforeOpen(
  DataSet: TDataSet);
begin
  inherited;

  AjouterWhere(setListeClients.SQL, 't_ficheanalyse = :T_FICHEANALYSE');
end;

procedure TdmModuleImportPHA.setConversionsOrganismesAMOBeforeOpen(
  DataSet: TDataSet);
begin
  inherited;

  AjouterWhere(setListeClients.SQL, 't_organisme_amo_id = :T_ORGANISME_AMO_ID');
end;

procedure TdmModuleImportPHA.setConversionsOrganismesAMOBeforeClose(
  DataSet: TDataSet);
begin
  inherited;

  if setListeClients.Active then setListeClients.Close;
end;

procedure TdmModuleImportPHA.setConversionsComptesBeforeOpen(
  DataSet: TDataSet);
begin
  inherited;

  AjouterWhere(setListeClients.SQL, 'lower(nom) like lower(:ANOM) || ' + '''' + '%' + '''' + ' and lower(prenom) like lower(:APRENOM) || ' + '''' + '%' + '''');
end;

procedure TdmModuleImportPHA.ImpExpConversions(AImpExp : Boolean);
const
  C_LIBELLE_ACTION : array[Boolean] of string = ('Importation', 'Exportation');

  procedure ExecuterImpExp(ADonnee : Integer; AFichier, AMessage : string);
  var
    f : string;
  begin
    f := Module.Projet.RepertoireProjet + '\' + AFichier + '.dat';
    if AImpExp or (not AImpExp and FileExists(f)) then
    begin
      if Module.Projet.Thread then
        with ParametresThreadRequeteFB do
        begin
          NomProcedure := 'PS_IMPEXP_CONVERSION';
          NombreParametresProc := 3;

          ParametresProc[0] := ADonnee;
          ParametresProc[1] := f;
          ParametresProc[2] := IntToStr(Ord(AImpExp));
          AttendreFinExecution(Self, taLibelle, TThreadRequeteFB, ParametresThreadRequeteFB, AMessage);
        end
      else
        with qryPHA do
          try
            qryPHA.Transaction.StartTransaction;
            BuildStoredProc('PS_IMPEXP_CONVERSION');
            Params.ByNameAsInteger['ADONNEE'] := ADonnee;
            Params.ByNameAsString['AFICHIER'] := f;
            Params.ByNameAsString['AIMPEXP'] := IntToStr(Ord(AImpExp));
            Execute;
            Close(etmCommit);
            ParametresThreadRequeteFB.Erreur.Etat := True;
          except
            on E:Exception do
            begin
              Close(etmRollback);
              ParametresThreadRequeteFB.Erreur.Etat := False;
              ParametresThreadRequeteFB.Erreur.Message := E.Message;
            end;
          end;

      // Résultat
      if not ParametresThreadRequeteFB.Erreur.Etat then
        MessageDlg('Erreur durant l''export ou l''import des conversions !'#13#10#13#10'Message : '  + ParametresThreadRequeteFB.Erreur.Message,
                   mtError, [mbOk], 0);
    end
    else
      if not AImpExp then MessageDlg('Les fichiers de conversions n''existent pas ! Impossible d''importer les conversions !', mtWarning, [mbOk], 0);
  end;

begin
  if not (Module.Projet.ModuleEnCours.IHM as TfrModule).EnTraitement then
  begin
    trModuleImport.CommitRetaining;

    // Exécution
    ExecuterImpExp(0, 'organismes_amo', C_LIBELLE_ACTION[AImpExp] + ' des organismes AMO ...');
    ExecuterImpExp(1, 'couvertures_amo', C_LIBELLE_ACTION[AImpExp] + ' des couvertures AMO ...');
  //    ExecuterConversion('PS_CONVERTIR_COUVERTURES_AMC', 'Conversions des couvertures AMC ...');
    ExecuterImpExp(2, 'comptes', C_LIBELLE_ACTION[AImpExp] + ' des comptes ...');
  //    ExecuterConversion('PS_CONVERTIR_CP_VILLE', 'Conversions des codes postaux/villes ...');

    Module.Projet.FichierProjet.DocumentElement.ChildNodes['informations_generales'].Attributes['date_conversions'] := Now;
  end
  else
    MessageDlg('Impossible d''importer ou d''exporter les conversions pendant un traitement !', mtWarning, [mbOk], 0);
end;

procedure TdmModuleImportPHA.OuvrirListeClients;
begin
  if setConversionsOrganismesAMO.Active or setConversionsCouverturesAMO.Active then
  begin
    if setConversionsOrganismesAMO.Active then
    begin
      setConversionsOrganismesAMOBeforeClose(nil);
      setListeClients.Params.ByNameAsString['T_ORGANISME_AMO_ID'] := string(setConversionsOrganismesAMOT_ORGANISME_AMO_ID.AsString);
    end;

    if setConversionsCouverturesAMO.Active then
    begin
      setConversionsCouverturesAMOBeforeClose(nil);
      setListeClients.Params.ByNameAsString['T_COUVERTURE_AMO_ID'] := string(setConversionsCouverturesAMOT_COUVERTURE_AMO_ID.AsString);
    end;

    setListeClients.Open;
  end;
end;

end.