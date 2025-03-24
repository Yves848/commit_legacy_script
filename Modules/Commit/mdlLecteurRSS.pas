unit mdlLecteurRSS;

interface

uses
  Windows, SysUtils, Classes, Contnrs, Variants,
  XMLDoc, ActiveX, XMLIntf, xmldom, msxmldom,
  IdHTTP, IdStack, DateUtils, Generics.Defaults, Generics.Collections;

type
  TItemRSS = class
  private
    FCategorie: string;
    FLien: string;
    FGUID: string;
    FTitre: string;
    FAuteur: string;
    FDescription: string;
    FPublication: TDateTime;
    FVersion: Integer;
  public
    property Titre : string read FTitre;
    property Description : string read FDescription;
    property Lien : string read FLien;
    property GUID : string read FGUID;
    property Auteur : string read FAuteur;
    property Categorie : string read FCategorie;
    property Version : Integer read FVersion;
    property Publication : TDateTime read FPublication;
    constructor Create(AItem : IXMLNode);
  end;

  TItemComparer = class(TComparer<TItemRSS>)
  public
    function Compare(const Left: TItemRSS; const Right: TItemRSS): Integer; override;
  end;

  TLecteurRSS = class(TComponent)
  private
    FRSS : TList<TItemRSS>;
    FLien: string;
    FDescription: string;
    FCopyright: string;
    FEditeur: string;
    FWebMaster: string;
    FLanguage: string;
    FTitre: string;
    FPublication: TDateTime;
    FURL: string;
    FSurApresCharger: TNotifyEvent;
    function GetItem(Index: Integer): TItemRSS;
    procedure SetURL(const Value: string);
    procedure ParserXML(Sender : TObject);
    function GetTotal: Integer;
  protected
    FComparer : TItemComparer;
    procedure TelechargerFlux(AURL: string); virtual;
  public
    property Items[Index : Integer] : TItemRSS read GetItem;
    property Total : Integer read GetTotal;
    constructor Create(Aowner : TComponent); overload; override;
    constructor Create(Aowner : TComponent; AURL : string);  reintroduce; overload;
    destructor Destroy; override;
    procedure Rafraichir;
  published
    property URL : string read FURL write SetURL;
    property Titre : string read FTitre;
    property Lien : string read FLien;
    property Description : string read FDescription;
    property Language : string read FLanguage;
    property Copyright : string read FCopyright;
    property Editeur : string read FEditeur;
    property WebMaster : string read FWebMaster;
    property Publication : TDateTime read FPublication;
    property SurApresCharger : TNotifyEvent read FSurApresCharger write FSurApresCharger;
  end;

implementation

function ValiderValeur(ANoeud: IXMLNodeList;
  ANomNoeud: string): string;
var
  n : IXMLNode;
  v : Variant;
  s : string;
begin
  n := ANoeud.FindNode(ANomNoeud);
  if Assigned(n) then
    if not VarIsNull(n.NodeValue) then
	begin
	  s := VarAsType(n.NodeValue, varString);
      Result := string(UTF8ToWideString(s))
	end
    else
      Result := ''
  else
    Result := '';
end;

type
  TThreadRequeteHTTP = class(TThread)
  private
    FFlux: string;
    FURL: string;
  protected
    procedure Execute; override;
  public
    property Flux : string read FFlux;
    constructor Create(AURL : string); reintroduce;
  end;

{ TItemRSS }

constructor TItemRSS.Create(AItem : IXMLNode);
const
  C_RSS_JOURS_COURTS : array[0..6] of string = ('Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun');
  C_RSS_MOIS_COURTS : array[1..12] of string = ('Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec');
var
  lStrPubDate, mois : string;
  y, m, d : Word;
  i: Integer;

  function Rechercher(AListe : array of string; AValeur : string) : Integer;
  var
    i : Integer;
  begin
    Result := -1; i := 0;
    while (i <= High(AListe)) and (Result = -1) do
      if AListe[i] = AValeur then
        Result := i + 1
      else
        Inc(i);
  end;

begin
  with AItem do
  begin
    FTitre := ValiderValeur(ChildNodes, 'title');
    FDescription := ValiderValeur(ChildNodes, 'description');
    FLien := ValiderValeur(ChildNodes, 'link');
    FGUID := ValiderValeur(ChildNodes, 'guid');
    FAuteur := ValiderValeur(ChildNodes, 'author');
    FCategorie := ValiderValeur(ChildNodes, 'category');
    TryStrToInt(ValiderValeur(ChildNodes, 'version'), FVersion);

    // Traitement date de publication
    lStrPubDate := ValiderValeur(ChildNodes, 'pubDate');
    y := StrToInt(Copy(lStrPubDate, 13, 4));

    i := 1; m := 0; mois := Copy(lStrPubDate, 9, 3);
    while (i <= 12) and (m = 0) do
    begin
      if (C_RSS_MOIS_COURTS[i] = mois) then
        m := i
      else
        Inc(i);
    end;

    d := StrToInt(Copy(lStrPubDate, 6, 2));

    TryEncodeDate(y, m, d, FPublication);
  end;
end;

{ TLecteurRSS }

constructor TLecteurRSS.Create(Aowner: TComponent);
begin
  inherited Create(Aowner);

  FRSS := TList<TItemRSS>.Create;
  FComparer := TItemComparer.Create;
end;

constructor TLecteurRSS.Create(Aowner: TComponent; AURL: string);
begin
  Create(Aowner);

  if AURL <> '' then
    SetURL(AURL);
end;

destructor TLecteurRSS.Destroy;
begin
  if Assigned(FComparer) then FreeAndNil(FComparer);
  if Assigned(FRSS) then FreeAndNil(FRSS);

  inherited;
end;

function TLecteurRSS.GetItem(Index: Integer): TItemRSS;
begin
  Result := FRSS[Index];
end;

function TLecteurRSS.GetTotal: Integer;
begin
  Result := FRSS.Count;
end;

procedure TLecteurRSS.ParserXML(Sender: TObject);
var
  lXML : IXMLDocument;
  i : Integer;
  q : TThreadRequeteHTTP;
begin
  try
    q := TThreadRequeteHTTP(Sender);
    with q do
      if ReturnValue = 0 then
      begin
        lXML := LoadXMLData(Flux);

        // Propriétés du flux RSS
        with lXML.DocumentElement.ChildNodes['channel'] do
        begin
          FTitre := ValiderValeur(ChildNodes, 'title');
          FLien := ValiderValeur(ChildNodes, 'link');
          FDescription := ValiderValeur(ChildNodes, 'description');
          FLanguage := ValiderValeur(ChildNodes, 'language');
          FCopyright := ValiderValeur(ChildNodes, 'copyright');
          FEditeur := ValiderValeur(ChildNodes, 'managingEditor');
          FWebMaster := ValiderValeur(ChildNodes, 'webMaster');

          FRSS.Clear;
          for i := 0 to ChildNodes.Count - 1 do
            if LowerCase(ChildNodes[i].NodeName) = 'item' then
              FRSS.Add(TItemRSS.Create(ChildNodes[i]));
        end;
      end;
  finally
    lXML := nil
  end;
end;

procedure TLecteurRSS.Rafraichir;
var
  i : Integer;
begin
  TelechargerFlux(FURL);

  // Tri par date
  FRSS.Sort(FComparer);

  if Assigned(FSurApresCharger) then
    FSurApresCharger(Self);
end;

procedure TLecteurRSS.SetURL(const Value: string);
begin
  FURL := Value;
  Rafraichir;
end;

procedure TLecteurRSS.TelechargerFlux(AURL : string);
begin
  if AURL <> '' then
    with TThreadRequeteHTTP.Create(AURL) do
      OnTerminate := ParserXML;
end;

{ TThreadRequeteHTTP }

constructor TThreadRequeteHTTP.Create(AURL: string);
begin
  FURL := AURL;
  FreeOnTerminate := True;
  inherited Create(False);
end;

procedure TThreadRequeteHTTP.Execute;
var
  l : TStringList;
begin
  inherited;

  try
    ReturnValue := 0;
    with TIdHTTP.Create(nil) do
    begin
      FFlux := Get(FURL);
      l := TStringList.Create;
      l.Add(FFlux);
      l.SaveToFile('d:\maj.xml');
      l.Free;
      Free;
    end;
  except
    on E:EIdSocketError do
    begin
      ReturnValue := E.LastError;
      FFlux := E.Message
    end;

    on E:EIdHTTPProtocolException do
    begin
      ReturnValue := E.ErrorCode;
      FFlux := E.ErrorMessage
    end;
  end;
end;

{ TItemComparer }

function TItemComparer.Compare(const Left, Right: TItemRSS): Integer;
begin
  Result := Round(Int(Right.Publication) - Int(Left.Publication));
end;

end.
