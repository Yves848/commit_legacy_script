unit mdlCouvAMCIncorr;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, IBSQL, DB, IBDatabase, IBCustomDataSet, mdlPIIBDataSet,
  Grids, DBGrids, mdlPIDBGrid, mdlPIIBParser, mdlDialog, ImgList, ComCtrls,
  ToolWin, mdlProject, mdlPIXPMenu, mdlPIGrid;

type
  TfrmCouvAMCIncorr = class(TfrmDialog)
    dSetCouvAMCIncorr: TPIIBDataSet;
    dbGrdCouvAMCIncorr: TPIDBGrid;
    dsCouvAMCIncorr: TDataSource;
    btnOk: TButton;
    btnCancel: TButton;

    procedure dSetCouvAMCIncorrAfterOpen(DataSet: TDataSet);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure btnOkClick(Sender: TObject);
  private
    { Déclarations privées }
    FCancel : Boolean;
  public
    { Déclarations publiques }
    constructor Create(Aowner : TComponent; AProject : TProject; AXPMenu : TPIXPMenu); override;
  end;

var
  frmCouvAMCIncorr: TfrmCouvAMCIncorr;

implementation

uses mdlCommitPHA;

{$R *.dfm}

constructor TfrmCouvAMCIncorr.Create(Aowner : TComponent; AProject : TProject; AXPMenu : TPIXPMenu);
var
  lStrWhere : string;
begin
  inherited;

  FCancel := True;  
  dSetCouvAMCIncorr.Database := Project.phaConnexion;

  // Chargement des requetes de sélection des couvertures
  with Project.IBQuery do
  begin
    Transaction.StartTransaction;
    SQL.Clear;
    SQL.Add('select pr.prestation');
    SQL.Add('from tr_prestation pr');
    SQL.Add('     inner join tr_prestation_detail pr_d on (pr_d.prestation = pr.prestation)');
    SQL.Add('where pr_d.utilisable_conversion = ' + '''' + '1' + '''');
    SQL.Add('order by pr.priorite');
    ExecQuery;

    while not EOF do
    begin
      // Dataset
      dSetCouvAMCIncorr.Parser.SetExpression(0, cSelect, dSetCouvAMCIncorr.Parser.Queries[0][cSelect].Expression + ', ' + FieldByName('prestation').AsString + '.taux ' + FieldByName('prestation').AsString);
      dSetCouvAMCIncorr.Parser.SetExpression(0, cFrom, dSetCouvAMCIncorr.Parser.Queries[0][cFrom].Expression + ' left join t_tauxpriseencharge ' + FieldByName('prestation').AsString +
                                                            ' on (' + FieldByName('prestation').AsString + '.couvertureamc = t_couvertureamc.couvertureamc and ' +
                                                            FieldByName('prestation').AsString + '.prestation = ' + '''' + FieldByName('prestation').AsString + '''' + ')');
      dSetCouvAMCIncorr.Parser.SetExpression(0, cGroupBy, dSetCouvAMCIncorr.Parser.Queries[0][cGroupBy].Expression + ', ' + FieldByName('prestation').AsString + '.taux');

      Next;
    end;
    Close;
    Transaction.Commit;
  end;

  // Refresh
  lStrWhere := dSetCouvAMCIncorr.Parser.Queries[0][cWhere].Expression;
  dSetCouvAMCIncorr.Parser.SetExpression(0, cWhere, lStrWhere + ' and couvamc.couvertureamc = :COUVERTUREAMC');
  dSetCouvAMCIncorr.RefreshSQL.AddStrings(dSetCouvAMCIncorr.SelectSQL);
  dSetCouvAMCIncorr.Parser.SetExpression(0, cWhere, lStrWhere);

  // Mise à jour des Mode de calcul
  with Project.IBQuery do
  begin
    Transaction.StartTransaction;
    SQL.Clear;
    SQL.Add('execute procedure MAJCOUVERTUREAMC(null, null)');
    ExecQuery;
    Transaction.Commit;
  end;

  dSetCouvAMCIncorr.Open;
end;

procedure TfrmCouvAMCIncorr.dSetCouvAMCIncorrAfterOpen(DataSet: TDataSet);
var
  i : integer;
begin
  with dbGrdCouvAMCIncorr do
  begin
    with Columns[0] do
    begin
      Title.Alignment := taCenter;
      Title.Caption := 'Organisme';
      Width := 60;
    end;

    with Columns[1] do
    begin
      Title.Alignment := taCenter;
      Title.Caption := 'Nom';
      Width := 125;
    end;

    with Columns[2] do
    begin
      Title.Alignment := taCenter;
      Title.Caption := 'Code couv.';
      Width := 60;
    end;

    with Columns[3] do
    begin
      Title.Alignment := taCenter;
      Title.Caption := 'Libéllé';
      Width := 125;
    end;

    with Columns[4] as TPIColumn do
    begin
      Control := ccComboBox;
      with ControlOptions.ComboBox do
      begin
        ValueAsIndex := True;
        PickList.Add('Complément du remboursement AMO');
        PickList.Add('Remboursement AMO compris');
        PickList.Add('Pourcentage du ticket modérateur');
      end;

      Title.Alignment := taCenter;
      Title.Caption := 'Mode de calcul';
      Width := 170;
    end;

    for i := 6 to Columns.Count - 1 do
    begin
      Columns[i].Title.Alignment := taCenter;
      Columns[i].Width := 30;
    end;

    with Columns[5] do
    begin
      Title.Alignment := taCenter;
      Title.Caption := 'Nb cli.';
      Width := 35;
      Index := Columns.Count - 1;
    end; 
  end;
end;

procedure TfrmCouvAMCIncorr.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  inherited;

  if FCancel then
    with dSetCouvAMCIncorr do
      if IsDataSetModified then
        case MessageDlg('Enregistrer les modifications ?', mtConfirmation, mbYesNoCancel, 0) of
          mrYes :
            begin
              if State = dsEdit then
                Post;

              Close;
              Commit;

              CanClose := True;
            end;

          mrNo :
            begin
              if State = dsEdit then
                Cancel;

              Close;
              Rollback;

              CanClose := True;
            end;

          mrCancel :
            CanClose := False;
        end
      else
      begin
        Close;
        Commit;
      end
  else
  begin
    if dSetCouvAMCIncorr.State = dsEdit then
      dSetCouvAMCIncorr.Post;

    dSetCouvAMCIncorr.Close;
    dSetCouvAMCIncorr.Commit;

    CanClose := True;
  end;
end;

procedure TfrmCouvAMCIncorr.btnOkClick(Sender: TObject);
begin
  inherited;

  FCancel := False;
end;

end.
