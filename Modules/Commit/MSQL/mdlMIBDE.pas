unit mdlMIBDE;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, mdlProjet, mdlModule, mdlModuleImport, DB, ActnList, ImgList, PdfDoc, PReport,
  Menus, JvMenus, ExtCtrls, mdlPIPanel, JvXPBar, JvXPCore, JvXPContainer,
  JvWizard, JvWizardRouteMapNodes, ComCtrls, Grids, mdlPIStringGrid, DBGrids,
  mdlPIDBGrid, JvExControls, StdCtrls, VirtualTrees, JvExExtCtrls,  JvNetscapeSplitter;

type
  TfrMIBDE = class(TfrModuleImport)
      procedure frMIBDE_AvantConnecter(Sender : TObject; var AAutorise: Boolean);
      procedure actAccesBDParametresExecute(Sender: TObject); override;
  private
    { Déclarations privées }
  protected
    procedure TraiterDonnee(ATraitement : TTraitement); override;
    procedure RenvoyerParametresConnexion; override;
    procedure StockerParametresConnexion; override;
  public
    { Déclarations publiques }
    constructor Create(AOwner : TComponent; AModule : TModule); override;
    procedure Connecter; override;
    procedure Deconnecter; override;
  end;

var
  frMIBDE: TfrMIBDE;

implementation

uses mdlMIBDEPHA, mdlBDEConnexionServeur;

{$R *.dfm}

{ TfrBDE }


constructor TfrMIBDE.Create(AOwner: TComponent; AModule: TModule);
begin
  ModeConnexion := mcBaseSQL;
  inherited;
  xpbAccesBD.Visible := True;

  with Module.Projet.FichierProjet.DocumentElement.ChildNodes['modules'].ChildNodes['import'].ChildNodes['acces_base'] do
  begin
    if HasAttribute('bd') then (PHA as TdmMIBDEPHA).setFichiersManquants.Params.ByNameAsString['AREPERTOIRE'] := IncludeTrailingPathDelimiter(Attributes['bd']);
    (PHA as TdmMIBDEPHA).setFichiersManquants.CloseOpen();
  end;

  SurAvantConnecter := frMIBDE_AvantConnecter;

  FInterfaceConnexion := TfrmBDEConnexionServeur;
end;

procedure TfrMIBDE.actAccesBDParametresExecute(Sender: TObject);
begin
  inherited;
  (PHA as TdmMIBDEPHA).setFichiersManquants.Params.ByNameAsString['AREPERTOIRE'] := IncludeTrailingPathDelimiter(PHA.ParametresConnexion.Values['bd']);
  (PHA as TdmMIBDEPHA).setFichiersManquants.CloseOpen();
end;

procedure TfrMIBDE.Connecter;
var
  i : Integer;
begin

  if PHA.ParametresConnexion.IndexOfName('bd') = -1 then PHA.ParametresConnexion.Add('bd=');
  with Module.Projet.FichierProjet.DocumentElement.ChildNodes['modules'].ChildNodes['import'].ChildNodes['acces_base'] do
  begin
    if HasAttribute('bd') then PHA.ParametresConnexion.Values['bd'] :=  Attributes['bd'] else PHA.ParametresConnexion.Values['bd'] := '';
  end;

  inherited;

  if FConnecte then
    for i := 0 to wzDonnees.PageCount - 1 do
    begin
      wzDonnees.Pages[i].Subtitle.Visible := True;
      wzDonnees.Pages[i].Subtitle.Text := 'Connecté à ' + PHA.ParametresConnexion.Values['bd'];
    end;

  actAccesBDConnexion.Enabled := False;
  actAccesBDDeconnexion.Enabled := True;
end;


procedure TfrMIBDE.Deconnecter;
var
  i : Integer;
begin
  inherited;

  if FConnecte then
    for i := 0 to wzDonnees.PageCount - 1 do
    begin
      wzDonnees.Pages[i].Subtitle.Visible := False;
      wzDonnees.Pages[i].Subtitle.Text := '';
    end;

  actAccesBDConnexion.Enabled := True;
  actAccesBDDeconnexion.Enabled := False;
end;

procedure TfrMIBDE.TraiterDonnee(ATraitement: TTraitement);
begin
  if TTraitementBD(ATraitement).RequeteSelection <> '' then
  begin
    dmMIBDEPHA.qryBDE.SQL.LoadFromFile(Module.RepertoireRessources + '\' + TTraitementBD(ATraitement).RequeteSelection);
    inherited TraiterDonnee(ATraitement, dmMIBDEPHA.qryBDE);
  end
  else
    inherited TraiterDonnee(ATraitement);
end;


procedure TfrMIBDE.RenvoyerParametresConnexion;
begin
  if PHA.ParametresConnexion.IndexOfName('bd') = -1 then PHA.ParametresConnexion.Add('bd=');

  with Module.Projet.FichierProjet.DocumentElement.ChildNodes['modules'].ChildNodes['import'].ChildNodes['acces_base'] do
  begin
    if HasAttribute('bd') then
      PHA.ParametresConnexion.Values['bd'] :=  Attributes['bd']
    else
      PHA.ParametresConnexion.Values['bd'] := module.Projet.RepertoireProjet;
  end;
end;

procedure TfrMIBDE.StockerParametresConnexion;
begin
  with Module.Projet.FichierProjet.DocumentElement.ChildNodes['modules'].ChildNodes['import'].ChildNodes['acces_base'] do
  begin
    Attributes['bd'] := PHA.ParametresConnexion.Values['bd'];
   end;
end;

procedure TfrMIBDE.frMIBDE_AvantConnecter(Sender: TObject;
  var AAutorise: Boolean);
begin
  AAutorise := (PHA.ParametresConnexion.Values['bd'] <> '');
end;

end.
