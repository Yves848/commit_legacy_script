unit mdlSantePHARMA;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, Grids, DBGrids, mdlPIDBGrid, mdlDialogue, ImgList, ComCtrls,
  ToolWin, ActnList, uib, StdCtrls, ExtCtrls;

type
  TfrmSantePHARMA = class(TfrmDialogue)
    grdOrganismes: TPIDBGrid;
    dsOrganismes: TDataSource;
    rgFiltre: TRadioGroup;
    procedure FormCreate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure rgFiltreClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure actImprimerExecute(Sender: TObject);
  private
    { Déclarations privées }
    FSQLOrganismes : string;
  public
    { Déclarations publiques }
  end;

const
  C_FILTRE_TOUS_ORGANISMES = 0;
  C_FILTRE_SP = 1;
  C_FILTRE_CETIP = 2;

var
  frmSantePHARMA: TfrmSantePHARMA;

implementation

uses mdlPHA, mdlBase, fbcustomdataset, mdlOutilsPHAPHA_be;

{$R *.dfm}

procedure TfrmSantePHARMA.FormCreate(Sender: TObject);
begin
  inherited;

  FSQLOrganismes := dmOutilsPHAPHA_be.setOrganismes.SQLSelect.Text;
  dmOutilsPHAPHA_be.trDataset.StartTransaction;
  rgFiltreClick(Self);
end;

procedure TfrmSantePHARMA.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  inherited;

  with dmOutilsPHAPHA_be, setOrganismes do
    if Active then
    begin
      if State = dsEdit then
        Post;

      if ChangementOrganismes then
        case MessageDlg('Enregistrer le paramètrage Santé PHARMA ?', mtConfirmation, mbYesNoCancel, 0) of
          mrYes :
            begin
              Close;
              Transaction.Commit;

              CanClose := True;
            end;
          mrNo :
            begin
              Close;
              Transaction.Rollback;

              CanClose := True;
            end;

          mrCancel :
            CanClose := False;
        end
      else
      begin
        Close;
        Transaction.Rollback;
      end;
    end;
end;

procedure TfrmSantePHARMA.rgFiltreClick(Sender: TObject);
begin
  inherited;

  with dmOutilsPHAPHA_be, setOrganismes do
  begin
    if Active then Close;
    case rgFiltre.ItemIndex of
      C_FILTRE_TOUS_ORGANISMES : AjouterWhere(SQLSelect, 'type_organisme = ' + '''' + 'AMC' + '''');
      C_FILTRE_SP : AjouterWhere(SQLSelect, 'type_organisme = ' + '''' + 'AMC' + '''' + ' and nom like ' + '''' + '%SP%' + '''');
      C_FILTRE_CETIP : AjouterWhere(SQLSelect, 'type_organisme = ' + '''' + 'AMC' + '''' + ' and nom = ' + '''' + '%CETIP%' + '''');
    end;
    Open;
  end;
end;

procedure TfrmSantePHARMA.FormDestroy(Sender: TObject);
begin
  inherited;

  dmOutilsPHAPHA_be.setOrganismes.SQLSelect.Text := FSQLOrganismes;
end;

procedure TfrmSantePHARMA.actImprimerExecute(Sender: TObject);
begin
  inherited;

  grdOrganismes.Imprimer;
end;

end.
