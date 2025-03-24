unit mdlOptionsReprise;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  mdlBase, ComCtrls, StdCtrls, Dialogs;

type
  TfrmOptionsReprise = class(TfrmBase)
    btnOK: TButton;
    btnAnnuler: TButton;
    pCtlOptionsReprise: TPageControl;
    tshImport: TTabSheet;
    tshTransfert: TTabSheet;
    procedure pCtlOptionsRepriseResize(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  frmOptionsReprise: TfrmOptionsReprise;

implementation

{$R *.dfm}

procedure TfrmOptionsReprise.pCtlOptionsRepriseResize(Sender: TObject);
begin
  inherited;

  Height := pCtlOptionsReprise.Height + 80;
end;

end.
 