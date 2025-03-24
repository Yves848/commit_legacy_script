unit mdlGreenock;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, DB, Grids, DBGrids, Menus, mdlModule,
  mdlModuleImport, ActnList, ImgList, PdfDoc, PReport,
  JvMenus, ExtCtrls, mdlPIPanel, JvXPCore, JvXPContainer, JvWizard,
  JvWizardRouteMapNodes, mdlPIStringGrid, mdlMISQLServeur, mdlMISQLServeurPHA,
  mdlPIDBGrid, JvExControls, JvXPBar, StrUtils, mdlProjet;

type
  TdmGreenockPHA = class(TdmMISQLServeurPHA);
  TfrGreenock = class(TfrMISQLServeur)
  protected
    procedure RenvoyerParametresConnexion; override;
    procedure TraiterDonneesPraticiens; override;
    procedure TraiterDonneesClients; override;
    procedure TraiterDonneesProduits; override;
    procedure TraiterAutresDonnees; override;
    procedure TraiterDonneesEncours; override;
  public
    { Déclarations publiques }
  end;


var
  frGreenock : TfrGreenock;

implementation

{$R *.dfm}

procedure TfrGreenock.RenvoyerParametresConnexion;
begin
  inherited;

  with Module.Projet.FichierProjet.DocumentElement.ChildNodes['modules'].ChildNodes['import'].ChildNodes['acces_base'] do
  begin
    if HasAttribute('authentification_windows') then PHA.ParametresConnexion.Values['authentification_windows'] :=  Attributes['authentification_windows'] else PHA.ParametresConnexion.Values['authentification_windows'] := '1';
    if HasAttribute('bd') then PHA.ParametresConnexion.Values['bd'] :=  Attributes['bd'] else PHA.ParametresConnexion.Values['bd'] := 'Greenock';
  end;
end;

procedure TfrGreenock.TraiterDonneesClients;
begin
  inherited;

  TraiterDonnee(Traitements.Traitements['PATIENTS']);
  TraiterDonnee(Traitements.Traitements['CLIENTS']);
  TraiterDonnee(Traitements.Traitements['COMPTERIST']);
  TraiterDonnee(Traitements.Traitements['CARTERIST']);
  TraiterDonnee(Traitements.Traitements['TRANSACTIONRIST']);
  TraiterDonnee(Traitements.Traitements['ATTESTATION']);
  TraiterDonnee(Traitements.Traitements['PROFILREMISE']);

end;

procedure TfrGreenock.TraiterDonneesPraticiens;
begin
  inherited;

  TraiterDonnee(Traitements.Traitements['MEDECINS']);
end;

procedure TfrGreenock.TraiterDonneesProduits;
begin
  inherited;

  TraiterDonnee(Traitements.Traitements['DEPOT']);            //OK
  TraiterDonnee(Traitements.Traitements['ZONEGEO']);            //OK
  TraiterDonnee(Traitements.Traitements['PRODUITS']);           //OK
  TraiterDonnee(Traitements.Traitements['STOCKS']);           //OK
  TraiterDonnee(Traitements.Traitements['PRODUITFOURNISSEURS']);//OK
  TraiterDonnee(Traitements.Traitements['REPARTITEURS']);       //OK
  TraiterDonnee(Traitements.Traitements['FOURNISSEURS']);       //OK
  TraiterDonnee(Traitements.Traitements['CODESBARRES']);        //OK
  TraiterDonnee(Traitements.Traitements['SCHEMA_PRODUIT']);        //OK
  TraiterDonnee(Traitements.Traitements['SCHEMA_PRISE']);        //OK
end;

procedure TfrGreenock.TraiterAutresDonnees;
begin
  inherited;
  TraiterDonnee(Traitements.Traitements['HISTODELGENERAL']);
  TraiterDonnee(Traitements.Traitements['HISTODELDETAILS']);
  TraiterDonnee(Traitements.Traitements['HISTODELMAG']);
  TraiterDonnee(Traitements.Traitements['HISTOVENTE']);
end;

procedure TfrGreenock.TraiterDonneesEncours;
begin
  inherited;

  TraiterDonnee(Traitements.Traitements['AVANCEPRODUIT']);
  TraiterDonnee(Traitements.Traitements['DELDIF']);
  TraiterDonnee(Traitements.Traitements['CREDITCLIENT']);
  TraiterDonnee(Traitements.Traitements['MEMO']);
end;

initialization
  RegisterClasses([TfrGreenock, TdmGreenockPHA]);

finalization
  unRegisterClasses([TfrGreenock, TdmGreenockPHA]);

end.
