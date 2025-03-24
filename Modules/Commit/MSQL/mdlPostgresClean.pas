unit mdlPostgresClean;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Grids, JvExGrids, JvStringGrid, ZAbstractConnection, ZConnection, DB, ZAbstractRODataset, ZAbstractDataset,
  ZDataset, dateUtils;

const
  get_dblist = 'SELECT datname FROM pg_database WHERE datistemplate = false';
  get_db_age = 'select stats_reset from pg_stat_database where datname=''%s''';
  get_db_size = 'SELECT pg_size_pretty(pg_database_size(''%s'')) as size';
  drop_db = 'DROP DATABASE IF EXISTS "%s";';

type
  tdbObject = class(tObject)
    private
       fdbName : string;
       fdbSize : string;
       fdbAge  : string;
       fAgeInDays : Integer;
    public
       property dbName : string read fdbName write fdbName;
       property dbSize : string read fdbSize write fdbSize;
       property dbAge : string read fdbAge write fdbAge;
       property ageInDays : Integer read fAgeInDays write fAgeInDays;
  end;

type
  TfrmPostgresClean = class(TForm)
    ZConnection1: TZConnection;
    sg1: TJvStringGrid;
    Memo1: TMemo;
    ZQuery1: TZQuery;
    Button1: TButton;
    btnDropDB: TButton;
    btnClose: TButton;
    procedure Button1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnDropDBClick(Sender: TObject);
    procedure sg1SelectCell(Sender: TObject; ACol, ARow: Integer; var CanSelect: Boolean);
    procedure btnCloseClick(Sender: TObject);
  private
    { Déclarations privées }
    dbList : tStrings;
    procedure cleanGrid;
    procedure addToGrid(pdbObject: tdbObject);
    procedure dropDB(pdbOObject: tdbObject);
  public
    { Déclarations publiques }
    procedure listDB;
  end;

var
  frmPostgresClean: TfrmPostgresClean;

implementation

{$R *.dfm}

procedure TfrmPostgresClean.addToGrid(pdbObject: tdbObject);
var
  iRow : integer;
begin
  iRow := sg1.rowcount -1;
  if sg1.Cells[0,iRow] <> '' then
  begin
    sg1.RowCount := sg1.RowCount + 1;
    iRow := sg1.rowcount -1;
  end;
  sg1.objects[0,iRow] := pdbObject;
  sg1.Cells[0,iRow] := pdbObject.dbName;
  sg1.Cells[1,iRow] := pdbObject.dbSize;
  sg1.Cells[2,iRow] := inttostr(pdbObject.ageInDays);

end;

procedure TfrmPostgresClean.btnCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmPostgresClean.btnDropDBClick(Sender: TObject);
begin
    if (sg1.Row > 0) and (sg1.Row <= sg1.RowCount -1) then
    begin
      dropdb(tdbObject(sg1.Objects[0, sg1.Row]));
      listDB;
    end;
end;

procedure TfrmPostgresClean.Button1Click(Sender: TObject);
begin
  listDB;

end;

procedure TfrmPostgresClean.cleanGrid;
var
  i : Integer;
begin
    sg1.Cells[0,0] := 'Database';
    sg1.Cells[1,0] := 'Taille';
    //sg1.Cells[2,0] := 'Age (jours)';

    i := 1;
    while i <= sg1.RowCount -1 do
    begin
      if sg1.Objects[0,i] <> nil then
      begin
         tdbObject(sg1.Objects[0,i]).Free;
      end;
      sg1.Cells[0,i] := '';
      sg1.Cells[1,i] := '';
      //sg1.Cells[2,i] := '';
      inc(i);
    end;
    sg1.RowCount := 2;
end;

procedure TfrmPostgresClean.dropDB(pdbOObject: tdbObject);
var
  sSql : String;
begin
    //
    sSql := Format(drop_db,[pdbOObject.dbName]);
    ZConnection1.Connected := true;
    ZQuery1.SQL.Text := sSql;
    ZQuery1.Active := True;
    zQuery1.ExecSQL;
    ZConnection1.Commit;
end;

procedure TfrmPostgresClean.FormShow(Sender: TObject);
begin
    listdb;
end;

procedure TfrmPostgresClean.listDB;
var
   pdbObject : tdbObject;
   i : integer;
   dNow, dDB : tDateTime;
   day,month, year : integer;
   idaysBetween : Integer;
begin
    ZConnection1.Connected := true;
    zquery1.SQL.Text := get_dblist;
    ZQuery1.Active := true;
    memo1.Lines.Clear;
    cleanGrid;
    dbList := tStringList.Create;
    // Get the database list
    while not zQuery1.Eof do
    begin
      pdbObject := tdbObject.Create;
      pdbObject.dbName := zQuery1.FieldByName('datname').AsString;
      dblist.AddObject(pdbObject.dbName,pdbObject);
      zquery1.Next;
    end;
    zQuery1.Close;

    // Get the databases infos.....

    i := 0;
    dNow := now;
    while i <= dbList.Count -1 do
    begin
      zquery1.Close;
      zquery1.SQL.Text := format(get_db_size,[tdbObject(dblist.Objects[i]).dbName]);
      zQuery1.Active := true;
      tdbObject(dblist.Objects[i]).dbSize := ZQuery1.FieldByName('size').AsString;
      zQuery1.Close;
      zQuery1.SQL.Text := format(get_db_age,[tdbObject(dblist.Objects[i]).dbName]);
      zquery1.Active := true;
      tdbObject(dblist.Objects[i]).dbAge := ZQuery1.FieldByName('stats_reset').AsString;
      //dDB := strtodatetime(tdbObject(dblist.Objects[i]).dbAge);
      //idaysBetween := DaysBetween(dNow,dDB);
      //tdbObject(dblist.Objects[i]).ageInDays := idaysBetween;
      //Memo1.Lines.Add(tdbObject(dblist.Objects[i]).dbName + '  = ' + tdbObject(dblist.Objects[i]).dbSize + '  | ' + tdbObject(dblist.Objects[i]).dbAge +
      //'  | ' + inttostr(tdbObject(dblist.Objects[i]).ageInDays) + ' jours');
      addToGrid(tdbObject(dblist.Objects[i]));
      inc(i);
    end;
    sg1.row := 1;
    zquery1.Close;


end;

procedure TfrmPostgresClean.sg1SelectCell(Sender: TObject; ACol, ARow: Integer; var CanSelect: Boolean);
begin
     //
     if (aRow > 0) and (aRow <= sg1.RowCount -1) then
     begin
       btnDropDB.Enabled := (uppercase(sg1.Cells[0,arow]) <> 'POSTGRES');

     end;
end;

end.
