unit mdlConversionsFournisseurs;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, mdlConversions, DB, Grids, DBGrids, mdlPIDBGrid, mdlProjet;

type
  TfrConversionsFournisseurs = class(TfrConversions)
    procedure grdConversionsDrawColumnCell(Sender: TObject;
      const Rect: TRect; DataCol: Integer; Column: TColumn;
      State: TGridDrawState);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
    constructor Create(AOwner: TComponent; AProjet : TProjet); override;
    destructor Destroy; override;
  end;

implementation

uses mdlModuleImportPHA,
  mdlRechercheFournisseurRef;

{$R *.dfm}

{ TfrConversionsFournisseurs }

constructor TfrConversionsFournisseurs.Create(AOwner: TComponent;
  AProjet: TProjet);
begin
  inherited;

  dsConversions.DataSet := dmModuleImportPHA.setConversionsFournisseurs;
end;

destructor TfrConversionsFournisseurs.Destroy;
begin
  if frmRechercheFournisseurRef <> nil  then
    frmRechercheFournisseurRef.Free;

  inherited;
end;

procedure TfrConversionsFournisseurs.grdConversionsDrawColumnCell(
  Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
var
  lStrFournisseurRef : string;
begin
  inherited;

  if (Column.FieldName = 'ATR_FOURNISSEUR') then
    if (gdFocused in State) then
      with dmModuleImportPHA do
        if (setConversionsFournisseursATR_FOURNISSEUR.AsString = '*') and not frmRechercheFournisseurRef.Visible then
          if frmRechercheFournisseurRef.ShowModal(lStrFournisseurRef) = mrOk then
            with setConversionsFournisseurs do
            begin
              Edit;
              setConversionsFournisseursATR_FOURNISSEUR.AsWideString := lStrFournisseurRef;
              Post;
              Transaction.CommitRetaining;
              //Next;
            end
          else
            setConversionsFournisseurs.Cancel;
end;

end.
