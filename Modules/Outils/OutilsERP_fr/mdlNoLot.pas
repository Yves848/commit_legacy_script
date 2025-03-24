unit mdlNoLot;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, mdlDialogue, Grids, DBGrids, mdlPIDBGrid, ImgList, ComCtrls,
  ToolWin, DB, ExtCtrls, DBCtrls, Ora, ActnList;

type
  TfrmNoLot = class(TfrmDialogue)
    dbGrdNoLot: TPIDBGrid;
    dsNoLot: TDataSource;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  frmNoLot: TfrmNoLot;

implementation

uses mdlOutilsERPERP_fr;

{$R *.dfm}

procedure TfrmNoLot.FormCreate(Sender: TObject);
begin
  inherited;

  dmOutilsERPERP_fr.qryNoLot.Open;
end;

procedure TfrmNoLot.FormDestroy(Sender: TObject);
begin
  inherited;

  dmOutilsERPERP_fr.qryNoLot.Close;
end;

procedure TfrmNoLot.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  inherited;

  with dmOutilsERPERP_fr, qryNoLot do
    if Active then
    begin
      if State = dsEdit then
        Post;

      if ChangementNoLot then
        case MessageDlg('Enregistrer les nouveaux  numeros de lot ?', mtConfirmation, mbYesNoCancel, 0) of
          mrYes :
            begin
              Close;
              Session.Commit;

              CanClose := True;
            end;
          mrNo :
            begin
              Close;
              Session.Rollback;

              CanClose := True;
            end;

          mrCancel :
            CanClose := False;
        end
      else
      begin
        Close;
        Session.Rollback;
      end;
    end;
end;

end.
