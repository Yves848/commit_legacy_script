unit mdlInfosoftLABFOUR;

interface

uses
  mdlLectureFichierBinaire, mdlInfosoftLectureFichier;

type
  TLABFOUR = class(TDonneesFormatees)
  private
    FId: string;
    FFlagG : integer;
    FRaisonSociale : string;
    FRue : string;
    FCodePostal : string;
    FVille : string;
    FTelephone : string;
    FFax : string;
    FCodeClient : string;
    FId171 : string;
    FNumeroAppel : string;
    FNom_Contact : string;
    FRue_Contact : string;
    FCodePostal_Contact : string;
    FVille_Contact: string;
    FTelephone_Contact : string;
    FFax_Contact : string;
    FPortable_Contact : string;
    Fpharmaml_ref_id: string;
    Fpharmaml_url_1: string;
    Fpharmaml_url_2: string;
    Fpharmaml_id_officine: string;
    Fpharmaml_id_magasin: string;
    Fpharmaml_cle: string;
    FEmail : string;
    FSupprime : boolean ;
  published
    public
      constructor Create(AFichier : TFichierBinaire); override;
      procedure Remplit(var ABuffer); override;
    published
      property Id : string read Fid;
      property FlagG : integer read FFlagG;
      property RaisonSociale : string read FRaisonSociale;
      property Rue : string read FRue;
      property CodePostal : string read FCodePostal;
      property Ville : string read FVille;
      property Telephone : string read FTelephone;
      property Fax : string read Ffax;
      property CodeClient : string read FCodeClient;
      property Id171 : string read FId171;
      property NumeroAppel : string read FNumeroAppel;
      property Nom_Contact : string read FNom_Contact;
      property Rue_Contact : string read FRue_Contact;
      property Ville_Contact : string read FVille_Contact;
      property Telephone_Contact : string read FTelephone_Contact;
      property Fax_Contact : string read FFax_Contact;
      property Portable_Contact : string read FPortable_Contact;
      property pharmaml_ref_id: string read  Fpharmaml_ref_id;
      property pharmaml_url_1: string read  Fpharmaml_url_1;
      property pharmaml_url_2: string read  Fpharmaml_url_2;
      property pharmaml_id_officine: string read  Fpharmaml_id_officine;
      property pharmaml_id_magasin: string read  Fpharmaml_id_magasin;
      property pharmaml_cle: string read Fpharmaml_cle;
      property email: string read Femail;
      property supprime: boolean read Fsupprime;
  end;

implementation

type
  TrecLABFOUR_PharmaML = record
    pharmaml_id_officine : array[0..15] of Ansichar;
    pharmaml_cle  :array[0..3] of Ansichar;
    pharmaml_id_magasin  :array[0..19] of Ansichar;
    pharmaml_ref_id : array[0..1] of Ansichar;
    pharmaml_url_1 : array[0..49] of Ansichar;
    pharmaml_url_2 : array[0..49] of Ansichar;
  end;

  TrecLABFOUR_Contact = record
    nom : array[0..27] of Ansichar;
    rue : array[0..27] of Ansichar;
    code_postal : array[0..4] of Ansichar;
    nom_ville : array[0..22] of Ansichar;
    telephone : array[0..14] of Ansichar;
    fax : array[0..14] of Ansichar;
    portable : array[0..14] of Ansichar;
  end;

  TrecLABFOUR = record
    id : array[0..3] of Ansichar;
    raison_sociale : array[0..27] of Ansichar;
    rue : array[0..27] of Ansichar;
    code_postal : array[0..4] of Ansichar;
    nom_ville : array[0..22] of Ansichar;
    telephone : array[0..14] of Ansichar;
    fax : array[0..14] of Ansichar;
    flags : byte;
    filler_1 : array[0..4] of Ansichar;
    contact : TrecLABFOUR_Contact;
    filler_2 : Ansichar;
    code_client : array[0..9] of Ansichar;
    filler_3 : array[0..53] of Ansichar;
    numero_appel : array[0..14] of Ansichar;
    filler_4 : Ansichar;
    idf_171 : array[0..7] of Ansichar;
    filler_5 : array[0..5] of Ansichar;
    pharmaml : TrecLABFOUR_PharmaML;
    filler_6 : array[0..16] of Ansichar;
    email : array[0..49] of Ansichar;
    filler_7 : array[0..462] of Ansichar;
    flag_grossiste : byte;
    flag_supprime : byte;
  end;



constructor TLABFOUR.Create(AFichier: TFichierBinaire);
begin
  inherited;

  FTailleBloc := 1024;
end;

procedure TLABFOUR.Remplit(var ABuffer);
begin
  inherited;

  with TFichierInfosoft(Fichier), TrecLABFOUR(ABuffer) do
  begin
    FID := id;
    FFlagG := flag_grossiste ;
    FRaisonSociale := raison_sociale;
    Frue := rue ;
    FCodePostal := code_postal;
    FVille := nom_ville;
    FTelephone := telephone;
    FFax := fax;
    with TrecLABFOUR_Contact(ABuffer) do
    begin
      FNom_Contact := contact.nom;
      FRue_Contact := contact.rue;
      FCodePostal_Contact := contact.code_postal;
      FVille_Contact := contact.nom_ville;
      FTelephone_Contact := contact.telephone;
      FFax_Contact := contact.fax;
      FPortable_Contact := contact.portable;
    end;
    with TrecLABFOUR_PharmaML(ABuffer) do
    begin
      Fpharmaml_ref_id := pharmaml.pharmaml_ref_id;
      Fpharmaml_url_1 := pharmaml.pharmaml_url_1;
      Fpharmaml_url_2:= pharmaml.pharmaml_url_2;
      Fpharmaml_id_officine := pharmaml.pharmaml_id_officine;
      Fpharmaml_id_magasin := pharmaml.pharmaml_id_magasin;
      Fpharmaml_cle := pharmaml.pharmaml_cle;
    end;
    FEmail := email;
    Fnumeroappel := numero_appel;
    FCodeClient := code_client;
    FId171 := idf_171;
    FSupprime := flag_supprime =1 ;
  end;
end;


end.
