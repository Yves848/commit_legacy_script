unit mdlConversions;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, mdlProjet, FBCustomDataSet, mdlPHA,
  mdlPIDBGrid, DB, mdlAttente, Contnrs;

type
  TfrConversions = class(TFrame)
    grdConversions: TPIDBGrid;
    dsConversions: TDataSource;
    procedure FrameResize(Sender: TObject);
    procedure grdConversionsDblClick(Sender: TObject);
  private
    FProjet: TProjet;
  public
    { Déclarations publiques }
    property Projet : TProjet read FProjet;
    constructor Create(Aowner : TComponent; AProjet : TProjet); reintroduce; virtual;
    procedure Fermer; virtual;
    procedure Ouvrir; virtual;
  end;
  TClasseFrConversions = class of TfrConversions;

implementation

uses mdlModuleImportPHA;

{$R *.dfm}

{ TfrConvertData }

constructor TfrConversions.Create(Aowner: TComponent; AProjet : TProjet);
begin
  inherited Create(Aowner);

  FProjet := AProjet;
  Align := alClient;
end;

procedure TfrConversions.Ouvrir;
var
  lParametres : TParametresOuvertureDataset;
begin
  if not dsConversions.DataSet.Active then
  begin
    TFBDataSet(dsConversions.DataSet).Transaction.StartTransaction;
    (dsConversions.Dataset as TFBDataSet).Open;
    if Projet.Thread then
    begin
      lParametres := TParametresOuvertureDataset.Create;
      lParametres.DataSet := dsConversions.DataSet;
      lParametres.DataSources.Add(dsConversions);
      AttendreFinExecution(Self, taLibelle, TThreadOuvertureDataset, lParametres, 'Ouverture des données ...');
      lParametres.Free;
    end
    else
      dsConversions.DataSet.Open;
    grdConversions.AjusterLargeurColonnes;
    BringToFront;
  end;
end;

procedure TfrConversions.Fermer;
begin
  with dsConversions.DataSet as TFBDataSet do
    if dmModuleImportPHA.ChangementDonneesConversion or (State = dsEdit) then
      case MessageDlg('Enregistrer les modifications ?', mtConfirmation, mbYesNoCancel, 0) of
        mrYes :
          begin
            if State = dsEdit then
              Post;

            Close;
            Transaction.Commit;
          end;

        mrNo :
          begin
            if State = dsEdit then
              Cancel;

            Close;
            Transaction.Rollback;
          end;
      end
    else
    begin
      Close;
      Transaction.Commit;
    end;
end;

procedure TfrConversions.FrameResize(Sender: TObject);
begin
  if dsConversions.DataSet.Active then
    grdConversions.AjusterLargeurColonnes;
end;

procedure TfrConversions.grdConversionsDblClick(Sender: TObject);
begin
  Ouvrir;
end;

end.
