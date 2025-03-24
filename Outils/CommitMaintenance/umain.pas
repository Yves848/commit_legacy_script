unit umain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, uConsts, ActiveX,
  Dialogs, IOUtils, StdCtrls, types, strutils, ComCtrls, JvExComCtrls, JvProgressBar, PerlRegEx, JvComCtrls, TabNotBk, ExtCtrls,
  JvExControls, JvTimeLine, XMLDoc, XMLDom, DateUtils, JvComponentBase, JvComputerInfoEx;

type
  tUpdatePJ4List = procedure(sFile: string) of object;
  tSetPB = procedure(bEnable: Boolean) of object;
  tUpdateTimeLine = procedure(f: string) of object;

  tSearchPj4 = class(tThread)
  private
    fOnUpdate: tUpdatePJ4List;
    fSetPB: tSetPB;
    fUpdTimeLine: tUpdateTimeLine;
  protected
    Procedure Execute; override;
    Procedure DoTerminate; override;
  public
    constructor Create; reintroduce;
    property setPB: tSetPB read fSetPB write fSetPB;
    property OnUpdate: tUpdatePJ4List read fOnUpdate write fOnUpdate;
    property OnUpdateTimeLine: tUpdateTimeLine read fUpdTimeLine write fUpdTimeLine;
  end;

  TForm2 = class(TForm)
    pb1: TProgressBar;
    TabbedNotebook1: TTabbedNotebook;
    Memo1: TMemo;
    pnlBottom: TPanel;
    pnlTop: TPanel;
    Button1: TButton;
    jvTml1: TJvTimeLine;
    compInfo: TJvComputerInfoEx;
    Label1: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure jvTml1ItemClick(Sender: TObject; Item: TJvTimeItem);
    procedure TabbedNotebook1Change(Sender: TObject; NewTab: Integer; var AllowChange: Boolean);
  private
    { Private declarations }
    procedure getSysinfo;
  public
    { Public declarations }
    procedure UpdatePJ4List(sFile: String);
    procedure setPB(bEnable: Boolean);
    procedure SearchProject;
    procedure start(var m: TMessage); message WM_START;
    procedure getPJ4Infos(f: string);
  end;

var
  Form2: TForm2;

implementation

{$R *.dfm}

procedure TForm2.Button1Click(Sender: TObject);
begin
  Close;
end;

{ tSearchPj4 }

constructor tSearchPj4.Create;
begin
  inherited Create(True);
  self.FreeOnTerminate := True;
end;

procedure TForm2.FormShow(Sender: TObject);
begin
  postmessage(self.Handle, WM_START, 0, 0);
end;

procedure TForm2.getPJ4Infos(f: string);
var
  FFichierProjet: TXMLDocument;
  Item: TJvTimeItem;
  sDate: String;
  fs: TFormatSettings;
  fProject: tProject;
begin

  FFichierProjet := TXMLDocument.Create(Application);
  FFichierProjet.DOMVendor := DOMVendors.Find('MSXML');
  FFichierProjet.FileName := f;
  FFichierProjet.Active := True;

  Item := jvTml1.Items.Add;
  Item.Caption := FFichierProjet.DocumentElement.ChildNodes['modules'].ChildNodes['import'].Attributes['nom'];
  Item.WidthAs := TJvTimeItemtype.asPixels;
  Item.Width := self.Canvas.TextWidth(Item.Caption) + 2;
  fProject := tProject.Create(f);
  Item.Data := fProject;
  try
    sDate := FFichierProjet.DocumentElement.ChildNodes['modules'].ChildNodes['import'].Attributes['date'];
    Item.Date := tFile.GetCreationTime(f);
  except

  end;
  FFichierProjet.Active := False;
  FFichierProjet.free;
end;

procedure TForm2.getSysinfo;
begin
  Label1.Caption := compInfo.Identification.LocalUserName;
end;

procedure TForm2.jvTml1ItemClick(Sender: TObject; Item: TJvTimeItem);
var
  fProject: tProject;
begin
  //
  fProject := tProject(Item.Data);
  Memo1.Lines.Add(Format('Chemin %s, Fichier %s', [fProject.Path, fProject.name]));
  Memo1.Lines.Add(Format('création %s', [datetostr(fProject.Date)]));
  Memo1.Lines.Add(Format('Taille %d', [fProject.Size]));

end;

procedure TForm2.SearchProject;
var
  PJ4Thread: tSearchPj4;
begin
  setPB(True);
  PJ4Thread := tSearchPj4.Create;
  PJ4Thread.OnUpdate := UpdatePJ4List;
  PJ4Thread.setPB := setPB;
  PJ4Thread.start;
end;

procedure TForm2.setPB(bEnable: Boolean);
begin
  pb1.Visible := bEnable;
end;

procedure TForm2.start(var m: TMessage);
begin
  TabbedNotebook1.ActivePage := 'Projets';
  Application.ProcessMessages;
  SearchProject;

end;

procedure TForm2.TabbedNotebook1Change(Sender: TObject; NewTab: Integer; var AllowChange: Boolean);
begin
  if NEwTab = 0 then
    GetSysinfo;
end;

procedure TForm2.UpdatePJ4List(sFile: String);
begin
  // Memo1.Lines.Add(sFile);
  getPJ4Infos(sFile);
end;

procedure tSearchPj4.DoTerminate;
begin
  setPB(False);
end;

procedure tSearchPj4.Execute;
const
  regEx = 'pj4$';
var
  Predicate: TDirectory.TFilterPredicate;
  aSearchOption: tSearchOption;
  drives: tStringDynArray;
  i: integer;
  RE: tPerlRegEx;
  sFile: String;
begin
  inherited;
  RE := tPerlRegEx.Create;
  RE.regEx := regEx;
  coinitialize(nil);
  drives := TDirectory.GetLogicalDrives;
  for i := 0 to length(drives) - 1 do
  begin
    Predicate := function(const Path: string; const SearchRec: TSearchrec): Boolean
    begin
      RE.Subject := SearchRec.Name;
      if RE.Match then
      begin
        sFile := tPath.Combine(Path, SearchRec.name);
        // OnUpdateTimeLine(sFile);
        OnUpdate(sFile);

        Application.ProcessMessages;
        exit(True);
      end;
      exit(False);
    end;

    aSearchOption := tSearchOption.soAllDirectories;
    TDirectory.GetFileSystemEntries(drives[i], aSearchOption, Predicate);
  end;
  RE.free;
  CoUninitialize;
  Terminate;
end;

end.
