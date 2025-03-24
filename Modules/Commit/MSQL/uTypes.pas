unit uTypes;

interface

uses Generics.Collections;

var
  tPgEncoding: TDictionary<String, String>;
  sModule: String;
  sEncoding: String;
procedure encodingInit;

implementation

procedure encodingInit;
begin
  tPgEncoding := TDictionary<String, String>.create;
  tPgEncoding.Add('LGO2', 'WIN1252');
  tPgEncoding.Add('SMARTRX', 'UTF-8');
end;

initialization

finalization

end.
