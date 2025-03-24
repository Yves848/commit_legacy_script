unit mdlModuleTransfertInstallationScriptsSQL;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, mdlBase, JvExExtCtrls, JvRadioGroup, Math,
  jpeg,  mdlModuleTransfertPHA;

type
  TfrmModuleTransfertInstallationScriptsSQL = class(TfrmBase)
    imgMigrationKit: TImage;
    btnOK: TButton;
    btnCancel: TButton;
    bvlSeparator_1: TBevel;
    rdgScripts: TJvRadioGroup;
    procedure FormCreate(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
    function ShowModal(var AScriptsSelectionnes : string) : Integer; reintroduce;
  end;

var
  frmModuleTransfertInstallationScriptsSQL : TfrmModuleTransfertInstallationScriptsSQL;

implementation

{$R *.dfm}

function TfrmModuleTransfertInstallationScriptsSQL.ShowModal(var AScriptsSelectionnes : string) : Integer;
begin
  Result := inherited ShowModal;

  if Result = mrOk then
    AScriptsSelectionnes := rdgScripts.Items[rdgScripts.ItemIndex]
  else
    AScriptsSelectionnes := '';
end;

procedure TfrmModuleTransfertInstallationScriptsSQL.FormCreate(Sender: TObject);
var
  lScripts : TSearchRec;
  versionTarget,
  versionSource : String;
begin
  inherited;

  versionSource := stringreplace(dmModuleTransfertPHA.versionLGPI,'.','',[rfReplaceAll]);
  if FindFirst(Module.RepertoireRessources + '\*.*', faAnyFile, lScripts) = 0 then
  begin
    repeat
      if ((lScripts.Attr and faDirectory) = faDirectory) and
         (lScripts.Name <> '.') and (lScripts.Name <> '..') then
         begin
          rdgScripts.Items.Add(lScripts.Name)  ;
          versionTarget := stringreplace(lScripts.Name,'.','',[rfReplaceAll]);
            if pos(  versionSource ,  versionTarget)> 0 then
            begin
              rdgScripts.itemindex := rdgScripts.Items.Count + 1 ;
              rdgScripts.Buttons[rdgScripts.itemindex].Color := clLime;
              rdgScripts.Buttons[rdgScripts.itemindex].Font.Size := 10;
              rdgScripts.Buttons[rdgScripts.itemindex].Font.Style := [fsBold,fsUnderline];
            end
         end;
    until FindNext(lScripts) <> 0;
    FindClose(lScripts);

    with rdgScripts do
    begin
      Height := (IfThen(Odd(Items.Count), Items.Count + 1, Items.Count) div Columns) * 30;
      //ItemIndex := Items.Count - 1;
    end;
  end;
end;

end.
