unit mdlLectureFichierCSV;

interface

uses
  Windows, Classes, SysUtils, Math, Dialogs, mdlInformationFichier,
  mdlLectureFichierBinaire, mdlTypes, xmlintf, JclStrings, Variants;

type
  TDonneesCSV = class(TDonneesFormatees)
  private
    FValeurs: TPIList<string>;
    FEntete: Boolean;
  public
    property Entete : Boolean read FEntete;
    constructor Create(AFichier : TFichierBinaire); override;
    destructor Destroy; override;
  published
    property Valeurs : TPIList<string> read FValeurs;
    procedure Remplit(var ABuffer); override;
  end;

  TFichierCSV = class(TFichierBinaire)
  private
    FSautLigne : Integer;
    FSeparateur : string;
    FEnregNoInterne : Integer;
    FEntetes: TStringList;
  protected
    function RenvoyerClasseDonnees : TClasseDonneesFormatees; override;
    procedure RemplirBuffer; override;
  public
    constructor Create(AFichier: string;
      AParametres : Pointer = nil); override;
    destructor Destroy; override;
    property Entetes : TStringList read FEntetes;
  end;

implementation

{ TFichierCSV }

constructor TFichierCSV.Create(AFichier: string; AParametres: Pointer);
begin
  inherited;

  FEnregNoInterne := 0;
  FEntetes := TStringList.Create;
  if IXMLNode(FParametres).ChildNodes.IndexOf('saut_ligne') <> -1 then
    FSautLigne := IXMLNode(FParametres).ChildNodes['saut_ligne'].NodeValue
  else
    FSautLigne := 0;
end;

destructor TFichierCSV.destroy;
begin
  if Assigned(FEntetes) then FreeAndNil(FEntetes);

  inherited;
end;

procedure TFichierCSV.RemplirBuffer;
const
  C_TAILLE_BLOC = 1024;

var
  lBoolEnreg : Boolean;
  l, lIntNbOctets, lIntFinEnreg : Integer;
  I: Integer;

  procedure InitialiserBuffer;
  begin
    SetLength(FBuffer, C_TAILLE_BLOC);
    l := 0;
  end;

  procedure RechercherFinEnreg;
  var
    i : Integer;
    lBoolEntreGuillemet : boolean;
  begin
    lBoolEntreGuillemet := false ;
    lIntFinEnreg := -1; i := 0;
    while (i < l) and (lIntFinEnreg = -1) do
    begin
      if FBuffer[i] = ord('"') then
        lBoolEntreGuillemet := not(lBoolEntreGuillemet);
      if (FBuffer[i] = $0A) and (not(lBoolEntreGuillemet)) then
        lIntFinEnreg := i
      else
        Inc(i);
    end;
  end;

begin
  lBoolEnreg := False;
  InitialiserBuffer;
  while not lBoolEnreg and (F.Position <> F.Size) do
  begin
    lIntNbOctets := IfThen((F.Position + C_TAILLE_BLOC) <= F.Size, C_TAILLE_BLOC, F.Size - F.Position);
    F.ReadBuffer(FBuffer[l], lIntNbOctets);

    l := Length(FBuffer);
    RechercherFinEnreg;
    if lIntFinEnreg = -1 then
      SetLength(FBuffer, l + C_TAILLE_BLOC)
    else
    begin
      l := lIntFinEnreg + 1;
      SetLength(FBuffer, lIntFinEnreg + 1);
      FBuffer[l - 1] := 0;
      F.Seek(l - lIntNbOctets, soFromCurrent);

      if FEnregNoInterne = FSautLigne then
      begin
        FEntetes.Clear;
        Donnees.Remplit(FBuffer[0]);
        for I := 0 to TDonneesCSV(Donnees).Valeurs.Count - 1 do
          FEntetes.Add(TDonneesCSV(Donnees).Valeurs[i]);

        lBoolEnreg := not TDonneesCSV(Donnees).Entete;
      end
      else
        lBoolEnreg := FEnregNoInterne > FSautLigne;

      Inc(FEnregNoInterne);
      InitialiserBuffer;
    end;
  end;
end;

function TFichierCSV.RenvoyerClasseDonnees: TClasseDonneesFormatees;
begin
  Result := TDonneesCSV;
end;

{ TDonneesCSV }

constructor TDonneesCSV.Create(AFichier: TFichierBinaire);
var
  s : string;
begin
  inherited;

  FValeurs := TPIList<string>.Create;

  s := ExtractFileNameWExt(Fichier.Fichier);
  if Assigned(TFichierCSV(Fichier).Parametres) then
    if IXMLNode(TFichierCSV(Fichier).Parametres).HasAttribute(s) then
      FEntete := IXMLNode(TFichierCSV(Fichier).Parametres).Attributes[s] = '1'
    else
      FEntete := True
  else
    FEntete := True;
end;

destructor TDonneesCSV.Destroy;
begin
  if Assigned(FValeurs) then FreeAndNil(FValeurs);

  inherited;
end;

procedure TDonneesCSV.Remplit(var ABuffer);
var
  i : Integer;
  lStrBuffer : ansistring;

  function ExtraireChaine(ASeparateurs: TSysCharSet; AChaine: string;
    AStrings: TPIList<string>): Integer;
  var
    i, l, d : Integer;
    dc : boolean;
  begin
    AStrings.Clear;
    Result := 0;

    i := 1;
    d := 1;
    l := Length(AChaine);

    if l > 0 then
    begin
      while (i <= l) do
      begin
        if (not dc) and (AChaine[i] = '"') then
          dc := True  //debut de chaine
        else
          if (dc and (AChaine[i] = '"')  and ((i=l) or (CharInSet(AChaine[i+1], ASeparateurs)) ) ) or
             (not dc and CharInSet(AChaine[i], ASeparateurs)) then
             //si on est dans une chaine ET il y a un caractère " ET (on est en fin de ligne OU il y a une virgule juste derrière)
             // OU on change de champs
             // le ((i=l) or (AChaine[i+1] = ','))  a été rajouté car si une chaine de caractère contenait "" : plantage
             // Donc on vérifie que le caractère fermant " est bien fermant : virgule derrière ou fin de ligne
          begin
            if dc then
            begin
              AStrings.Add(Trim(Copy(AChaine, d + 1, i - d - 1)));
              Inc(i);
            end
            else
              AStrings.Add(Trim(Copy(AChaine, d, i - d)));
            dc := false;
            d := i + 1;
          end;

        Inc(i);
      end;

      if (CharInSet(AChaine[l], ASeparateurs)) then
        AStrings.Add('')
      else
        if i <> d then
          AStrings.Add(Copy(AChaine, d, i - d));
    end;
  end;

begin
  inherited;

  lStrBuffer := ''; i := 0;
  while TByteArray(ABuffer)[i] <> 0 do
    Inc(i);

  setstring( lStrBuffer ,  Pansichar(@TByteArray(ABuffer)[0]) , i );
  lStrBuffer := Utf8toAnsi(lStrBuffer);

  ExtraireChaine([','], lStrBuffer, FValeurs);
end;

end.
