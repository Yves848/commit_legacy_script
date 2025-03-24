unit mdlVisualisationScriptSQL;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, SynEdit, SynMemo, SynEditHighlighter, SynHighlighterSQL,
  SynEditMiscClasses, SynEditSearch, StdCtrls, Buttons, mdlPISpeedButton,
  ExtCtrls, Mask, JvExMask, JvSpin, ComCtrls, mdlBase;

type
  TfrmVisualisationScriptSQL = class(TfrmBase)
    shSQL: TSynSQLSyn;
    mmSQL: TSynMemo;
    pnlRecherche: TPanel;
    lblChercher: TLabel;
    edtChercher: TEdit;
    btnChercher: TPISpeedButton;
    edtNumeroLigne: TJvSpinEdit;
    btnAllerLigne: TPISpeedButton;
    lblNumeroLigne: TLabel;
    Bevel1: TBevel;
    tvScriptsSQL: TTreeView;
    procedure edtChercherKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnChercherClick(Sender: TObject);
    procedure edtChercherChange(Sender: TObject);
    procedure btnAllerLigneClick(Sender: TObject);
    procedure edtNumeroLigneKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure tvScriptsSQLClick(Sender: TObject);
  private
    { Déclarations privées }
    FRepertoireRacine : string;
  public
    { Déclarations publiques }
    function ShowModal(ARepertoire : string; ATypeSQL : TSQLDialect) : Integer; reintroduce; overload;
    function ShowModal(AScriptSQL : string) : Integer; reintroduce; overload;
  end;

var
  frmVisualisationScriptSQL: TfrmVisualisationScriptSQL;

implementation

uses StrUtils, mdlProjet;

{$R *.dfm}

function TfrmVisualisationScriptSQL.ShowModal(ARepertoire : string; ATypeSQL : TSQLDialect) : Integer;

  procedure AjouterScriptsSQL(ARepertoire : string; AParent : TTreeNode);
  var
    lScriptSQL : TSearchRec;
  begin
    if FindFirst(ARepertoire + '\*.*', faAnyFile, lScriptSQL) = 0 then
    begin
      repeat
        if ((lScriptSQL.Name <> '.') and (lScriptSQL.Name <> '..')) or
           (ExtractFileExt(lScriptSQL.Name) = '.sql') then
          if lScriptSQL.Attr and faDirectory = faDirectory then
            AjouterScriptsSQL(ARepertoire + '\' + lScriptSQL.Name, tvScriptsSQL.Items.AddChild(AParent, lScriptSQL.Name))
          else
            tvScriptsSQL.Items.AddChild(AParent, lScriptSQL.Name);
      until FindNext(lScriptSQL) <> 0;

      FindClose(lScriptSQL);
    end;
  end;

begin
  shSQL.SQLDialect := ATypeSQL;
  FRepertoireRacine := ARepertoire;
  AjouterScriptsSQL(ARepertoire, nil);
  tvScriptsSQL.Show;
  tvScriptsSQL.FullExpand;

  Result := inherited ShowModal;
end;

function TfrmVisualisationScriptSQL.ShowModal(AScriptSQL: string): Integer;
begin
  Caption := AScriptSQL;
  mmSQL.Lines.LoadFromFile(AScriptSQL);
  Result := inherited ShowModal;
end;

procedure TfrmVisualisationScriptSQL.edtChercherKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;

  if Key = VK_RETURN then
    btnChercher.Click;
end;

procedure TfrmVisualisationScriptSQL.btnChercherClick(Sender: TObject);
var
  lIntPos : Integer;
begin
  inherited;

  with mmSQL do
  begin
    lIntPos := PosEx(UpperCase(edtChercher.Text), UpperCase(Lines.Text), SelStart + SelLength);
    if lIntPos > 0 then
    begin
      SelStart := lIntPos - 1;
      SelLength := Length(edtChercher.Text);
    end;
  end;
end;

procedure TfrmVisualisationScriptSQL.edtChercherChange(Sender: TObject);
begin
  inherited;

  mmSQL.SelStart := 0;
  mmSQL.SelLength := 0;
end;

procedure TfrmVisualisationScriptSQL.btnAllerLigneClick(Sender: TObject);
begin
  inherited;

  mmSQL.GotoLineAndCenter(edtNumeroLigne.AsInteger);
end;

procedure TfrmVisualisationScriptSQL.edtNumeroLigneKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;

  if Key = VK_RETURN then
    btnAllerLigne.Click
end;

procedure TfrmVisualisationScriptSQL.tvScriptsSQLClick(Sender: TObject);
var
  lStrNomScriptSQL : string;

  procedure RenvoyerNomScriptSQL(Node : TTreeNode);
  begin
    if Assigned(Node.Parent) then
    begin
      lStrNomScriptSQL := Node.Parent.Text + '\' + lStrNomScriptSQL;
      RenvoyerNomScriptSQL(Node.Parent);
    end;
  end;

begin
  RenvoyerNomScriptSQL(tvScriptsSQL.Selected);
  lStrNomScriptSQL := FRepertoireRacine + '\' + lStrNomScriptSQL  + '\' + tvScriptsSQL.Selected.Text;
  Caption := lStrNomScriptSQL;
  mmSQL.Lines.LoadFromFile(lStrNomScriptSQL);
end;

end.
