unit mdlStock_fr;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, Grids, DBGrids, mdlPIDBGrid, StdCtrls, Mask, DBCtrls;

type
  TfrStock = class(TFrame)
    lblStockMini: TLabel;
    lblDus: TLabel;
    Stock: TLabel;
    lblConditionnement: TLabel;
    txtConditionnement: TDBEdit;
    lblColisage: TLabel;
    txtColisage: TDBEdit;
    txtMoyVte: TDBEdit;
    lblUV: TLabel;
    dbGrdStock: TPIDBGrid;
    txtStockMini: TDBEdit;
    txtStockMaxi: TDBEdit;
    lblStockMaxi: TLabel;
    txtPrdDus: TDBEdit;
    dsProduitsGeo: TDataSource;
    edtStockTotal: TDBEdit;
    lblDatePeremption: TLabel;
    edtDatePeremption: TDBEdit;
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

implementation

{$R *.dfm}

end.
