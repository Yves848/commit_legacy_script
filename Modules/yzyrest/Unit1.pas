unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, System.IOUtils,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, REST.Types, Vcl.StdCtrls, REST.Client,
  REST.Response.Adapter, Data.Bind.Components, Data.Bind.ObjectScope, uYZYRecords;

type
  TtsfProduits = function(pYZYProduct : tYZYPOSTProducts; var Response : tYZYResponse) : pChar; stdcall;
  TFinalizeRestObjects = procedure; stdcall;

  TForm1 = class(TForm)
    Memo1: TMemo;
    btGo: TButton;
    Button1: TButton;
    procedure btGoClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
    dllHandle : tHandle;
    tsfProduits : TtsfProduits;
    FinalizeRestObjects : TFinalizeRestObjects;
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.btGoClick(Sender: TObject);
var
  result : pChar;
  Response : tYZYResponse;
  produit : tYZYPOSTProducts;
begin
  produit.sUrl := 'https://api-france-1.durnal.groupe.pharmagest.com/api/durnal-import/v1/jobs/start/repro-import';
  produit.sFile := 'PRODUITS_2024_03_07-17-02.csv';
  result := tsfProduits(produit,Response);
end;

procedure TForm1.FormShow(Sender: TObject);
begin
       DLLHandle := LoadLibrary('C:\Git\yzyrest\Win32\Debug\pYzyRest.dll');
       @tsfProduits := GetProcAddress(DLLHandle, 'tsfProduits');
       @FinalizeRestObjects := GetProcAddress(DLLHandle, 'FinalizeRestObject');
end;

end.
