unit mdlOutilsERPERP_fr;

interface

uses
  SysUtils, Classes, mdlModuleOutils, mdlModule,
  mdlProjet, DB, MemDS, DBAccess, Ora, OraSmart, OraError, Menus, JvMenus;

type
  TdmOutilsERPERP_fr = class(TdmModuleOutils)
    qryOrgStat: TOraQuery;
    qryProdStat: TOraQuery;
    qryOrgStatTYPE_ORGANISME: TStringField;
    qryOrgStatNOM: TStringField;
    qryOrgStatIDENTIFIANT_NATIONAL: TStringField;
    qryOrgStatNB_CLIENTS: TFloatField;
    sp: TOraStoredProc;
    qryNoLot: TOraQuery;
    qryNoLotNUMLOT: TFloatField;
    qryNoLotT_DESTINATAIRE_ID: TFloatField;
    qryNoLotNOM: TStringField;
    qryProdStatTAUX_TVA: TFloatField;
    qryProdStatNB_PRODUITS: TFloatField;
    qryProdStatNB_UNITES: TFloatField;
    qryProdStatTOTAL_PRIX_ACHAT_CATALOGUE: TFloatField;
    qryProdStatTOTAL_PRIX_VENTE: TFloatField;
    qryProdStatTOTAL_PAMP: TFloatField;
    procedure DataModuleCreate(Sender: TObject);
    procedure qryNoLotAfterPost(DataSet: TDataSet);
    procedure qryNoLotAfterClose(DataSet: TDataSet);
  private
    FChangementNoLot: Boolean;
    { Déclarations privées }
  public
    { Déclarations publiques }
    property ChangementNoLot : Boolean read FChangementNoLot;
    procedure ReInitialiserSequence(ANomSequence : string; ADebut : Integer);
    function RenvoyerDebutSequence(ANomSequence : string) : Integer;
  end;

var
  dmOutilsERPERP_fr: TdmOutilsERPERP_fr;

implementation

{$R *.dfm}

procedure TdmOutilsERPERP_fr.DataModuleCreate(Sender: TObject);
begin
  inherited;

  // Connexion à la base ERP
  with Projet do
    if Assigned(ModuleTransfert) and Assigned(Projet.ERPConnexion) then
      if Projet.ERPConnexion is TOraSession then
      begin
        qryProdStat.Session := Projet.ERPConnexion as TOraSession;
        qryOrgStat.Session := Projet.ERPConnexion as TOraSession;
        qryNoLot.Session := Projet.ERPConnexion as TOraSession;

        sp.Session := Projet.ERPConnexion as TOraSession;
      end
      else
        raise EDatabaseError.Create('Aucune connexion Oracle trouvée !')
    else
      raise EDatabaseError.Create('Aucune module de transfert et/ou connexion trouvée !');
end;

procedure TdmOutilsERPERP_fr.qryNoLotAfterPost(DataSet: TDataSet);
begin
  inherited;

  if not FChangementNoLot then FChangementNoLot := True;
end;

procedure TdmOutilsERPERP_fr.qryNoLotAfterClose(DataSet: TDataSet);
begin
  inherited;

  FChangementNoLot := False;
end;

procedure TdmOutilsERPERP_fr.ReInitialiserSequence(ANomSequence: string;
  ADebut: Integer);
begin
  with sp do
  begin
    StoredProcName := 'MIGRATION.PK_SUPPRIMER.INITIALISER_SEQUENCE';
    Prepare;
    ParamByName('ASEQUENCE').AsString := ANomSequence;
    ParamByName('ADEBUT').AsInteger := ADebut;
    ExecProc;
  end;
end;

function TdmOutilsERPERP_fr.RenvoyerDebutSequence(
  ANomSequence: string): Integer;
begin
  with sp do
  begin
    StoredProcName := 'MIGRATION.PK_SUPPRIMER.RENVOYER_DEBUT_SEQUENCE';
    Prepare;
    ParamByName('ASEQUENCE').AsString := ANomSequence;
    ExecProc;
    Result := ParamByName('RESULT').AsInteger;
  end;
end;

end.
