unit mdlHistoAchats_fr;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, DB, Grids, DBGrids, mdlPIDBGrid, StdCtrls, mdlProjet,
  Buttons, mdlPISpeedButton, ExtCtrls, DBCtrls, dbcgrids, Mask, mdlPIEdit,
  JvMenus, DateUtils, mdlFrameVisualisation_fr;

type
  TfrHistoAchat = class(TfrFrameVisualisation)
    lblDesignation: TLabel;
    edtDesignation: TDBEdit;
    lblCodeCIP: TLabel;
    edtCodeCIP: TDBEdit;
    lblHistoAchat: TLabel;
    dsHistoAchat1: TDataSource;
    dsHistoAchat2: TDataSource;
    lblAchats: TLabel;
    dbGrdCmdEnCours: TPIDBGrid;
    dsListeAchats: TDataSource;
    lblPAMP: TLabel;
    edtPAMP: TDBEdit;
    lblCmdEnCours: TLabel;
    edtCmdEnCours: TDBEdit;
    lblAnnee112: TLabel;
    lblAnnee1324: TLabel;
    dsCodeEAN13: TDataSource;
    dsProduits: TDataSource;
    dbGrdHistoAchat112: TDBCtrlGrid;
    pnlMois: TPanel;
    txtMois: TDBText;
    pnlAchat112: TPanel;
    txtAchat112: TDBText;
    dbGrdHistoAchat1324: TDBCtrlGrid;
    pnlAchat1324: TPanel;
    txtAchat1324: TDBText;
    Panel1: TPanel;
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
    constructor Create(Aowner : TComponent; AProjet : TProjet); override;
    destructor Destroy; override;
  end;

var
  frHistoAchat: TfrHistoAchat;

implementation

uses mdlVisualisationPHA_fr;

{$R *.dfm}

destructor TfrHistoAchat.Destroy;
begin
  if dmVisualisationPHA_fr.dSetCommandesEnCours.Active then dmVisualisationPHA_fr.dSetCommandesEnCours.Close;
  if dmVisualisationPHA_fr.dSetHistoAchats2.Active then dmVisualisationPHA_fr.dSetHistoAchats2.Close;
  if dmVisualisationPHA_fr.dSetHistoAchats1.Active then dmVisualisationPHA_fr.dSetHistoAchats1.Close;

  inherited;
end;

constructor TfrHistoAchat.Create(Aowner: TComponent; AProjet : TProjet);
var
  lWrdAnneeEnCours : Word;
begin
  inherited;
  dbGrdCmdEnCours.OnDrawColumnCell := self.grilleLGPIsimple;

  // Titre fenetre
  Caption := 'Historique achat';

  // Taille par défaut
  FClientHeight := 396;
  FClientWidth := 595;

  lWrdAnneeEnCours := CurrentYear;
  lblAnnee112.Caption := Format('%d/%d', [lWrdAnneeEnCours, lWrdAnneeEnCours - 1]);
  lblAnnee1324.Caption := Format('%d/%d', [lWrdAnneeEnCours - 1, lWrdAnneeEnCours - 2]);
end;

end.
