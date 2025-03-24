unit mdlClients_be;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, DB, Grids, DBGrids, mdlPIDBGrid, StdCtrls, mdlProjet,
  Buttons, mdlPISpeedButton, ExtCtrls, mdlFrameVisualisation_be, JvMenus,
  Mask, DBCtrls, JvExDBGrids, JvDBGrid, ComCtrls, JvDBGridFooter, mdlPIEdit;

type
  TfrClients = class(TfrFrameVisualisation_be)
    Label3: TLabel;
    procedure btnChercherClick(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
    constructor Create(Aowner : TComponent; AProjet : TProjet); override;
  end;

var
  frClients: TfrClients;

implementation

uses mdlVisualisationPHA_be;

{$R *.dfm}

{ TfrViewDataVignAvanc }

procedure TfrClients.btnChercherClick(Sender: TObject);
var
  lIntPos : Integer;
  lStrNom, lStrPrn : string;
begin
  inherited;


  Screen.Cursor := crSQLWait;
  if dmVisualisationPHA_be.dSetClients.Active then dmVisualisationPHA_be.dSetClients.Close;

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

 with dmVisualisationPHA_be.dSetClients do
  begin
    Params.ByNameAsString['ANOM'] := lStrNom;
    Params.ByNameAsString['APRENOM'] := lStrPrn;
    Open;
  end;

   Screen.Cursor := crDefault;
end;

constructor TfrClients.Create(Aowner: TComponent;
  AProjet: TProjet);
begin
  inherited;

  Caption := 'Comptes Clients';

  FClientHeight := 370;
  FClientWidth := 566;
end;


end.
