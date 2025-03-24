unit mdlRistournes_be;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, DB, Grids, DBGrids, mdlPIDBGrid, StdCtrls, mdlProjet,
  Buttons, mdlPISpeedButton, ExtCtrls, JvMenus,
  Mask, DBCtrls, JvExDBGrids, JvDBGrid, ComCtrls, JvDBGridFooter, mdlPIEdit,
  mdlFrameVisualisation_be;

type
  TfrRistournes = class(TfrFrameVisualisation_be)
    pnlRecapitulatif: TPanel;
    lblNom: TLabel;
    edtNom: TDBEdit;
    Label3: TLabel;
    Label2: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    DBEdit2: TDBEdit;
    DBEdit3: TDBEdit;
    DBEdit4: TDBEdit;
    DBEdit5: TDBEdit;
    DBEdit6: TDBEdit;
    DBEdit7: TDBEdit;
    DBEdit1: TDBEdit;
    grdCartes: TPIDBGrid;
    dsCartes: TDataSource;
    Label1: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    procedure btnChercherClick(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
    constructor Create(Aowner : TComponent; AProjet : TProjet); override;
  end;

var
  frRistournes: TfrRistournes;

implementation

uses mdlVisualisationPHA_be;

{$R *.dfm}

{ TfrViewDataVignAvanc }

procedure TfrRistournes.btnChercherClick(Sender: TObject);
var
  lIntPos : Integer;
  lStrNom, lStrPrn : string;
begin
  inherited;


  Screen.Cursor := crSQLWait;
  if dmVisualisationPHA_be.dSetRistournes.Active then dmVisualisationPHA_be.dSetRistournes.Close;

  // Séparation des paramètres
  lStrNom := edtCritere.Text;
  lIntPos := Pos('+', lStrNom);
  if lIntPos > 0 then
  begin
    lStrPrn := Copy(lStrNom, lIntPos + 1, Length(lStrNom));
    lStrNom := Copy(lStrNom, 1, lIntPos - 1);
  end
  else
    lStrPrn := '';

 with dmVisualisationPHA_be.dSetRistournes do
  begin
    Params.ByNameAsString['ANOM'] := lStrNom;
    Params.ByNameAsString['APRENOM'] := lStrPrn;
    Open;
  end;

   Screen.Cursor := crDefault;
end;

constructor TfrRistournes.Create(Aowner: TComponent;
  AProjet: TProjet);
begin
  inherited;

  Caption := 'Comptes ristournes';

  FClientHeight := 370;
  FClientWidth := 566;
end;


end.
