unit mdlChoixDate;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, mdlPIEdit, DateUtils, StrUtils, Math;

type
  TfrmChoixDate = class(TForm)
    lblChoixDate: TLabel;
    edtChoixDate: TPIDateTimePicker;
    btnOk: TButton;
    btnAnnuler: TButton;
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
    function ShowModal(var AChoixDate : TDateTime) : TModalResult; reintroduce;
  end;

  function FaireChoixDate(ACaption, ALibelle : string; var AChoixDate : TDateTime) : TModalResult;

var
  frmChoixDate: TfrmChoixDate;

implementation

{$R *.dfm}
function FaireChoixDate(ACaption, ALibelle : string; var AChoixDate : TDateTime) : TModalResult;
var
  lIntEspacement : Integer;
begin
  if not Assigned(frmChoixDate) then frmChoixDate := TfrmChoixDate.Create(Application.MainForm);
  with frmChoixDate do
  begin
    lblChoixDate.Caption := ALibelle;

    edtChoixDate.Date := Now;
    edtChoixDate.Left := lblChoixDate.Left + lblChoixDate.Width + 16;

    if ACaption <> '' then Caption := ACaption;
    Width := edtChoixDate.Left + edtChoixDate.Width + 8;

    lIntEspacement := (Width - btnOk.Width - btnAnnuler.Width) div 3;
    btnOk.Left := lIntEspacement;
    btnAnnuler.Left := Width - lIntEspacement - btnAnnuler.Width;

    Result := ShowModal(AChoixDate);
  end;
end;

{ TfrmChoixDate }

function TfrmChoixDate.ShowModal(var AChoixDate: TDateTime): TModalResult;
begin
  Result := inherited ShowModal;
  AChoixDate := IfThen(Result = mrOk, edtChoixDate.Date)
end;

end.
