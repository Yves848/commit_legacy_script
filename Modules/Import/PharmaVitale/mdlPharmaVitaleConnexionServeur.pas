unit mdlPharmaVitaleConnexionServeur;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, mdlConnexionServeur, StdCtrls, ExtCtrls, mdlSQLServeurConnexionServeur;

type
  TfrmPharmaVitaleConnexionServeur = class(TfrmSQLServeurConnexionServeur)

  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  frmPharmaVitaleConnexionServeur: TfrmPharmaVitaleConnexionServeur;

implementation

{$R *.dfm}




End.
