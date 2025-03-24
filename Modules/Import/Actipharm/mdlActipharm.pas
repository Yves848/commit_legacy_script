unit mdlActipharm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, IniFiles, StdCtrls, Buttons, ComCtrls, ExtCtrls, DateUtils, strutils, 
  mdlProjet, mdlModuleImport, DB, ActnList, ImgList, PdfDoc, PReport,
  Menus, JvMenus, mdlPIPanel, JvXPCore, JvXPContainer, JvWizard,
  JvWizardRouteMapNodes, Grids, mdlPIStringGrid, DBGrids, mdlPIDBGrid,
  JvExControls, mdlLectureFichierBinaire, UIB, JvXPBar, VirtualTrees,
  JvExExtCtrls, JvNetscapeSplitter;

type
  TfrActipharm = class(TfrModuleImport)
  private
    { Déclarations privées }
  protected
    function FaireTraitementDonnees(ADonnees : TDonneesFormatees) : TResultatCreationDonnees; override;
    procedure TraiterDonneesPraticiens; override;
    procedure TraiterDonneesOrganismes; override;
    procedure TraiterDonneesClients; override;
    procedure TraiterDonneesProduits; override;
    procedure TraiterAutresDonnees; override;
  public
    { Déclarations publiques }
    constructor Create(AOwner : TComponent; AModule : TModule); override;
  end;

var
  frActipharm : TfrActipharm;

implementation

{$R *.dfm}

uses mdlActipharmPHA, mdlActipharmLectureFichier, mdlModule;

{ TfrActipharm }

constructor TfrActipharm.Create(AOwner: TComponent; AModule: TModule);
begin
  inherited;

  LectureFichierBinaire := TFichierActipharm;
  frActipharm := Self;
end;

function TfrActipharm.FaireTraitementDonnees(
  ADonnees: TDonneesFormatees): TResultatCreationDonnees;
begin
  if ADonnees is TP01MEDE then Result := dmActipharmPHA.CreerDonnees(TP01MEDE(ADonnees));
  if ADonnees is TP01OAMO then Result := dmActipharmPHA.CreerDonnees(TP01OAMO(ADonnees));
  if ADonnees is TP01OAMC then Result := dmActipharmPHA.CreerDonnees(TP01OAMC(ADonnees));
  if ADonnees is TP01CNTR then Result := dmActipharmPHA.CreerDonnees(TP01CNTR(ADonnees));
  if ADonnees is TP01ASSU then Result := dmActipharmPHA.CreerDonnees(TP01ASSU(ADonnees));
  if ADonnees is TP01AYDR then Result := dmActipharmPHA.CreerDonnees(TP01AYDR(ADonnees));
  if ADonnees is TP01AYMU then Result := dmActipharmPHA.CreerDonnees(TP01AYMU(ADonnees));
  if ADonnees is TP01TIER then Result := dmActipharmPHA.CreerDonnees(TP01TIER(ADonnees));
  if ADonnees is TP01FOUR then Result := dmActipharmPHA.CreerDonnees(TP01FOUR(ADonnees));
  if ADonnees is TP01LPAR then Result := dmActipharmPHA.CreerDonnees(TP01LPAR(ADonnees));
  if ADonnees is TP01EMPL then Result := dmActipharmPHA.CreerDonnees(TP01EMPL(ADonnees));
  if ADonnees is TP01ARTI then Result := dmActipharmPHA.CreerDonnees(TP01ARTI(ADonnees));
  if ADonnees is TP01TARI then Result := dmActipharmPHA.CreerDonnees(TP01TARI(ADonnees));
  if ADonnees is TP01CUM then Result := dmActipharmPHA.CreerDonnees(TP01CUM(ADonnees));
  if ADonnees is TM01DLOT then Result := dmActipharmPHA.CreerDonnees(TM01DLOT(ADonnees));
  if ADonnees is TM01ENTE then Result := dmActipharmPHA.CreerDonnees(TM01ENTE(ADonnees));
  if ADonnees is TM01LIGN then Result := dmActipharmPHA.CreerDonnees(TM01LIGN(ADonnees));
  if ADonnees is TFP2PSTOC then Result := dmActipharmPHA.CreerDonnees(TFP2PSTOC(ADonnees));
  if ADonnees is TFP2EAN13 then Result := dmActipharmPHA.CreerDonnees(TFP2EAN13(ADonnees));
  if ADonnees is TFP2PTIPS then Result := dmActipharmPHA.CreerDonnees(TFP2PTIPS(ADonnees));
  if ADonnees is TFP2PVETO then Result := dmActipharmPHA.CreerDonnees(TFP2PVETO(ADonnees));
  if ADonnees is TFP2SCDFO then Result := dmActipharmPHA.CreerDonnees(TFP2SCDFO(ADonnees));
  if ADonnees is TFP2PVIGA then Result := dmActipharmPHA.CreerDonnees(TFP2PVIGA(ADonnees));
end;

procedure TfrActipharm.TraiterAutresDonnees;
begin
  inherited;

  TraiterDonnee(Traitements.Traitements['P01TIER.D']);
  dmActipharmPHA.HistoriqueClient.Clear;
  TraiterDonnee(Traitements.Traitements['M01ENTE.D']);
  TraiterDonnee(Traitements.Traitements['M01LIGN.D']);
end;

procedure TfrActipharm.TraiterDonneesClients;
begin
  inherited;

  TraiterDonnee(Traitements.Traitements['P01ASSU.D']);
  TraiterDonnee(Traitements.Traitements['P01AYDR.D']);
  TraiterDonnee(Traitements.Traitements['P01AYMU.D']);

end;

procedure TfrActipharm.TraiterDonneesOrganismes;
begin
  inherited;

  TraiterDonnee(Traitements.Traitements['P01OAMO.D']);
  TraiterDonnee(Traitements.Traitements['P01OAMC.D']);
  TraiterDonnee(Traitements.Traitements['P01CNTR.D']);
end;

procedure TfrActipharm.TraiterDonneesPraticiens;
begin
  inherited;

  TraiterDonnee(Traitements.Traitements['P01MEDE.D']);
end;

procedure TfrActipharm.TraiterDonneesProduits;
begin
  inherited;

  TraiterDonnee(Traitements.Traitements['P01FOUR.D']);
  TraiterDonnee(Traitements.Traitements['P01LPAR.D']);
  TraiterDonnee(Traitements.Traitements['P01EMPL.D']);
  TraiterDonnee(Traitements.Traitements['P01ARTI.D']);
  TraiterDonnee(Traitements.Traitements['M01DLOT.D']);
  TraiterDonnee(Traitements.Traitements['P01TARI.D']);
  TraiterDonnee(Traitements.Traitements['P01CUM.D']);
  if not Annulation then
    dmActipharmPHA.ExecuterPS('P01ARTI.D', 'PS_MAJ_DATE_DERNIERE_VENTE', null, True, etmCommit);
end;

initialization
  RegisterClasses([TfrActipharm, TdmActipharmPHA]);

finalization
  unRegisterClasses([TfrActipharm, TdmActipharmPHA]);

end.
