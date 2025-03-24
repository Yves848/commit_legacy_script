unit mdlSmartRXPHA;

interface

uses
  SysUtils, Classes, DB, mdlPHA, Dialogs, UIBDataSet, UIB, UIBLib, JvComponent,
  Variants, mydbUnit, FBCustomDataSet, mdlModuleImportPHA,
  mdlProjet, DateUtils, IniFiles, mdlAttente, mdlTypes, XMLIntf, StrUtils, Generics.Collections,
  Contnrs, mdlMIPostgreSQLPHA;

type
  TdmSmartRXPHA = class(TdmMIPostgreSQLPHA, IRequeteur)
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
  dmSmartRXPHA : TdmSmartRXPHA;

implementation

{$R *.dfm}

procedure TdmSmartRXPHA.DataModuleCreate(Sender: TObject);
begin
 inherited;

 dmSmartRXPHA := Self;
 FHistorique := THashedStringList.Create;
end;

procedure TdmSmartRXPHA.DataModuleDestroy(Sender: TObject);
begin
  inherited;

  if Assigned(FHistorique) then FreeAndNil(FHistorique);
end;

function TdmSmartRXPHA.CreerCartefi(
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
        Result := ExecuterPS('Programme fidelite', 'PS_SMARTRX_CREER_CF2',
                            Vararrayof([type_objectif,
                                        objectif,
                                        type_avantage,
                                        avantage])) ;
      end
      else
        Result := rcdRejetee;
    end;

end;

procedure TdmSmartRXPHA.SupprimerDonnees(
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

function TdmSmartRXPHA.CreerDocument(AIDClient: Integer;
  ALibelle : string; AFichier: string): TResultatCreationDonnees;
begin
  Result := ExecuterPS('SCANS', 'PS_SMARTRX_CREER_DOCUMENT', VarArrayOf([AIDClient, ALibelle, AFichier]));
end;

end.


