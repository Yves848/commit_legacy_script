unit mdlActipharmPHA;

interface

uses
  SysUtils, Classes, DB, mdlPHA, mdlModuleImportPHA, uib, uibdataset,
  mydbunit, fbcustomdataset, mdlActipharmLectureFichier, mdlProjet, Variants, IniFiles,
  mdlTypes, StrUtils;

type
  TdmActipharmPHA = class(TdmModuleImportPHA)
    procedure DataModuleCreate(Sender: TObject);
  private
    FHistoriqueClient: THashedStringList;
    { Declarations privees }
  public
    { Declarations publiques }
    property HistoriqueClient : THashedStringList read FHistoriqueClient;
    function CreerDonnees(AP01MEDE : TP01MEDE) : TResultatCreationDonnees; reintroduce; overload;
    function CreerDonnees(AP01OAMO : TP01OAMO): TResultatCreationDonnees; reintroduce; overload;
    function CreerDonnees(AP01OAMC : TP01OAMC): TResultatCreationDonnees; reintroduce; overload;
    function CreerDonnees(AP01CNTR : TP01CNTR): TResultatCreationDonnees; reintroduce; overload;
    function CreerDonnees(AP01ASSU : TP01ASSU) : TResultatCreationDonnees; reintroduce; overload;
    function CreerDonnees(AP01AYDR : TP01AYDR) : TResultatCreationDonnees; reintroduce; overload;
    function CreerDonnees(AP01AYMU : TP01AYMU) : TResultatCreationDonnees; reintroduce; overload;
    function CreerDonnees(AP01TIER : TP01TIER) : TResultatCreationDonnees; reintroduce; overload;
    function CreerDonnees(AP01FOUR : TP01FOUR) : TResultatCreationDonnees; reintroduce; overload;
    function CreerDonnees(AP01LPAR : TP01LPAR) : TResultatCreationDonnees; reintroduce; overload;
    function CreerDonnees(AP01EMPL : TP01EMPL) : TResultatCreationDonnees; reintroduce; overload;
    function CreerDonnees(AP01FAM : TP01FAM) : TResultatCreationDonnees; reintroduce; overload;
    function CreerDonnees(AP01ARTI : TP01ARTI) : TResultatCreationDonnees; reintroduce; overload;
    function CreerDonnees(AP01TARI : TP01TARI) : TResultatCreationDonnees; reintroduce; overload;
    function CreerDonnees(AP01CUM : TP01CUM) : TResultatCreationDonnees; reintroduce; overload;
    function CreerDonnees(AM01ENTE : TM01ENTE) : TResultatCreationDonnees; reintroduce; overload;
    function CreerDonnees(AM01LIGN : TM01LIGN) : TResultatCreationDonnees; reintroduce; overload;
    function CreerDonnees(AM01DLOT : TM01DLOT) : TResultatCreationDonnees; reintroduce; overload;
    function CreerDonnees(AFP2PVIGA : TFP2PVIGA) : TResultatCreationDonnees; reintroduce; overload;
    function CreerDonnees(AFP2PTIPS : TFP2PTIPS) : TResultatCreationDonnees; reintroduce; overload;
    function CreerDonnees(AFP2PVETO : TFP2PVETO) : TResultatCreationDonnees; reintroduce; overload;
    function CreerDonnees(AFP2SCDFO : TFP2SCDFO) : TResultatCreationDonnees; reintroduce; overload;
  end;

var
  dmActipharmPHA: TdmActipharmPHA;

implementation

uses DateUtils;

{$R *.dfm}

function TdmActipharmPHA.CreerDonnees(
  AP01LPAR: TP01LPAR): TResultatCreationDonnees;
begin
  Result := ExecuterPS('P01LPAR.D', 'PS_ACTIPHARM_CREER_FABRICANT',
                       VarArrayOf([AP01LPAR.ID]));
end;

function TdmActipharmPHA.CreerDonnees(
  AP01ARTI: TP01ARTI): TResultatCreationDonnees;
begin
  Result := ExecuterPS('P01ARTI.D', 'PS_ACTIPHARM_CREER_ARTICLE',
                       VarArrayOf([AP01ARTI.ID,
                                   AP01ARTI.CodeCIP,
                                   AP01ARTI.CodeCIP13,
                                   AP01ARTI.Libelle,
                                   AP01ARTI.CodeEAN13,
                                   AP01ARTI.DateCreation,
                                   AP01ARTI.IDFabricant,
                                   AP01ARTI.Prestation,
                                   AP01ARTI.IDEmplacement,
                                   AP01ARTI.BaseRemboursement,
                                   AP01ARTI.DateModification,
                                   AP01ARTI.CodesDisponible.Values[FloatToSTr(AP01ARTI.Disponible)],
                                   AP01ARTI.MethodeReappro,
                                   AP01ARTI.StockMini,
                                   AP01ARTI.StockMaxi,
                                   AP01ARTI.TVA,
                                   //TP00SOC(AP01ARTI.P00SOC.Donnees).TauxTVA[AP01ARTI.TVA],
                                   AP01ARTI.Liste,
                                   AP01ARTI.GereStock]));
end;

function TdmActipharmPHA.CreerDonnees(
  AP01ASSU: TP01ASSU): TResultatCreationDonnees;
begin
  Result := ExecuterPS('P01ASSU.D', 'PS_ACTIPHARM_MAJ_ASSURE',
                       VarArrayOf([AP01ASSU.ID,
                                   AP01ASSU.NumeroInsee,
                                   AP01ASSU.IDNatAMO,
                                   AP01ASSU.IDAMO,
                                   AP01ASSU.IDCentreAMO ]));
end;

function TdmActipharmPHA.CreerDonnees(
  AP01AYDR: TP01AYDR): TResultatCreationDonnees;
var
  i : Integer;
begin
  Result := ExecuterPS('P01AYDR.D', 'PS_ACTIPHARM_MAJ_AYANT_DROIT',
                       VarArrayOf([AP01AYDR.ID,
                                   AP01AYDR.IDAssure,
                                   AP01AYDR.NumeroInseeBenef,
                                   AP01AYDR.Qualite,
                                   AP01AYDR.RangGemellaire,
                                   AP01AYDR.Nom,
                                   AP01AYDR.NomJeuneFille,
                                   AP01AYDR.Prenom,
                                   AP01AYDR.DateNaissance,
                                   AP01AYDR.Sexe,
                                   AP01AYDR.IDAMCFichier,
                                   AP01AYDR.IDAMCCarte,
                                   AP01AYDR.IDCouvAMCFichier,
                                   AP01AYDR.IDCouvAMCCarte,
                                   AP01AYDR.NumeroAdherentMutuelle,
                                   AP01AYDR.DebutDroitAMCFichier,
                                   AP01AYDR.DebutDroitAMCCarte,
                                   AP01AYDR.FinDroitAMCFichier,
                                   AP01AYDR.FinDroitAMCCarte,
                                   AP01AYDR.Adresse1,
                                   AP01AYDR.Adresse2,
                                   AP01AYDR.Adresse4,
                                   AP01AYDR.DerniereVisite]));

  for i := 0 to AP01AYDR.CodesCouverturesAMO.Count - 1 do
    if AP01AYDR.CodesCouverturesAMO[i] <> '' then
      ExecuterPS('P01PAYDR.D', 'PS_ACTIPHARM_CREER_COUV_AMO',
               VarArrayOf([AP01AYDR.ID,
                           AP01AYDR.CodesCouverturesAMO[i],
                           AP01AYDR.DebutsDroitsAMO[i],
                           AP01AYDR.FinsDroitsAMO[i]]));
end;


function TdmActipharmPHA.CreerDonnees(
  AP01AYMU: TP01AYMU): TResultatCreationDonnees;
begin
 if AP01AYMU.Flag = 'N' then
    Result := ExecuterPS('P01AYMU.D', 'PS_ACTIPHARM_MAJ_COUV_AMC',
                       VarArrayOf([AP01AYMU.IDBenef,
                                   AP01AYMU.IDAssure,
                                   AP01AYMU.IDAMC,
                                   AP01AYMU.IDContratAMC,
                                   AP01AYMU.NumeroAdherent,
                                   AP01AYMU.date1,
                                   AP01AYMU.DateFinAmc ]))
   else
    Result := rcdRejetee;

end;

function TdmActipharmPHA.CreerDonnees(
  AP01TIER: TP01TIER): TResultatCreationDonnees;
begin
  Result := ExecuterPS('P01TIER.D', 'PS_ACTIPHARM_MAJ_TIER',
                       VarArrayOf([AP01TIER.ID,
                                   AP01TIER.TypeTier,
                                   AP01TIER.Nom,
                                   AP01TIER.Prenom,
                                   AP01TIER.Rue1,
                                   AP01TIER.Rue2,
                                   AP01TIER.Rue3,
                                   AP01TIER.CodePostal,
                                   AP01TIER.NomVille,
                                   AP01TIER.Telephone,
                                   AP01TIER.Fax,
                                   AP01TIER.Portable]));
end;

function TdmActipharmPHA.CreerDonnees(
  AP01MEDE: TP01MEDE): TResultatCreationDonnees;
begin
  Result := ExecuterPS('P01MEDE.D', 'PS_ACTIPHARM_CREER_MEDECIN',
             VarArrayOf([AP01MEDE.ID,
                       AP01MEDE.NumeroFiness,
                       AP01MEDE.Specialite,
                       AP01MEDE.Hospitalier,
                       AP01MEDE.Salarie,
                       AP01MEDE.SNCF,
                       AP01MEDE.Mines,
                       AP01MEDE.RPPS,
                       AP01MEDE.NomPrenom
                       ]));
end;

function TdmActipharmPHA.CreerDonnees(
  AFP2PTIPS: TFP2PTIPS): TResultatCreationDonnees;
var
  i : Integer;
  t : Integer;
begin
  for i := 0 to AFP2PTIPS.CodesTIPS.Count -1 do
    if (Length(AFP2PTIPS.CodesTIPS[i]) = 7) and TryStrToInt(AFP2PTIPS.CodesTIPS[i], t) then
      Result := ExecuterPS('FP2PTIPS.D', 'PS_PHARMINFOR_CREER_TIPS',
                           VarArrayOf([AFP2PTIPS.CodeCIP,
                                       AFP2PTIPS.CodesTIPS[i]]))
    else
      Result := rcdRejetee;
end;

function TdmActipharmPHA.CreerDonnees(
  AP01OAMO: TP01OAMO): TResultatCreationDonnees;
begin
  Result := ExecuterPS('P01OAMO.D', 'PS_ACTIPHARM_CREER_ORG_AMO',
                       VarArrayOf([AP01OAMO.ID,
                                   AP01OAMO.IDNatAMO]));
end;

procedure TdmActipharmPHA.DataModuleCreate(Sender: TObject);
begin
  inherited;

  dmActipharmPHA := Self;
  FHistoriqueClient := THashedStringList.Create;
end;

function TdmActipharmPHA.CreerDonnees(
  AFP2PVETO: TFP2PVETO): TResultatCreationDonnees;
begin
  Result := ExecuterPS('FP2PVETO.D', 'PS_PHARMINFOR_MAJ_PRODUIT',
                       VarArrayOf([AFP2PVETO.CodeCIP,
                                   AFP2PVETO.Commentaire1,
                                   AFP2PVETO.Commentaire2]));
end;

function TdmActipharmPHA.CreerDonnees(
  AFP2SCDFO: TFP2SCDFO): TResultatCreationDonnees;
begin
  if (AFP2SCDFO.QuantiteCommandee > 0) and
     (Trim(AFP2SCDFO.NumeroCommande) <> '') and (Trim(AFP2SCDFO.CodeCIP) <> '') and (Trim(AFP2SCDFO.Fournisseur) <> '') then
      Result := ExecuterPS('FP2SCDFO.D', 'PS_PHARMINFOR_CREER_HISTO_ACHAT',
                            VarArrayOf([AFP2SCDFO.Fournisseur,
                                       AFP2SCDFO.NumeroCommande,
                                       AFP2SCDFO.CodeCIP,
                                       AFP2SCDFO.QuantiteCommandee,
                                       AFP2SCDFO.DateCommande,
                                       AFP2SCDFO.DateReception,
                                       AFP2SCDFO.PrixAchat]))
  else
    Result := rcdRejetee;
end;

function TdmActipharmPHA.CreerDonnees(
  AFP2PVIGA: TFP2PVIGA): TResultatCreationDonnees;
begin
  if not AFP2PVIGA.Supprime then
    Result := ExecuterPS('FP2PVIGA.D', 'PS_PHARMINFOR_CREER_VIGNETTE',
                         VarArrayOf([AFP2PVIGA.NumeroInsee,
                                    AFP2PVIGA.Rang,
                                    AFP2PVIGA.CodeCIP,
                                    AFP2PVIGA.DateAvance,
                                    AFP2PVIGA.Designation,
                                    AFP2PVIGA.Forme,
                                    AFP2PVIGA.Operateur,
                                    AFP2PVIGA.QuantiteAvancee]))
  else
    Result := rcdRejetee;                                    
end;

function TdmActipharmPHA.CreerDonnees(
  AP01OAMC: TP01OAMC): TResultatCreationDonnees;
begin
  Result := ExecuterPS('P01OAMO.D', 'PS_ACTIPHARM_CREER_ORG_AMC',
                       VarArrayOf([AP01OAMC.id,
                                   AP01OAMC.Sigle,
                                   AP01OAMC.Code,
                                   AP01OAMC.CodePrefectoral]));
end;

function TdmActipharmPHA.CreerDonnees(
  AP01CNTR: TP01CNTR): TResultatCreationDonnees;
begin
  Result := ExecuterPS('P01CNTR.D', 'PS_ACTIPHARM_CREER_CONTRAT_AMC',
                       VarArrayOf([AP01CNTR.ID,
                                   AP01CNTR.IDAmc,
                                   AP01CNTR.Libelle,
                                   AP01CNTR.Taux[0],
                                   AP01CNTR.Taux[2],
                                   AP01CNTR.Taux[3],
                                   AP01CNTR.Taux[1],
                                   AP01CNTR.Taux[33]]));
end;

function TdmActipharmPHA.CreerDonnees(
  AP01FAM: TP01FAM): TResultatCreationDonnees;
begin

end;

function TdmActipharmPHA.CreerDonnees(
  AP01EMPL: TP01EMPL): TResultatCreationDonnees;
begin
  Result := ExecuterPS('P01EMPL.D', 'PS_ACTIPHARM_CREER_ZG',
                       VarArrayOf([AP01EMPL.ID,
                                   AP01EMPL.TypeMagasin,
                                   AP01EMPL.Armoire,
                                   AP01EMPL.Rayon,
                                   AP01EMPL.Numero,
                                   AP01EMPL.Libelle]));
end;

function TdmActipharmPHA.CreerDonnees(
  AP01TARI: TP01TARI): TResultatCreationDonnees;
begin
  if (AP01TARI.FinTarif >= now) or (YearOf(AP01TARI.FinTarif)=1899) then
    Result := ExecuterPS('P01TARI.D', 'PS_ACTIPHARM_MAJ_ARTICLE',
                       VarArrayOf([AP01TARI.IDArticle,
                                   AP01TARI.SansTier,
                                   AP01TARI.TypeTarif,
                                   AP01TARI.Catalogue,
                                   AP01TARI.Prix,
                                   AP01TARI.PrixNet,
                                   AP01TARI.Remise1,
                                   AP01TARI.NetTTC,
                                   AP01TARI.IDTier,
                                   AP01TARI.TVA,
                                   AP01TARI.DateModification]))
  else
    Result := rcdRejetee;

end;

function TdmActipharmPHA.CreerDonnees(
  AP01CUM: TP01CUM): TResultatCreationDonnees;
begin
  if (AP01CUM.IDArticle <> 0) and (AP01CUM.Date <> 0) and (AP01CUM.table = 47) then
    Result := ExecuterPS('P01CUM.D', 'PS_ACTIPHARM_CREER_HISTO_VENTE',
                         VarArrayOf([AP01CUM.IDArticle,
                                     AP01CUM.NbBoitesVendues,
                                     AP01CUM.Date]))
  else
    Result := rcdRejetee;
end;

function TdmActipharmPHA.CreerDonnees(
  AM01ENTE: TM01ENTE): TResultatCreationDonnees;
begin
  if (AM01ENTE.TypeVente <> 'C') and (AM01ENTE.IDClient <> 0) then
  begin
    Result := ExecuterPS('M01ENTE.D', 'PS_ACTIPHARMA_CREER_HISTO_ENT',
                         VarArrayOf([AM01ENTE.ID,
                                     AM01ENTE.Piece,
                                     AM01ENTE.IDClient,
                                     AM01ENTE.IDMedecin,
                                     AM01ENTE.DateExecution,
                                     AM01ENTE.DatePrescription,
                                     AM01ENTE.MontantTTC]));
    if Result = rcdImportee then
      FHistoriqueClient.Add(FloatToStr(AM01ENTE.ID));
  end
  else
    Result := rcdRejetee;
end;

function TdmActipharmPHA.CreerDonnees(
  AM01LIGN: TM01LIGN): TResultatCreationDonnees;
begin
  if FHistoriqueClient.IndexOf(FloatToStr(AM01LIGN.IDEntete)) <> -1 then
    Result := ExecuterPS('M01LIGN.D', 'PS_ACTIPHARMA_CREER_HISTO_LIG',
                         VarArrayOf([AM01LIGN.IDEntete,
                                     AM01LIGN.IDLigne,
                                     AM01LIGN.CodeCIPDelivree,
                                     AM01LIGN.Libelle,
                                     AM01LIGN.Quantite,
                                     AM01LIGN.PrixUnitaireTTC]))
  else
    Result := rcdRejetee;
end;

function TdmActipharmPHA.CreerDonnees(
  AM01DLOT: TM01DLOT): TResultatCreationDonnees;
begin
  if (AM01DLOT.DLotType = 'A') and (AM01DLOT.DLotSens = 'E') and (AM01DLOT.DLotPivot = 'O') and (AM01DLOT.EnCommande = '0')  then
    Result := ExecuterPS('M01DLOT.D', 'PS_ACTIPHARM_MAJ_STOCK',
                         VarArrayOf([AM01DLOT.IDArticle, AM01DLOT.Reste]))
  else
    Result := rcdRejetee;
end;

function TdmActipharmPHA.CreerDonnees(
  AP01FOUR: TP01FOUR): TResultatCreationDonnees;
begin
  Result := ExecuterPS('P01FOUR.D', 'PS_ACTIPHARM_CREER_FOURNISSEUR',
                       VarArrayOf([AP01FOUR.ID,
                                   AP01FOUR.NumeroClient,
                                   AP01FOUR.Repartiteur,
                                   AP01FOUR.URL1,
                                   AP01FOUR.URL2,
                                   AP01FOUR.IDOfficine,
                                   AP01FOUR.Cle,
                                   AP01FOUR.Login,
                                   AP01FOUR.MotDePasse]));
end;

end.
