unit mdlSantePHARMA;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, Grids, DBGrids, mdlPIDBGrid, mdlDialogue, ImgList, ComCtrls,
  ToolWin, ActnList, uib, StdCtrls, ExtCtrls, mdlAttente, mdlUIBThread;

type
  TfrmSantePHARMA = class(TfrmDialogue)
    grdOrganismes: TPIDBGrid;
    dsOrganismes: TDataSource;
    rgFiltre: TRadioGroup;
    actEclaterOrgSP: TAction;
    procedure FormCreate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure rgFiltreClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure actImprimerExecute(Sender: TObject);
    procedure actEclaterOrgSPExecute(Sender: TObject);
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

uses mdlPHA, mdlBase, fbcustomdataset, mdlOutilsPHAPHA_fr;

{$R *.dfm}

procedure TfrmSantePHARMA.FormCreate(Sender: TObject);
begin
  inherited;

  FSQLOrganismes := dmOutilsPHAPHA_fr.setOrganismes.SQLSelect.Text;
  dmOutilsPHAPHA_fr.trDataset.StartTransaction;
  rgFiltreClick(Self);
end;

procedure TfrmSantePHARMA.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  inherited;

  with dmOutilsPHAPHA_fr, setOrganismes do
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

  with dmOutilsPHAPHA_fr, setOrganismes do
  begin
    if Active then Close;
    case rgFiltre.ItemIndex of
      C_FILTRE_TOUS_ORGANISMES : AjouterWhere(SQLSelect, 'type_organisme = ' + '''' + 'AMC' + '''');
      C_FILTRE_SP : AjouterWhere(SQLSelect, 'type_organisme = ' + '''' + 'AMC' + '''' + ' and nom like ' + '''' + '%SP%' + '''');
      C_FILTRE_CETIP : AjouterWhere(SQLSelect, 'type_organisme = ' + '''' + 'AMC' + '''' + ' and nom like ' + '''' + '%CETIP%' + '''');
    end;
    Open;
  end;
end;

procedure TfrmSantePHARMA.FormDestroy(Sender: TObject);
begin
  inherited;

  dmOutilsPHAPHA_fr.setOrganismes.SQLSelect.Text := FSQLOrganismes;
end;

procedure TfrmSantePHARMA.actEclaterOrgSPExecute(Sender: TObject);
var
  p : TParametresThreadRequeteFB;
begin
  inherited;

  if MessageDlg('Effectuer l''éclatement SP Santé sur l''organisme ' + dmOutilsPHAPHA_fr.setOrganismesNOM.AsString + ' ?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    p := TParametresThreadRequeteFB.Create(Projet.PHAConnexion, 'PS_UTL_PHA_ECLATER_ORG_SP', 2);
    p.ParametresProc[0] := dmOutilsPHAPHA_fr.setOrganismesT_ORGANISME_ID.AsString;
    p.ParametresProc[1] := 'contrat_sante_pharma';
    AttendreFinExecution(Self, taLibelle, TThreadRequeteFB, p, 'Eclatement SP Santé ...');
    FreeAndNil(p)
  end;
end;

procedure TfrmSantePHARMA.actImprimerExecute(Sender: TObject);
begin
  inherited;

  grdOrganismes.Imprimer;
end;

end.
