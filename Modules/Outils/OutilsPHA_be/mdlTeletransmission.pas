unit mdlTeletransmission;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, Grids, DBGrids, mdlPIDBGrid, mdlDialogue, ImgList, ComCtrls,
  ToolWin, ActnList, uib, Menus, JvMenus, StdCtrls, ExtCtrls;

type
  TfrmTeletransmission = class(TfrmDialogue)
    grdTransmissions: TPIDBGrid;
    dsOrganismes: TDataSource;
    rgTypeOrganisme: TRadioGroup;
    actForcer: TAction;
    procedure FormCreate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure actForcerExecute(Sender: TObject);
    procedure rgTypeOrganismeClick(Sender: TObject);
    procedure actImprimerExecute(Sender: TObject);
    procedure grdTransmissionsKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Déclarations privées }
    procedure OuvrirOrganismes;
  public
    { Déclarations publiques }
  end;

var
  frmTeletransmission: TfrmTeletransmission;

implementation

uses mdlPHA, mdlBase, mdlChoixID, mdlForcageDestinataire,
  mdlOutilsPHAPHA_be;
{$R *.dfm}

procedure TfrmTeletransmission.FormCreate(Sender: TObject);
begin
  inherited;

  OuvrirOrganismes;
end;

procedure TfrmTeletransmission.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  inherited;

  with dmOutilsPHAPHA_be, setOrganismes do
    if Active then
    begin
      if State = dsEdit then
        Post;

      if ChangementOrganismes then
        case MessageDlg('Enregistrer les nouveaux destinataires ?', mtConfirmation, mbYesNoCancel, 0) of
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

procedure TfrmTeletransmission.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  if Key = VK_DELETE then
    with dmOutilsPHAPHA_be.setOrganismes do
    begin
      Edit;
      FieldByName('T_DESTINATAIRE_ID').Value := null;
      post;
    end;
end;

procedure TfrmTeletransmission.OuvrirOrganismes;
begin
  with dmOutilsPHAPHA_be.setOrganismes do
  begin
    if Active then Close;
    if Transaction.InTransaction then Transaction.Commit;
    Transaction.StartTransaction;
    Open;
  end;
end;

procedure TfrmTeletransmission.actForcerExecute(Sender: TObject);
var
  lVarDestinataireID : Variant;
  lVarDepartementID : Variant;
  lIntTypeOrganisme : Integer;
begin
  inherited;

  with dmOutilsPHAPHA_be do
    if TfrmForcageDestinataire.Create(Self).ShowModal(lIntTypeOrganisme, lVarDestinataireID, lVarDepartementID) = mrOk then
    begin
      sp.Transaction.StartTransaction;
      sp.BuildStoredProc('ps_utl_pha_maj_organisme');

      sp.Params.ByNameAsInteger['ATYPEORGANISME'] := lIntTypeOrganisme;

      if VarIsNull(lVarDepartementID) then
        sp.Params.ByNameIsNull['ADEPARTEMENT'] := True
      else
        sp.Params.ByNameAsString['ADEPARTEMENT'] := lVarDepartementID;

      if VarIsNull(lVarDestinataireID) then
        sp.Params.ByNameIsNull['ADESTINATAIREID'] := True
      else
        sp.Params.ByNameAsString['ADESTINATAIREID'] := lVarDestinataireID;
      sp.Execute;
      sp.Transaction.Commit;

      OuvrirOrganismes;
    end;
end;

procedure TfrmTeletransmission.rgTypeOrganismeClick(Sender: TObject);
begin
  inherited;


  with dmOutilsPHAPHA_be, setOrganismes do
  begin
    if Active then Close;
    case rgTypeOrganisme.ItemIndex of
      C_TELETRANS_TOUS_ORGANISMES : AjouterWhere(SQLSelect, '');
      C_TELETRANS_ORGANISMES_AMO : AjouterWhere(SQLSelect, 'type_organisme = ' + '''' + 'AMO' + '''');
      C_TELETRANS_ORGANISMES_AMC : AjouterWhere(SQLSelect, 'type_organisme = ' + '''' + 'AMC' + '''');
    end;
    Open;
  end;
end;

procedure TfrmTeletransmission.actImprimerExecute(Sender: TObject);
begin
  inherited;

  grdTransmissions.Imprimer;
end;

procedure TfrmTeletransmission.grdTransmissionsKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;

  if (Key = VK_DELETE) and (ssCtrl in Shift) then
    with dmOutilsPHAPHA_be.setOrganismes do
    begin
      Edit;
      FieldByName('T_DESTINATAIRE_ID').AsVariant := null;
      Post;
    end;
end;

end.
