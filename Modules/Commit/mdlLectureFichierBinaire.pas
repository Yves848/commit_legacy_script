unit mdlLectureFichierBinaire;

interface

uses
  Windows, Classes, SysUtils, Contnrs, Variants, TypInfo, XMLIntf, mdlTypes, Generics.Collections,
  rtti;

type
  EBinaire = class(Exception);
  EBinaireFinFichierInattendue = class(EBinaire);

  TFichierBinaire = class;

  TDonneesFormatees = class(TPersistent)
  private
    FFichier: TFichierBinaire;
  protected
    FTailleBloc: Word;
    FTailleEntete: Word;
  public
    property TailleBloc : Word read FTailleBloc write FTailleBloc;
    property TailleEntete : Word read FTailleEntete write FTailleEntete;
    property Fichier : TFichierBinaire read FFichier;
    procedure Remplit(var ABuffer); virtual; abstract;
    constructor Create(AFichier : TFichierBinaire); virtual;
  end;
  TClasseDonneesFormatees = class of TDonneesFormatees;

  TFichierBinaire = class
  private
    // Recherche des infos RTTI
    FCtx : TRttiContext;
    FRTTI : TRttiType;
    FDonnees: TDonneesFormatees;
    FDonneesBrut : TStringList;
    function GetPosition: Int64;
    function GetDonneesBrut: TStringList;
  protected
    FF: TFileStream;
    FParametres : Pointer;
    FFichier: string;
    FNbEnreg: Integer;
    FEnregNo: Integer;
    FBuffer : TBytes;
    function GetBOF: Boolean; virtual;
    function GetEOF: Boolean; virtual;
    procedure Lire; virtual;
    function RenvoyerDate(ADate : TBytes) : TDateTime; virtual; abstract;
    function RenvoyerFloat(AFloat : TBytes) : Double; virtual; abstract;
    function RenvoyerInt(AInt : TBytes) : Integer; virtual; abstract;
    function RenvoyerClasseDonnees : TClasseDonneesFormatees; virtual; abstract;
    procedure InitialiserLecture; virtual;
    procedure RemplirBuffer; virtual;
  public
    property F : TFileStream read FF;
    property Parametres : Pointer read FParametres;
    property EnregNo : Integer read FEnregNo;
    property NbEnreg : Integer read FNbEnreg;
    property BOF : Boolean read GetBOF;
    property EOF : Boolean read GetEOF;
    property Fichier : string read FFichier;
    property Buffer : TBytes read FBuffer;
    property Donnees : TDonneesFormatees read FDonnees;
    property DonneesBrut : TStringList read GetDonneesBrut;
    property Position : Int64 read GetPosition;
    constructor Create(AFichier: string; AParametres : Pointer = nil); virtual;
    destructor Destroy; override;
    procedure Premier; virtual;
    procedure Suivant; virtual;
  end;
  TClasseFichierBinaire = class of TFichierBinaire;

  IInventaire = interface
    ['{77BB1FFA-C423-4893-A5D7-50DFA554F51D}']
    function GenererInventaire : TStrings;
  end;
  
implementation

{ TFichierBinaire }

constructor TFichierBinaire.Create(AFichier: string;
  AParametres : Pointer = nil);
var
  lTypeFichier : TClasseDonneesFormatees;
begin
  FParametres := AParametres;
  FF := TFileStream.Create(AFichier, fmOpenRead or fmShareDenyWrite);
  FFichier := AFichier;

  FEnregNo := 0;

  lTypeFichier := RenvoyerClasseDonnees;
  if Assigned(lTypeFichier) then
  begin
    FDonnees := lTypeFichier.Create(Self);
    InitialiserLecture;
  end
  else
    raise EBinaire.Create('Type de fichier inconnu !');

  // Informations RTTI
  FCtx := TRttiContext.Create;
  FRTTI := FCtx.GetType(Donnees.ClassInfo);
  FDonneesBrut := TStringList.Create;
end;

destructor TFichierBinaire.Destroy;
begin
  if Assigned(FDonneesBrut) then FreeAndNil(FDonneesBrut);
  FCtx.Free;
  if Assigned(FDonnees) then FreeAndnil(FDonnees);
  if Assigned(F) then FreeAndNil(FF);

  inherited;
end;

function TFichierBinaire.GetBOF: Boolean;
begin
  Result := FEnregNo = 0;
end;

function TFichierBinaire.GetDonneesBrut: TStringList;
var
  props : TArray<TRttiProperty>;
  prop: TRttiProperty;
  v : TValue;
  o : TObject;
  i : Integer;
begin
  FDonneesBrut.Clear;
  props := FRTTI.GetProperties;
  for prop in props do
    if prop.Visibility = mvPublished then
    begin
      v := prop.GetValue(Donnees);
      if prop.PropertyType.TypeKind = tkClass then
      begin
        o := v.AsObject;

        if Assigned(o) then
        begin
          if (o.ClassNameIs('TPIList<System.string>')) then
            for i := 0 to TPIList<string>(o).Count - 1 do FDonneesBrut.Add(prop.Name + IntToStr(i) + '=' + TPIList<string>(o)[i]);

          if (o.ClassNameIs('TPIList<System.TDateTime>')) then
            for i := 0 to TPIList<TDateTime>(o).Count - 1 do FDonneesBrut.Add(prop.Name + IntToStr(i) + '=' + DateToStr(TPIList<TDateTime>(o)[i]));

          if (o.ClassNameIs('TPIList<System.Integer>')) then
            for i := 0 to TPIList<Integer>(o).Count - 1 do FDonneesBrut.Add(prop.Name + IntToStr(i) + '=' + IntToStr(TPIList<Integer>(o)[i]));

          if (o.ClassNameIs('TPIList<System.Double>')) then
            for i := 0 to TPIList<Double>(o).Count - 1 do FDonneesBrut.Add(prop.Name + IntToStr(i) + '=' + FloatToStr(TPIList<Double>(o)[i]));
        end;
      end
      else
      begin
        v := prop.GetValue(Donnees);
        case prop.PropertyType.TypeKind of
          tkInteger: FDonneesBrut.Add(prop.Name + '=' + IntToStr(v.AsInteger));
          tkChar, tkString, tkWChar, tkLString, tkWString, tkUString: FDonneesBrut.Add(prop.Name + '=' + v.AsString);
          tkFloat:
            if prop.PropertyType.Handle = TypeInfo(TDateTime) then
              FDonneesBrut.Add(prop.Name + '=' + DateToStr(v.AsType<TDateTime>))
            else
              FDonneesBrut.Add(prop.Name + '=' + FloatToStr(v.AsType<Double>));
          tkVariant: FDonneesBrut.Add(prop.Name + '=' + VarAsType(v.AsVariant, varString));
          tkInt64: FDonneesBrut.Add(prop.Name  + '=' + IntToStr(v.AsInt64));
          tkSet, tkEnumeration : FDonneesBrut.Add(prop.Name + '=' + v.ToString);
        end;
      end;
    end;
  Result := FDonneesBrut;
end;

function TFichierBinaire.GetEOF: Boolean;
begin
  Result := (FEnregNo = FNbEnreg) and (F.Position = F.Size);
end;

function TFichierBinaire.GetPosition: Int64;
begin
  Result := F.Position;
end;

procedure TFichierBinaire.InitialiserLecture;
begin
  F.Seek(FDonnees.TailleEntete,0);
  if FDonnees.TailleBloc > 0 then
  begin
    SetLength(FBuffer, FDonnees.TailleBloc);
    FNbEnreg := (F.Size-FDonnees.TailleEntete) div FDonnees.TailleBloc;
  end
  else
    FNbEnreg := -1;
end;

procedure TFichierBinaire.Lire;
begin
  if (F.Position + FDonnees.TailleBloc) > F.Size then
    //raise EBinaire.Create('Impossible de lire au délà de la taille du fichier !')
  else
  begin
    RemplirBuffer;
    if Assigned(FDonnees) then
      FDonnees.Remplit(FBuffer[0]);
  end;
end;

procedure TFichierBinaire.Premier;
begin
  F.Position := 0;
  FEnregNo := 1;

  Lire;
end;

procedure TFichierBinaire.RemplirBuffer;
begin
  F.ReadBuffer(FBuffer[0], FDonnees.TailleBloc);
end;

procedure TFichierBinaire.Suivant;
begin
  if (FEnregNo + 1) > FNbEnreg then
  begin
    FEnregNo := FNbEnreg;
    if FNbEnreg <> -1 then
      F.Position := F.Size;
//    raise EBinaireFinFichierInattendue.Create('Impossible de lire plus d''enregistrement !')
  end
  else
    FEnregNo := FEnregNo + 1;
  Lire;
end;

{ TDonnees }

constructor TDonneesFormatees.Create(AFichier: TFichierBinaire);
begin
  FFichier := AFichier;
  FTailleEntete := 0;
end;

end.
