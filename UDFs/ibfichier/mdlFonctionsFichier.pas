unit mdlFonctionsFichier;

interface

uses
  Windows, SysUtils, Classes, JclFileUtils, JclStringConversions, Math;

type
  ISC_QUAD = record
    isc_quad_high : Integer ;  // Date
    isc_quad_low  : Cardinal ; // Time
  end;
  PISC_QUAD = ^ISC_QUAD;

  TIb_Util_Malloc = function(l: integer): pointer;

  function supprimerfichier(AFichier : PAnsiChar) : Integer; cdecl;
  function fichierexistant(AFichier : PAnsiChar) : Integer; cdecl;
  function extrairechemin(AFichier : PAnsiChar) : PAnsiChar; cdecl;
  function extrairefichier(AFichier : PAnsiChar) : PAnsiChar; cdecl;
  function renvoyerdatefichier(AFichier : PAnsiChar; AResultat : PISC_QUAD) : PISC_QUAD; cdecl;
  function ouvrirfichiertexte(AFichier : PAnsiChar) : Integer; cdecl;
  function creerfichiertexte(AFichier : PAnsiChar) : Integer; cdecl;
  function lirefichiertexte(AFichier : PInteger) : PAnsiChar; cdecl;
  function ecrirefichiertexte(AFichier : PInteger; ATexte : PAnsiChar) : Integer; cdecl;
  function fermerfichier(AFichier : PInteger) : Integer; cdecl;
  function renommerfichier(AFichier : PAnsiChar; ANom : PAnsiChar) : Integer; cdecl;

var
  hdlIB_UTIL : THandle;
  ib_util_malloc : TIb_Util_Malloc;

implementation

uses DateUtils;

type
  TM = record
    tm_sec : integer;   // Seconds
    tm_min : integer;   // Minutes
    tm_hour : integer;  // Hour (0--23)
    tm_mday : integer;  // Day of month (1--31)
    tm_mon : integer;   // Month (0--11)
    tm_year : integer;  // Year (calendar year minus 1900)
    tm_wday : integer;  // Weekday (0--6) Sunday = 0)
    tm_yday : integer;  // Day of year (0--365)
    tm_isdst : integer; // 0 if daylight savings time is not in effect)
  end;
  PTM = ^TM;

  procedure isc_encode_timestamp (tm_date: PTM; ib_date: PISC_QUAD); stdcall; external 'fbembed.DLL';
  procedure isc_decode_timestamp (ib_date: PISC_QUAD; tm_date: PTM); stdcall; external 'fbembed.DLL';
  procedure isc_decode_sql_date (var ib_date: Integer; tm_date: PTM); stdcall; external 'fbembed.DLL';
  procedure isc_encode_sql_date (tm_date: PTM; var ib_date: Integer); stdcall; external 'fbembed.DLL';
  procedure isc_decode_sql_time (var ib_date: Cardinal; tm_date: PTM); stdcall; external 'fbembed.DLL';
  procedure isc_encode_sql_time (tm_date: PTM; var ib_date: Cardinal); stdcall; external 'fbembed.DLL';

function supprimerfichier(AFichier : PAnsiChar) : Integer; cdecl;
var
  c : string;
begin
  c := AFichier;
  c := UTF8ToWideString(c);
  if FileExists(AFichier) then
    Result := Ord(DeleteFile(AFichier))
  else
    Result := -1;
end;

function fichierexistant(AFichier : PAnsiChar) : Integer; cdecl;
var
  c : string;
  r : TSearchRec;
begin
  c := AFichier;
  c := UTF8ToWideString(c);
  if not Assigned(AFichier) then
    Result := -1
  else
    if (Pos('*', c) > 0) or (Pos('?', c) > 0) then
      if FindFirst(c, faAnyFile, r) = 0 then
      begin
        Result := 1;
        FindClose(r);
      end
      else
        Result := 0
    else
      if FileExists(c) then
        Result := 1
      else
        Result := 0;
end;

function extrairechemin(AFichier : PAnsiChar) : PAnsiChar; cdecl;
var
  c : string;
  i, j : Integer;
begin
  c := AFichier;
  c := WideStringToUTF8(ExtractFilePath(UTF8ToWideString(c))); i := Length(c);
  Result := ib_util_malloc(i + 1);
  for j := 0 to i - 1do
   Result[j] := AnsiChar(c[j + 1]);
  Result[i] := #0;
end;

function extrairefichier(AFichier : PAnsiChar) : PAnsiChar; cdecl;
var
  c : string;
  i, j : Integer;
begin
  c := AFichier;
  c := WideStringToUTF8(ExtractFileName(UTF8ToWideString(c))); i := Length(c);
  Result := ib_util_malloc(i + 1);
  for j := 0 to i - 1do
   Result[j] := AnsiChar(c[j + 1]);
  Result[i] := #0;
end;

function renvoyerdatefichier(AFichier : PAnsiChar; AResultat : PISC_QUAD) : PISC_QUAD;
var
  c : string;
  d : TDateTime;
  a, m, j, h, mn, s, ms : Word;
  r : TM;
begin
  c := AFichier;
  if GetFileLastWrite(UTF8ToWideString(AFichier), d) then
  begin
    DecodeDateTime(d, a, m, j, h, mn, s, ms);
    r.tm_sec := s;
    r.tm_min := mn;
    r.tm_hour := h;
    r.tm_mday := j;
    r.tm_mon := m - 1;
    r.tm_year := a - 1900;
    isc_encode_timestamp(@r, AResultat);
    Result := AResultat;
  end
  else
    Result := nil;
end;

function ouvrirfichiertexte(AFichier : PAnsiChar) : Integer;
var
  c : string;
begin
  c := AFichier;
  Result := FileOpen(UTF8ToWideString(c), fmOpenRead);
end;

function creerfichiertexte(AFichier : PAnsiChar) : Integer;
var
  c : string;
begin
  c := AFichier;
  Result := FileCreate(UTF8ToWideString(AFichier), fmOpenWrite, 0);
end;

function lirefichiertexte(AFichier : PInteger) : PAnsiChar;
const
  C_TAILLE_BUFFER = 2048;
var
  s : PAnsiChar;
  i, l, nb : Integer;
begin
  s := AnsiStrAlloc(C_TAILLE_BUFFER);
  nb := FileRead(AFichier^, s^, C_TAILLE_BUFFER);
  if nb = 0 then
  begin
    s := '-1';
    l := 2;
  end
  else
  begin
    i := 0; l := StrLen(s);
    while (s[i] <> #10) and (i < l) do
      Inc(i);
    FileSeek(AFichier^, (nb - i - 1) * -1, soFromCurrent);

    if (s[i-1] = #13) then
      l := i - 1
    else
      l := i;
  end;

  Result := ib_util_malloc(l + 1);
  Move(s[0], Result[0], l);
  Result[l] := #0;
end;

function ecrirefichiertexte(AFichier : PInteger; ATexte : PAnsiChar) : Integer;
var
  s : PAnsiChar;
  i, l : Integer;
begin
  l := StrLen(ATexte) + 3;
  s := AnsiStrAlloc(l);
  Move(ATexte^, s^, l - 3);
  s[l - 3] := #13;
  s[l - 2] := #10;
  s[l - 1] := #0;

  Result := FileWrite(AFichier^, s^, l - 1);
  StrDispose(s);
end;

function fermerfichier(AFichier : PInteger) : Integer;
begin
  FileClose(AFichier^);
  Result := 0;
end;

function renommerfichier(AFichier : PAnsiChar; ANom : PAnsiChar) : Integer; cdecl;
begin
  Result := IfThen(FileMove(AFichier, ANom, True), 1);
end;

initialization
  hdlIB_UTIL := LoadLibrary('ib_util.dll');
  ib_util_malloc := GetProcAddress(hdlIB_UTIL, 'ib_util_malloc');

finalization
  FreeLibrary(hdlIB_UTIL);

end.


