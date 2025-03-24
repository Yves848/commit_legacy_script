unit mdlModuleImport;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, mdlModule, PdfDoc, PReport, ExtCtrls, Menus, JvMenus, pngimage,
  mdlPIPanel, JvWizard, JvWizardRouteMapNodes, Grids, mdlPIStringGrid,
  JvExControls, DB, DBGrids, mdlPIDBGrid, mdlProjet, StdCtrls, mdlConversions,
  ComCtrls, mdlGrille, UIB, JvXPCore, JvXPContainer, ImgList, ActnList,
  mdlLectureFichierBinaire, mdlAttente, mdlPHA, Contnrs, JvXPBar, mdlPIButton,
  Rtti, TypInfo, VirtualTrees, JvExExtCtrls, JvNetscapeSplitter, ShellAPI,
  StrUtils, Sockets; // pour plus tard ,IOUtils ;

type
  TfrModuleImport = class(TfrModule, IInterface)
    grdFichiersManquants: TPIDBGrid;
    dsFichiersManquants: TDataSource;
    wipConversions: TJvWizardInteriorPage;
    tctlConversions: TTabControl;
    mnuOutils: TMenuItem;
    mnuOutilsInventaire: TMenuItem;
    mnuSeparateur_1: TMenuItem;
    mnuReprise: TMenuItem;
    mnuRepriseConversions: TMenuItem;
    mnuRepriseConversionsImporter: TMenuItem;
    mnuRepriseConversionsExporter: TMenuItem;
    N1: TMenuItem;
    mnuRepriseConversionTIFF: TMenuItem;
    procedure SurAnnulation(Sender : TObject);
    procedure wzDonneesActivePageChanging(Sender: TObject;
      var ToPage: TJvWizardCustomPage);
    procedure wzDonneesActivePageChanged(Sender: TObject);
    procedure tctlConversionsChange(Sender: TObject);
    procedure grdFichiersManquantsSurAppliquerProprietesCellule(
      Sender: TObject; ACol, ALig: Integer; ARect: TRect;
      var AFond: TColor; APolice: TFont; var AAlignement: TAlignment;
      AEtat: TGridDrawState);
    procedure grdFichiersManquantsColumns3SurCocher(Sender: TObject;
      var AAccepter: Boolean; AValeur: Boolean);
    procedure tctlConversionsChanging(Sender: TObject;
      var AllowChange: Boolean);
    procedure wipConversionsEnterPage(Sender: TObject;
      const FromPage: TJvWizardCustomPage);
    procedure mnuOutilsInventaireClick(Sender: TObject);
    procedure mnuRepriseConversionsImporterClick(Sender: TObject);
    procedure mnuRepriseConversionsExporterClick(Sender: TObject);
    procedure grdFichiersManquantsSurDessinerColonne(Sender: TObject;
      const Rect: TRect; DataCol: Integer; Column: TColumn;
      State: TGridDrawState);
    procedure mnuRepriseConversionTIFFClick(Sender: TObject);
  private
    { Déclarations privées }
    FEtatAttention : TPngImage;
    FListeClassesConversions : TClassList;
    FListeProceduresConversions : TStringList;
    FConversionEnCours : TfrConversions;
    FLectureFichierBinaire: TClasseFichierBinaire;
    FRejets : TextFile;
    procedure ChargerConversions(AConversions : Integer);
  protected
    procedure TraiterDonneesPraticiens; override;
    procedure TraiterDonneesOrganismes; override;
    procedure TraiterDonneesClients; override;
    procedure TraiterDonneesProduits; override;
    procedure FinTraitement(AFichier : TFichierBinaire); virtual;
    function FaireTraitementDonnees(ADonnees : TDonneesFormatees) : TResultatCreationDonnees; overload; virtual; abstract;
    procedure TraiterDonnee(ATraitement : TTraitement); override;
    procedure TraiterDocumentSF(ATraitement : TTraitement; ARepertoire, AFiltre : string;
      AConversionTIFF, ARecursif : Boolean); virtual;
    function FaireTraitementDocumentSF(ARepertoire, AFichier : string) : TResultatCreationDonnees; virtual; abstract;
    procedure FinTraitementDocumentsSF; virtual;
  public
    { Déclarations publiques }
    constructor Create(AOwner : TComponent; AModule : TModule); override;
    destructor Destroy; override;
    procedure Hide; override;
    property LectureFichierBinaire : TClasseFichierBinaire read FLectureFichierBinaire write FLectureFichierBinaire;
  end;

  ITransfertFTP = interface
    ['{6A864F22-7A9B-47DF-91B8-4AE86E666B42}']
    function RenvoyerFichiersATelecharger : TStrings;
  end;

implementation

uses mdlModuleImportPHA, mdlConversionsOrganismesAMO,
  mdlConversionsCouverturesAMO, mdlConversionsComptes, mdlLIsteClients,
  fbcustomdataset, XMLIntf, mdlConversionsFournisseurs,
  mdlConversionsRepartiteurs, mdlConversionsReferenceAnalytiques, mdlConversionsTIFF,
  mdlOptionsSCANS;

{$R *.dfm}
{$R xml_rejets.res}

procedure TfrModuleImport.FinTraitement(AFichier : TFichierBinaire);
begin
  (PHA as TdmModuleImportPHA).DePreparerCreationDonnees(FResultat <> rcdErreurSysteme);
  if Assigned(TraitementEnCours) then
  begin
    TraitementEnCours.Fait := (FResultat <> rcdErreurSysteme) and not Annulation;
    if TraitementEnCours.Fait then  Module.Projet.FichierProjet.SaveToFile;
  end;
end;

procedure TfrModuleImport.TraiterDonnee(ATraitement: TTraitement);
const
  C_REJETS_DONNEES_BRUT_XML : string = '<donnee nom="%s" valeur="%s"/>';
  C_LIMITE_XML_REJETS : Integer = 10*1024*1024;
var
  lFichier : TFichierBinaire;
  i, idx_xml : Integer;
  lBoolCreeXML : Boolean;

  procedure CreerFichierXMLRejets(AIndice : Integer);
  begin
    // Création d'un fichier des rejets
    AssignFile(fRejets, Module.Projet.RepertoireProjet + '\rejets\' + TraitementEnCours.Fichier + IntToStr(AIndice) + '.rejets.xml');
    Rewrite(fRejets);

    with TStringList.Create do
    begin
      LoadFromStream(TResourceStream.Create(hInstance, 'DEBUT_XML_REJETS', 'TEXT'));
      Writeln(fRejets, StringReplace(Text, '#FICHIER#', TraitementEnCours.Fichier, [rfReplaceAll]));
      Free;
    end;
  end;

  procedure FermerFichierXML;
  begin
    with TStringList.Create do
    begin
      LoadFromStream(TResourceStream.Create(hInstance, 'FIN_XML_REJETS', 'TEXT'));
      Writeln(fRejets, Text);
      Free;
    end;
    CloseFile(fRejets);
  end;

  function ConvertirChaineVersHTML(AChaine : string) : string;
  var
    i, l : Integer;
  begin
    l := Length(AChaine); Result := '';
    for i := 1 to l do
      case AChaine[i] of
        '"' : Result := Result + '&quot;';
        '>' : Result := Result + '&gt;';
        '<' : Result := Result + '&lt;';
        '&' : Result := Result + '&amp;';
        '{' : Result := Result + '(';
        '}' : Result := Result + ')';
      else
        Result := Result + AChaine[i];
      end;
  end;

begin
  if not Annulation then
  begin
    if (ATraitement.Fichier = 'SCANS') then
      with TfrmOptionsSCANS.Create(Application.MainForm, Module.Projet) do
      begin
        if ShowModal = mrOk then
          TraiterDocumentSF(ATraitement, edtRepertoire.Directory, cbxFiltre.Text, chkConversion.Checked, chkRecursif.Checked);
        Free;
      end
    else
    begin
      TraitementEnCours := ATraitement;
      TraitementEnCours.Fait := False;
      try
        if TraitementEnCours.TypeTraitement = ttProcedure then
          inherited
        else
        begin
          lFichier := nil;
          lFichier := FLectureFichierBinaire.Create(Module.Projet.RepertoireProjet +  ATraitement.Fichier,
                                                    Pointer(Module.Projet.FichierProjet.DocumentElement.ChildNodes['modules'].ChildNodes['import'].ChildNodes['options']));
          TraitementEnCours.FichierPresent := True;

          // Boucle
          idx_xml := 0; lBoolCreeXML := True;
          repeat
            if lBoolCreeXML then
            begin
              CreerFichierXMLRejets(idx_xml);
              lBoolCreeXML := False;
            end;

            lFichier.Suivant;
            FResultat := FaireTraitementDonnees(lFichier.Donnees);
            case FResultat of
              rcdImportee : TraitementEnCours.Succes := TraitementEnCours.Succes + 1;
              rcdAvertissement : TraitementEnCours.Avertissements := TraitementEnCours.Avertissements + 1;
              rcdRejetee :
                begin
                  TraitementEnCours.Rejets := TraitementEnCours.Rejets + 1;

                  // Ecriture des données
                  with lFichier.DonneesBrut do
                  begin
                    // Entetes
                    if TraitementEnCours.Rejets = 1 then
                    begin
                      Writeln(fRejets, '<entetes>');
                      for i := 0 to Count - 1 do
                        Write(fRejets, '<entete>', Names[i], '</entete>');
                      Writeln(fRejets, '</entetes>');
                    end;

                    // Données
                    Writeln(fRejets, '<donnees>');
                    for i := 0 to Count - 1 do
                      Write(fRejets, Format(C_REJETS_DONNEES_BRUT_XML, [Names[i], ConvertirChaineVersHTML(ValueFromIndex[i])]));
                    Writeln(fRejets, '</donnees>');
                  end;
                end;
              rcdErreur : TraitementEnCours.Erreurs := TraitementEnCours.Erreurs + 1;
            else
              Abort;
            end;

            if lFichier.EnregNo mod 20000 = 0 then (PHA as TdmModuleImportPHA).DePreparerCreationDonnees(True);
            if FileSize(fRejets) * 128 > C_LIMITE_XML_REJETS then
            begin
              FermerFichierXML;
              lBoolCreeXML := True;
              Inc(idx_xml);
            end;

          until lFichier.EOF or Annulation;
          FermerFichierXML;
        end;
        FinTraitement(lFichier);
      except
        on E:ERangeError do
        begin
          Module.Projet.Console.AjouterLigne(ATraitement.Fichier + ' : ' + E.Message + ' à ma position ' + IntToStr(lFichier.EnregNo) + '/' + IntToStr(lFichier.Position));
          TraitementEnCours.FichierPresent := False;
          FResultat := rcdErreurSysteme;
        end;

        on EFOpenError do
        begin
          Module.Projet.Console.AjouterLigne('Impossible d''ouvrir le fichier ' + ATraitement.Fichier);
          TraitementEnCours.FichierPresent := False;
          FResultat := rcdErreurSysteme;
        end;

        on E:Exception do
        begin
          Module.Projet.Console.AjouterLigne(ATraitement.Fichier + ' : ' + E.Message);
          FResultat := rcdErreurSysteme;
        end;
      end;

      if Assigned(lFichier) then
        FreeAndNil(lFichier);
    end;
  end;
end;

constructor TfrModuleImport.Create(AOwner: TComponent; AModule: TModule);
var
  lPage : TJvWizardCustomPage;
  lPays : IXMLNode;
  i : Integer;
begin
  inherited;

  if AModule.TypeModule <> tmImport then
    raise EModule.Create('Type de module incorrecte !')
  else
  begin
    FConversionEnCours := nil;

    ChargerBitmap('ETAT_ATTENTION', 'PNG', FEtatAttention);

    lPage := wipBienvenue;

    if ((PHA as TdmModuleImportPHA).setFichiersManquants.Params.ByNameAsString['AREPERTOIRE']='') then
      (PHA as TdmModuleImportPHA).setFichiersManquants.Params.ByNameAsString['AREPERTOIRE'] := Module.Projet.RepertoireProjet;

    FListeProceduresConversions := TStringList.Create;   
    FListeClassesConversions := TClassList.Create;
    with Module.Projet.FichierParametres.DocumentElement.ChildNodes['ListePays'] do
    begin
      i := 0; lPays := nil;
      while not Assigned(lPays) and (i < ChildNodes.Count) do
        if ChildNodes[i].Attributes['code'] = Module.Pays then
          lPays := ChildNodes[i]
        else
          Inc(i);

      if Assigned(lPays) then
      begin
        // Liste des interfaces
        for i := 0 to lPays.ChildNodes['Conversions'].ChildNodes.Count - 1 do
        begin
          FListeClassesConversions.Add(GetClass(lPays.ChildNodes['Conversions'].ChildNodes[i].Attributes['classe']));
          tctlConversions.Tabs.Add(lPays.ChildNodes['Conversions'].ChildNodes[i].Attributes['libelle']);
          FListeProceduresConversions.Add(lPays.ChildNodes['Conversions'].ChildNodes[i].Attributes['procedure']);
        end;

        // Liste des procedures*
        for i := 0 to lPays.ChildNodes['AutresConversions'].ChildNodes.Count - 1 do
          FListeProceduresConversions.Add(lPays.ChildNodes['AutresConversions'].ChildNodes[i].NodeValue);
      end;
    end;

    wipConversions.Enabled := FListeClassesConversions.Count > 0;
    wzDonneesActivePageChanging(Self, lPage);
    wipRecapitulatif.PageIndex := wzDonnees.PageCount - 1;
    wipConversions.PageIndex := wzDonnees.PageCount - 2;

    // Gestion de l'inventaire
    mnuOutilsInventaire.Visible := Supports(Self, IInventaire);
  end;
end;

procedure TfrModuleImport.wzDonneesActivePageChanging(Sender: TObject;
  var ToPage: TJvWizardCustomPage);
var
  f, d : Boolean;
begin
  inherited;

  if Assigned(Module) then
  begin
    // Vérification fichiers
    with (PHA as TdmModuleImportPHA).setFichiersManquants do
    begin
      if Active then
      begin
        if dsFichiersManquants.State = dsEdit then
          Post;
        Close;
        Transaction.Commit;
      end;

      Transaction.StartTransaction;
      Open;
      DisableControls;
      First;

      // Controle des fichiers obligatoire
      f := False; d := False;
      while not EOF and not (f and d) do
      begin
        f := (FieldByName('APRESENCE').AsWideString = '0') and (FieldByName('AREQUIS').AsWideString = '1') and (FieldByName('AVALIDATIONABSENCE').AsWideString = '0');
        d := dmModuleImportPHA.setFichiersManquants.FieldByName('ADATEHEURE').AsDateTime < Date - 7;
        Next;
      end;

      if Visible and wipBienvenue.Visible then
      begin
        if d and Module.Projet.Ouvert then
          MessageDlg('Certain(s) fichier(s) ont une date de dernière modification ancienne !', mtWarning, [mbOk], 0);

        if f then
        begin
          MessageDlg('Certain(s) fichier(s) sont manquants ! Veuillez validez leur(s) absence(s).', mtWarning, [mbOk], 0);
          ToPage := wipBienvenue;
        end;
      end;

      First;
      EnableControls;
    end;

    if (wzDonnees.ActivePageIndex = wipConversions.PageIndex) then
    begin
      frmListeClients.Close;
      if Assigned(FConversionEnCours) then FConversionEnCours.Fermer;

      Module.Projet.FichierProjet.SaveToFile;
    end;
  end;
end;

procedure TfrModuleImport.wzDonneesActivePageChanged(Sender: TObject);

  procedure LancerConversions;
  begin
    if Assigned(FConversionEnCours) then
      FConversionEnCours.Fermer;
    (PHA as TdmModuleImportPHA).ConvertirDonnees(FListeProceduresConversions);
    Module.Projet.FichierProjet.DocumentElement.ChildNodes['informations_generales'].Attributes['date_conversions'] := Now;
  end;

begin
  inherited;

  xpcOutils.Visible := wzDonnees.ActivePageIndex < wzDonnees.PageCount - 2;
  if Assigned(Module) then
    with (PHA as TdmModuleImportPHA) do
    begin
      if wzDonnees.ActivePageIndex = C_INDEX_PAGE_BIENVENUE then
      begin
        if not setFichiersManquants.Active then
        begin
          setFichiersManquants.Transaction.StartTransaction;
          setFichiersManquants.Open;
        end;
      end
      else if wzDonnees.ActivePageIndex = wipConversions.PageIndex then
      begin
        xpcOutils.Visible := False;
        if not Assigned(Sender) then
          LancerConversions
        else
          if Module.Projet.FichierProjet.DocumentElement.ChildNodes['informations_generales'].Attributes['date_conversions'] = '' then
            LancerConversions;

        if not Assigned(FConversionEnCours) then
          ChargerConversions(tctlConversions.TabIndex)
        else
          FConversionEnCours.Ouvrir;
      end
      else
        if setFichiersManquants.Active then
        begin
          setFichiersManquants.Close;
          setFichiersManquants.Transaction.Commit;
        end;
    end;
end;

destructor TfrModuleImport.Destroy;
var
  i : Integer;
begin
  if mdlListeClients.frmExiste then frmListeClients.Free;
  if mdlConversionsTIFF.frmExiste then frmConversionTIFF.Free;

  for i := 0 to tctlConversions.Tabs.Count - 1 do
    if Assigned(tctlConversions.Tabs.Objects[i]) then
      tctlConversions.Tabs.Objects[i].Free;

  if Assigned(FListeClassesConversions) then FreeAndNil(FListeClassesConversions);
  if Assigned(FListeProceduresConversions) then FreeAndNil(FListeProceduresConversions);

  inherited;
end;

procedure TfrModuleImport.tctlConversionsChange(Sender: TObject);
begin
  ChargerConversions(tctlConversions.TabIndex);
end;

procedure TfrModuleImport.grdFichiersManquantsSurAppliquerProprietesCellule(
  Sender: TObject; ACol, ALig: Integer; ARect: TRect; var AFond: TColor;
  APolice: TFont; var AAlignement: TAlignment; AEtat: TGridDrawState);
begin
  inherited;

  if ALig > C_LIGNE_TITRE then
    with (PHA as TdmModuleImportPHA).setFichiersManquants do
    begin
      if (FieldByName('APRESENCE').AsWideString = '0') and (FieldByName('AREQUIS').AsWideString = '1') and (FieldByName('AVALIDATIONABSENCE').AsWideString = '0') then
      begin
        AFond := clRed;
        APolice.Color := clWindow;
      end;
    end;
end;

procedure TfrModuleImport.grdFichiersManquantsColumns3SurCocher(
  Sender: TObject; var AAccepter: Boolean; AValeur: Boolean);
begin
  inherited;

  with (PHA as TdmModuleImportPHA).setFichiersManquants do
    AAccepter := (FieldByName('AREQUIS').AsWideString = '1') and (FieldByName('APRESENCE').AsWideString = '0') {and (FieldByName('AVALIDATIONABSENCE').AsString = '0')};
end;

procedure TfrModuleImport.tctlConversionsChanging(Sender: TObject;
  var AllowChange: Boolean);
begin
  inherited;

  // On cache la frame courante
  if Assigned(FConversionEnCours) then
    FConversionEnCours.Fermer;
end;

procedure TfrModuleImport.wipConversionsEnterPage(Sender: TObject;
  const FromPage: TJvWizardCustomPage);
begin
  inherited;

  tctlConversions.TabIndex := 0;
end;

procedure TfrModuleImport.ChargerConversions(AConversions: Integer);
var
  lClasseConversions : TClasseFrConversions;
begin
  with tctlConversions do
  begin
    // Si inexistante, cnstruction de la frame demandée
    if not Assigned(Tabs.Objects[AConversions]) then
    begin
      if AConversions < FListeClassesConversions.Count then
        lClasseConversions := TClasseFrConversions(FListeClassesConversions[AConversions])
      else
        lClasseConversions := nil;

      if Assigned(lClasseConversions) then
      begin
        FConversionEnCours := lClasseConversions.Create(Self, Module.Projet);
        FConversionEnCours.Parent := tctlConversions;

        Tabs.Objects[AConversions] := FConversionEnCours;
      end;
    end;

    FConversionEnCours := TfrConversions(Tabs.Objects[AConversions]);
    FConversionEnCours.Ouvrir;
  end;
end;

procedure TfrModuleImport.mnuOutilsInventaireClick(Sender: TObject);
var
  lInventaire : TStringList;
begin
  inherited;

  if mnuOutilsInventaire.Visible then
  begin
    lInventaire := TStringList((Self as IInventaire).GenererInventaire);
    lInventaire.SaveToFile(Module.Projet.RepertoireProjet + '\inventaire.txt');
    MessageDlg('Inventaire exporté !', mtInformation, [mbOk], 0);
    FreeAndNil(lInventaire);
  end;
end;

procedure TfrModuleImport.Hide;
begin
  inherited;

  if frmListeClients.Visible then
    frmListeClients.Hide;
end;

procedure TfrModuleImport.mnuRepriseConversionsImporterClick(
  Sender: TObject);
begin
  inherited;

  if Assigned(FConversionEnCours) then FConversionEnCours.Fermer;
  dmModuleImportPHA.ImpExpConversions(False);
  if Assigned(FConversionEnCours) then FConversionEnCours.Ouvrir;
end;

procedure TfrModuleImport.mnuRepriseConversionTIFFClick(Sender: TObject);
begin
  inherited;

  frmConversionTIFF.Show;
end;

procedure TfrModuleImport.SurAnnulation(Sender: TObject);
begin
  // Vérification s une conversion TIFF est en cours
  if Assigned(frmConversionTIFF.THConversions) then
    frmConversionTIFF.THConversions.Terminate;
end;

procedure TfrModuleImport.mnuRepriseConversionsExporterClick(
  Sender: TObject);
begin
  inherited;

  dmModuleImportPHA.ImpExpConversions(True);
end;

procedure TfrModuleImport.TraiterDocumentSF(ATraitement: TTraitement;
  ARepertoire, AFiltre: string; AConversionTIFF, ARecursif: Boolean);
var
  i : Integer;

  procedure ChercherDocuments(r, f : string);
  var
    ext : string;
    sr : TSearchRec;
  begin
    if FindFirst(r + '*.*', faAnyFile, sr) = 0 then
    begin
      repeat
        if (sr.Name <> '.') and (sr.Name <> '..') then
          if ARecursif and ((sr.Attr and faDirectory) = faDirectory) then
            ChercherDocuments(r  + includetrailingbackslash(sr.Name), f)
          else
          begin
            ext := copy(UpperCase(ExtractFileExt(sr.Name)),2,3);
            if ((sr.Attr and faDirectory) <> faDirectory) and (pos(IfThen(ext = '', '.', ext),UpperCase(f))>0) then
            begin
              FResultat := FaireTraitementDocumentSF(r, sr.Name);
              case FResultat of
                rcdImportee : TraitementEnCours.Succes := TraitementEnCours.Succes + 1;
                rcdAvertissement : TraitementEnCours.Avertissements := TraitementEnCours.Avertissements + 1;
                rcdRejetee : TraitementEnCours.Rejets := TraitementEnCours.Rejets + 1;
                rcdErreur : TraitementEnCours.Erreurs := TraitementEnCours.Erreurs + 1;
              else
                Abort;
              end;

              Inc(i);
              if i mod 250 = 0 then
                dmModuleImportPHA.DePreparerCreationDonnees(True);
            end;
          end;
      until (FindNext(sr) <> 0) or Annulation;
      FindClose(sr);
    end;
  end;

begin
  if not Annulation then
  begin
    try
      SurAnnulerTraitement := SurAnnulation;

      TraitementEnCours := ATraitement;
      TraitementEnCours.Fait := False;

      ChercherDocuments(includetrailingbackslash(ARepertoire), AFiltre);

    except
      on E:Exception do
      begin
        Module.Projet.Console.AjouterLigne(ATraitement.Fichier + ' : ' + E.Message);
        FResultat := rcdErreurSysteme;
      end;
    end;
    FinTraitementDocumentsSF;
  end;
end;

procedure TfrModuleImport.TraiterDonneesClients;
begin
  inherited;

  Module.Projet.FichierProjet.DocumentElement.ChildNodes['informations_generales'].Attributes['date_conversions'] := '';
end;

procedure TfrModuleImport.TraiterDonneesOrganismes;
begin
  inherited;

  Module.Projet.FichierProjet.DocumentElement.ChildNodes['informations_generales'].Attributes['date_conversions'] := '';
end;

procedure TfrModuleImport.TraiterDonneesPraticiens;
begin
  inherited;

  Module.Projet.FichierProjet.DocumentElement.ChildNodes['informations_generales'].Attributes['date_conversions'] := '';
end;

procedure TfrModuleImport.TraiterDonneesProduits;
begin
  inherited;

  Module.Projet.FichierProjet.DocumentElement.ChildNodes['informations_generales'].Attributes['date_conversions'] := '';
end;

procedure TfrModuleImport.grdFichiersManquantsSurDessinerColonne(
  Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
var
  r : TRect;
begin
  inherited;

  if DataCol = grdFichiersManquants.ColonneParNom('ADATEHEURE').Index then
    if (not dmModuleImportPHA.setFichiersManquants.FieldByName('ADATEHEURE').IsNull) and
       (dmModuleImportPHA.setFichiersManquants.FieldByName('ADATEHEURE').AsDateTime < Date - 7) then
    begin
      grdFichiersManquants.Canvas.Brush.Color := grdFichiersManquants.Color;
      r := Rect;
      r.Left := r.Left + 1;
      r.Right := r.Left + 16;
      r.Top := r.Top + 1;
      grdFichiersManquants.Canvas.FillRect(r);

      grdFichiersManquants.Canvas.Draw(r.Left, r.Top, FEtatAttention);
    end;
end;

procedure TfrModuleImport.FinTraitementDocumentsSF;
begin
  (PHA as TdmModuleImportPHA).DePreparerCreationDonnees(FResultat <> rcdErreurSysteme);
  if Assigned(TraitementEnCours) then
    TraitementEnCours.Fait := (FResultat <> rcdErreurSysteme) and not Annulation;
end;

initialization
  RegisterClasses([TfrConversionsOrganismesAMO, TfrConversionsCouverturesAMO, TfrConversionsComptes,
    TfrConversionsFournisseurs, TfrConversionsRepartiteurs, TfrConversionsReferenceAnalytiques]);

finalization
  UnRegisterClasses([TfrConversionsOrganismesAMO, TfrConversionsCouverturesAMO, TfrConversionsComptes,
    TfrConversionsFournisseurs, TfrConversionsRepartiteurs,TfrConversionsReferenceAnalytiques]);

end.
