unit mdlVisualisationPHA_be;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, mdlProjet, uibdataset, uib, mdlModuleOutils, Menus,
  JvMenus, mydbunit, fbcustomdataset, mdlPHA;

type
  TdmVisualisationPHA_be = class(TdmModuleOutils)
    trPHA: TUIBTransaction;
    dSetRistournes: TUIBDataSet;
    dSetRistournesT_COMPTE_ID: TWideStringField;
    dSetRistournesT_CLIENT_ID: TWideStringField;
    dSetRistournesNOM: TWideStringField;
    dSetRistournesPRENOM: TWideStringField;
    dSetRistournesSOLDEDISP: TUIBBCDField;
    dSetRistournesSOLDE2: TUIBBCDField;
    dSetRistournesSOLDE3: TUIBBCDField;
    dSetRistournesRISTDISP: TUIBBCDField;
    dSetRistournesSOLDE0: TUIBBCDField;
    dSetRistournesSOLDE1: TUIBBCDField;
    dSetCartesRistournes: TUIBDataSet;
    dSetCartesRistournesT_COMPTE_ID: TWideStringField;
    dSetCartesRistournesNOM: TWideStringField;
    dSetCartesRistournesPRENOM: TWideStringField;
    dSetCartesRistournesNUM_CARTE: TWideStringField;
    dSetCartesRistournesDATEEMIS: TDateField;
    dSetRistournesNB_CARTES: TSmallintField;
    dSetClients: TUIBDataSet;
    procedure DataModuleCreate(Sender: TObject);
    procedure dSetRistournesBeforeClose(DataSet: TDataSet);
    procedure dSetRistournesAfterScroll(DataSet: TDataSet);
    procedure dSetCartesRistournesBeforeClose(DataSet: TDataSet);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
    constructor Create(Aowner : TComponent; AProjet : TProjet); override;
  end;

//const
//  C_TYPE_PRATICIEN_PRIVE = '1';

var
  dmVisualisationPHA_be: TdmVisualisationPHA_be;

implementation

{$R *.dfm}

constructor TdmVisualisationPHA_be.Create(Aowner: TComponent;
  AProjet: TProjet);
begin
  inherited;

end;



procedure TdmVisualisationPHA_be.DataModuleCreate(Sender: TObject);
begin
  inherited;

  dSetRistournes.Database := Projet.PHAConnexion;
  trPHA.DataBase := Projet.PHAConnexion;

end;

procedure TdmVisualisationPHA_be.dSetRistournesBeforeClose(DataSet: TDataSet);
begin
  inherited;

  if dSetCartesRistournes.Active then dSetCartesRistournes.Close;
  
 end;

procedure TdmVisualisationPHA_be.dSetRistournesAfterScroll(DataSet: TDataSet);
begin
  inherited;

  dSetRistournesBeforeClose(DataSet);

  dSetCartesRistournes.params.ByNameAsString['T_COMPTE_ID'] := dSetRistournesT_COMPTE_ID.AsString;
  dSetCartesRistournes.Open;

  //AjouterWhere(dSetCatalogues.SQL, 't_produit_id = ' + QuotedStr(dSetProduitsT_PRODUIT_ID.AsString));
//  dSetCatalogues.Open;

end;

procedure TdmVisualisationPHA_be.dSetCartesRistournesBeforeClose(DataSet: TDataSet);
begin
  inherited;

 // if dSetCartesRistournes.Active then dSetCartesRistournes.Close;
 end;


end.