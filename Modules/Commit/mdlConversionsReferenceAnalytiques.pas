unit mdlConversionsReferenceAnalytiques;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, mdlConversions, DB, Grids, DBGrids, mdlPIDBGrid, mdlProjet;

type
  TfrConversionsReferenceAnalytiques = class(TfrConversions)
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
  mdlRechercheReferenceAnalytiqueRef;

{$R *.dfm}

{ TfrConversionsReferenceAnalytiques }

constructor TfrConversionsReferenceAnalytiques.Create(AOwner: TComponent;
  AProjet: TProjet);
begin
  inherited;

  dsConversions.DataSet := dmModuleImportPHA.setConversionsReferenceAnalytiques;
end;

destructor TfrConversionsReferenceAnalytiques.Destroy;
begin
  if frmRechercheReferenceAnalytiqueRef <> nil  then
    frmRechercheReferenceAnalytiqueRef.Free;

  inherited;
end;

procedure TfrConversionsReferenceAnalytiques.grdConversionsDrawColumnCell(
  Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
var
  lStrReferenceAnalytiqueRef : string;
begin
  inherited;

  if (Column.FieldName = 'ATR_REFERENCEANALYTIQUE') then
    if (gdFocused in State) then
      with dmModuleImportPHA do
        if (setConversionsReferenceAnalytiquesATR_REFERENCEANALYTIQUE.AsString = '*') and not frmRechercheReferenceAnalytiqueRef.Visible then
          if frmRechercheReferenceAnalytiqueRef.ShowModal(lStrReferenceAnalytiqueRef) = mrOk then
            with setConversionsReferenceAnalytiques do
            begin
              Edit;
              setConversionsReferenceAnalytiquesATR_REFERENCEANALYTIQUE.AsWideString := lStrReferenceAnalytiqueRef;
              Post;
              Transaction.CommitRetaining;
              //Next;
            end
          else
            setConversionsReferenceAnalytiques.Cancel;
end;

end.
