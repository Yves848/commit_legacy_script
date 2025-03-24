unit mdlNEVPHA;

interface

uses
  SysUtils, Classes, DB, mdlPHA, Dialogs, UIBDataSet, UIB, UIBLib, JvComponent,
  Variants, mydbUnit, FBCustomDataSet, mdlModuleImportPHA,
  mdlProjet, DateUtils, IniFiles, mdlAttente, mdlTypes, XMLIntf, StrUtils, Generics.Collections,
  Contnrs, mdlMIPostgreSQLPHA;

type
  TdmNEVPHA = class(TdmMIPostgreSQLPHA, IRequeteur)
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
   function CreerCartefi(): TResultatCreationDonnees;
  end;
var
  dmNEVPHA : TdmNEVPHA;

implementation

{$R *.dfm}

procedure TdmNEVPHA.DataModuleCreate(Sender: TObject);
begin
 inherited;

 dmNEVPHA := Self;
 FHistorique := THashedStringList.Create;
end;

procedure TdmNEVPHA.DataModuleDestroy(Sender: TObject);
begin
  inherited;

  if Assigned(FHistorique) then FreeAndNil(FHistorique);
end;

function TdmNEVPHA.CreerCartefi(
 ): TResultatCreationDonnees;
 var type_objectif, objectif, type_avantage, avantage : integer ;
begin

  with module.Projet.FichierProjet.DocumentElement.ChildNodes['modules'].ChildNodes['import'].ChildNodes['options'].ChildNodes['carte_fidelite'] do
    if HasAttribute('carte_fidelite') then
    begin
       showmessage(Attributes['creation']);
      if (Attributes['creation']) = 'true' then
      begin
        type_objectif := Attributes['type_objectif'];
        objectif := Attributes['objectif'];
        type_avantage := Attributes['type_avantage'];
        avantage := Attributes['avantage'];
        Result := ExecuterPS('Programme fidelite', 'PS_NEV_CREER_CF2',
                            Vararrayof([type_objectif,
                                        objectif,
                                        type_avantage,
                                        avantage])) ;
      end
      else
        Result := rcdRejetee;
    end;

end;

procedure TdmNEVPHA.SupprimerDonnees(
  ADonneesASupprimer: TList<Integer>);
var i : integer;
begin
  if(ADonneesASupprimer.IndexOf(Ord(suppEncours))) <> -1 then ADonneesASupprimer.Add(101);
  if ADonneesASupprimer.IndexOf(Ord(suppClients)) <> -1 then ADonneesASupprimer.Add(103);
  if ADonneesASupprimer.IndexOf(Ord(suppProduits)) <> -1 then ADonneesASupprimer.Add(104);
  if ADonneesASupprimer.IndexOf(Ord(suppParametre)) <> -1 then ADonneesASupprimer.Add(102);

  inherited;
end;

function TdmNEVPHA.CreerDocument(AIDClient: Integer;
  ALibelle : string; AFichier: string): TResultatCreationDonnees;
begin
  Result := ExecuterPS('SCANS', 'PS_NEV_CREER_DOCUMENT', VarArrayOf([AIDClient, ALibelle, AFichier]));
end;

end.


