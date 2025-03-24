unit mdlOrganismes_fr;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, DB, Grids, DBGrids, mdlPIDBGrid, StdCtrls,
  Buttons, mdlPISpeedButton, ExtCtrls, ImgList, Mask, DBCtrls,
  ComCtrls, mdlProjet,
  mdlPIPopupMenu, JvMenus,
  mdlFrameVisualisation_fr, mdlAdresse_fr;

type
  TfrOrganismes = class(TfrFrameVisualisation)
    lblTypeOrganisme: TLabel;
    lblNom: TLabel;
    lblNomReduit: TLabel;
    lblIdNatAMC: TLabel;
    lblDestinataire: TLabel;
    chkOrgReference: TDBCheckBox;
    pCtrlDetailOrganisme: TPageControl;
    tShGeneralites: TTabSheet;
    tShRemboursements: TTabSheet;
    tShGestion: TTabSheet;
    tShCommentaires: TTabSheet;
    tShAMOAssAMC: TTabSheet;
    lblRemboursements: TLabel;
    grdCouvertures: TPIDBGrid;
    dsCouvertures: TDataSource;
    pnlGestionAMO: TPanel;
    chkOrgConventionne: TDBCheckBox;
    chkOrgCirconscription: TDBCheckBox;
    chkGestionTOPR: TDBCheckBox;
    gBxAccords: TGroupBox;
    chkAccordsTierPayantAMO: TDBCheckBox;
    lblMtMiniPriseEnChargeAMO: TLabel;
    lblApplicationMiniPCAMO: TLabel;
    edtMtMiniPriseenchargeAMO: TDBEdit;
    edtApplicationMiniPCAMO: TDBEdit;
    chkFinDroitsOrgAMC: TDBCheckBox;
    pnlGestionAMC: TPanel;
    chkOrgSantePharma: TDBCheckBox;
    chkSaisieNoAdherent: TDBCheckBox;
    chkPriseEnChargeAME: TDBCheckBox;
    gBxGestionAMC: TGroupBox;
    lblMtMiniPriseEnChargeAMC: TLabel;
    lblApplicationMiniPCAMC: TLabel;
    chkAccordsTierPayantAMC: TDBCheckBox;
    edtMtMiniPriseenchargeAMC: TDBEdit;
    edtApplicationMiniPCAMC: TDBEdit;
    lblTypeContrat: TLabel;
    edtTypeContrat: TDBEdit;
    lblDocFacturation: TLabel;
    lblSeuilEdReleve: TLabel;
    chkEditionReleve: TDBCheckBox;
    lblTypeReleve: TLabel;
    lblFrequenceEdition: TLabel;
    edtDocFacturation: TDBEdit;
    txtSeuilEdReleve: TDBEdit;
    edtTypeReleve: TDBEdit;
    edtFrequenceEdition: TDBEdit;
    lblCommentaire: TLabel;
    lblCommGlobal: TLabel;
    mmCommentaire: TDBMemo;
    mmCommGlobal: TDBMemo;
    lblAMOAssAMC: TLabel;
    dbGrdAMOAssAMC: TPIDBGrid;
    dsAMOAssAMC: TDataSource;
    edtNom: TDBEdit;
    edtNomReduit: TDBEdit;
    edtDestinataire: TDBEdit;
    edtIdNat: TDBEdit;
    edtTypeOrganisme: TDBEdit;
    pnlSeparator_1: TPanel;
    edtRegime: TDBEdit;
    EdtCaisGest: TDBEdit;
    edtCtrGest: TDBEdit;
    edtIdentifiant: TEdit;
    frAdresseOrganisme: TfrAdresse;
    Label2: TLabel;
    procedure dsResultDataChange(Sender: TObject; Field: TField);
    procedure sBtnSearchClick(Sender: TObject);
    procedure dsCouverturesStateChange(Sender: TObject);
    procedure pCtrlDetailOrganismeDrawTab(Control: TCustomTabControl;
      TabIndex: Integer; const Rect: TRect; Active: Boolean);
    procedure pCtrlDetailOrganismeChange(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
    constructor Create(Aowner : TComponent; AProjet : TProjet); override;
  end;

const
  C_PAGE_GENERALITES = 0;
  C_PAGE_REMBOURSEMENTS = 1;
  C_PAGE_GESTION = 2;
  C_PAGE_COMMENTAIRES = 3;
  C_PAGE_AMOASSAMC = 4;

var
  frOrganismes: TfrOrganismes;

implementation

uses mdlVisualisationPHA_fr;

{$R *.dfm}

constructor TfrOrganismes.Create(Aowner : TComponent; AProjet : TProjet);
begin
  inherited;

  grdCouvertures.OnDrawColumnCell := self.grilleLGPIsimple ;
  dbGrdAMOAssAMC.OnDrawColumnCell := self.grilleLGPIsimple ;
  // Détails par défaut
  pCtrlDetailOrganisme.ActivePageIndex := C_PAGE_GENERALITES;

//  Caption := 'Visualisation organismes AMO & AMC'
end;

procedure TfrOrganismes.sBtnSearchClick(Sender: TObject);
begin
  inherited;

  Screen.Cursor := crSQLWait;

  with dmVisualisationPHA_fr.dSetOrganismes do
  begin
    if Active then
      Close;

    Params.ByNameAsString['ANOM'] := edtCritere.Text;
    Params.ByNameAsString['AIDENTIFIANTNATIONAL'] := edtIdentifiant.Text;
    Open;
  end;

  Screen.Cursor := crDefault;
end;

procedure TfrOrganismes.dsResultDataChange(Sender: TObject;
  Field: TField);
var
  lIntPageActive : Integer;
begin
  inherited;

    with dmVisualisationPHA_fr do
      if dSetOrganismesTYPE_ORGANISME.AsString = '2' then
      begin
        edtRegime.Hide;
        edtCaisGest.Hide;
        edtCtrGest.Hide;
        edtIdNat.Show;

        dsCouvertures.DataSet := dSetCouverturesAMC;
        tShAMOAssAMC.TabVisible := True;
      end
      else
      begin
        edtRegime.Show;
        edtCaisGest.Show;
        edtCtrGest.Show;
        edtIdNat.Hide;

        dsCouvertures.DataSet := dSetCouverturesAMO;
        tShAMOAssAMC.TabVisible := False;
      end;

   if pCtrlDetailOrganisme.ActivePageIndex = C_PAGE_GESTION then
     pCtrlDetailOrganismeChange(Sender);
end;

procedure TfrOrganismes.pCtrlDetailOrganismeChange(Sender: TObject);
begin
  inherited;

  if pCtrlDetailOrganisme.ActivePageIndex = C_PAGE_GESTION then
    with dmVisualisationPHA_fr do
      if dSetOrganismesTYPE_ORGANISME.AsString = '2' then
      begin
        pnlGestionAMO.Hide;
        pnlGestionAMC.Show;
      end
      else
      begin
        pnlGestionAMO.Show;
        pnlGestionAMC.Hide;
      end;
end;

procedure TfrOrganismes.pCtrlDetailOrganismeDrawTab(Control: TCustomTabControl;
  TabIndex: Integer; const Rect: TRect; Active: Boolean);
var
  i, h, L , realindex : Integer;
begin
  RealIndex:=TabIndex;
  for i:=0 to (Control as TPageControl).PageCount-1 do
  begin
    if ( (RealIndex>=i) and ((Control as TPageControl).Pages[i].TabVisible=FALSE) ) then
      RealIndex:=RealIndex+1;
  end;

  if Active then
  begin
    Control.Canvas.Brush.Color := CL_ORANGE;
    Control.Canvas.Font.Color := clwhite;
  end
  else
  begin
    Control.Canvas.Brush.Color := $CBCBCB;
    Control.Canvas.Font.Color := clBLack;
  end;

  Control.Canvas.Pen.Style := psClear;
  Control.Canvas.Rectangle(Rect);
  h := Control.Canvas.TextHeight((Control as TPageControl).Pages[RealIndex].Caption);
  L := Rect.Left;
  if Active then Inc(L, 4);
  Control.Canvas.TextOut(L, Rect.Top + (Rect.Bottom - Rect.Top - h) div 2, (Control as TPageControl).Pages[RealIndex].Caption);

end;

procedure TfrOrganismes.dsCouverturesStateChange(
  Sender: TObject);
begin
  inherited;

  if dsCouvertures.State = dsBrowse then
  begin
    dsCouvertures.DataSet.Fields[0].Visible := False;
    grdCouvertures.AjusterLargeurColonnes;
  end;
end;

end.
