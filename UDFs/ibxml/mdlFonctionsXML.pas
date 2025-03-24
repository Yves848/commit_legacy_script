unit mdlFonctionsXML;

interface
  uses Windows, SysUtils, MSXML;

type
  TIb_Util_Malloc = function(l: integer): pointer;

  function OuvrirXML(AFichier : PInteger; AXML : PAnsiChar) : Integer; cdecl;
  function RenvoyerNombreEnfants(ACritere : PAnsiChar) : Integer; cdecl;
  function RenvoyerValeurXML(ANoeud : PAnsiChar) : PAnsiChar; cdecl;
  function FermerXML : Integer; cdecl;

var
  hdlIB_UTIL : THandle;
  ib_util_malloc : TIb_Util_Malloc;

  xml : IXMLDOMDocument;

implementation

function OuvrirXML(AFichier : PInteger; AXML : PAnsiChar) : Integer;
var
  f : string;
begin
  try
    f := AXML;
    f := UTF8ToWideString(f);
    xml := CoDOMDocument.Create;
    xml.async := False;
    if AFichier^ = 1 then
      xml.load(f)
    else
      xml.loadXML(f);
    Result := 1;
  except
    xml := nil;
    Result := 0;
  end;
end;

function RenvoyerNombreEnfants(ACritere : PAnsiChar) : Integer;
var
  node : IXMLDOMNodeList;
begin
  node := xml.getElementsByTagName(ACritere);
  if Assigned(node) then
    Result := node.length
  else
    Result := -1;
end;

function RenvoyerValeurXML(ANoeud : PAnsiChar) : PAnsiChar;
var
  node : IXMLDOMNode;
  s : string;
  len, j : Integer;
begin
  s := '';
  node := xml.selectSingleNode(ANoeud);
  if node <> nil then
    s := node.text;

  len := Length(s);
  Result := ib_util_malloc(len + 1);
  for j := 0 to len - 1do
   Result[j] := AnsiChar(s[j + 1]);
  Result[len] := #0;
end;

function FermerXML : Integer;
begin
  try
    xml := nil;
    Result := 1;
  except
    Result := 0;
  end;
end;

initialization
  hdlIB_UTIL := LoadLibrary('ib_util.dll');
  ib_util_malloc := GetProcAddress(hdlIB_UTIL, 'ib_util_malloc');

finalization
  if Assigned(xml) then
    FreeAndNil(xml);
  FreeLibrary(hdlIB_UTIL);

end.
