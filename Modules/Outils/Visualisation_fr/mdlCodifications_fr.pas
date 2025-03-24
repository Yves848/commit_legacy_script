unit mdlCodifications_fr;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Menus, DB, Grids, DBGrids,
  mdlPIDBGrid, Buttons, mdlPISpeedButton, StrUtils,
  mdlProjet, JvMenus, mdlFrameVisualisation_fr;

type
  TfrCodifications = class(TfrFrameVisualisation)
    lblSelection: TLabel;
    cbxSelection: TComboBox;
    bvlSeparator: TBevel;
    dbGrdCodifs: TPIDBGrid;
    lblLabel: TLabel;
    edtLabel: TEdit;
    procedure cbxSelectionChange(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
    constructor Create(Aowner: TComponent; AProjet : TProjet); override;
    destructor Destroy; override;
    procedure Hide; override;
  end;

implementation

uses mdlVisualisationPHA_fr;

{$R *.dfm}

constructor TfrCodifications.Create(Aowner: TComponent; AProjet : TProjet);
begin
  inherited;


  dbGrdCodifs.OnDrawColumnCell := self.grilleLGPIsimple ;

  with dmVisualisationPHA_fr.dSetLibellesCodifications do
  begin
    if Active then Close;
    Open;
  end;
end;

procedure TfrCodifications.cbxSelectionChange(Sender: TObject);
var
  lVarValeur : Variant;

  procedure ChangerLabel;
  begin
    with edtLabel do
    begin
      Text := '';
      if (cbxSelection.ItemIndex = 0) or (cbxSelection.ItemIndex > 5) then
      begin
        Enabled := False;
        Color := clInactiveCaption;
        lblLabel.Font.Color := clInactiveCaptionText;
      end
      else
      begin
        Enabled := True;
        Color := clWindow;
        lblLabel.Font.Color := clWindowText;
      end;
    end;
  end;

begin
  inherited;

  with dmVisualisationPHA_fr.dSetcodifications do
  begin
    if Active then
      Close;
    ChangerLabel;

    // Ouverture des codifs
    if (cbxSelection.ItemIndex > 0) and (cbxSelection.ItemIndex < 5) then
    begin
      lVarValeur := dmVisualisationPHA_fr.dSetLibellesCodifications.FieldValues['alibellecdf' + IntToStr(cbxSelection.ItemIndex)];
      if not VarIsNull(lVarValeur) then
        edtLabel.Text := dmVisualisationPHA_fr.dSetLibellesCodifications.FieldValues['alibellecdf' + IntToStr(cbxSelection.ItemIndex)];
    end;
    Params.ByNameAsInteger['ARANG'] := cbxSelection.ItemIndex;
    Open;
  end;
end;

procedure TfrCodifications.Hide;
begin
  inherited;

  cbxSelection.ItemIndex := -1;
end;

destructor TfrCodifications.Destroy;
begin
  if dmVisualisationPHA_fr.dSetLibellesCodifications.Active then
    dmVisualisationPHA_fr.dSetLibellesCodifications.Close;

  inherited;
end;

end.
