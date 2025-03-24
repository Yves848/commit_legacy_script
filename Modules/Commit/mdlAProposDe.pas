unit mdlAProposDe;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ShellAPI, ExtCtrls, mdlPIPanel, JclPeImage,
  mdlInformationFichier, VirtualTrees, JvExControls, JvLinkLabel, jpeg,
  JclSySInfo;

type
  TfrmAProposDe = class(TForm)
    pnlInformationVersion: TPIPanel;
    btnFermer: TButton;
    lblNomApplication: TLabel;
    lblVersionApplication: TLabel;
    vstDLL_BPL: TVirtualStringTree;
    lblVersionWindows: TLabel;
    lblLisezMoi: TLabel;
    imgApp: TImage;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure vstDLL_BPLFreeNode(Sender: TBaseVirtualTree;
      Node: PVirtualNode);
    procedure lblLisezMoiClick(Sender: TObject);
    procedure vstDLL_BPLGetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType; var CellText: string);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmAProposDe: TfrmAProposDe;

implementation

{$R *.dfm}

const
  C_COLONNE_NOM = 0;
  C_COLONNE_VERSION = 1;
  C_COLONNE_DATE_MODIFICATION = 2;

type
  PrecEXE = ^TrecEXE;
  TrecEXE = record
    Nom : string;
    Version : string;
    Date : TDateTime;
  end;

procedure TfrmAProposDe.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TfrmAProposDe.FormCreate(Sender: TObject);
var
  lRechercheDLL_BPL : TSearchRec;
  lStrRepApp : string;
  lNoeud : PVirtualNode;
  lpRecInfoEXE : PrecEXE;
  info : TJclPeImage;
  lVersionWindows : TOSVersionInfo;
begin
  // Version COMMIT
  info := TJclPeImage.Create;

  info.FileName := ParamStr(0);
  with info.VersionInfo do
  begin
    lblNomApplication.Caption := Items.Values['ProductName'];
    lblVersionApplication.Caption := FileVersion;
  end;

  // DLL & BPL utilisés
  lStrRepApp := ExtractFileDir(ParamStr(0));
  vstDLL_BPL.NodeDataSize := SizeOf(TrecEXE);
  if FindFirst(lStrRepApp + '\*.bpl', faAnyFile, lRechercheDLL_BPL) = 0 then
  begin
    vstDLL_BPL.BeginUpdate;
    vstDLL_BPL.Clear;
    repeat
      lNoeud := vstDLL_BPL.AddChild(nil);
      lpRecInfoEXE := vstDLL_BPL.GetNodeData(lNoeud);

      info.FileName := lStrRepApp +  '\' + lRechercheDLL_BPL.Name;
      with info do
      begin
        lpRecInfoEXE^.Nom := ExtractFileName(lRechercheDLL_BPL.Name);
        lpRecInfoEXE^.Version := VersionInfo.FileVersion;
        lpRecInfoEXE^.Date := FileProperties.LastWriteTime;
      end;
    until FindNext(lRechercheDLL_BPL) <> 0;
    vstDLL_BPL.EndUpdate;

    FindClose(lRechercheDLL_BPL);
  end;

  // Version Windows
  lblVersionWindows.Caption := GetWindowsVersionString;

  FreeAndNil(info);
end;

procedure TfrmAProposDe.vstDLL_BPLFreeNode(Sender: TBaseVirtualTree;
  Node: PVirtualNode);
var
  lpRecInfoEXE : PrecEXE;
begin
  lpRecInfoEXE := vstDLL_BPL.GetNodeData(Node);
  if Assigned(lpRecInfoEXE) then
    with lpRecInfoEXE^ do
    begin
      Nom := '';
      Version := '';
      Date := 0;
    end;
end;

procedure TfrmAProposDe.vstDLL_BPLGetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: string);
var
  lpRecInfoEXE : PrecEXE;
begin
  lpRecInfoEXE := vstDLL_BPL.GetNodeData(Node);
  case Column of
    C_COLONNE_NOM : CellText := lpRecInfoEXE^.Nom;
    C_COLONNE_VERSION : CellText := lpRecInfoEXE^.Version;
    C_COLONNE_DATE_MODIFICATION : CellText := FormatDateTime('DD/MM/YYYY', lpRecInfoEXE^.Date);
  end;
end;

procedure TfrmAProposDe.lblLisezMoiClick(Sender: TObject);
var
  lStrRepApp : string;
begin
  lStrRepApp := ExtractFileDir(ParamStr(0));
  ShellExecute(0, 'open', PChar(lStrRepApp + '\lisez moi.txt'), nil, PChar(lStrRepApp), SW_NORMAL);
end;

end.
