unit mdlModuleTransfertErreursOracle;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, DB, Grids, DBGrids, mdlPIDBGrid;

type
  TfrmModuleTransfertErreursOracle = class(TForm)
    grdErreursOracle: TPIDBGrid;
    dsErreurs: TDataSource;
    btnFermer: TButton;
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  frmModuleTransfertErreursOracle: TfrmModuleTransfertErreursOracle;

implementation

uses mdlModuleTransfertPHA;

{$R *.dfm}

end.
