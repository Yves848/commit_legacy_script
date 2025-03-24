unit mdlDialogue;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ImgList, ComCtrls, ToolWin,
  mdlProjet, ActnMan, ActnList, ActnCtrls,
  Menus, XPStyleActnCtrls, mdlBase;

type
  TfrmDialogue = class(TfrmBase)
    ilActions: TImageList;
    alActionsSupp: TActionList;
    alActionsStd: TActionList;
    actFermer: TAction;
    actImprimer: TAction;
    actStdSeparateur_1: TAction;
    procedure actFermerExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    FActionManager: TActionManager;
  protected
    { Déclarations privées }
    property ActionManager : TActionManager read FActionManager;
  public
    { Déclarations publiques }
  end;

var
  frmDialogue: TfrmDialogue;

implementation

{$R *.dfm}

procedure TfrmDialogue.FormCreate(Sender: TObject);
var
  i, lIntNbOcc : Integer;
  lItemClient : TActionClientItem;
  lStrCategorie : string; lItemCategorie : TActionClientItem;
begin
  // Construction de la barre d'outils
  lIntNbOcc := alActionsSupp.ActionCount - 1;
  if (lIntNbOcc >= 0) or (alActionsStd.Tag = 1) then
  begin
    FActionManager := TActionManager.Create(Self);
    FActionManager.Images := ilActions;
    with FActionManager.ActionBars.Add do
    begin
      ActionBar := TActionToolBar.Create(Self);
      ActionBar.Parent := Self;
      with alActionsSupp do
      begin
        lStrCategorie := ''; lItemCategorie := nil;
        for i := 0 to lIntNbOcc do
          if TAction(Actions[i]).Visible then
          begin
            if TAction(Actions[i]).Category <> '' then
            begin
              if (not Assigned(lItemCategorie)) or (TAction(Actions[i]).Category <> lStrCategorie) then
              begin
                lStrCategorie := TAction(Actions[i]).Category;

                lItemCategorie := Items.Add;
                lItemCategorie.Action := Actions[i];
                lItemCategorie.Caption := lStrCategorie;
              end;
              lItemCategorie.Items.Add.Action := Actions[i];
            end
            else
            begin
              lItemClient := Items.Add;
              lItemClient.Action := Actions[i];
            end;
          end;
      end;
      ActionBar.RecreateControls;

      if lIntNbOcc < 0 then actStdSeparateur_1.Visible := False;

      with alActionsStd do
      begin
        for i := 0 to ActionCount - 1 do
          if TAction(Actions[i]).Visible then
          begin
            lItemClient := Items.Add;
            lItemClient.Action := Actions[i];
          end
      end;
    end;
  end;
end;

procedure TfrmDialogue.actFermerExecute(Sender: TObject);
begin
  Close;
end;

end.
