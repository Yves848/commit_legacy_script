unit mdlConversionsRepartiteurs;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, mdlConversions, DB, Grids, DBGrids, mdlPIDBGrid, mdlProjet;

type
  TfrConversionsRepartiteurs = class(TfrConversions)
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
  mdlRechercheRepartiteurRef;

{$R *.dfm}

{ TfrConversionsRepartiteurs }

constructor TfrConversionsRepartiteurs.Create(AOwner: TComponent;
  AProjet: TProjet);
begin
  inherited;

  dsConversions.DataSet := dmModuleImportPHA.setConversionsRepartiteurs;
end;

procedure TfrConversionsRepartiteurs.grdConversionsDrawColumnCell(
  Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
var
  lStrRepartiteurRef : string;
begin
  inherited;

  if (Column.FieldName = 'ATR_REPARTITEUR') then
    if (gdFocused in State) then
      with dmModuleImportPHA do
        if (setConversionsRepartiteursATR_REPARTITEUR.AsString = '*') and not frmRechercheRepartiteurRef.Visible then
          if frmRechercheRepartiteurRef.ShowModal(lStrRepartiteurRef) = mrOk then
            with setConversionsRepartiteurs do
            begin
              Edit;
              setConversionsRepartiteursATR_REPARTITEUR.AsWideString := lStrRepartiteurRef;
              Post;
              Transaction.CommitRetaining;
              //Next;
            end
          else
            setConversionsRepartiteurs.Cancel;
end;

destructor TfrConversionsRepartiteurs.Destroy;
begin
  if frmRechercheRepartiteurRef <> nil  then
    frmRechercheRepartiteurRef.Free;

  inherited;
end;

end.
