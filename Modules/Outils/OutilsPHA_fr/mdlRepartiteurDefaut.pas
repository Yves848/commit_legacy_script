unit mdlRepartiteurDefaut;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, DB, Grids, DBGrids, mdlPIDBGrid, mdlDialogue, ImgList,
  ComCtrls, ToolWin, ActnList, Math, fbcustomdataset;

type
  TfrmRepartiteurDefaut = class(TfrmDialogue)
    dbGrdRepDefaut: TPIDBGrid;
    dsRepartiteur: TDataSource;
    procedure FormCreate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure dsRepartiteurDataChange(Sender: TObject; Field: TField);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  frmRepartiteurDefaut: TfrmRepartiteurDefaut;

implementation

uses mdlOutilsPHAPHA_fr;

{$R *.dfm}

procedure TfrmRepartiteurDefaut.FormCreate(Sender: TObject);
begin
  with dmOutilsPHAPHA_fr.setRepartiteur do
  begin
    Transaction.StartTransaction;
    Open;
  end;
end;

procedure TfrmRepartiteurDefaut.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  with dmOutilsPHAPHA_fr, setRepartiteur do
    if Active then
    begin
      if State = dsEdit then
        Post;
      
      if ChangementRepDefaut then
        case MessageDlg('Enregistrer le nouveau répartiteur par défaut ?', mtConfirmation, mbYesNoCancel, 0) of
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

procedure TfrmRepartiteurDefaut.dsRepartiteurDataChange(Sender: TObject;
  Field: TField);
begin
  inherited;

  dbGrdRepDefaut.Refresh;
end;

end.
