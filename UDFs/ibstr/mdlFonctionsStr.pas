unit mdlFonctionsStr;

interface

uses
  Windows,
  SysUtils,
  //StrUtils,
  //Classes,
  //Dialogs,
  JclStringConversions;

type
  PByte = ^Byte;
  PInteger = ^Integer;

  TIb_Util_Malloc = function(l: integer): pointer;

  function initcap(AValeur : PAnsiChar) : PAnsiChar; cdecl;
  function isnumber(AValeur : PAnsiChar) : Integer; cdecl;
  function isdate(AValeur : PAnsiChar) : Integer; cdecl;
  function ldistance(AChaine1 : PAnsiChar; AChaine2 : PAnsiChar): Integer; cdecl;
  function rtftotext(AChaine : PAnsiChar) : PAnsiChar; cdecl;

var
  hdlIB_UTIL : THandle;
  ib_util_malloc : TIb_Util_Malloc;

implementation

//******************************************************************************
function initcap(AValeur : PAnsiChar) : PAnsiChar;
var
  s : string;
  lIntLgValeur : Integer;
begin
  if Assigned(AValeur) then
  begin
    lIntLgValeur := StrLen(AValeur);
    if lIntLgValeur > 0 then
    begin
      s := Utf8ToAnsi(AValeur);
      s := UpperCase(s[1]) + LowerCase(Copy(s, 2, Length(s)));
      AValeur := PAnsiChar(AnsiToUTF8(s));

      Result := ib_util_malloc(lIntLgValeur + 1);
      Move(AValeur[0], Result[0], lIntLgValeur );
      Result[lIntLgValeur] := #0;
    end
    else
      Result := nil;
  end
  else
    Result := nil;
end;

//******************************************************************************
function isnumber(AValeur : PAnsiChar) : Integer; cdecl;
var
  lIntTemp : Int64;
begin
  if Assigned(AValeur) then
    if TryStrToInt64(AValeur, lIntTemp) then
      Result := 1
    else
      Result := 0
  else
    Result := -1;
end;

function isdate(AValeur : PAnsiChar) : Integer; cdecl;
var
  lDtTemp : TDateTime;
begin
  if Assigned(AValeur) then
    if TryStrToDate(AValeur, lDtTemp) then
      Result := 1
    else
      Result := 0
  else
    Result := -1;
end;

function ldistance(AChaine1 : PAnsiChar; AChaine2 : PAnsiChar): Integer; cdecl;

  function minimum(a,b,c: integer):integer;
  var min : integer;
  begin
    min := a;
    if (b < min) then
      min := b;
    if (c < min) then
      min := c;

    Result := min;
  end;

var
  c1, c2 : string;
  d: array of array of Integer;
  n, m, i, j, costo: Integer;
  s_i, t_j: Char;

begin
  c1 := UTF8Decode(AChaine1); c2 := UTF8Decode(AChaine2);
  n := Length(AChaine1);
  m := Length(AChaine2);
  if (n = 0) then begin
      Result := m;
      Exit;
    end;
  if m = 0 then begin
      Result := n;
      Exit;
    end;
  setlength(d, n + 1, m + 1);
  for i := 0 to n do
    d[i, 0] := i;
  for j := 0 to m do
    d[0, j] := j;
  for i := 1 to n do
    begin
      s_i := c1[i];
      for j := 1 to m do
        begin
          t_j := c2[j];
          if s_i = t_j then costo := 0 else costo := 1;
          d[i, j] := Minimum(d[i - 1][j] + 1, d[i][j - 1] + 1, d[i -1][j - 1] + costo);
        end;
    end;
  Result := d[n, m];
end;

function rtftotext(AChaine : PAnsiChar) : PAnsiChar;
var
  //n: Nombre de caractères à traiter à la source
  //i:index du caractère dans le résultat
  //    (utilisé après le traitement de la source)
  //x:index du caractère que l'on traite dans la source (voir ThisChar)
  n, x : Integer;

  //flag iniquant si on est en train de lie un code de formatage
  //Un code de formatage commence par un Anti-Slash "\" et
  //considéré comme fini juste avant un autre Anti-slash,
  //un espace ou un retour à la ligne.
  GetCode : Boolean;

  //Chaîne dans laquelle on stocke le code de formatage que
  //l'on est en train de lire
  Code : String;

  //Caractère que l'on est en train de traiter,
  //et caractère le précédant
  ThisChar, LastChar : Char;

  //Niveau de groupe (ou bloc) de format dans lequel on se trouve
  //un groupe commence par une accolade ouverte "{" et se termine par une accolade fermée "}"
  Group : Integer;

//Flag indiquant si le caractère Thiscar doit être rejeté (True) ou recopié dans le résultat (False]
  Skip : Boolean;

  c, r : string;

  procedure ProcessCode;
  begin
    //Si on vient de terminer la lecture d'un code de formatage
    if CharInSet(ThisChar, ['\',' ',#13,#10]) then
    begin
      //si on vient de lire le code de format d'un début de paragraphe
      //ou celui d'un passage à la ligne...
      if (Code = '\par') or (Code = '\line') or (Code = '\pard') then
        begin
          //#13#10 est le code iutilisé sous Windows
          //pour coder en ASCII un retour à la ligne
          r := r + #13#10;
          GetCode := FALSE;
          skip := TRUE;
        end;
      //si on vient de lire le code de format d'une tabulation
      if Code = '\tab' then
      begin
        //#9 est le code iutilisé sous Windows
          //pour coder une tabulation en code ASCII
        r := r + #9;
        GetCode := FALSE;
        skip := TRUE;
      end;
    end;
    //Un code de format \'xx indigue le code ASCII d'un caractère spécial
    // (lettres accentuées en particulier). xx est ce code en héxadécimal.
    if ((Length(Code) = 4) and ((Code[1] + code[2]) = '\''')) then
    begin
      //on retranscrit le code hexadécimal en code ASCII)
      r := r + Chr(strtoint('$' + code[3] + code[4]));
      GetCode := FALSE;
      skip := TRUE;
    end;
  end;

begin
  try
    //Initialisations
    c := AChaine;
    c := UTF8ToWideString(c);
    n := Length(c);
    if (n > 0) then
    begin
      r := '';

      GetCode := FALSE;
      Group := 0;
      LastChar := #0;

      //Traitement de la source
      x := 1;
      while x <= n do
        begin
          Skip := FALSE;
          ThisChar := c[x];
          case ThisChar of
           '{' :
             if LastChar <> '\' then
             begin  //Début de groupe
               inc(Group);
               skip := TRUE;
             end
             else
               GetCode := FALSE;

            '}':
              if LastChar <> '\' then
              begin //Fin de groupe
                dec(Group);
                skip := TRUE;
              end
              else
                GetCode := FALSE;

            '\':
              if LastChar <> '\' then
              begin // Début de Code de format à traiter
                 if GetCode then
                   ProcessCode;
                 Code := '';
                 GetCode := TRUE;
              end
              else
                GetCode := FALSE; //c'était bien le caractère anti-slash
                                  //(codé en RTF avec deux anti-slashs
                                  // successifs)
            ' ':
              begin
                if GetCode then
                begin //fin de Code de format
                  ProcessCode;
                  GetCode := FALSE;
                  skip:=TRUE;
                end;
              end;

            #10:
              begin
                if GetCode then
                begin //fin de Code de format
                  ProcessCode;
                  GetCode := FALSE;
                  skip := TRUE;
                end;

                //(on est dans un groupe,
                // on ne recopie pas le "LineFeed")
                if Group > 0 then
                  skip := TRUE;
              end;
            #13:
              begin
                if GetCode then
                begin
                  ProcessCode;
                  GetCode := FALSE;
                  skip := TRUE;
                end;

                //(on est dans un groupe,
                // on ne recopie pas le "Retour chariot")
                if Group > 0 then
                  skip := TRUE;
              end;
          end;
          if not GetCode then
          begin
            if (not Skip) and (Group <= 1) then
              //On a un caractère à recopier dans le résultat du traitement
              //(du texte brut, pas du format)
              r := r + ThisChar;
          end
          else
          begin
            //on lit le code
            Code := Code + ThisChar;
            ProcessCode;
          end;
          //Préparation de la boucle suivante
          LastChar:=ThisChar;
          Inc(x);
        end;
      //Fin du traitement de la source et
      //Début de traitement du résultat obtenu

      //Suppression des catractères cr/lf et espaces en fin de chaîne
      n := Length(r);
      while ((n > 0) and (r[n] < ' ')) do
        dec(n);

      if n > 0 then
        SetLength(r, n);
      r := TrimLeft(r);
      r := WideStringToUTF8(r);

      Result := ib_util_malloc(n + 1);
      for x := 0 to n - 1do
        Result[x] := AnsiChar(r[x + 1]);
      Result[n] := #0;
    end
    else
      Result := nil;
  except
    on e:exception do
  end;
end;

initialization
  hdlIB_UTIL := LoadLibrary('ib_util.dll');
  ib_util_malloc := GetProcAddress(hdlIB_UTIL, 'ib_util_malloc');

finalization
  FreeLibrary(hdlIB_UTIL);

end.

