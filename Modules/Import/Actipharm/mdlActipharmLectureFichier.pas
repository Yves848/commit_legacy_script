unit mdlActipharmLectureFichier;

interface

uses
  SysUtils, Classes, IniFiles, mdlLectureFichierBinaire, mdlLectureFichierPrologue,
  JclStrings, mdlTypes;

type
  TActipharmDate = array[0..7] of ansichar;
  TActipharmDateTime = record
    date : TActipharmDate;
    heure : array[0..3] of ansichar;
  end;

  TFichierActipharm = class(TFichierPrologue)
  protected
    function RenvoyerDate(ADate : TActipharmDate) : TDateTime; reintroduce;
    function RenvoyerClasseDonnees : TClasseDonneesFormatees; override;
  end;

  TP00SOC = class(TDonneesFormatees)
  private
    FID: Single;
    FTauxTVA: TPIList<Double>;
  public
    constructor Create(AFichier : TFichierBinaire); override;
    destructor Destroy; override;
    procedure Remplit(var ABuffer); override;
  published
    property ID : Single read FID;
    property TauxTVA : TPIList<Double> read FTauxTVA;
  end;

  TP01CONT = class(TDonneesFormatees)
  private
    FID: Single;
    FAdresseMail: string;
    FAdresse2: string;
    FPortable: string;
    FAdresse1: string;
    FAdresse3: string;
    FCodePostal: string;
    FFax: string;
    FNom: string;
    FTelephone: string;
    FNomVille: string;
    FTypeContact: string;
  public
    constructor Create(AFichier : TFichierBinaire); override;
    procedure Remplit(var ABuffer); override;
  published
    property ID : Single read FID;
    property TypeContact : string read FTypeContact;
    property Nom : string read FNom;
    property Telephone : string read FTelephone;
    property Fax : string read FFax;
    property Portable : string read FPortable;
    property AdresseMail : string read FAdresseMail;
    property Adresse1 : string read FAdresse1;
    property Adresse2 : string read FAdresse2;
    property Adresse3 : string read FAdresse3;
    property CodePostal : string read FCodePostal;
    property NomVille : string read FNomVille;
  end;

  TP01MEDE = class(TDonneesFormatees)
  private
    FMines: AnsiChar;
    FSalarie: AnsiChar;
    FSNCF: AnsiChar;
    FHospitalier: AnsiChar;
    FID: Single;
    FNumeroFiness: string;
    FSpecialite: string;
    FRPPS : string;
    FNomPrenom : string;
  public
    constructor Create(AFichier : TFichierBinaire); override;
    procedure Remplit(var ABuffer); override;
  published
    property ID : Single read FID;
    property NumeroFiness : string read FNumeroFiness;
    property Specialite : string read FSpecialite;
    property Hospitalier : AnsiChar read FHospitalier;
    property Salarie : AnsiChar read FSalarie;
    property SNCF : AnsiChar read FSNCF;
    property Mines : AnsiChar read FMines;
    property RPPS : string read FRPPS;
    property NomPrenom : string read FNomPrenom;
  end;

  TP01CNTR = class(TDonneesFormatees)
  private
    FModeGestion: AnsiChar;
    FID: Single;
    FFormuleGenerale: Single;
    FIDAMC: Single;
    FLibelle: string;
    FCodePreFectoral: string;
    FDateModification: TDateTime;
    FFormules: TPIList<Double>;
    FP01FORM : TFichierActipharm;
    FTaux: TPIList<Double>;
  public
    property Taux : TPIList<Double> read FTaux;
    constructor Create(AFichier : TFichierBinaire); override;
    destructor Destroy; override;
    procedure Remplit(var ABuffer); override;
  published
    property ID : Single read FID;
    property IDAmc : Single read FIDAMC;
    property CodePrefectoral : string read FCodePreFectoral;
    property DateModification : TDateTime read FDateModification;
    property FormuleGenerale : Single read FFormuleGenerale;
    property ModeGestion : AnsiChar read FModeGestion;
    property Formules : TPIList<Double> read FFormules;
    property Libelle : string read FLibelle;
  end;

  TP01FORM = class(TDonneesFormatees)
  private
    FTarifConvActive: AnsiChar;
    FMntRegimeObligActive: AnsiChar;
    FForfaitActive: AnsiChar;
    FSTS: AnsiChar;
    FTarifResponActive: AnsiChar;
    FPlafondActive: AnsiChar;
    FPlafondMensuelSSActive: AnsiChar;
    FTicketModActive: AnsiChar;
    FPlafondMensuelSS: Single;
    FForfait: Single;
    FTarifConv: Single;
    FDepenseReelle: Single;
    FTicketMod: Single;
    FMntRegimeOblig: Single;
    FPlafond: Single;
    FTarifRepon: Single;
    FID: Single;
    FCodeFormule: string;
    FFormule: string;
    FLibelle: string;
    FDepenseReelleActive: AnsiChar;
  public
    constructor Create(AFichier : TFichierBinaire); override;
    procedure Remplit(var ABuffer); override;
  published
    property ID : Single read FID;
    property STS : AnsiChar read FSTS;
    property CodeFormule : string read FCodeFormule;
    property Libelle : string read FLibelle;
    property Plafond : Single read FPlafond;
    property PlafondActive : AnsiChar read FPlafondActive;
    property DepenseReelle : Single read FDepenseReelle;
    property DepenseReelleActive : AnsiChar read FDepenseReelleActive;
    property TarifRespon : Single read FTarifRepon;
    property TarifResponActive : AnsiChar read FTarifResponActive;
    property MntRegimeOblig : Single read FMntRegimeOblig;
    property MntRegimeObligActive : AnsiChar read FMntRegimeObligActive;
    property PlafondMensuelSS : Single read FPlafondMensuelSS;
    property PlafondMensuelSSActive : AnsiChar read FPlafondMensuelSSActive;
    property TicketMod : Single read FTicketMod;
    property TicketModActive : AnsiChar read FTicketModActive;
    property Forfait : Single read FForfait;
    property ForfaitActive : AnsiChar read FForfaitActive;
    property TarifConv : Single read FTarifConv;
    property TarifConvActive : AnsiChar read FTarifConvActive;
    property Formule : string read FFormule;
  end;

  TP01OAMO = class(TDonneesFormatees)
  private
    FBordereauRSS: AnsiChar;
    FSesamVitale: AnsiChar;
    FBanquePharmacie: Single;
    FID: Single;
    FOrgDestinataire: string;
    FCentreInformatique: string;
    FOrdreClassementBord: AnsiChar;
    FIDNatAMO: string;
  public
    constructor Create(AFichier : TFichierBinaire); override;
    procedure Remplit(var ABuffer); override;
  published
    property ID : Single read FID;
    property IDNatAMO : string read FIDNatAMO;
    property OrgDestinataire : string read FOrgDestinataire;
    property CentreInformatique : string read FCentreInformatique;
    property SesamVitale : AnsiChar read FSesamVitale;
    property BordereauRSS : AnsiChar read FBordereauRSS;
    property OrdreClassementBord : AnsiChar read FOrdreClassementBord;
    property BanquePharmacie : Single read FBanquePharmacie;
  end;

  TP01OAMC = class(TDonneesFormatees)
  private
    FSigle: string;
    FID: Single;
    FBanquePharmacie: Single;
    FCodePrefectoral: string;
    FCode: string;
    FTypeAMC: Integer;
  public
    constructor Create(AFichier : TFichierBinaire); override;
    procedure Remplit(var ABuffer); override;
  published
    property id : Single read FID;
    property Code : string read FCode;
    property CodePrefectoral : string read FCodePrefectoral;
    property BanquePharmacie : Single read FBanquePharmacie;
    property TypeAMC : Integer read FTypeAMC;
    property Sigle : string read FSigle;
  end;

  TP01ASSU = class(TDonneesFormatees)
  private
    FIDCentreAMO: Single;
    FID: Single;
    FIDAMO: Single;
    FCodeGestion: string;
    FNumeroInsee: string;
    FIDNatAMO: string;
  public
    constructor Create(AFichier : TFichierBinaire); override;
    procedure Remplit(var ABuffer); override;
  published
    property ID : Single read FID;
    property NumeroInsee : string read FNumeroInsee;
    property IDNatAMO : string read FIDNatAMO;
    property CodeGestion : string read FCodeGestion;
    property IDAMO : Single read FIDAMO;
    property IDCentreAMO : Single read FIDCentreAMO;
  end;

  TP01AYDR = class(TDonneesFormatees)
  private
    FSexe: AnsiChar;
    FRangGemellaire: AnsiChar;
    FID: Single;
    FIDAssure: Single;
    FNom: string;
    FNomJeuneFille: string;
    FIndTraitementMutuelle: string;
    FPrenom: string;
    FAdresse5: string;
    FAdresse4: string;
    FRang: string;
    FAdresse2: string;
    FAdresse3: string;
    FQualite: string;
    FAdresse1: string;
    FNumeroInseeBenef: string;
    FNumeroInsee: string;
    FDateNaissance: string;
    FNumeroAdherentMutuelle: string;
    FDebutDroitAMO: TDateTime;
    FFinDroitAMO: TDateTime;
    FCodesCouverturesAMO: TPIList<string>;
    FFinsDroitsAMO: TPIList<TDateTime>;
    FDebutsDroitsAMO: TPIList<TDateTime>;
    FIDCouvAMCFichier: Single;
    FIDAMCCarte: Single;
    FIDAMCFichier: Single;
    FIDCouvAMCCarte: Single;
    FIDNatAMCFichier: string;
    FIDNatAMCCarte: string;
    FDebutDroitAMCFichier: TDateTime;
    FDebutDroitAMCCarte: TDateTime;
    FFinDroitAMCFichier: TDateTime;
    FFinDroitAMCCarte: TDateTime;
    FDerniereVisite: TDateTime;
  public
    constructor Create(AFichier : TFichierBinaire); override;
    destructor Destroy; override;
    procedure Remplit(var ABuffer); override;
  published
    property ID : Single read FID;
    property IDAssure : Single read FIDAssure;
    property Rang : string read FRang;
    property Nom : string read FNom;
    property NomJeuneFille : string read FNomJeuneFille;
    property Prenom : string read FPrenom;
    property Adresse1 : string read FAdresse1;
    property Adresse2 : string read FAdresse2;
    property Adresse3 : string read FAdresse3;
    property Adresse4 : string read FAdresse4;
    property Adresse5 : string read FAdresse5;
    property NumeroInseeBenef : string read FNumeroInseeBenef;
    property DateNaissance : string read FDateNaissance;
    property RangGemellaire : AnsiChar read FRangGemellaire;
    property Qualite : string read FQualite;
    property DebutDroitAMO : TDateTime read FDebutDroitAMO;
    property FinDroitAMO : TDateTime read FFinDroitAMO;
    property CodesCouverturesAMO : TPIList<string> read FCodesCouverturesAMO;
    property DebutsDroitsAMO : TPIList<TDateTime> read FDebutsDroitsAMO;
    property FinsDroitsAMO : TPIList<TDateTime> read FFinsDroitsAMO;
    property IDNatAMCCarte : string read FIDNatAMCCarte;
    property IDNatAMCFichier : string read FIDNatAMCFichier;
    property DebutDroitAMCCarte : TDateTime read FDebutDroitAMCCarte;
    property FinDroitAMCCarte : TDateTime read FFinDroitAMCCarte;
    property DebutDroitAMCFichier : TDateTime read FDebutDroitAMCFichier;
    property FinDroitAMCFichier : TDateTime read FFinDroitAMCFichier;
    property Sexe : AnsiChar read FSexe;
    property IDAMCCarte : Single read FIDAMCCarte;
    property IDAMCFichier : Single read FIDAMCFichier;
    property NumeroAdherentMutuelle : string read FNumeroAdherentMutuelle;
    property IndTraitementMutuelle : string read FIndTraitementMutuelle;
    property NumeroInsee : string read FNumeroInsee;
    property IDCouvAMCCarte : Single read FIDCouvAMCCarte;
    property IDCouvAMCFichier : Single read FIDCouvAMCFichier;
    property DerniereVisite : TDateTime read FDerniereVisite;
  end;

  TP01TIER = class(TDonneesFormatees)
  private
    FTypeTier: Integer;
    FID: Single;
    FPays: Single;
    FModeReglement: Single;
    FFidelisation: Single;
    FCompteAuxiliaire: Single;
    FCompteGeneral: Single;
    FCivilite: string;
    FFax: string;
    FRue2: string;
    FRue1: string;
    FRue3: string;
    FNomVille: string;
    FInterlocurteur: string;
    FCodePostal: string;
    FTelephone: string;
    FPrenom: string;
    FAdresseMail: string;
    FNumero: string;
    FNom: string;
    FDateCreation: TDateTime;
    FDateModification: TDateTime;
    FPortable: string;
  public
    constructor Create(AFichier : TFichierBinaire); override;
    procedure Remplit(var ABuffer); override;
  published
    property ID : Single read FID;
    property Numero : string read FNumero;
    property TypeTier : Integer read FTypeTier;
    property Nom : string read FNom;
    property Rue1 : string read FRue1;
    property Rue2 : string read FRue2;
    property Rue3 : string read FRue3;
    property CodePostal : string read FCodePostal;
    property NomVille : string read FNomVille;
    property Pays : Single read FPays;
    property Civilite : string read FCivilite;
    property Telephone : string read FTelephone;
    property Fax : string read FFax;
    property AdresseMail : string read FAdresseMail;
    property Portable : string read FPortable;
    property Interlocuteur : string read FInterlocurteur;
    property DateCreation : TDateTime read FDateCreation;
    property DateModification : TDateTime read FDateModification;
    property Fidelisation : Single read FFidelisation;
    property CompteGeneral : Single read FCompteGeneral;
    property CompteAuxiliaire : Single read FCompteAuxiliaire;
    property ModeReglement : Single read FModeReglement;
    property Prenom : string read FPrenom;
  end;

  TP01FOUR = class(TDonneesFormatees)
  private
    FRepartiteur: Byte;
    FFluxTest: AnsiChar;
    FID: Single;
    FURL2: string;
    FNumeroClient: string;
    FRepartiteurNature: string;
    FOfficineIdentifiant: string;
    FURL1: string;
    FCle: string;
    FDevise: string;
    FEncoding: string;
    FPharmaML: string;
    FLogin: string;
    FRepartiteurIdentifiant: string;
    FOfficineNature: string;
    FMotDePasse: string;
    FSchemaEnveloppe: string;
    FVersionXML: string;
    FIDOfficine: string;
    FRepartiteurCode: string;
    FOfficineCode: string;
    FSchemaMessage: string;
  public
    constructor Create(AFichier : TFichierBinaire); override;
    procedure Remplit(var ABuffer); override;
  published
    property ID : Single read FID;
    property NumeroClient : string read FNumeroClient;
    property Repartiteur : Byte read FRepartiteur;
    property URL1 : string read FURL1;
    property URL2 : string read FURL2;
    property IDOfficine : string read FIDOfficine;
    property Cle : string read FCle;
    property RepartiteurNature : string read FRepartiteurNature;
    property RepartiteurIdentifiant : string read FRepartiteurIdentifiant;
    property RepartiteurCode : string read FRepartiteurCode;
    property OfficineNature : string read FOfficineNature;
    property OfficineIdentifiant : string read FOfficineIdentifiant;
    property OfficineCode : string read FOfficineCode;
    property PharmaML : string read FPharmaML;
    property FluxTest : AnsiChar read FFluxTest;
    property Devise : string read FDevise;
    property SchemaEnveloppe : string read FSchemaEnveloppe;
    property SchemaMessage : string read FSchemaMessage;
    property VersionXML : string read FVersionXML;
    property Encoding : string read FEncoding;
    property Login : string read FLogin;
    property MotDePasse : string read FMotDePasse;
  end;

  TP01LPAR = class(TDonneesFormatees)
  private
    FID: Single;
  public
    constructor Create(AFichier : TFichierBinaire); override;
    procedure Remplit(var ABuffer); override;
  published
    property ID : Single read FID;
  end;

  TP01EMPL = class(TDonneesFormatees)
  private
    FFrigo: AnsiChar;
    FID: Single;
    FTypeMagasin: AnsiChar;
    FRayon: string;
    FNumero: string;
    FLibelle: string;
    FArmoire: string;
  public
    constructor Create(AFichier : TFichierBinaire); override;
    procedure Remplit(var ABuffer); override;
  published
    property ID : Single read FID;
    property TypeMagasin : AnsiChar read FTypeMagasin;
    property Armoire : string read FArmoire;
    property Rayon : string read FRayon;
    property Numero : string read FNumero;
    property Frigo : AnsiChar read FFrigo;
    property Libelle : string read FLibelle;
  end;

  TP01FAM = class(TDonneesFormatees)
  private
    FID: Single;
    FLibelle: string;
    FCode: string;
    FEtat: Byte;
    FTable: Integer;
  public
    constructor Create(AFichier : TFichierBinaire); override;
    procedure Remplit(var ABuffer); override;
  published
    property ID : Single read FID;
    property Libelle : string read FLibelle;
    property Etat : Byte read FEtat;
    property Table : Integer read FTable;
    property Code : string read FCode;
  end;


  TP01ARTI = class(TDonneesFormatees)
  private
    FDureeStockage: Double;
    FFourchetteTemperature: Integer;
    FID: Single;
    FIDFabricant: Single;
    FIDEmplacement: Single;
    FForme: Single;
    FClasseATC: Single;
    FConditionnement: Single;
    FCodeCIP13: string;
    FDataSemp: Single;
    FPrestation: string;
    FCodeCIP: string;
    FLibelle: string;
    FCodeEAN13: string;
    FDateCreation: TDateTime;
    FTVA: Single;
    FListe: AnsiChar;
    FMethodeReappro: AnsiChar;
    FFamille: Single;
    FGamme: Single;
    FBaseRembousement: Single;
    FStockMini: Single;
    FDisponible: Single;
    FStockMaxi: Single;
    FDateModification: TDateTime;
    FGereStock: AnsiChar;
    FCodesDisponible : TStringList;
    FP00SOC: TFichierActipharm;
    FComptegeneral : Single;
  public
    property CodesDisponible : TStringList read FCodesDisponible;
    property P00SOC : TFichierActipharm read FP00SOC;
    constructor Create(AFichier : TFichierBinaire); override;
    destructor Destroy; override;
    procedure Remplit(var ABuffer); override;
  published
    property ID : Single read FID;
    property CodeCIP : string read FCodeCIP;
    property Libelle : string read FLibelle;
    property CodeCIP13 : string read FCodeCIP13;
    property Forme : Single read FForme;
    property DataSemp : Single read FDataSemp;
    property DateCreation : TDateTime read FDateCreation;
    property IDFabricant : Single read FIDFabricant;
    property DureeStockage : Double read FDureeStockage;
    property Conditionnement : Single read FConditionnement;
    property FourchetteTemperature : Integer read FFourchetteTemperature;
    property ClasseATC : Single read FClasseATC;
    property Prestation : string read FPrestation;
    property IDEmplacement : Single read FIDEmplacement;
    property CodeEAN13 : string read FCodeEAN13;
    property Gamme : Single read FGamme;
    property DateModification : TDateTime read FDateModification;
    property Disponible : Single read FDisponible;
    property BaseRemboursement : Single read FBaseRembousement;
    property MethodeReappro : AnsiChar read FMethodeReappro;
    property StockMini : Single read FStockMini;
    property StockMaxi : Single read FStockMaxi;
    property TVA : Single read FTVA;
    property Liste : AnsiChar read FListe;
    property Famille : Single read FFamille;
    property GereStock : AnsiChar read FGereStock;
    property CompteGeneral : Single read FCompteGeneral;
  end;

  TM01DLOT = class(TDonneesFormatees)
  private
    FEnCommande: AnsiChar;
    FDLotPivot: AnsiChar;
    FDLotType: AnsiChar;
    FDLotSens: AnsiChar;
    FSolde: AnsiChar;
    FEmplacementType: AnsiChar;
    FPerdue: AnsiChar;
    FCalendaire: AnsiChar;
    FVignette: AnsiChar;
    FPromotionAffecte: AnsiChar;
    FPromotion: AnsiChar;
    FIDEntete: Single;
    FIDEmplacement: Single;
    FIDUtilisateur: Single;
    FIDDest: Single;
    FIDEnteteOrig: Single;
    FIDLigneOrig: Single;
    FIDLigneDest: Single;
    FIDOrig: Single;
    FQuantite: Single;
    FID: Single;
    FReste: Single;
    FIDArticle: Single;
    FIDEnteteDest: Single;
    FIDTierCommande: Single;
    FIDLigne: Single;
    FNumero: string;
    FDatePeremption: TDateTime;
    FDateCommande: TDateTime;
    FDLotDate: TDateTime;
    FDateFabrication: TDateTime;
  public
    constructor Create(AFichier : TFichierBinaire); override;
    procedure Remplit(var ABuffer); override;
  published
    property IDEntete : Single read FIDEntete;
    property IDLigne : Single read FIDLigne;
    property ID : Single read FID;
    property DLotType : AnsiChar read FDLotType;
    property DLotSens : AnsiChar read FDLotSens;
    property DLotPivot : AnsiChar read FDLotPivot;
    property IDEnteteOrig : Single read FIDEnteteOrig;
    property IDLigneOrig : Single read FIDLigneOrig;
    property IDOrig : Single read FIDOrig;
    property Solde : AnsiChar read FSolde;
    property IDArticle : Single read FIDArticle;
    property Quantite : Single read FQuantite;
    property Numero : string read FNumero;
    property DLotDate : TDateTime read FDLotDate;
    property Reste : Single read FReste;
    property IDEmplacement : Single read FIDEmplacement;
    property IDEnteteDest : Single read FIDEnteteDest;
    property IDLigneDest : Single read FIDLigneDest;
    property IDDest : Single read FIDDest;
    property IDUtilisateur : Single read FIDUtilisateur;
    property DatePeremption : TDateTime read FDatePeremption;
    property DateFabrication : TDateTime read FDateFabrication;
    property PromotionAffecte : AnsiChar read FPromotionAffecte;
    property Calendaire : AnsiChar read FCalendaire;
    property DateCommande : TDateTime read FDateCommande;
    property Perdue : AnsiChar read FPerdue;
    property Promotion : AnsiChar read FPromotion;
    property Vignette : AnsiChar read FVignette;
    property IDTierCommande : Single read FIDTierCommande;
    property EnCommande : AnsiChar read FEnCommande;
    property EmplacementType : AnsiChar read FEmplacementType;
  end;

  TP01TARI = class(TDonneesFormatees)
  private
    FRegime: Byte;
    FPromotion: AnsiChar;
    FTypeTarif: AnsiChar;
    FCatalogue: AnsiChar;
    FSansTier: AnsiChar;
    FPrixTTC: Single;
    FNetTTC: Single;
    FID: Single;
    FRemise1: Single;
    FIDModifieur: Single;
    FIDTier: Single;
    FPrixNet: Single;
    FIDFamille: Single;
    FPrix: Single;
    FTVA: Single;
    FIDCreateur: Single;
    FIDArticle: Single;
    FRemise2: Single;
    FFinTarif: TDateTime;
    FDateCreation: TDateTime;
    FDebutTarif: TDateTime;
    FDateModification: TDateTime;
    FRemise3: Single;
    FIDTVA: Byte;
  public
    constructor Create(AFichier : TFichierBinaire); override;
    procedure Remplit(var ABuffer); override;
  published
    property ID : Single read FID;
    property TypeTarif : AnsiChar read FTypeTarif;
    property SansTier : AnsiChar read FSansTier;
    property Catalogue : AnsiChar read FCatalogue;
    property Promotion : AnsiChar read FPromotion;
    property IDFamille : Single read FIDFamille;
    property IDArticle : Single read FIDArticle;
    property IDTier : Single read FIDTier;
    property DebutTarif : TDateTime read FDebutTarif;
    property FinTarif : TDateTime read FFinTarif;
    property Prix : Single read FPrix;
    property Remise1 : Single read FRemise1;
    property Remise2 : Single read FRemise2;
    property Remise3 : Single read FRemise3;
    property PrixNet : Single read FPrixNet;
    property IDTVA : Byte read FIDTVA;
    property TVA : Single read FTVA;
    property NetTTC : Single read FNetTTC;
    property DateModification : TDateTime read FDateModification;
    property DateCreation: TDateTime read FDateCreation;
    property IDCreateur : Single read FIDCreateur;
    property IDModifieur : Single read FIDModifieur;
    property Regime : Byte read FRegime;
    property PrixTTC : Single read FPrixTTC;
  end;

  TP01CUM = class(TDonneesFormatees)
  private
    FTable: Integer;
    FNbBoitesVendues: Single;
    FNBVentes: Single;
    FNBAchats: Single;
    FIDArticle: Single;
    FNbAchatsAchetees: Single;
    FDate: TDateTime;
  public
    constructor Create(AFichier : TFichierBinaire); override;
    procedure Remplit(var ABuffer); override;
  published
    property Table : Integer read FTable;
    property IDArticle : Single read FIDArticle;
    property Date : TDateTime read FDate;
    property NbVentes : Single read FNBVentes;
    property NbAchats : Single read FNBAchats;
    property NbBoitesVendues : Single read FNbBoitesVendues;
    property NbBoitesAchetees : Single read FNbAchatsAchetees;
  end;

  TFP2PSTOC = class(TDonneesFormatees)
  private
    FDernierPrixAchat: Single;
    FPrixVente: Single;
    FQuantite: SmallInt;
    FCodeCIP: string;
    FZoneGeographique: string;
    FDesignation1: string;
    FPAMP: Single;
    FStockMini: SmallInt;
    FStockMaxi: SmallInt;
    FFournisseurs: TPIList<string>;
  public
    constructor Create(AFichier : TFichierBinaire); override;
    destructor Destroy; override;
    procedure Remplit(var ABuffer); override;
  published
    property CodeCIP : string read FCodeCIP;
    property Designation1 : string read FDesignation1;
    property DernierPrixAchat : Single read FDernierPrixAchat;
    property PrixVente : Single read FPrixVente;
    property Quantite : SmallInt read FQuantite;
    property ZoneGeographique : string read FZoneGeographique;
    property StockMini : SmallInt read FStockMini;
    property StockMaxi : SmallInt read FStockMaxi;
    property PAMP : Single read FPAMP;
    property Fournisseurs : TPIList<string> read FFournisseurs;
  end;

  TFP2EAN13 = class(TDonneesFormatees)
  private
    FCodeEAN13: string;
    FCodeCIP: string;
  public
    constructor Create(AFichier : TFichierBinaire); override;
    procedure Remplit(var ABuffer); override;
  published
    property CodeEAN13 : string read FCodeEAN13;
    property CodeCIP : string read FCodeCIP;
  end;

  TFP2PTIPS = class(TDonneesFormatees)
  private
    FCodeCIP: string;
    FCodesTIPS: TPIList<string>;
  public
    constructor Create(AFichier : TFichierBinaire); override;
    destructor Destroy; override;
    procedure Remplit(var ABuffer); override;
  published
    property CodeCIP : string read FCodeCIP;
    property CodesTIPS : TPIList<string> read FCodesTIPS;
  end;

  TFP2PVETO = class(TDonneesFormatees)
  private
    FCommentaire1: string;
    FCommentaire2: string;
    FCodeCIP: string;
  public
    constructor Create(AFichier : TFichierBinaire); override;
    procedure Remplit(var ABuffer); override;
  published
    property CodeCIP : string read FCodeCIP;
    property Commentaire1 : string read FCommentaire1;
    property Commentaire2 : string read FCommentaire2;
  end;

  TM01ENTE = class(TDonneesFormatees)
  public
    constructor Create(AFichier : TFichierBinaire); override;
    procedure Remplit(var ABuffer); override;
  private
    FModePIE: AnsiChar;
    FIDUtilisateurCreation: Single;
    FTypeVente: AnsiChar;
    FEtat: AnsiChar;
    FTypePIE: AnsiChar;
    FTypeFacture: AnsiChar;
    FNatureASS: AnsiChar;
    FLecture: Integer;
    FIDTier: Single;
    FIDMedecin: Single;
    FIDClient: Single;
    FIDAssure: Single;
    FID: Single;
    FNumeroInsee: string;
    FMontantTTC: Single;
    FDatePrescription: TDateTime;
    FDateExecution: TDateTime;
    FDateCreation: TDateTime;
    FPiece: string;
  published
    property ID : Single read FID;
    property TypeFacture : AnsiChar read FTypeFacture;
    property Etat : AnsiChar read FEtat;
    property TypePIE : AnsiChar read FTypePIE;
    property TypeVente : AnsiChar read FTypeVente;
    property ModePIE : AnsiChar read FModePIE;
    property Lecture : Integer read FLecture;
    property Piece : string read FPiece;
    property NatureASS : AnsiChar read FNatureASS;
    property DateCreation : TDateTime read FDateCreation;
    property IDtilisateurCreation : Single read FIDUtilisateurCreation;
    property IDTier : Single read FIDTier;
    property NumeroInsee : string read FNumeroInsee;
    property MontantTTC : Single read FMontantTTC;
    property IDAssure : Single read FIDAssure;
    property IDMedecin : Single read FIDMedecin;
    property IDClient : Single read FIDClient;
    property DateExecution : TDateTime read FDateExecution;
    property DatePrescription : TDateTime read FDatePrescription;
  end;

  TM01LIGN = class(TDonneesFormatees)
  private
    FPromotion: AnsiChar;
    FGratuit: AnsiChar;
    FPrixNetTTC: Single;
    FTauxTVA: Single;
    FCodeCIPDelivree: string;
    FIDLigne: Single;
    FPrixUnitaireTTC: Single;
    FIDEntete: Single;
    FMontantTVA: Single;
    FTotalHT: Single;
    FIDArticle: Single;
    FPrix: Single;
    FTotalTTC: Single;
    FQuantitePrescrite: Single;
    FQuantite: Single;
    FPrestation: string;
    FLibelle: string;
    FIDTVA: Byte;
  public
    constructor Create(AFichier : TFichierBinaire); override;
    procedure Remplit(var ABuffer); override;
  published
    property IDEntete : Single read FIDEntete;
    property IDLigne : Single read FIDLigne;
    property Libelle : string read FLibelle;
    property IDArticle : Single read FIDArticle;
    property Prix : Single read FPrix;
    property PrixUnitaireTTC : Single read FPrixUnitaireTTC;
    property PrixNetTTC : Single read FPrixNetTTC;
    property IDTVA : Byte read FIDTVA;
    property TauxTVA : Single read FTauxTVA;
    property Promotion : AnsiChar read FPromotion;
    property Gratuit : AnsiChar read FGratuit;
    property Quantite : Single read FQuantite;
    property TotalHT : Single read FTotalHT;
    property MontantTVA : Single read FMontantTVA;
    property TotalTTC : Single read FTotalTTC;
    property Prestation : string read FPrestation;
    property QuantitePrescrite : Single read FQuantitePrescrite;
    property CodeCIPDelivree : string read FCodeCIPDelivree;
  end;

  TFP2SCDFO = class(TDonneesFormatees)
  private
    FPrixAchat: Single;
    FQuantiteCommandee: SmallInt;
    FFournisseur: string;
    FDateReception: string;
    FDateCommande: string;
    FCodeCIP: string;
    FNumeroCommande: string;
  public
    constructor Create(AFichier : TFichierBinaire); override;
    procedure Remplit(var ABuffer); override;
  published
    property Fournisseur : string read FFournisseur;
    property NumeroCommande : string read FNumeroCommande;
    property CodeCIP : string read FCodeCIP;
    property PrixAchat : Single read FPrixAchat;
    property QuantiteCommandee : SmallInt read FQuantiteCommandee;
    property DateCommande : string read FDateCommande;
    property DateReception : string read FDateReception;
  end;

  TFP2PVIGA = class(TDonneesFormatees)
  private
    FSupprime: Boolean;
    FDesignation: string;
    FForme: string;
    FNomPrenom: string;
    FRang: string;
    FCodeCIP: string;
    FNumeroInsee: string;
    FOperateur: string;
    FDateAvance: string;
    FQuantiteAvancee: Integer;
  public
    constructor Create(AFichier : TFichierBinaire); override;
    procedure Remplit(var ABuffer); override;
  published
    property NumeroInsee : string read FNumeroInsee;
    property Rang : string read FRang;
    property DateAvance : string read FDateAvance;
    property CodeCIP : string read FCodeCIP;
    property QuantiteAvancee : Integer read FQuantiteAvancee;
    property Operateur : string read FOperateur;
    property NomPrenom : string read FNomPrenom;
    property Designation : string read FDesignation;
    property Forme : string read FForme;
    property Supprime : Boolean read FSupprime;
  end;



  TP01AYMU = class(TDonneesFormatees)
  private
    FID : single;
    FIDAssure : single;
    FIDBenef : single;
    FIDAMC : single;
    FIDContratAMC : single;
    FFlagCMU :string;
    FNumeroCMU : string;
    Fdate1 : TDateTime;
    Fdate2 : TDateTime;
    FNumeroCMU2 : string;
    FNumeroAdherent : string;
    FDateFinAmc : TDateTime;
    FNumeroAmc : string;
    FModeGestion : string;
    FFlag : string;
  public
    constructor Create(AFichier : TFichierBinaire); override;
    procedure Remplit(var ABuffer); override;
  published
    property ID : Single read FID;
    property IDAssure : Single read FIDAssure;
    property IDBenef : Single read FIDBenef;
    property IDAMC : Single read FIDAMC;
    property IDContratAMC : Single read FIDContratAMC;
    property FlagCMU: string read FFlagCMU;
    property NumeroCMU: string read FNumeroCMU;
    property NumeroCMU2: string read FNumeroCMU2;
    property NumeroAdherent: string read FNumeroAdherent;
    property date1: TDateTime read FDate1;
    property date2: TDateTime read FDate2;
    property DateFinAmc: TDateTime read FDateFinAmc;
    property NumeroAmc: string read FNumeroAmc;
    property ModeGestion: string read FModeGestion;
    property Flag: string read FFlag;
  end;











var
  gFP2UPARA : THashedStringList;

implementation

type
  TrecP00SOC = record
    id : array[0..5] of Byte;
    filler_1 : Byte;
    taux_tva : array[0..9, 0..3] of Byte;
  end;

  TrecP01CONT = record
    id : array[0..5] of Byte;
    filler_1 : array[0..12] of Byte;
    type_contact : array[0..19] of AnsiChar;
    nom : array[0..29] of AnsiChar;
    telephone : array[0..19] of AnsiChar;
    fax : array[0..19] of AnsiChar;
    portable : array[0..19] of AnsiChar;
    adresse_mail : array[0..101] of AnsiChar;
    rue_1 : array[0..29] of AnsiChar;
    rue_2 : array[0..29] of AnsiChar;
    rue_3 : array[0..29] of AnsiChar;
    code_postal : array[0..4] of AnsiChar;
    nom_ville : array[0..29] of AnsiChar;
  end;

  TrecP01MEDE = record
    id : array[0..5] of Byte;
    filler_1 : array[0..6] of Byte;
    numero_finess : array[0..8] of AnsiChar;
    specialite : array[0..1] of AnsiChar;
    hospitalier : AnsiChar;
    salarie : AnsiChar;
    sncf : AnsiChar;
    mines : AnsiChar;
    //filler_2 : array[0..249] of Byte;
    filler_2 : array[0..224] of Byte;
    rpps : array[0..10] of AnsiChar;
    filler_4 : array[0..13] of Byte;
    nom_prenom : array[0..26] of AnsiChar;
    filler_3 : array[0..6] of Byte;
  end;

  TrecP01OAMO = record
    id : array[0..5] of Byte;
    filler_1 : array[0..6] of Byte;
    id_nat_amo : array[0..8] of AnsiChar;
    org_destinataire : array[0..2] of AnsiChar;
    centre_informatique : array[0..2] of AnsiChar;
    sesam_vitale : AnsiChar;
    bordereau_rss : AnsiChar;
    ordre_classement_bord : AnsiChar;
    banque_pharmacie : array[0..5] of Byte;
    filler_2 : array[0..474] of Byte;
  end;

  TrecP01OAMC = record
    id : array[0..5] of Byte;
    flag : Byte;
    filler_1 : array[0..5] of Byte;
    code : array[0..7] of AnsiChar;
    code2 : array[0..1] of AnsiChar;
    code_prefectoral : array[0..7] of AnsiChar;
    filler_2 : array[0..2] of Byte;
    banque_pharmacie : array[0..5] of Byte;
    filler_3 : Byte;
    type_amc : TWordPrologue;
    filler_4 : Byte;
    sigle : array[0..15] of AnsiChar;
    filler_5 : array[0..447] of Byte;
  end;

  TrecP01CNTR = record
    id : array[0..5] of Byte;
    filler_1 : array[0..6] of Byte;
    id_amc : array[0..5] of Byte;
    code_prefectoral : array[0..9] of AnsiChar;
    code_prefectoral2 : array[0..9] of AnsiChar;
    //date_modification : TActipharmDateTime;
    formule_generale : array[0..5] of Byte;
    formules : array[0..49, 0..5] of Byte;
    mode_gestion : AnsiChar;
    filler_2 : array[0..9] of AnsiChar;
    libelle : array[0..19] of AnsiChar;
  end;

  TrecP01FORM = record
    id : array[0..5] of Byte;
    flag : AnsiChar;
    filler_1 : array[0..5] of Byte;
    sts : AnsiChar;
    code_formule : array[0..2] of AnsiChar;
    libelle : array[0..99] of AnsiChar;
    plafond : array[0..11] of Byte;
    plafond_active : AnsiChar;
    depense_reelle : array[0..11] of Byte;
    depense_reelle_active : AnsiChar;
    tarif_respon : array[0..11] of Byte;
    tarif_respon_active : AnsiChar;
    mnt_regime_oblig : array[0..11] of Byte;
    mnt_regime_oblig_active : AnsiChar;
    plafond_mensuel_ss : array[0..11] of Byte;
    plafond_mensuel_ss_active : AnsiChar;
    ticket_mod : array[0..11] of Byte;
    ticket_mod_active : AnsiChar;
    forfait : array[0..11] of Byte;
    forfait_active : AnsiChar;
    tarif_conv : array[0..11] of Byte;
    tarif_conv_active : AnsiChar;
    filler_2 : AnsiChar;
    formule : array[0..199] of AnsiChar;
  end;

  TrecP01ASSU = record
    id : array[0..5] of Byte;
    filler_1 : array[0..75] of Byte;
    numero_insee : array[0..14] of AnsiChar;
    id_nat_amo : array[0..8] of AnsiChar;
    code_gestion : array[0..1] of AnsiChar;
    filler_2 : array[0..54] of Byte;
    id_amo : array[0..5] of Byte;
    id_centre_amo : array[0..5] of Byte;
    filler_3 : array[0..336] of Byte;
  end;

  TrecP01AYDR = record
    id : array[0..5] of Byte;
    filler_1 : array[0..6] of Byte;
    id_assure : array[0..5] of Byte;
    rang : array[0..1] of AnsiChar;
    nom : array[0..26] of AnsiChar;
    nom_jeune_fille : array[0..26] of AnsiChar;
    prenom : array[0..26] of AnsiChar;
    adresse_1 : array[0..31] of AnsiChar;
    adresse_2 : array[0..31] of AnsiChar;
    adresse_3 : array[0..31] of AnsiChar;
    adresse_4 : array[0..31] of AnsiChar;
    adresse_5 : array[0..31] of AnsiChar;
    //filler_1_2 : array[0..26] of Byte;
    numero_insee_benef_old : array[0..14] of AnsiChar;
    filler_2 : array[0..11] of Byte;
    date_naissance : TActipharmDateTime;
    rang_gemellaire : AnsiChar;
    qualite : array[0..1] of AnsiChar;
    filler_4 : array[0..80] of Byte;
    debut_droit_amo : TActipharmDateTime;
    fin_droit_amo : TActipharmDateTime;
    filler_7 : array[0..71] of Byte;

    droits_amo : array[0..2] of record
      code_couverture : array[0..4] of AnsiChar;
      debut_droit : TActipharmDateTime;
      fin_droit : TActipharmDateTime;
    end;

    filler_71 : array[0..422] of AnsiChar;
    sexe : AnsiChar;
    filler_72 : array[0..262] of AnsiChar;
    id_amc_fichier : array[0..5] of Byte;
    num_adh  : array[0..15] of AnsiChar;
    filler_8 : array[0..74] of AnsiChar;
    date_dv  : TActipharmDate;
    filler_81 : array[0..77] of AnsiChar;

    id_amc_carte : array[0..5] of Byte;
    id_amc_fichier_inc : array[0..5] of Byte;

    numero_insee_benef : array[0..14] of AnsiChar;
    debut_droit_amc : TActipharmDate;
    fin_droit_amc : TActipharmDate;

    filler_9 : array[0..22] of Byte;

    id_nat_amc_carte : array[0..7] of AnsiChar;
    filler_16 : array[0..33] of Byte;
    id_couv_amc_carte : array[0..5] of AnsiChar;
    id_couv_amc_fichier : array[0..5] of AnsiChar;

    //debut_droit_amc_carte : TActipharmDateTime;
    //fin_droit_amc_carte : TActipharmDateTime;

    filler_17 : array[0..245] of Byte;

    filler_09 : array[0..262] of AnsiChar;
    filler_12 : array[0..5] of Byte;
    filler_11 : array[0..7] of AnsiChar;
    numero_adherent_mutuelle : array[0..7] of AnsiChar;
    ind_traitement_mutuelle : array[0..1] of AnsiChar;
    filler_10 : array[0..158] of AnsiChar;
    filler_13: array[0..5] of Byte;
    filler_18 : array[0..5] of Byte;

    numero_insee : array[0..14] of AnsiChar;
    debut_droit_amc_fichier : TActipharmDate;
    fin_droit_amc_fichier : TActipharmDate;
    filler_19 : array[0..56] of Byte;


    id_nat_amc_fichier : array[0..7] of AnsiChar;
    //filler_13 : array[0..33] of Byte;

    filler_15 : array[0..507] of AnsiChar;
  end;

  TrecP01TIER = record
    id : array[0..5] of Byte;
    filler_1 : array[0..6] of Byte;
    numero : array[0..19] of AnsiChar;
    type_tier : TWordPrologue;
    nom : array[0..29] of AnsiChar;
    rue_1 : array[0..29] of AnsiChar;
    rue_2 : array[0..29] of AnsiChar;
    rue_3 : array[0..29] of AnsiChar;
    code_postal : array[0..4] of AnsiChar;
    nom_ville : array[0..29] of AnsiChar;
    pays : array[0..5] of Byte;
    civilite : array[0..19] of AnsiChar;
    telephone : array[0..19] of AnsiChar;
    fax : array[0..19] of AnsiChar;
    adresse_mail : array[0..99] of AnsiChar;
    portable : array[0..19] of AnsiChar;
    interlocuteur : array[0..29] of AnsiChar;
    date_creation : TActipharmDate;
    date_modification : TActipharmDate;
    fidelisation : array[0..5] of Byte;
    compte_general : array[0..5] of Byte;
    compte_auxiliaire : array[0..5] of Byte;
    mode_reglement : array[0..5] of Byte;
    filler_2 : array[0..105] of Byte;
    prenom : array[0..26] of AnsiChar;
    filler_3 : array[0..444] of Byte;
  end;

  TrecP01FOUR = record
    id : array[0..5] of Byte;
    filler_1 : array[0..6] of Byte;
    numero_client : array[0..19] of AnsiChar;
    repartiteur : Byte;
    filler_2 : array[0..200] of AnsiChar;
    url_1 : array[0..63] of AnsiChar;
    url_2 : array[0..63] of AnsiChar;
    id_officine : array[0..15] of AnsiChar;
    cle : array[0..3] of AnsiChar;
    repartiteur_nature : array[0..1] of AnsiChar;
    repartiteur_identifiant : array[0..19] of AnsiChar;
    repartiteur_code : array[0..1] of AnsiChar;
    officine_nature : array[0..1] of AnsiChar;
    officine_identifiant : array[0..19] of AnsiChar;
    officine_code : array[0..1] of AnsiChar;
    pharma_ml : array[0..11] of AnsiChar;
    flux_test : AnsiChar;
    devise : array[0..2] of AnsiChar;
    schema_enveloppe : array[0..49] of AnsiChar;
    schema_message : array[0..49] of AnsiChar;
    version_xml : array[0..7] of AnsiChar;
    encoding : array[0..9] of AnsiChar;
    login : array[0..19] of AnsiChar;
    mot_de_passe : array[0..19] of AnsiChar;
    filler_3 : array[0..324] of AnsiChar;
  end;

  TrecP01LPAR = record
    id : array[0..5] of AnsiChar;
    filler_1 : array[0..249] of AnsiChar;
  end;

  TrecP01EMPL = record
    id : array[0..5] of Byte;
    filler_1 : array[0..6] of Byte;
    type_magasin : AnsiChar;
    armoire : array[0..2] of AnsiChar;
    rayon : array[0..1] of AnsiChar;
    numero : array[0..2] of AnsiChar;
    frigo : AnsiChar;
    libelle : array[0..19] of AnsiChar;
  end;

  TrecP01FAM = record
    id : array[0..5] of AnsiChar;
    filler_1 : array[0..12] of Byte;
    libelle : array[0..126] of AnsiChar;
    etat : Byte;
    table : TWordPrologue;
    filler_2 : array[0..136] of Byte;
    code : array[0..19] of AnsiChar;
  end;

  TrecP01ARTI = record
    id : array[0..5] of AnsiChar;
    filler_1 : array[0..6] of Byte;
    type_produit : AnsiChar;
    id_t00 : array[0..5] of Byte;
    id_unique : array[0..9] of AnsiChar;
    code_cip : array[0..12] of AnsiChar;
    libelle : array[0..44] of AnsiChar;
    code_ean_13 : array[0..12] of AnsiChar;
    emphra : array[0..5] of Byte;
    unite_prise : array[0..5] of Byte;
    unite_boite : array[0..11] of Byte;
    reference_fabricant : array[0..19] of AnsiChar;
    gamme : array[0..5] of AnsiChar;
    cb_vignette : array[0..24] of AnsiChar;
    libelle_long : array[0..126] of AnsiChar;
    libelle_court : array[0..19] of AnsiChar;
    inventorex : array[0..5] of Byte;
    forme : array[0..5] of Byte;
    datasemp : array[0..5] of Byte;
    classe_ims : array[0..5] of Byte;
    abstraite : array[0..1] of Byte;
    date_creation : TActipharmDate;
    date_modification : TActipharmDate;
    filler_4 : array[0..5] of Byte;
    id_fabricant : array[0..5] of Byte;
    lieu_prescription : array[0..5] of Byte;
    disponible : array[0..5] of Byte;
    hauteur_emballage : array[0..11] of Byte;
    largeur_emballage : array[0..11] of Byte;
    poids_emballage : array[0..11] of Byte;
    poids_brut : array[0..11] of Byte;
    img_facing : array[0..7] of AnsiChar;
    duree_stockage : array[0..11] of Byte;
    unite_duree_stockage : array[0..5] of Byte;
    fourchette_temperature : TWordPrologue;
    temperature_mini : TWordPrologue;
    temperature_maxi : TWordPrologue;
    duree_apres_destock : array[0..11] of AnsiChar;
    unite_duree_apres_destock : array[0..5] of Byte;
    poids_net : array[0..11] of Byte;
    volume_net : array[0..11] of Byte;
    classe_interne : TWordPrologue;
    qualification_clinique : TWordPrologue;
    classe_atc : array[0..5] of Byte;
    dosage : array[0..5] of Byte;
    base_remboursement : array[0..11] of Byte;
    regime_ss : TWordPrologue;
    date_amm : TActipharmDate;
    mini_2_delivrance : TWordPrologue;
    maxi_2_delivrance : TWordPrologue;
    prestation : array[0..2] of AnsiChar;
    max_prescription : TWordPrologue;
    classe : AnsiChar;
    sans_stock : AnsiChar;
    gere_stock : AnsiChar;
    jour_couverture : array[0..11] of Byte;
    k_mini : array[0..11] of Byte;
    k_maxi : array[0..11] of Byte;
    quantite_mini : array[0..11] of Byte;
    date_calcul : TActipharmDate;
    stock_mini : array[0..11] of Byte;
    stock_maxi : array[0..11] of Byte;
    saisonnier : AnsiChar;
    debut_saison : array[0..3] of AnsiChar;
    fin_saison : array[0..3] of AnsiChar;
    periode : array[0..1] of AnsiChar;
    methode_reappro : AnsiChar;
    colisage_achat : array[0..11] of Byte;
    colisage_vente : array[0..11] of Byte;
    mini_perso : AnsiChar;
    maxi_perso : AnsiChar;
    division_colisage_achat : AnsiChar;
    tri_subst : AnsiChar;
    id_emplacement : array[0..5] of Byte;
    prix_unitaire : array[0..11] of Byte;
    rembourse : AnsiChar;
    type_p : array[0..1] of Byte;
    compte_general : array[0..5] of Byte;
    tva : Byte;
    liste : AnsiChar;
    famille : array[0..5] of Byte;
    filler_9 : array[0..77] of Byte;
    code_cip_13 : array[0..12] of AnsiChar;
  end;

  TrecM01DLOT = record
    id_entete : array[0..5] of Byte;
    id_ligne : array[0..5] of Byte;
    id : array[0..5] of Byte;
    filler_1 : array[0..18] of Byte;
    dlot_type : AnsiChar;
    dlot_sens : AnsiChar;
    dlot_pivot : AnsiChar;
    id_entete_orig : array[0..5] of Byte;
    id_ligne_orig : array[0..5] of Byte;
    id_orig : array[0..5] of Byte;
    solde : AnsiChar;
    id_article : array[0..5] of Byte;
    quantite : array[0..11] of Byte;
    numero : array[0..29] of AnsiChar;
    dlot_date : TActipharmDateTime;
    reste : array[0..11] of Byte;
    id_emplacement : array[0..5] of Byte;
    id_entete_dest : array[0..5] of Byte;
    id_ligne_dest : array[0..5] of Byte;
    id_dest : array[0..5] of Byte;
    id_utilisateur : array[0..5] of Byte;
    date_peremption : TActipharmDate;
    date_fabrication : TActipharmDate;
    promotion_affecte : AnsiChar;
    calendaire : AnsiChar;
    date_commande : TActipharmDate;
    perdue : AnsiChar;
    promotion : AnsiChar;
    vignette : AnsiChar;
    id_tier_commande : array[0..5] of Byte;
    en_commande : AnsiChar;
    emplacement_type : AnsiChar;
  end;

  TrecP01TARI = record
    id : array[0..5] of AnsiChar;
    filler_1 : array[0..6] of Byte;
    type_tarif : AnsiChar;
    sans_tier : AnsiChar;
    catalogue : AnsiChar;
    promotion : AnsiChar;
    id_famille : array[0..5] of Byte;
    id_article : array[0..5] of Byte;
    id_tier : array[0..5] of Byte;
    debut_tarif : TActipharmDate;
    fin_tarif : TActipharmDate;
    prix : array[0..11] of Byte;
    remise_1 : array[0..11] of Byte;
    remise_2 : array[0..11] of Byte;
    remise_3 : array[0..11] of Byte;
    prix_net : array[0..11] of Byte;
    id_tva : Byte;
    tva : array[0..11] of Byte;
    net_ttc : array[0..11] of Byte;
    date_modification : TActipharmDate;
    date_creation: TActipharmDate;
    id_createur : array[0..5] of Byte;
    id_modifieur : array[0..5] of Byte;
    regime : Byte;
    filler_2 : array[0..56] of Byte;
    prix_ttc : array[0..11] of Byte;
  end;

  TrecP01CUM = record
    table : TWordPrologue;
    id_article : array[0..5] of Byte;
    date : TActipharmDate;
    filler_1 : Byte;
    nb_ventes : array[0..11] of Byte;
    nb_achats : array[0..11] of Byte;
    nb_boites_vendues : array[0..11] of Byte;
    nb_boites_achetees : array[0..11] of Byte;
  end;

  TrecFP2PSTOC = record
    code_cip : array[0..6] of AnsiChar;
    filler_1 : Byte;
    designation_1 : array[0..16] of AnsiChar;
    filler_2 : array[0..6] of AnsiChar;
    dernier_prix_achat : array[0..4] of AnsiChar;
    taux_marque : array[0..4] of AnsiChar;
    prix_vente : array[0..4] of AnsiChar;
    filler_4 : array[0..6] of Byte;
    pamp : array[0..4] of  Byte;
    quantite : TSmallIntPrologue;
    filler_5 : array[0..1] of AnsiChar;
    stock_mini : TSmallIntPrologue;
    stock_maxi : TSmallIntPrologue;
    seuil_reappro : array[0..1] of AnsiChar;
    zone_geographique : array[0..2] of AnsiChar;
    filler_6 : array[0..3] of AnsiChar;
    fournisseurs : array[0..2, 0..9] of AnsiChar;
  end;

  TrecFP2EAN13 = record
    code_ean13 : array[0..12] of AnsiChar;
    filler_1 : array[0..13] of AnsiChar;
    code_cip : array[0..6] of AnsiChar;
  end;

  TrecFP2PTIPS = record
    code_cip : array[0..6] of AnsiChar;
    filler_1 : array[0..7] of AnsiChar;
    codes_tips : array[0..7, 0..14] of AnsiChar;
  end;

  TrecFP2PVETO = record
    code_cip : array[0..6] of AnsiChar;
    filler_1 : array[0..72] of Byte;
    commentaire_1 : array[0..59] of AnsiChar;
    commentaire_2 : array[0..59] of AnsiChar;
  end;

  TrecM01ENTE = record
    id : array[0..5] of Byte;
    filler_1 : array[0..6] of Byte;
    type_facture : AnsiChar;
    etat : AnsiChar;
    type_pie : AnsiChar;
    type_vente : AnsiChar;
    mode_pie : AnsiChar;
    lecture : TWordPrologue;
    nature_ass : AnsiChar;
    date_creation : TActipharmDateTime;
    utilisateur_creation : array[0..5] of Byte;
    date_modification : TActipharmDateTime;
    utilisateur_modification : array[0..5] of Byte;
    piece : array[0..19] of AnsiChar;
    avant_saisie : AnsiChar;
    numero_source : array[0..5] of Byte;
    id_tier : array[0..5] of Byte;
    numero_insee : array[0..14] of AnsiChar;
    montant_ttc : array[0..11] of Byte;
    montant_tva : array[0..11] of Byte;
    montant_ht : array[0..11] of Byte;
    montant_tva_1 : array[0..11] of Byte;
    montant_tva_2 : array[0..11] of Byte;
    montant_tva_3 : array[0..11] of Byte;
    montant_tva_4 : array[0..11] of Byte;
    id_tva_1 : Byte;
    id_tva_2 : Byte;
    id_tva_3 : Byte;
    id_tva_4 : Byte;
    taux_tva_1 : array[0..11] of Byte;
    taux_tva_2 : array[0..11] of Byte;
    taux_tva_3 : array[0..11] of Byte;
    taux_tva_4 : array[0..11] of Byte;
    filler_2 : array[0..401] of Byte;
    id_assure : array[0..5] of Byte;
    filler_3 : Byte;
    id_medecin : array[0..5] of Byte;
    filler_4 : array[0..14] of Byte;
    id_client : array[0..5] of Byte;
    filler_5 : array[0..23] of Byte;
    date_execution : TActipharmDate;
    date_prescription : TActipharmDate;
  end;

  TrecM01LIGN = record
    id_entete : array[0..5] of Byte;
    id_ligne : array[0..5] of Byte;
    filler_1 : array[0..12] of Byte;
    type_ligne_1 : AnsiChar;
    type_ligne_2 : AnsiChar;
    libelle : array[0..49] of AnsiChar;
    id_article : array[0..5] of Byte;
    prix : array[0..11] of Byte;
    prix_unitaire_ttc : array[0..11] of Byte;
    remise_1 : array[0..11] of Byte;
    remise_2 : array[0..11] of Byte;
    remise_3 :  array[0..11] of Byte;
    prix_net : array[0..11] of Byte;
    prix_net_ttc : array[0..11] of Byte;
    id_tva : Byte;
    taux_tva : array[0..11] of Byte;
    promotion : AnsiChar;
    gratuit : AnsiChar;
    quantite : array[0..11] of Byte;
    total_ht : array[0..11] of Byte;
    montant_tva : array[0..11] of Byte;
    total_ttc : array[0..11] of Byte;
    filler_2 : array[0..56] of Byte;
    prestation : array[0..2] of AnsiChar;
    filler_3 : array[0..137] of Byte;
    quantite_prescrite : array[0..11] of Byte;
    filler_4 : array[0..124] of Byte;
    code_cip_delivree : array[0..12] of AnsiChar;
  end;

  TrecFP2SCDFO = record
    fournisseur : array[0..9] of AnsiChar;
    numero_commande : array[0..5] of AnsiChar;
    code_cip : array[0..6] of AnsiChar;
    filler_1 : array[0..40] of Byte;
    prix_achat : array[0..4] of Byte;
    filler_2 : array[0..1] of AnsiChar;
    quantite_commandee : TSmallIntPrologue;
    filler_3 : array[0..2] of Byte;
    date_commande : array[0..7] of AnsiChar;
    date_reception : array[0..7] of AnsiChar;
  end;

  TrecFP2PVIGA = record
    numero_insee : array[0..14] of AnsiChar;
    rang : array[0..1] of AnsiChar;
    date_avance : array[0..7] of AnsiChar;
    code_cip : array[0..6] of AnsiChar;
    filler_1 : array[0..6] of Byte;
    quantite_avancee : TSmallIntPrologue;
    filler_4 : array[0..39] of Byte;
    operateur : array[0..1] of AnsiChar;
    nom_prenom : array[0..21] of AnsiChar;
    filler_2 : array[0..50] of AnsiChar;
    designation : array[0..16] of AnsiChar;
    forme : array[0..29] of AnsiChar;
    filler_3 : array[0..61] of Byte;
    supprime : Byte;
  end;



  TrecP01AYMU = record
    id_rec : array[0..5] of Byte;
    filler_07 : array[0..6] of Byte;
    id_assure : array[0..5] of Byte;
    id_benef : array[0..5] of Byte;
    id_amc : array[0..5] of Byte;
    id_contrat : array[0..5] of Byte;
    flag_cmu : AnsiChar;
    numero_cmu : array[0..7] of AnsiChar;
    flagON : array[0..7] of AnsiChar;
    filler_55 : array[0..28] of AnsiChar;
    date_1 : TActipharmDateTime;
    date_2 : TActipharmDateTime;
    filler_108 : array[0..86] of AnsiChar;
    filler_195 : array[0..67] of Byte;
    numero_cmu2 : array[0..7] of AnsiChar;
    numero_adherent: array[0..7] of AnsiChar;
    filler_279 : array[0..28] of Byte;
    fin_amc : TActipharmDate;
    numero_amc : array[0..7] of AnsiChar;
    filler_324 : array[0..26] of Byte;
    mode_gestion : AnsiChar;
    filler_352 : array[0..39] of AnsiChar;
    flag_ : ansiChar;
    filler_fin_393 : array[0..602] of AnsiChar;
  end;

{ TP01ARTI }

constructor TP01ARTI.Create(AFichier: TFichierBinaire);
var
  f : TFichierActipharm;
begin
  inherited;

  FTailleBloc := 2048;

  FCodesDisponible := TStringList.Create;
  f := TFichierActipharm.Create(ExtractFilePath(Fichier.Fichier) + 'P01FAM.D');
  repeat
    f.Suivant;
    with TP01FAM(f.Donnees) do
    begin
      if Table = 8 then
        FCodesDisponible.Add(FloatToStr(ID) + '=' + Trim(Code));
    end;
  until f.EOF;

  FP00SOC := TFichierActipharm.Create(ExtractFilePath(Fichier.Fichier) + 'P00SOC.D');
  FP00SOC.Suivant;
end;

destructor TP01ARTI.Destroy;
begin
  if Assigned(FP00SOC) then FreeAndNil(FP00SOC);
  if Assigned(FCodesDisponible) then FreeAndNil(FCodesDisponible);

  inherited;
end;

procedure TP01ARTI.Remplit(var ABuffer);
begin
  with Fichier as TFichierActipharm, TrecP01ARTI(ABuffer) do
  begin
    FDureeStockage := RenvoyerFloat(@duree_stockage[0], 12);
    FFourchetteTemperature := RenvoyerInt(fourchette_temperature);
    FID := RenvoyerFloat(@id[0], 6);
    FIDFabricant := RenvoyerFloat(@id_fabricant, 6);
    FIDEmplacement := RenvoyerFloat(@id_emplacement, 6);
    FForme := RenvoyerFloat(@forme[0], 6);
    FClasseATC := RenvoyerFloat(@classe_atc[0], 6);
    FConditionnement := RenvoyerFloat(@unite_boite[0], 12);
    FCodeCIP13 := code_cip_13;
    FDataSemp := RenvoyerFloat(@datasemp[0], 6);
    FPrestation := prestation;
    FCodeCIP := code_cip;
    FLibelle := libelle;
    FCodeEAN13 := code_ean_13;
    FDateCreation := RenvoyerDate(date_creation);
    FComptegeneral :=  RenvoyerFloat(@compte_general[0], 6);
    if FComptegeneral = 70701000 then
        FTVA := 2.1 else
        if FComptegeneral = 70703000 then
          FTVA := 20
           else
            FTVA := 5.5;
    FListe := liste;
    FMethodeReappro := methode_reappro;
    FFamille := RenvoyerFloat(@famille[0], 6);
    FGamme := RenvoyerFloat(@gamme[0], 6);
    FBaseRembousement := RenvoyerFloat(@base_remboursement, 12);
    FStockMini := RenvoyerFloat(@stock_mini[0], 12);
    FDisponible := RenvoyerFloat(@disponible[0], 6);
    FStockMaxi := RenvoyerFloat(@stock_maxi[0], 12);
    FDateModification := RenvoyerDate(date_modification);
    FGereStock := gere_stock;
  end;
end;

{ TFP2PAYDR }

constructor TP01AYDR.Create(AFichier: TFichierBinaire);
begin
  FCodesCouverturesAMO := TPIList<string>.Create(7);
  FFinsDroitsAMO := TPIList<TDateTime>.Create(7);
  FDebutsDroitsAMO := TPIList<TDateTime>.Create(7);

  inherited;

  FTailleBloc := 2066;
end;

constructor TP01AYMU.Create(AFichier: TFichierBinaire);
begin

  inherited;

  FTailleBloc := 995;
end;

destructor TP01AYDR.Destroy;
begin
  if Assigned(FDebutsDroitsAMO) then FreeAndNil(FDebutsDroitsAMO);
  if Assigned(FFinsDroitsAMO) then FreeAndNil(FFinsDroitsAMO);
  if Assigned(FCodesCouverturesAMO) then FreeAndNil(FCodesCouverturesAMO);

  inherited;
end;

procedure TP01AYDR.Remplit(var ABuffer);
var
  i : Integer;
begin
  inherited;

  with TFichierActipharm(Fichier), TrecP01AYDR(ABuffer) do
  begin
    FID := RenvoyerFloat(@id[0], 6);
    FIDAssure := RenvoyerFloat(@id_assure[0], 6);
    FIDAMCFichier := RenvoyerFloat(@id_amc_fichier[0], 6);
    FIDCouvAMCFichier := RenvoyerFloat(@id_couv_amc_fichier[0], 6);
    FIDNatAMCFichier := id_nat_amc_fichier;
    FIDAMCCarte := RenvoyerFloat(@id_amc_carte[0], 6);
    FIDCouvAMCCarte := RenvoyerFloat(@id_couv_amc_carte[0], 6);
    FIDNatAMCCarte := id_nat_amc_carte;
    FNom := nom;
    FNomJeuneFille := nom_jeune_fille;
    FIndTraitementMutuelle := ind_traitement_mutuelle;
    FPrenom := trim(prenom);
    FAdresse1 := adresse_1;
    FAdresse2 := adresse_2;
    FAdresse3 := adresse_3;
    FAdresse4 := adresse_4;
    FAdresse5 := adresse_5;
    FRang := rang;
    FRangGemellaire := rang_gemellaire;
    FQualite := qualite;
    FNumeroInseeBenef := numero_insee_benef;
    FNumeroAdherentMutuelle := num_adh;
    FNumeroInsee := numero_insee;
    FDateNaissance := date_naissance.date;
    FDebutDroitAMO := RenvoyerDate(debut_droit_amo.date);
    FFinDroitAMO := RenvoyerDate(fin_droit_amo.date);
    for i := 0 to 2 do
    begin
      FCodesCouverturesAMO[i] := droits_amo[i].code_couverture;
      FDebutsDroitsAMO[i] := RenvoyerDate(droits_amo[i].debut_droit.date);
      FFinsDroitsAMO[i] := RenvoyerDate(droits_amo[i].fin_droit.date);
    end;
    FDebutDroitAMCFichier := RenvoyerDate(debut_droit_amc_fichier);
    FFinDroitAMCFichier := RenvoyerDate(fin_droit_amc_fichier);
    FDerniereVisite := RenvoyerDate(date_dv);
    FDebutDroitAMCCarte := RenvoyerDate(debut_droit_amc);
    FFinDroitAMCCarte := RenvoyerDate(fin_droit_amc);
    FSexe := sexe;
  end;

end;


procedure TP01AYMU.Remplit(var ABuffer);
begin
  inherited;

  with TFichierActipharm(Fichier), TrecP01AYMU(ABuffer) do
  begin
    FID := RenvoyerFloat(@id_rec[0], 6);
    FIDAssure := RenvoyerFloat(@id_assure[0], 6);
    FIDBenef := RenvoyerFloat(@id_benef[0], 6);
    FIDAMC := RenvoyerFloat(@id_amc[0], 6);
    FIDContratAMC := RenvoyerFloat(@id_contrat[0], 6);
    FFlagCMU := flag_cmu;
    FNumeroCMU := numero_cmu;
    FNumeroAdherent := numero_adherent;
    Fdate1 := RenvoyerDate(date_1.date);
    Fdate2 := RenvoyerDate(date_2.date);
    FDateFinAmc :=  RenvoyerDate(fin_amc);
    FNumeroAmc := numero_amc;
    FModeGestion := mode_gestion;
    FFlag := flag_;
    FNumeroCMU2 := numero_cmu2;

  end;

end;

{ TFichierActipharm }

function TFichierActipharm.RenvoyerClasseDonnees: TClasseDonneesFormatees;
var
  lStrFichier : string;
begin
  lStrFichier := UpperCase(ExtractFileName(FFichier)); Result := nil;
  if lStrFichier = 'P00SOC.D' then Result := TP00SOC;
  if lStrFichier = 'P01CONT.D' then Result := TP01CONT;
  if lStrFichier = 'P01MEDE.D' then Result := TP01MEDE;
  if lStrFichier = 'P01OAMO.D' then Result := TP01OAMO;
  if lStrFichier = 'P01OAMC.D' then Result := TP01OAMC;
  if lStrFichier = 'P01CNTR.D' then Result := TP01CNTR;
  if lStrFichier = 'P01FORM.D' then Result := TP01FORM;
  if lStrFichier = 'P01ASSU.D' then Result := TP01ASSU;
  if lStrFichier = 'P01AYDR.D' then Result := TP01AYDR;
  if lStrFichier = 'P01AYMU.D' then Result := TP01AYMU;
  if lStrFichier = 'P01TIER.D' then Result := TP01TIER;
  if lStrFichier = 'P01FOUR.D' then Result := TP01FOUR;
  if lStrFichier = 'P01LPAR.D' then Result := TP01LPAR;
  if lStrFichier = 'P01EMPL.D' then Result := TP01EMPL;
  if lStrFichier = 'P01FAM.D' then Result := TP01FAM;
  if lStrFichier = 'P01ARTI.D' then Result := TP01ARTI;
  if lStrFichier = 'P01TARI.D' then Result := TP01TARI;
  if lStrFichier = 'P01CUM.D' then Result := TP01CUM;
  if lStrFichier = 'M01ENTE.D' then Result := TM01ENTE;
  if lStrFichier = 'M01LIGN.D' then Result := TM01LIGN;
  if lStrFichier = 'M01DLOT.D' then Result := TM01DLOT;
  if lStrFichier = 'FP2EAN13.D' then Result := TFP2EAN13;
  if lStrFichier = 'FP2PTIPS.D' then Result := TFP2PTIPS;
  if lStrFichier = 'FP2PVETO.D' then Result := TFP2PVETO;
  if lStrFichier = 'FP2PVIGA.D' then Result := TFP2PVIGA;
end;

function TFichierActipharm.RenvoyerDate(ADate: TActipharmDate): TDateTime;
var
  a, m, j : Word;
begin
  if (ADate <> '') and (Length(Trim(ADate)) = 8) then
    try
      a := StrToInt(Copy(ADate, 1, 4));
      m := StrToInt(Copy(ADate, 5, 2));
      j := StrToInt(Copy(ADate, 7, 2));
      TryEncodeDate(a, m, j, Result);
    except
      Result := 0;
    end
  else
    Result := 0;
end;

{ TFP2PSTOC }

constructor TFP2PSTOC.Create(AFichier: TFichierBinaire);
begin
  FFournisseurs := TPIList<string>.Create(3);

  inherited;

  FTailleBloc := 521;
end;

destructor TFP2PSTOC.Destroy;
begin
  if Assigned(FFournisseurs) then FreeAndNil(FFournisseurs);

  inherited;
end;

procedure TFP2PSTOC.Remplit(var ABuffer);
var
  i : Integer;
begin
  inherited;

  with TFichierActipharm(Fichier), TrecFP2PSTOC(ABuffer) do
  begin
    FCodeCIP := code_cip;
    FDesignation1 := designation_1;
    FDernierPrixAchat := RenvoyerFloat(@dernier_prix_achat[0], 5);
    FPrixVente := RenvoyerFloat(@prix_vente[0], 5);
    FZoneGeographique := zone_geographique;
    FQuantite := RenvoyerInt(quantite);
    FPAMP := RenvoyerFloat(@pamp[0], 5);
    FStockMini := RenvoyerInt(stock_mini);
    FStockMaxi := RenvoyerInt(stock_maxi);
    for i := 0 to 2 do
      FFournisseurs[i] := fournisseurs[i];
  end;
end;

{ TP01ASSU }

constructor TP01ASSU.Create(AFichier: TFichierBinaire);
begin
  inherited;

  FTailleBloc := 512;
end;

procedure TP01ASSU.Remplit(var ABuffer);
begin
  inherited;

  with TFichierActipharm(Fichier), TrecP01ASSU(ABuffer) do
  begin
    FID := RenvoyerFloat(@id[0], 6);
    FIDCentreAMO := RenvoyerFloat(@id_centre_amo[0], 6);
    FIDAMO := RenvoyerFloat(@id_amo[0], 6);
    FCodeGestion := code_gestion;
    FNumeroInsee := numero_insee;
    FIDNatAMO := id_nat_amo;
  end;
end;

{ TFP2EAN13 }

constructor TFP2EAN13.Create(AFichier: TFichierBinaire);
begin
  inherited;

  FTailleBloc := 47;
end;

procedure TFP2EAN13.Remplit(var ABuffer);
begin
  inherited;

  with TFichierActipharm(Fichier), TrecFP2EAN13(ABuffer) do
  begin
    FCodeEAN13 := code_ean13;
    FCodeCIP := code_cip;
  end;
end;

{ TP01LPAR }

constructor TP01LPAR.Create(AFichier: TFichierBinaire);
begin
  inherited;

  FTailleBloc := 256;
end;

procedure TP01LPAR.Remplit(var ABuffer);
begin
  inherited;

  with TFichierActipharm(Fichier), TrecP01LPAR(ABuffer) do
  begin
    FID := RenvoyerFloat(@id[0], 6);
  end;
end;

{ TFP2PTIPS }

constructor TFP2PTIPS.Create(AFichier: TFichierBinaire);
begin
  FCodesTIPS := TPIList<string>.Create(8);

  inherited;

  FTailleBloc := 137;
end;

destructor TFP2PTIPS.Destroy;
begin
  if Assigned(FCodesTIPS) then FreeAndNil(FCodesTIPS);

  inherited;
end;

procedure TFP2PTIPS.Remplit(var ABuffer);
var
  i : Integer;
begin
  inherited;

  with TFichierActipharm(Fichier), TrecFP2PTIPS(ABuffer) do
  begin
    FCodeCIP := code_cip;
    for i := 0 to 7 do
      FCodesTIPS[i] := codes_tips[i];
  end
end;

{ TFP2HFTEN }

constructor TM01ENTE.Create(AFichier: TFichierBinaire);
begin
  inherited;

  FTailleBloc := 4088;
end;

procedure TM01ENTE.Remplit(var ABuffer);
begin
  inherited;

  with TFichierActipharm(Fichier), TrecM01ENTE(ABuffer) do
  begin
    FModePIE := mode_pie;
    FTypeVente := type_vente;
    FEtat := etat;
    FTypePIE := type_pie;
    FTypeFacture := type_facture;
    FNatureASS := nature_ass;
    FLecture := RenvoyerInt(lecture);
    FIDTier := RenvoyerFloat(@id_tier[0], 6);
    FIDAssure := RenvoyerFloat(@id_assure[0], 6);
    FIDClient := RenvoyerFloat(@id_client[0], 6);
    FIDMedecin := RenvoyerFloat(@id_medecin[0], 6);
    FIDUtilisateurCreation := RenvoyerFloat(@utilisateur_creation[0], 6);
    FID := RenvoyerFloat(@id[0], 6);
    FNumeroInsee := numero_insee;
    FMontantTTC := RenvoyerFloat(@montant_ttc[0], 12);
    FDatePrescription := RenvoyerDate(date_prescription);
    FDateExecution := RenvoyerDate(date_execution);
    FDateCreation := RenvoyerDate(date_creation.date);
    FPiece := piece;
  end;
end;

{ TFP2PVETO }

constructor TFP2PVETO.Create(AFichier: TFichierBinaire);
begin
  inherited;

  FTailleBloc := 201;
end;

procedure TFP2PVETO.Remplit(var ABuffer);
begin
  inherited;

  with TFichierActipharm(Fichier), TrecFP2PVETO(ABuffer) do
  begin
    FCodeCIP := code_cip;
    FCommentaire1 := commentaire_1;
    FCommentaire2 := commentaire_2;
  end;
end;

{ TFP2SCDFO }

constructor TFP2SCDFO.Create(AFichier: TFichierBinaire);
begin
  inherited;

  FTailleBloc := 105;
end;

procedure TFP2SCDFO.Remplit(var ABuffer);
begin
  inherited;

  with TFichierActipharm(Fichier), TrecFP2SCDFO(Abuffer) do
  begin
    FFournisseur := fournisseur;
    FNumeroCommande := numero_commande;
    FCodeCIP := code_cip;
    FPrixAchat := RenvoyerFloat(@prix_achat[0], 5);
    FQuantiteCommandee := RenvoyerInt(quantite_commandee);
    FDateReception := date_reception;
    FDateCommande := date_commande;
  end;
end;

{ TFP2PVIGA }

constructor TFP2PVIGA.Create(AFichier: TFichierBinaire);
begin
  inherited;

  FTailleBloc := 266;
end;

procedure TFP2PVIGA.Remplit(var ABuffer);
begin
  with TFichierActipharm(Fichier), TrecFP2PVIGA(ABuffer) do
  begin
    FNumeroInsee := numero_insee;
    FRang := rang;
    FDateAvance := date_avance;
    FOperateur := operateur;
    FDesignation := designation;
    FCodeCIP := code_cip;
    FNomPrenom := nom_prenom;
    FQuantiteAvancee := RenvoyerInt(quantite_avancee);
    FSupprime := supprime = 0;
  end;
end;

{ TP01TIER }

constructor TP01TIER.Create(AFichier: TFichierBinaire);
begin
  inherited;

  FTailleBloc := 1024;
end;

procedure TP01TIER.Remplit(var ABuffer);
begin
  inherited;

  with TFichierActipharm(Fichier), TrecP01TIER(ABuffer) do
  begin
    FID := RenvoyerFloat(@id[0], 6);
    FTypeTier := RenvoyerInt(type_tier);
    FPays := RenvoyerFloat(@pays[0], 6);
    FModeReglement := RenvoyerFloat(@mode_reglement[0], 6);
    FFidelisation := RenvoyerFloat(@fidelisation[0], 6);
    FCompteAuxiliaire := RenvoyerFloat(@compte_auxiliaire[0], 6);
    FCompteGeneral := RenvoyerFloat(@compte_general[0], 6);
    FCivilite := civilite;
    FFax := fax;
    FRue1 := rue_1;
    FRue2 := rue_2;
    FRue3 := rue_3;
    FCodePostal := code_postal;
    FNomVille := nom_ville;
    FNom := nom;
    FPrenom := prenom;
    FInterlocurteur := interlocuteur;
    FTelephone := telephone;
    FPortable := portable;
    FAdresseMail := adresse_mail;
    FNumero := numero;
    FDateCreation := RenvoyerDate(date_creation);
    FDateModification := RenvoyerDate(date_modification);
  end;
end;

{ TP01CONT }

constructor TP01CONT.Create(AFichier: TFichierBinaire);
begin
  inherited;

  FTailleBloc := 512;
end;

procedure TP01CONT.Remplit(var ABuffer);
begin
  inherited;

  with TFichierActipharm(Fichier), TrecP01CONT(ABuffer) do
  begin
    FID := RenvoyerFloat(@id[0], 6);
    FTypeContact := type_contact;
    FAdresseMail := adresse_mail;
    FAdresse2 := rue_2;
    FPortable := portable;
    FAdresse1 := rue_1;
    FAdresse3 := rue_3;
    FCodePostal := code_postal;
    FFax := fax;
    FTelephone := telephone;
    FNom := nom;
    FTelephone := telephone;
    FNomVille := nom_ville;
  end;
end;

{ TP01OAMO }

constructor TP01OAMO.Create(AFichier: TFichierBinaire);
begin
  inherited;

  FTailleBloc := 512;
end;

procedure TP01OAMO.Remplit(var ABuffer);
begin
  inherited;

  with TFichierActipharm(Fichier), TrecP01OAMO(ABuffer) do
  begin
    FID := RenvoyerFloat(@id[0], 6);
    FOrdreClassementBord := ordre_classement_bord;
    FBordereauRSS := bordereau_rss;
    FSesamVitale := sesam_vitale;
    FBanquePharmacie := RenvoyerFloat(@banque_pharmacie[0], 6);
    FOrgDestinataire := org_destinataire;
    FCentreInformatique := centre_informatique;
    FIDNatAMO := id_nat_amo;
  end;
end;

{ TP01OAMC }

constructor TP01OAMC.Create(AFichier: TFichierBinaire);
begin
  inherited;

  FTailleBloc := 512;
end;

procedure TP01OAMC.Remplit(var ABuffer);
begin
  inherited;

  with TFichierActipharm(Fichier), TrecP01OAMC(ABuffer) do
  begin
    FID := RenvoyerFloat(@id[0], 6);
    FCode := code;
    FCodePrefectoral := code_prefectoral;
    FTypeAMC := RenvoyerInt(type_amc);
    FBanquePharmacie := RenvoyerFloat(@banque_pharmacie[0], 6);
    FSigle := sigle ;
  end;
end;

{ TP01CNTR }

constructor TP01CNTR.Create(AFichier: TFichierBinaire);
begin
  FFormules := TPIList<Double>.Create(50);
  FTaux := TPIList<Double>.Create(50);

  inherited;

  FTailleBloc := 512;
  FP01FORM := TFichierActipharm.Create(ExtractFilePath(AFichier.Fichier) + 'P01FORM.D');
end;

destructor TP01CNTR.Destroy;
begin
  if Assigned(FP01FORM) then FreeAndNil(FP01FORM);
  if Assigned(FTaux) then FreeAndNil(FTaux);
  if Assigned(FFormules) then FreeAndNil(FFormules);

  inherited;
end;

procedure TP01CNTR.Remplit(var ABuffer);
var
  i : Integer;
  lFtTauxGen : Single;

  function RenvoyerTaux(AFormule : Single) : Single;
  begin
    FP01FORM.Premier; Result := -1;
    repeat
      FP01FORM.Suivant;
      with TP01FORM(FP01FORM.Donnees) do
        if ID = AFormule then
        begin
          if (TarifResponActive = 'O') then Result := TarifRespon;
          if (TicketModActive = 'O') then Result := TicketMod;
        end;
    until FP01FORM.EOF or (Result <> -1);

    if Result = -1 then
      Result := 0;
  end;

begin
  inherited;

  with TFichierActipharm(Fichier), TrecP01CNTR(ABuffer) do
  begin
    FID := RenvoyerFloat(@id[0], 6);
    FIDAMC := RenvoyerFloat(@id_amc[0], 6);
    FFormuleGenerale := RenvoyerFloat(@formule_generale[0], 6);
    lFtTauxGen := RenvoyerTaux(FFormuleGenerale);
    FModeGestion := mode_gestion;
    FLibelle := libelle;
    FCodePreFectoral := code_prefectoral;
    for i := 0 to 49 do
    begin
      FFormules[i] := RenvoyerFloat(@formules[i][0], 6);
      if FFormules[i] = 0 then
        FTaux[i] := lFtTauxGen
      else
        FTaux[i] := RenvoyerTaux(FFormules[i]);
    end;
  end;
end;

{ TP01FORM }

constructor TP01FORM.Create(AFichier: TFichierBinaire);
begin
  inherited;

  FTailleBloc := 512;
end;

procedure TP01FORM.Remplit(var ABuffer);
begin
  inherited;

  with TFichierActipharm(Fichier), TrecP01FORM(ABuffer) do
  begin
    FID := RenvoyerFloat(@id[0], 6);
    FLibelle := libelle;
    FSTS := sts;
    FCodeFormule := code_formule;
    FFormule := formule;
    FTarifResponActive := tarif_respon_active;
    FPlafondActive := plafond_active;
    FPlafondMensuelSSActive := plafond_mensuel_ss_active;
    FTicketModActive := ticket_mod_active;
    FDepenseReelleActive := depense_reelle_active;
    FPlafondMensuelSS := RenvoyerFloat(@plafond_mensuel_ss[0], 12);
    FForfait := RenvoyerFloat(@forfait[0], 12);
    FForfaitActive := forfait_active;
    FTarifConv := RenvoyerFloat(@tarif_conv[0], 12);
    FTarifConvActive := tarif_conv_active;
    FDepenseReelle := RenvoyerFloat(@depense_reelle[0], 12);
    FTicketMod := RenvoyerFloat(@ticket_mod[0], 12);
    FMntRegimeOblig := RenvoyerFloat(@mnt_regime_oblig[0], 12);
    FMntRegimeObligActive := mnt_regime_oblig_active;
    FPlafond := RenvoyerFloat(@plafond[0], 12);
    FTarifRepon := RenvoyerFloat(@tarif_respon[0], 12);
  end;
end;

{ TP01MEDE }

constructor TP01MEDE.Create(AFichier: TFichierBinaire);
begin
  inherited;

  FTailleBloc := 512;
end;

procedure TP01MEDE.Remplit(var ABuffer);
begin
  inherited;

  with TFichierActipharm(Fichier), TrecP01MEDE(ABuffer) do
  begin
    FID := RenvoyerFloat(@id[0], 6);
    FSpecialite := specialite;
    FNumeroFiness := numero_finess;
    FHospitalier := hospitalier;
    FSNCF := sncf;
    FMines := mines;
    FSalarie := salarie;
    FRPPS := rpps;
    FNomPrenom := nom_prenom;
  end;
end;

{ TP01FOUR }

constructor TP01FOUR.Create(AFichier: TFichierBinaire);
begin
  inherited;

  FTailleBloc := 1024;
end;

procedure TP01FOUR.Remplit(var ABuffer);
begin
  inherited;

  with TFichierActipharm(Fichier), TrecP01FOUR(ABuffer) do
  begin
    FID := RenvoyerFloat(@id[0], 6);
    FURL1 := url_1;
    FURL2 := url_2;
    FIDOfficine := id_officine;
    FNumeroClient := numero_client;
    FRepartiteurNature := repartiteur_nature;
    FRepartiteurIdentifiant := repartiteur_identifiant;
    FRepartiteurCode := repartiteur_code;
    FCle := cle;
    FOfficineNature := officine_nature;
    FOfficineIdentifiant := officine_identifiant;
    FOfficineCode := officine_code;
    FRepartiteur := repartiteur;
    FFluxTest := flux_test;
    FDevise := devise;
    FSchemaEnveloppe := schema_enveloppe;
    FSchemaMessage := schema_message;
    FVersionXML := version_xml;
    FEncoding := encoding;
    FLogin := login;
    FMotDePasse := mot_de_passe;
  end;
end;

{ TP01FAM }

constructor TP01FAM.Create(AFichier: TFichierBinaire);
begin
  inherited;

  FTailleBloc := 512;
end;

procedure TP01FAM.Remplit(var ABuffer);
begin
  inherited;

  with TFichierActipharm(Fichier), TrecP01FAM(ABuffer) do
  begin
    FID := RenvoyerFloat(@id[0], 6);
    FLibelle := libelle;
    FEtat := etat;
    FTable := RenvoyerInt(table);
    FCode := code;
  end;
end;

{ TP01EMPL }

constructor TP01EMPL.Create(AFichier: TFichierBinaire);
begin
  inherited;

  FTailleBloc := 256;
end;

procedure TP01EMPL.Remplit(var ABuffer);
begin
  inherited;

  with TFichierActipharm(Fichier), TrecP01EMPL(ABuffer) do
  begin
    FID := RenvoyerFloat(@id[0], 6);
    FLibelle := libelle;
    FRayon := rayon;
    FNumero := numero;
    FFrigo := frigo;
    FTypeMagasin := type_magasin;
    FArmoire := armoire;
  end;
end;

{ TP01TARI }

constructor TP01TARI.Create(AFichier: TFichierBinaire);
begin
  inherited;

  FTailleBloc := 512
end;

procedure TP01TARI.Remplit(var ABuffer);
begin
  inherited;

  with TFichierActipharm(Fichier), TrecP01TARI(ABuffer) do
  begin
    FRegime := regime;
    FPromotion := promotion;
    FTypeTarif := type_tarif;
    FCatalogue := catalogue;
    FSansTier := sans_tier;
    FNetTTC := RenvoyerFloat(@net_ttc, 12);
    FID := RenvoyerFloat(@id[0], 6);
    FRemise1 := RenvoyerFloat(@remise_1[0], 12);
    FRemise2 := RenvoyerFloat(@remise_2[0], 12);
    FRemise3 := RenvoyerFloat(@remise_3[0], 12);
    FIDModifieur := RenvoyerFloat(@id_modifieur[0], 6);
    FIDCreateur := RenvoyerFloat(@id_createur[0], 6);
    FIDTier := RenvoyerFloat(@id_tier[0], 6);
    FPrixNet := RenvoyerFloat(@prix_net[0], 12);
    FIDFamille := RenvoyerFloat(@id_famille[0], 6);
    FPrix := RenvoyerFloat(@prix[0], 12);
    FIDTVA := id_tva;
    FTVA := RenvoyerFloat(@tva[0], 12);
    FIDArticle := RenvoyerFloat(@id_article[0], 6);
    FDebutTarif := RenvoyerDate(debut_tarif);
    FFinTarif := RenvoyerDate(fin_tarif);
    FDateCreation := RenvoyerDate(date_creation);
    FDateModification := RenvoyerDate(date_modification);
  end;
end;

{ TPOOSOC }

constructor TP00SOC.Create(AFichier: TFichierBinaire);
begin
  FTauxTVA := TPIList<Double>.Create(10);

  inherited;

  FTailleBloc := 2048;
end;

destructor TP00SOC.Destroy;
begin
  if Assigned(FTauxTVA) then FreeAndNil(FTauxTVA);

  inherited;
end;

procedure TP00SOC.Remplit(var ABuffer);
var
  i : Integer;
begin
  inherited;

  with TFichierActipharm(Fichier), TrecP00SOC(ABuffer) do
  begin
    FID := RenvoyerFloat(@id[0], 6);
    for i := 0 to 9 do
      FTauxTVA[i] := RenvoyerFloat(@taux_tva[i][0], 4);
  end;
end;

{ TP01CUM }

constructor TP01CUM.Create(AFichier: TFichierBinaire);
begin
  inherited;

  FTailleBloc := 162;
end;

procedure TP01CUM.Remplit(var ABuffer);
begin
  inherited;

  with TFichierActipharm(Fichier), TrecP01CUM(ABuffer) do
  begin
    FTable := RenvoyerInt(table);
    FIDArticle := RenvoyerFloat(@id_article[0], 6);
    FDate := RenvoyerDate(date);
    FNbBoitesVendues := RenvoyerFloat(@nb_boites_vendues[0], 12);
    FNBVentes := RenvoyerFloat(@nb_ventes[0], 12);
    FNBAchats := RenvoyerFloat(@nb_achats[0], 12);;
    FNbAchatsAchetees := RenvoyerFloat(@nb_boites_achetees[0], 12);
  end;
end;

{ TM01LIGN }

constructor TM01LIGN.Create(AFichier: TFichierBinaire);
begin
  inherited;

  FTailleBloc := 2054
end;

procedure TM01LIGN.Remplit(var ABuffer);
begin
  inherited;

  with TFichierActipharm(Fichier), TrecM01LIGN(ABuffer) do
  begin
    FIDEntete := RenvoyerFloat(@id_entete[0], 6);
    FIDLigne := RenvoyerFloat(@id_ligne[0], 6);
    FIDArticle := RenvoyerFloat(@id_article[0], 6);
    FIDTVA := id_tva;
    FLibelle := libelle;
    FCodeCIPDelivree := code_cip_delivree;
    FPromotion := promotion;
    FGratuit := gratuit;
    FPrixNetTTC := RenvoyerFloat(@prix_net_ttc[0], 12);
    FTauxTVA := RenvoyerFloat(@taux_tva[0], 12);
    FPrixUnitaireTTC := RenvoyerFloat(@prix_unitaire_ttc[0], 12);
    FMontantTVA := RenvoyerFloat(@montant_tva[0], 12);
    FTotalHT := RenvoyerFloat(@total_ht[0], 12);
    FPrix := RenvoyerFloat(@prix[0], 12);
    FTotalTTC := RenvoyerFloat(@total_ttc[0], 12);
    FQuantitePrescrite := RenvoyerFloat(@quantite_prescrite[0], 12);
    FQuantite := RenvoyerFloat(@quantite[0], 12);
    FPrestation := prestation;
  end;
end;

{ TM01DLOT }

constructor TM01DLOT.Create(AFichier: TFichierBinaire);
begin
  inherited;

  FTailleBloc := 256;
end;

procedure TM01DLOT.Remplit(var ABuffer);
begin
  inherited;

  with TFichierActipharm(Fichier), TrecM01DLOT(ABuffer) do
  begin
    FIDEntete := RenvoyerFloat(@id_entete[0], 6);
    FIDEmplacement := RenvoyerFloat(@id_emplacement[0], 6);
    FIDUtilisateur := RenvoyerFloat(@id_utilisateur[0], 6);
    FIDDest := RenvoyerFloat(@id_dest[0], 6);
    FIDEnteteOrig := RenvoyerFloat(@id_entete_orig[0], 6);
    FIDLigneOrig := RenvoyerFloat(@id_ligne_orig[0], 6);
    FIDLigneDest := RenvoyerFloat(@id_ligne_dest[0], 6);
    FIDOrig := RenvoyerFloat(@id_orig[0], 6);
    FID := RenvoyerFloat(@id[0], 6);
    FIDArticle := RenvoyerFloat(@id_article[0], 6);
    FIDEnteteDest := RenvoyerFloat(@id_entete_dest[0], 6);
    FIDTierCommande := RenvoyerFloat(@id_tier_commande[0], 6);
    FIDLigne := RenvoyerFloat(@id_ligne[0], 6);
    FDatePeremption := RenvoyerDate(date_peremption);
    FDateCommande := RenvoyerDate(date_commande);
    FDateFabrication := RenvoyerDate(date_fabrication);
    FEnCommande := en_commande;
    FDLotPivot := dlot_pivot;
    FDLotType := dlot_type;
    FDLotSens := dlot_sens;
    FDLotDate := RenvoyerDate(dlot_date.date);
    FSolde := solde;
    FEmplacementType := emplacement_type;
    FPerdue := perdue;
    FCalendaire := calendaire;
    FVignette := vignette;
    FPromotionAffecte := promotion_affecte;
    FPromotion := promotion;
    FReste := RenvoyerFloat(@reste[0], 12);
    FQuantite := RenvoyerFloat(@quantite[0], 12);
    FNumero := numero;
  end;
end;

initialization

finalization

end.
