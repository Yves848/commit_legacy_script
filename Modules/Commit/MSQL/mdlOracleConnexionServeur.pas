unit mdlOracleConnexionServeur;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, mdlConnexionServeur;

type
  TfrmOracleConnexionServeur = class(TfrmConnexionServeur)
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

implementation

{$R *.dfm}

procedure TfrmOracleConnexionServeur.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
//  inherited;
end;

end.
