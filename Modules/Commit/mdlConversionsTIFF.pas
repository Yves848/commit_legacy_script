unit mdlConversionsTIFF;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, mdlPIStringGrid, libgfl, StdCtrls, ImgList, pngimage, mdlGrille,
  Registry, ShellAPI, mdlInformationFichier,zlib, IOUtils, jpeg;

type
  tUpdateStatus = procedure(sMessage: String) of object;

  TThreadConversionTIFF = class(TThread)
  private
    FListeAConvertir: TStrings;
    FSP : TGFL_SAVE_PARAMS;
    FGrille : TStringGrid;
    FTotalAConvertir: Integer;
    FResultatsConversions: TStrings;
    FDocumentEnCours : Integer;
    FCheminGS : string;
    fUpd : tUpdateStatus;
    procedure DecompZLI(zliIn, inflated : String);
    procedure AfficherResultat;
  protected
    procedure Execute; override;
  public
    property ListeAConvertir : TStrings read FListeAConvertir;
    property ResultatsConversions : TStrings read FResultatsConversions;
    property TotalAConvertir : Integer read FTotalAConvertir write FTotalAConvertir;
    constructor Create(ASP : TGFL_SAVE_PARAMS; AGrille : TStringGrid; ACheminGS : string; callBack: tUpdateStatus); reintroduce;
  end;

  TfrmConversionTIFF = class(TForm)
    grdConversionsDocuments: TPIStringGrid;
    btnAnnuler: TButton;
    ListBox1: TListBox;
    procedure FormCreate(Sender: TObject);
    procedure btnAnnulerClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure ThreadConversionsTIFFSurFinConversions(Sender : TObject);
    procedure grdConversionsDocumentsSurDessinerCellule(Sender: TObject; ACol,
      ARow: Integer; Rect: TRect; State: TGridDrawState);
  private
    { Déclarations privées }
    FEtatGrille : array[Boolean] of TPngImage;
    FTHConversions : TThreadConversionTIFF;
    FCheminGS : string;
    procedure upd(sMessage: string);
  public
    { Déclarations publiques }
    property THConversions : TThreadConversionTIFF read FTHConversions;
    procedure Initialiser(ACheminGS : string);
    procedure AjouterDocumentAConvertir(AFichier : string);
    procedure RelancerConversions;
    procedure StartConvert;
  end;

  procedure ChargerBitmap(ANomRessource, ATypeRessource : string; var ABitmap : TPngImage);
  function frmConversionTIFF: TfrmConversionTIFF;
  function frmExiste : Boolean;

const
  C_CONVERSIONS_TIFF_COLONNE_FICHIER = 0;
  C_CONVERSIONS_TIFF_COLONNE_RESULTAT = 1;

implementation

{$R *.dfm}
{$R etat_grille.res}

var
  FfrmConversionTIFF : TfrmConversionTIFF;

procedure ChargerBitmap(ANomRessource, ATypeRessource : string; var ABitmap : TPngImage);
var
  r : TResourceStream;
begin
  r := TResourceStream.Create(hinstance, ANomRessource, PChar(ATypeRessource));
  ABitmap := TPngImage.Create;
  ABitmap.LoadFromStream(r);
  FreeAndNil(r);
end;

function frmConversionTIFF: TfrmConversionTIFF;
begin
  if not Assigned(FfrmConversionTIFF) and not Application.Terminated then
    FfrmConversionTIFF := TfrmConversionTIFF.Create(Application.MainForm);
  Result := FfrmConversionTIFF;
end;

function frmExiste : Boolean;
begin
  Result := Assigned(FfrmConversionTIFF);
end;

{ TThreadConversionJPGTIFF }

procedure TThreadConversionTIFF.AfficherResultat;
begin
  FResultatsConversions[FDocumentEnCours] := IntToStr(ReturnValue);
  FGrille.Row := FDocumentEnCours;
end;

constructor TThreadConversionTIFF.Create(ASP : TGFL_SAVE_PARAMS; AGrille : TStringGrid;
  ACheminGS : string; callBack : tUpdateStatus);
begin
  inherited Create(true);
  fUpd := callback;
  FSP := ASP;
  FGrille := AGrille;
  FCheminGS := ACheminGS;
  FListeAConvertir := AGrille.Cols[C_CONVERSIONS_TIFF_COLONNE_FICHIER];
  FResultatsConversions := AGrille.Cols[C_CONVERSIONS_TIFF_COLONNE_RESULTAT];
  FTotalAConvertir := -1;
end;

procedure TThreadConversionTIFF.DecompZLI(zliIn, inflated : String);
var
   LInput     : TFileStream;
   LUnZip     : TZDecompressionStream;
   lBMP       : TMemoryStream;
   Bmp        : TBitMap;
   Jpg        : TJPEGImage;
begin
  // Ouverture du fichier ZLI .....
  LInput := TFileStream.Create(zliIn, fmOpenRead);
  // Création d'un stream mémoire pour lire le flux décompressé
  lBmp := TmemoryStream.Create;
  // Création du flux de décompression
  LUnZip := TZDecompressionStream.Create(LInput);
  // Décompresser le ZLI.....
  lBmp.CopyFrom(lUnzip,0);
  // Passer les 13 premiers bytes
  lBmp.Position := 13;
  // Créer le Bitmap et charger le flux décompressé (à partir du 14ème octet)
  Bmp := TBitMap.Create;
  Bmp.LoadFromStream(lBmp);
  // Créer le JPG
  Jpg := TJPEGImage.Create;
  // Assigner le BMP lu
  Jpg.Assign(Bmp);
  // Sauver l'image au format JPEG
  Jpg.SaveToFile(Inflated);
  // Libérer les obets et fermer les fichiers.....
  Jpg.Free;
  Bmp.Free;
  LUnZip.Free;
  LInput.Free;
  lBmp.Free;
end;

procedure TThreadConversionTIFF.Execute;
var
  s : string;
  lp : TGFL_LOAD_PARAMS;
  bmp : PGFL_BITMAP;
  info : TGFL_FILE_INFORMATION;
begin
  inherited;

  FDocumentEnCours := 1;
  while not Terminated and ((FTotalAConvertir = -1) or ((FTotalAConvertir <> - 1) and (FDocumentEnCours < FTotalAConvertir))) do
  begin
    if FDocumentEnCours < FListeAConvertir.Count then
    begin
      s := FListeAConvertir[FDocumentEnCours];
      //fUpd('ligne: '+s);
      if s <> '' then
      begin
        if (pos('.ZLI',uppercase(s)) > 0) then
        begin
           DecompZLI(s, ChangeFileExt(s,'.jpg'));
           ReturnValue := GFL_NO_ERROR;
        end
        else
        begin
          gflGetDefaultLoadParams(lp);
          //lp.EpsDpi := 200;
          ReturnValue := gflLoadBitmapW(PChar(s), bmp, lp, info);
          if ReturnValue = GFL_NO_ERROR then
          begin
            ReturnValue := gflSaveBitmapW(PChar(s), bmp, FSP);
            gflFreeBitmap(bmp);
          end;
        end;
        Synchronize(AfficherResultat);
      end;
      Inc(FDocumentEnCours);
    end;
  end;

  if not Terminated then
  begin
    Terminate;
  end;
end;

{ TfrmConversionVersTIFF }

procedure TfrmConversionTIFF.StartConvert;
begin
  THConversions.Start;
end;

procedure TfrmConversionTIFF.upd(sMessage: string);
begin
   ListBox1.Items.Add(sMessage)
end;


procedure TfrmConversionTIFF.AjouterDocumentAConvertir(AFichier: string);
begin
  if trim(AFichier) <> '' then
  with grdConversionsDocuments do
  begin
    Cells[C_CONVERSIONS_TIFF_COLONNE_FICHIER, RowCount - 1] := AFichier;
    RowCount := RowCount + 1;
  end;
  if (FTHConversions <> Nil) then
  begin
    // Ne démarrer le Thread QUE si il a été créé => conversion des scans compressés.
    if FTHConversions.Suspended then
       FTHConversions.Start;
  end;
end;

procedure TfrmConversionTIFF.btnAnnulerClick(Sender: TObject);
begin
  if Assigned(FTHConversions) then
    with FTHConversions do
    begin
      if MessageDlg('Annuler la conversion des documents scannées vers le format TIFF ?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
        Terminate;
    end;
end;

procedure TfrmConversionTIFF.FormCreate(Sender: TObject);
begin
  ChargerBitmap('ETAT_VRAI', 'PNG', FEtatGrille[True]);
  ChargerBitmap('ETAT_FAUX', 'PNG', FEtatGrille[False]);
end;

procedure TfrmConversionTIFF.FormDestroy(Sender: TObject);
begin
  if Assigned(FEtatGrille[True]) then FreeAndNil(FEtatGrille[True]);
  if Assigned(FEtatGrille[False]) then FreeAndNil(FEtatGrille[False]);

  FfrmConversionTIFF := nil;
end;

procedure TfrmConversionTIFF.grdConversionsDocumentsSurDessinerCellule(
  Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
begin
  with grdConversionsDocuments do
    if (ARow > C_LIGNE_TITRE) and (ACol = C_CONVERSIONS_TIFF_COLONNE_RESULTAT) and (Cells[ACol, ARow] <> '') then
    begin
      Canvas.Brush.Color := clWindow;
      Canvas.FillRect(Rect);
      Canvas.Draw(Rect.Left, Rect.Top, FEtatGrille[Cells[ACol, ARow] = '0']);
    end;
end;

procedure TfrmConversionTIFF.Initialiser(ACheminGS : string);
var
  r : TRegistry;
begin
  FCheminGS := ACheminGS;

  // Inscription des clés de registre pour GS
  r := TRegistry.Create;
  with r do
  begin
    RootKey := HKEY_LOCAL_MACHINE;
    if OpenKey('SOFTWARE\GPL Ghostscript\9.02', True) then
    begin
      WriteString('GS_DLL', FCheminGS + '\gsdll32.dll');
      WriteString('GS_LIB', FCheminGS + ';' + FCheminGS + '\gs');
    end;
    Free;
  end;

  RelancerConversions; 
  grdConversionsDocuments.Cols[C_CONVERSIONS_TIFF_COLONNE_RESULTAT].Clear;
end;

procedure TfrmConversionTIFF.RelancerConversions;
var
  sp : TGFL_SAVE_PARAMS;
begin
  if not Assigned(FTHConversions) then
  begin
    gflEnableLZW(GFL_TRUE);
    gflGetDefaultSaveParams(sp);

    sp.FormatIndex := gflGetFormatIndexByName('tiff');
    sp.Compression := GFL_LZW;
    sp.Flags := sp.Flags or GFL_SAVE_REPLACE_EXTENSION;

    FTHConversions := TThreadConversionTIFF.Create(sp, grdConversionsDocuments, FCheminGS, upd);
    FTHConversions.FreeOnTerminate := True;
    FTHConversions.OnTerminate := ThreadConversionsTIFFSurFinConversions;
  end;
end;


procedure TfrmConversionTIFF.ThreadConversionsTIFFSurFinConversions(
  Sender: TObject);
begin
  FTHConversions := nil;
end;

end.
