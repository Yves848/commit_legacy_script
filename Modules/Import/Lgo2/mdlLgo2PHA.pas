unit mdlLgo2PHA;

interface

uses
  SysUtils, Classes, DB, mdlPHA, Dialogs, UIBDataSet, UIB, UIBLib, JvComponent,
  Variants, mydbUnit, FBCustomDataSet, mdlModuleImportPHA,
  mdlProjet, DateUtils, IniFiles, mdlAttente, mdlTypes, XMLIntf, StrUtils, Generics.Collections,
  Contnrs, mdlMIPostgreSQLPHA;

type
  TdmLgo2PHA = class(TdmMIPostgreSQLPHA, IRequeteur)
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Déclarations privées }
    FHistorique : THashedStringList;
  public
    { Déclarations publiques }
    property Historique : THashedStringList read FHistorique;
    procedure SupprimerDonnees(ADonneesASupprimer : TList<Integer>); override;
    function CreerDocument(AIDClient: Integer; ALibelle : string; AFichier: string): TResultatCreationDonnees;
  end;
var
  dmLgo2PHA : TdmLgo2PHA;

implementation

{$R *.dfm}

procedure TdmLgo2PHA.DataModuleCreate(Sender: TObject);
begin
 inherited;

 dmLgo2PHA := Self;
 FHistorique := THashedStringList.Create;
end;

procedure TdmLgo2PHA.DataModuleDestroy(Sender: TObject);
begin
  inherited;

  if Assigned(FHistorique) then FreeAndNil(FHistorique);
end;

procedure TdmLgo2PHA.SupprimerDonnees(
  ADonneesASupprimer: TList<Integer>);
var i : integer;
begin
  // Remplacement de la procédure de suppression des encours
  i := ADonneesASupprimer.IndexOf(Ord(suppEncours));
  if i <> -1 then ADonneesASupprimer[i] := 101;

  if ADonneesASupprimer.IndexOf(Ord(suppClients)) <> -1 then ADonneesASupprimer.Add(103);
  if ADonneesASupprimer.IndexOf(Ord(suppProduits)) <> -1 then ADonneesASupprimer.Add(104);
  if ADonneesASupprimer.IndexOf(Ord(suppParametre)) <> -1 then ADonneesASupprimer.Add(102);

  inherited;
end;

function TdmLgo2PHA.CreerDocument(AIDClient: Integer;
  ALibelle : string; AFichier: string): TResultatCreationDonnees;
begin
  Result := ExecuterPS('SCANS', 'PS_LGO2_CREER_DOCUMENT', VarArrayOf([AIDClient, ALibelle, AFichier]));
end;

end.


