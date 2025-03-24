unit uConsts;

interface
uses
  messages, strutils, ioutils, sysutils ;

const
  SelectPGDB = 'SELECT pg_database.oid,pg_database.datname,pg_database_size(pg_database.datname),stats_reset FROM pg_database '+#13+
               'left join pg_stat_database on pg_database.oid = pg_stat_database.datid '+#13+
               'WHERE datistemplate = false';

  WM_START = WM_USER + 2001;
 type
    tProject = class(tObject)
      private
        fName : String;
        fPath : String;
        fDate : tDateTime;
        function GetDirSize(dir: string; subdir: Boolean): Longint;
      published
        property Name : string read fName write fName;
        property Path : string read fPath write fPAth;
        property Date : TDateTime read fDate write fDate;
      public
        Constructor create(sFile : string);
        function Size : Integer;
    end;
implementation

{ tProject }

constructor tProject.create(sFile : string);
begin
    Path := tPath.GetDirectoryName(sFile);
    Name := tPath.GetFileName(sFile);
    Date := tFile.GetCreationTime(sFile);
end;

function tProject.Size: Integer;
begin
  result := GetDirSize(path,true);
end;

function tProject.GetDirSize(dir: string; subdir: Boolean): Longint;
var
  rec: TSearchRec;
  found: Integer;
begin
  Result := 0;
  if dir[Length(dir)] <> '\' then dir := dir + '\';
  found := FindFirst(dir + '*.*', faAnyFile, rec);
  while found = 0 do
  begin
    Inc(Result, rec.Size);
    if (rec.Attr and faDirectory > 0) and (rec.Name[1] <> '.') and (subdir = True) then
      Inc(Result, GetDirSize(dir + rec.Name, True));
    found := FindNext(rec);
  end;
  FindClose(rec);
end;

end.
