unit mdlInfosoftMESSAGES;

interface

uses mdlLectureFichierBinaire, mdlInfosoftLectureFichier, SysUtils, Windows, JclUnicode;

type
   TMESSAGES = class(TDonneesFormatees)
  private
    FCodeCip: string;
    FCommentaire : string;
  published
   public
     constructor Create(AFichier : TFichierBinaire); override;
     procedure Remplit(var ABuffer); override;
   published
      property CodeCip : string read FCodeCip;
      property Commentaire : string read FCommentaire;
   end;

implementation

type
  TrecMESSAGES = record
    code_cip : TCodeCip;
    numero : AnsiChar;
    flag1 : byte;
    flag2 : byte;
    longueur : TWordInfosoft;
    commentaire :  array[0..191] of AnsiChar;
  end;
{ TCREDITS }

constructor TMESSAGES.Create(AFichier: TFichierBinaire);
begin
  inherited;

  FTailleBloc := 204;
end;

procedure TMESSAGES.Remplit(var ABuffer);
var longueur_chaine : integer;
    commoem : UnicodeString;


begin
  inherited;

  with TFichierInfosoft(Fichier), TrecMESSAGES(ABuffer) do
  begin
    // si le premier demi octet est F ( de F0 a FF ) alors c'est un codecip13
    if ( ord(code_cip[0]) >= 240 )  then
      FCodeCip := RenvoyerCodeCIP13(code_cip)
    else
      FCodeCip := code_cip;

   longueur_chaine := RenvoyerSInt(longueur);
   commoem  :=copy(commentaire ,1, longueur_chaine);
   FCommentaire := StringToWideStringEx(commoem, 850);


  end;


end;

end.
