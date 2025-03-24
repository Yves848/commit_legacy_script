unit mdlOfficinall;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, DB, Grids, DBGrids, Menus, mdlModule, 
  mdlModuleImport, ActnList, ImgList, PdfDoc, PReport,
  JvMenus, ExtCtrls, mdlPIPanel, JvXPCore, JvXPContainer, JvWizard,
  JvWizardRouteMapNodes, mdlPIStringGrid, mdlMISQLServeur, mdlMISQLServeurPHA,
  mdlPIDBGrid, JvExControls, JvXPBar, StrUtils, mdlProjet;

type
  TdmOfficinallPHA = class(TdmMISQLServeurPHA);
  TfrOfficinall = class(TfrMISQLServeur)
      { Déclarations privées }
  protected
    procedure RenvoyerParametresConnexion; override;
    procedure TraiterDonneesPraticiens; override;
    procedure TraiterDonneesClients; override;
    procedure TraiterDonneesProduits; override;
    procedure TraiterAutresDonnees; override;
    procedure TraiterDonneesEncours; override;
  public
    { Déclarations publiques }
    constructor Create(AOwner : TComponent; AModule : TModule); override;
  end;


var
  frOfficinall : TfrOfficinall;

implementation

{$R *.dfm}
{$R logo.res}

procedure TfrOfficinall.RenvoyerParametresConnexion;
begin
  inherited;

  PHA.ParametresConnexion.Values['bd'] := 'Officinall';
  with Module.Projet.FichierProjet.DocumentElement.ChildNodes['modules'].ChildNodes['import'].ChildNodes['acces_base'] do
    if HasAttribute('serveur') then PHA.ParametresConnexion.Values['serveur'] := Attributes['serveur'] else PHA.ParametresConnexion.Values['serveur'] := '192.168.0.10';
end;

procedure TfrOfficinall.TraiterDonneesClients;
begin
  inherited;

  TraiterDonnee(Traitements.Traitements['PATIENTS']);
  TraiterDonnee(Traitements.Traitements['CLIENTS']);
  TraiterDonnee(Traitements.Traitements['COMPTERIST']);
  TraiterDonnee(Traitements.Traitements['CARTERIST']);
  TraiterDonnee(Traitements.Traitements['TRANSACTIONRIST']);
  TraiterDonnee(Traitements.Traitements['ATTESTATION']);
  TraiterDonnee(Traitements.Traitements['PHARMACIEN_REFERENCE']);
  TraiterDonnee(Traitements.Traitements['PROFILREMISE']);
end;

procedure TfrOfficinall.TraiterDonneesPraticiens;
begin
  inherited;

  TraiterDonnee(Traitements.Traitements['MEDECINS']);
end;

procedure TfrOfficinall.TraiterDonneesProduits;
begin
  inherited;

  TraiterDonnee(Traitements.Traitements['ZONEGEO']);            //OK
  TraiterDonnee(Traitements.Traitements['PRODUITS']);           //OK
  TraiterDonnee(Traitements.Traitements['PRODUITFOURNISSEURS']);//OK
  TraiterDonnee(Traitements.Traitements['REPARTITEURS']);       //OK
  TraiterDonnee(Traitements.Traitements['FOURNISSEURS']);       //OK
  TraiterDonnee(Traitements.Traitements['CODESBARRES']);        //OK
end;

constructor TfrOfficinall.Create(AOwner: TComponent; AModule: TModule);
begin
  AModule.Logo.LoadFromResourceName(hInstance, 'LOGO');
  AModule.Icone.LoadFromResourceName(hInstance, 'ICONE');

  inherited;
end;

procedure TfrOfficinall.TraiterAutresDonnees;
begin
  inherited;
  TraiterDonnee(Traitements.Traitements['HISTODELGENERAL']);
  TraiterDonnee(Traitements.Traitements['HISTODELDETAILS']);
  TraiterDonnee(Traitements.Traitements['HISTOVENTE']);
end;

procedure TfrOfficinall.TraiterDonneesEncours;
begin
  inherited;

  TraiterDonnee(Traitements.Traitements['AVANCEPRODUIT']);
  TraiterDonnee(Traitements.Traitements['DELDIF']);
  TraiterDonnee(Traitements.Traitements['CREDITCLIENT']);
  TraiterDonnee(Traitements.Traitements['MEMO']);
end;

initialization
  RegisterClasses([TfrOfficinall, TdmOfficinallPHA]);

finalization
  unRegisterClasses([TfrOfficinall, TdmOfficinallPHA]);

end.
