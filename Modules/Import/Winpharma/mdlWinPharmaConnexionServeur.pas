unit mdlWinPharmaConnexionServeur;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Mask , mdlConnexionServeur, ExtCtrls,
  jpeg, JvExMask, JvToolEdit;

type
  TfrmWinPharmaConnexionServeur = class(TfrmConnexionServeur)
    edtCheminBLOB: TJvDirectoryEdit;
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
    function ShowModal(AParametres : TStringList) : Integer; override;
  end;

implementation

{$R *.dfm}

function TfrmWinPharmaConnexionServeur.ShowModal(AParametres: TStringList): Integer;
begin
  edtcheminBLOB.Text := AParametres.Values['cheminBLOB'];
  if edtcheminBLOB.Text = '' then edtcheminBLOB.Text := 'C:\WPHARMA';


  result := inherited ShowModal(AParametres);

  AParametres.Values['cheminBLOB'] := edtcheminBLOB.Text;
 end;

end.
