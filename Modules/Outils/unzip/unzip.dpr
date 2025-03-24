program unzip;

{$APPTYPE CONSOLE}

uses
  SysUtils, SynZip, ioutils;

var
  zipNAme : String;
  destDir : String;
  pZipRead : tZipREad;
begin
  zipName := paramstr(1);
  if paramcount = 2 then
    destdir := paramstr(2)
  else
  begin
    destdir := tPath.GetDirectoryName(paramstr(0));
  end;
  Writeln('zipFile : '+zipName);
  Writeln('destination : '+destdir);

  Writeln('Décompression........'+chr(13)+chr(13));
  pZipRead := tZipRead.Create(ZipNAme);
  pZipRead.UnZipAll(destdir);
  pZipRead.Free;

  Writeln('Done !!');


end.
