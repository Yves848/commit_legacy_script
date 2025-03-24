unit mdlChoixID;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, 
  Dialogs, StdCtrls, DB, DBCtrls;

type
  TfrChoixID = class(TFrame)
    cbxChoix: TDBLookupComboBox;
    dsChoix: TDataSource;
    btnOk: TButton;
    btnAnnuler: TButton;
    procedure cbxChoixKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

  function FaireChoixID(ADataSet : TDataSet; ACaption : string; var AID : Variant) : TModalResult;

var
  frmChoixID : TForm;
  frChoixID : TfrChoixID;

implementation

{$R *.dfm}

function FaireChoixID(ADataSet : TDataSet; ACaption : string; var AID : Variant) : TModalResult;
begin
  if not Assigned(frmChoixID) then
  begin
    frmChoixID := TForm.Create(Application.MainForm);
    with frmChoixID do
    begin
      BorderStyle := bsDialog;
      Position := poScreenCenter;
      AutoSize := True;
      Caption := ACaption
    end;

    frChoixID := TfrChoixID.Create(frmChoixID);
    frChoixID.Parent := frmChoixID;
  end;

  with frmChoixID, frChoixID do
  begin
    if ADataSet.Active then
      ADataSet.Close;

    dsChoix.DataSet := ADataSet;
    ADataSet.Open;

    cbxChoix.KeyValue := null;

    Result := ShowModal;
    if Result = mrOk then
      AID := cbxChoix.KeyValue
    else
      AID := null;
  end;
end;

procedure TfrChoixID.cbxChoixKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_DELETE then
    cbxChoix.KeyValue := null;
end;

end.
