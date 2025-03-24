unit mdlActionTransaction;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, mdlDialogue, ActnList, ImgList;

type
  TfrmActTrans = class(TForm)
    lblMessage: TLabel;
    btnCommit: TButton;
    btnRollback: TButton;
    btnCancel: TButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

  function ActionTransaction(ABD : string) : Integer;

var
  frmActTrans: TfrmActTrans;

implementation

{$R *.dfm}

function ActionTransaction(ABD : string) : Integer;
begin
  frmActTrans := TfrmActTrans.Create(Screen.ActiveForm);
  frmActTrans.Caption := ABD + ' : ' + frmActTrans.Caption;
  Result := frmActTrans.ShowModal;
end;

procedure TfrmActTrans.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

end.
