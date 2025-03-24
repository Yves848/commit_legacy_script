unit mdlOutilsERPERP_be;

interface

uses
  SysUtils, Classes, mdlModuleOutils, mdlModule,
  mdlProjet, DB, MemDS, DBAccess, Ora, OraSmart, OraError, Menus, JvMenus;

type
  TdmOutilsERPERP_be = class(TdmModuleOutils)
    sp: TOraStoredProc;
    qryNoOrdo: TOraQuery;
    qryNoOrdoT_DESTINATAIRE_ID: TFloatField;
    qryNoOrdoNOM: TStringField;
    procedure DataModuleCreate(Sender: TObject);
    procedure qryNoOrdoAfterPost(DataSet: TDataSet);
    procedure qryNoOrdoAfterClose(DataSet: TDataSet);
  private
    FChangementNoOrdo: Boolean;
    { Déclarations privées }
  public
    { Déclarations publiques }
    property ChangementNoOrdo : Boolean read FChangementNoOrdo;
    procedure ReInitialiserSequence(ANomSequence : string; ADebut : Integer);
    procedure ReInitialiserTable(ATable : string);
    function RenvoyerDebutSequence(ANomSequence : string) : Integer;
    function RenvoyerNumMaxCrist() : Integer;
    procedure ChangerGestionCarte(ATypeCarte: string);
  end;

var
  dmOutilsERPERP_be: TdmOutilsERPERP_be;

implementation

{$R *.dfm}

procedure TdmOutilsERPERP_be.DataModuleCreate(Sender: TObject);
begin
  inherited;

  // Connexion à la base ERP
  with Projet do
    if Assigned(ModuleTransfert) and Assigned(Projet.ERPConnexion) then
      if Projet.ERPConnexion is TOraSession then
      begin
        qryNoOrdo.Session := Projet.ERPConnexion as TOraSession;

        sp.Session := Projet.ERPConnexion as TOraSession;
      end
      else
        raise EDatabaseError.Create('Aucune connexion Oracle trouvée !')
    else
      raise EDatabaseError.Create('Aucune module de transfert et/ou connexion trouvée !');
end;

procedure TdmOutilsERPERP_be.qryNoOrdoAfterPost(DataSet: TDataSet);
begin
  inherited;

  if not FChangementNoOrdo then FChangementNoOrdo := True;
end;

procedure TdmOutilsERPERP_be.qryNoOrdoAfterClose(DataSet: TDataSet);
begin
  inherited;

  FChangementNoOrdo := False;
end;

procedure TdmOutilsERPERP_be.ReInitialiserSequence(ANomSequence: string;
  ADebut: Integer);
begin
  with sp do
  begin
    StoredProcName := 'MIGRATION.pk_supprimer.INITIALISER_SEQUENCE';
    Prepare;
    ParamByName('ASEQUENCE').AsString := ANomSequence;
    ParamByName('ADEBUT').AsInteger := ADebut;
    ExecProc;
  end;
end;

procedure TdmOutilsERPERP_be.ReInitialiserTable(ATable: string);
begin
  with sp do
  begin
    StoredProcName := 'MIGRATION.pk_supprimer.SUPPRIMER_DONNEES_TABLE';
    Prepare;
    ParamByName('ATABLE').AsString := ATable;
    ExecProc;
  end;
end;

function TdmOutilsERPERP_be.RenvoyerDebutSequence(
  ANomSequence: string): Integer;
begin
  with sp do
  begin
    StoredProcName := 'MIGRATION.pk_supprimer.RENVOYER_DEBUT_SEQUENCE';
    Prepare;
    ParamByName('ASEQUENCE').AsString := ANomSequence;
    ExecProc;
    Result := ParamByName('RESULT').AsInteger;
  end;
end;

function TdmOutilsERPERP_be.RenvoyerNumMaxCrist(): Integer;
begin
  with sp do
  begin
    StoredProcName := 'MIGRATION.pk_annexes.Num_Max_Crist';
    Prepare;
    ExecProc;
    Result := ParamByName('RESULT').AsInteger;
  end;
end;

procedure TdmOutilsERPERP_be.ChangerGestionCarte(ATypeCarte: string);
begin
  with sp do
  begin
    StoredProcName := 'MIGRATION.pk_annexes.CHOIXTYPECARTERIST';
    Prepare;
    ParamByName('idTypeCarte').AsString := ATypeCarte;
    ExecProc;
  end;
end;

end.
