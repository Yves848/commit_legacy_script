unit mdlAdresse_fr;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, 
  Dialogs, StdCtrls, Mask, DBCtrls;

type
  TfrAdresse = class(TFrame)
    lblRue: TLabel;
    edtRue1: TDBEdit;
    edtRue2: TDBEdit;
    lblCPVille: TLabel;
    edtCP: TDBEdit;
    edtVille: TDBEdit;
    Label2: TLabel;
    lblMobile: TLabel;
    edtTelephone1: TDBEdit;
    lblTelephone2: TLabel;
    lblFax: TLabel;
    edtMobile: TDBEdit;
    edtTelephone2: TDBEdit;
    edtFax: TDBEdit;
    lblEmail: TLabel;
    edtEmail: TDBEdit;
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

implementation

{$R *.dfm}

end.
