unit mdlIPharmaConnexionServeur;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, mdlConnexionServeur, StdCtrls, ExtCtrls, mdlFirebirdConnexionServeur, Mask,
  JvExMask, JvToolEdit, mdlConnexionServeurFB;

type
  TfrmIPharmaConnexionServeur = class(TfrmFirebirdConnexionServeur)
  private
    { D�clarations priv�es }
  public
    { D�clarations publiques }
  end;

var
  frmFirebirdConnexionServeur: TfrmFirebirdConnexionServeur;

implementation

{$R *.dfm}

end.
