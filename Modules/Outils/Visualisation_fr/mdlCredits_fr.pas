unit mdlCredits_fr;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, DB, Grids, DBGrids, mdlPIDBGrid, StdCtrls, mdlProjet,
  Buttons, mdlPISpeedButton, ExtCtrls, JvMenus,
  Mask, DBCtrls, JvExDBGrids, JvDBGrid, ComCtrls, JvDBGridFooter, mdlPIEdit,
  mdlFrameVisualisation_fr;

type
  TfrCredit = class(TfrFrameVisualisation)
    pnlRecapitulatif: TPanel;
    edtTotal: TPIEdit;
    lblTotal: TLabel;
    procedure btnChercherClick(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
    constructor Create(Aowner : TComponent; AProjet : TProjet); override;
    procedure CalculerTotal;  
  end;

var
  frCredit: TfrCredit;

implementation

uses mdlVisualisationPHA_fr;

{$R *.dfm}

{ TfrViewDataVignAvanc }

procedure TfrCredit.btnChercherClick(Sender: TObject);
begin
  inherited;

  Screen.Cursor := crSQLWait;
  if dmVisualisationPHA_fr.dSetCredits.Active then dmVisualisationPHA_fr.dSetCredits.Close;

  with dmVisualisationPHA_fr.dSetCredits do
  begin
    Params.ByNameAsString['ANOMCLIENT'] := edtCritere.Text;
    Open;
    CalculerTotal;
  end;

  Screen.Cursor := crDefault;
end;

procedure TfrCredit.CalculerTotal;
var
  lSgTotal : Double;
begin
  with dmVisualisationPHA_fr.dSetCredits do
  begin
    // Calcul du total des crédits
    DisableControls;
    First; lSgTotal := 0;
    while not EOF do
    begin
      lSgTotal := lSgTotal + FieldByName('MONTANT').AsFloat;
      Next;
    end;
    First;
    EnableControls;

    edtTotal.Text := FormatFloat('0.##', lSgTotal);
  end;
end;

constructor TfrCredit.Create(Aowner: TComponent;
  AProjet: TProjet);
begin
  inherited;

  Caption := 'Crédits';

  FClientHeight := 370;
  FClientWidth := 566;
end;

end.
