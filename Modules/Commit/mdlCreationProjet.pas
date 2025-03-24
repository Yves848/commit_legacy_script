unit mdlCreationProjet;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, mdlProjet, StdCtrls, Buttons, IOUtils, Generics.Collections,
  ImgList, ComCtrls, ToolWin, ActnList, ActnMan, ActnCtrls, mdlBase, Mask,
  JvExMask, JvToolEdit, JvCombobox, JvExStdCtrls, JvGroupBox, mdlPIGroupBox, JclSysInfo;

type
  TfrmCreationProjet = class(TfrmBase)
    imgCreateProjectWizard: TImage;
    pnlCreateProject: TPanel;
    pnlSysteme: TPIGroupBox;
    cbxModuleTransfert: TComboBox;
    gbxFichierProjet: TPIGroupBox;
    edtFichierProjet: TJvFilenameEdit;
    sdFichierProjet: TSaveDialog;
    btnValider: TButton;
    btnAnnuler: TButton;
    cbxModuleImport: TComboBox;
    lblModuleImport: TLabel;
    lblModuleTransfert: TLabel;
    lblPays: TLabel;
    cbxPays: TComboBox;
    bvlSeparateur: TBevel;
    lRepValid: TLabel;
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure cbxPaysChange(Sender: TObject);
    procedure cbxModuleChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure edtFichierProjetChange(Sender: TObject);
    procedure btnValiderClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Déclarations privées }
    sFolders : TStrings;
  public
    { Déclarations publiques }
    function ShowModal(var APays : string; var AFichierProjet : string; var AModuleImport: TModule;
      var AModuleTransfert : TModule) : TModalResult; reintroduce;
  end;

var
  frmCreationProjet: TfrmCreationProjet;

implementation

{$R *.dfm}

{ TfrmCreationProjet }

function TfrmCreationProjet.ShowModal(var APays : string; var AFichierProjet : string; var AModuleImport: TModule;
  var AModuleTransfert : TModule) : TModalResult;
  var chemin, module : string;
begin
  Result := inherited ShowModal;

  if ModalResult = mrOk then
  begin
    if ExtractFileExt(edtFichierProjet.Text) = '.pj4' then
      AFichierProjet := edtFichierProjet.Text
    else

      begin // creation rapide d'un projet
       ShortDateFormat := ('yyyy-mm-dd');
       module := trim(copy(cbxModuleImport.Items[cbxModuleImport.ItemIndex], 1 , pos('-',cbxModuleImport.Items[cbxModuleImport.ItemIndex])-1 ));
       chemin := ExtractFilePath(Application.ExeName)+'\projets commit\'+datetostr(now)+' '+module;
       if (ForceDirectories(chemin)) then
        AFichierProjet := chemin +'\projet '+module+' du '+datetostr(now)+'.pj4';
      end;

    AModuleImport := cbxModuleImport.Items.Objects[cbxModuleImport.ItemIndex] as TModule;
    AModuleTransfert := cbxModuleTransfert.Items.Objects[cbxModuleTransfert.ItemIndex] as TModule;
    APays := Projet.ListePays.Names[cbxPays.ItemIndex];
  end
  else
  begin
    APays := '';
    AFichierProjet := '';
    AModuleImport := nil;
    AModuleTransfert := nil;
  end;
end;

procedure TfrmCreationProjet.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  sFolders.Clear;
  sFolders.Free;
end;

procedure TfrmCreationProjet.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
//  if ModalResult = mrCancel then
//    CanClose := MessageDlg('Annuler la création/modification de ce projet ?', mtConfirmation, [mbYes, mbNo], 0) = mrYes
end;

procedure TfrmCreationProjet.FormCreate(Sender: TObject);
var
  i : Integer;
begin
  inherited;

  for i := 0 to Projet.ListePays.Count - 1 do
    cbxPays.Items.Add(Projet.ListePays.ValueFromIndex[i]);

  cbxPays.Enabled := cbxPays.Items.Count > 1;
  if cbxPays.Items.Count = 1 then
  begin
    cbxPays.ItemIndex := 0;
    cbxPaysChange(nil);
  end;

  sFolders := tStringList.Create;
  sFolders.Add(GetCommonFilesFolder);
  sFolders.Add(GetCurrentFolder);
  sFolders.Add(GetProgramFilesFolder);
  sFolders.Add(GetWindowsFolder);
  sFolders.Add(GetWindowsSystemFolder);
  sFolders.Add(GetWindowsTempFolder);
  sFolders.Add(GetDesktopFolder);
  sFolders.Add(GetProgramsFolder);
  sFolders.Add(GetPersonalFolder);
  sFolders.Add(GetFavoritesFolder);
  sFolders.Add(GetStartupFolder);
  sFolders.Add(GetRecentFolder);
  sFolders.Add(GetSendToFolder);
  sFolders.Add(GetStartmenuFolder);
  sFolders.Add(GetDesktopDirectoryFolder);
  sFolders.Add(GetCommonDocumentsFolder);
  sFolders.Add(GetNethoodFolder);
  sFolders.Add(GetFontsFolder);
  sFolders.Add(GetCommonStartmenuFolder);
  sFolders.Add(GetCommonStartupFolder);
  sFolders.Add(GetPrinthoodFolder);
  sFolders.Add(GetProfileFolder);
  sFolders.Add(GetCommonProgramsFolder);
  sFolders.Add(GetCommonDesktopdirectoryFolder);
  sFolders.Add(GetCommonAppdataFolder);
  sFolders.Add(GetAppdataFolder);
  sFolders.Add(GetLocalAppData);
  sFolders.Add(GetCommonFavoritesFolder);
  sFolders.Add(GetTemplatesFolder);
  sFolders.Add(GetInternetCacheFolder);
  sFolders.Add(GetCookiesFolder);
  sFolders.Add(GetHistoryFolder);
end;

procedure TfrmCreationProjet.cbxPaysChange(Sender: TObject);
var
  i, lIntMaxOcc : Integer;
  lModule : TModule;
  p : string;
begin
  cbxModuleImport.Items.Clear;
  cbxModuleTransfert.Items.Clear;

  p := Projet.ListePays.Names[cbxPays.ItemIndex];
  lIntMaxOcc := Projet.TotalModules - 1;
  for i := 0 to lIntMaxOcc do
  begin
    lModule := Projet.ModulesParIndex[i];
    if lModule.Pays = p then
      case lModule.TypeModule of
          tmImport :
            cbxModuleImport.Items.AddObject(lModule.NomModule + ' - ' + lModule.Description, lModule);
          tmTransfert :
            cbxModuleTransfert.AddItem(lModule.NomModule + ' - ' + lModule.Description, lModule);
      end;
  end;

  cbxModuleImport.Enabled := cbxModuleImport.Items.Count > 1;
  if cbxModuleImport.Items.Count = 1 then cbxModuleImport.ItemIndex := 0;
  cbxModuleTransfert.Enabled := cbxModuleTransfert.Items.Count > 1;
  if cbxModuleTransfert.Items.Count = 1 then cbxModuleTransfert.ItemIndex := 0;
  cbxModuleChange(nil);
end;

procedure TfrmCreationProjet.edtFichierProjetChange(Sender: TObject);
var
  spath : string;
  filepath : String;
begin
  // Vérifier que le répertoire est un répertoire "valide"
  sPath := uppercase(tPath.GetDirectoryName(tEdit(Sender).Text));
  lRepValid.Visible := False;
  for filepath in sFolders do
   begin
     if Pos(uppercase(filePath),sPAth) = 1 then
     begin
       lRepValid.Visible := True;
       break;
     end;
   end;
end;

procedure TfrmCreationProjet.btnValiderClick(Sender: TObject);
begin
  if not lRepValid.visible then
    ModalResult := mrOk;
end;

procedure TfrmCreationProjet.cbxModuleChange(Sender: TObject);
begin
  btnValider.Enabled := (cbxModuleImport.ItemIndex <> -1) and (cbxModuleTransfert.ItemIndex <> -1);
  gbxFichierProjet.Enabled := (cbxModuleImport.ItemIndex <> -1) and (cbxModuleTransfert.ItemIndex <> -1);
end;

end.
