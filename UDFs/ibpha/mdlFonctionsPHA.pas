unit mdlFonctionsPHA;

interface

uses
  Windows, SysUtils;

type
  TIb_Util_Malloc = function(l: integer): pointer;

  function clecip(AValeur : PAnsiChar) : Integer; cdecl;
  function cless(AValeur : PAnsiChar) : Integer; cdecl;

var
  hdlIB_UTIL : THandle;
  ib_util_malloc : TIb_Util_Malloc;

implementation

//******************************************************************************
function clecip(AValeur : PAnsiChar) : Integer; cdecl;
var
  s : string;
  i : Integer;
  lIntTemp : Integer;
begin
  if Assigned(AValeur) then
  begin
    s := AValeur;
    if Length(s) = 6 then
      try
        Result := 0; i := 0;
        while (i <= 5) and (Result <> -1) do
          if TryStrToInt(s[i+1], lIntTemp) then
          begin
            Result := Result + lIntTemp * (i + 2);
            i := i + 1;
          end
          else
            Result := -1;

        if Result <> -1 then
          Result := Result mod 11;
      except
        Result := -1;
      end
    else
     Result := -1
  end
  else
    Result := -1;
end;

//******************************************************************************
function cless(AValeur : PAnsiChar) : Integer; cdecl;
var
  s : string;
  lIntTemp : Int64;
begin
  if Assigned(AValeur) then
  begin
    s := AValeur;
    if (s <> '') and (Length(s) = 13) then
      try
        if TryStrToInt64(s, lIntTemp) then
          Result := 97 - lIntTemp mod 97
        else
          Result := -1;
      except
        Result := -1;
      end
    else
      Result := -1
  end
  else
    Result := -1
end;

initialization
  hdlIB_UTIL := LoadLibrary('ib_util.dll');
  ib_util_malloc := GetProcAddress(hdlIB_UTIL, 'ib_util_malloc');

finalization
  FreeLibrary(hdlIB_UTIL);

end.
