unit uDriveChoice;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TfDriveChoice = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    cbDrives: TComboBox;
    Button1: TButton;
    Button2: TButton;
    Label3: TLabel;
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  fDriveChoice: TfDriveChoice;

implementation

{$R *.dfm}

end.
