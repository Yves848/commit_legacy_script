unit mdlPraticiens_fr;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, DB, Grids, DBGrids, mdlPIDBGrid, StdCtrls,
  Buttons, mdlPISpeedButton, ExtCtrls, Mask, DBCtrls,
  ComCtrls, mdlPIPanel, ImgList,
  mdlProjet, JvMenus, mdlFrameVisualisation_fr, mdlAdresse_fr;

type
  TfrPraticiens = class(TfrFrameVisualisation)
    pCtrlDetailPraticien: TPageControl;
    tShAdresse: TTabSheet;
    tShCommentaires: TTabSheet;
    mmCommentaires: TDBMemo;
    pnlPPrive: TPanel;
    lblNomPP: TLabel;
    lblPrenomPP: TLabel;
    lblFinessPP: TLabel;
    lblSpecialitePP: TLabel;
    chkAgreeRATPPP: TDBCheckBox;
    edtNomPP: TDBEdit;
    edtPrenomPP: TDBEdit;
    edtFinessPP: TDBEdit;
    edtSpecialitePP: TDBEdit;
    pnlPHosp: TPanel;
    lblNomPH: TLabel;
    lblFinessHP: TLabel;
    edtNomHP: TDBEdit;
    edtFinessHP: TDBEdit;
    dbGrdPraticiensHosp: TPIDBGrid;
    pnlSeparator: TPanel;
    dsPraticiensHosp: TDataSource;
    frAdressePraticien: TfrAdresse;
    txtTypePraticien: TDBText;
    LblRpps: TLabel;
    edtRpps: TDBEdit;
    procedure dsResultDataChange(Sender: TObject; Field: TField);
    procedure btnChercherClick(Sender: TObject);
    procedure edtCritereExit(Sender: TObject);
    procedure edtCritereEnter(Sender: TObject);
    procedure pCtrlDetailPraticienDrawTab(Control: TCustomTabControl;
      TabIndex: Integer; const Rect: TRect; Active: Boolean);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
    constructor Create(Aowner : TComponent; AProjet : TProjet); override;
  end;

const
  PAGE_ADRESSE = 0;
  PAGE_COMMENTAIRE = 1;

var
  frPraticiens: TfrPraticiens;

implementation

uses mdlVisualisationPHA_fr;

{$R *.dfm}

procedure TfrPraticiens.dsResultDataChange(Sender: TObject;
  Field: TField);
var
  lIntPageActive : Integer;
begin
  inherited;

  lIntPageActive := pCtrlDetailPraticien.ActivePageIndex;
  if dmVisualisationPHA_fr.dSetPraticiensTYPE_PRATICIEN.AsString = C_TYPE_PRATICIEN_HOSPITALIER then
  begin
    // Hosp.
    pnlPPrive.Hide;

    pnlPHosp.Show;
    dbGrdPraticiensHosp.Show;
  end
  else
  begin
    // Privé
    dbGrdPraticiensHosp.Hide;
    pnlPHosp.Hide;

    pnlPPrive.Show;
  end;
  pCtrlDetailPraticien.ActivePageIndex := lIntPageActive;
end;

procedure TfrPraticiens.edtCritereEnter(Sender: TObject);
begin
  inherited;
   TEdit(Sender).Color := CL_JAUNE_SELECTION ;
end;

procedure TfrPraticiens.edtCritereExit(Sender: TObject);
begin
  inherited;
  TEdit(Sender).Color := CL_GRIS_CLAIR ;
end;

procedure TfrPraticiens.pCtrlDetailPraticienDrawTab(Control: TCustomTabControl;
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

constructor TfrPraticiens.Create(Aowner: TComponent; AProjet : TProjet);
begin
  inherited;

  // Détails par défaut
  pCtrlDetailPraticien.ActivePageIndex := PAGE_ADRESSE;

  dbGrdPraticiensHosp.OnDrawColumnCell := self.grilleLGPIsimple ;
  //grdResultat.OnDrawColumnCell := self.grilleLGPI ;
//  Caption := 'Visualisation praticiens';
end;

procedure TfrPraticiens.btnChercherClick(Sender: TObject);
var
  lIntPos : Integer;
  lStrNom, lStrPrn : string;
begin
  inherited;

  Screen.Cursor := crSQLWait;

  if dmVisualisationPHA_fr.dSetPraticiens.Active then dmVisualisationPHA_fr.dSetPraticiens.Close;

  // Sépération des paramètres
  lStrNom := edtCritere.Text;
  lIntPos := Pos('+', lStrNom);
  if lIntPos > 0 then
  begin
    lStrPrn := Copy(lStrNom, lIntPos + 1, Length(lStrNom));
    lStrNom := Copy(lStrNom, 1, lIntPos - 1);
  end
  else
    lStrPrn := '';

  with dmVisualisationPHA_fr.dSetPraticiens do
  begin
    Params.ByNameAsString['ANOM'] := lStrNom;
    Params.ByNameAsString['APRENOM'] := lStrPrn;
    Open;
  end;

  Screen.Cursor := crDefault;
end;
end.