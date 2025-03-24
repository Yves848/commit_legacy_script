unit mdlMIPI;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, 
  Dialogs, mdlProjet, mdlModule, mdlModuleImport, DB, ActnList, ImgList, PdfDoc, PReport,
  Menus, JvMenus, ExtCtrls, mdlPIPanel, JvXPBar, JvXPCore, JvXPContainer,
  JvWizard, JvWizardRouteMapNodes, ComCtrls, Grids, mdlPIStringGrid, DBGrids,
  mdlPIDBGrid, JvExControls, mdlPIDataSet, MidasLib, StdCtrls, VirtualTrees,
  JvExExtCtrls, JvNetscapeSplitter;

type
  TfrMIPI = class(TfrModuleImport)
  private
    { Déclarations privées }
  protected
    function FaireTraitementDonnees(ADonnees: TPIChamps): TResultatCreationDonnees; overload; virtual;
    procedure TraiterDonnee(ATraitement : TTraitement); override;
  public
    { Déclarations publiques }
  end;

implementation

uses mdlMIPIPHA;

{$R *.dfm}

{ TfrMIPI }

function TfrMIPI.FaireTraitementDonnees(
  ADonnees: TPIChamps): TResultatCreationDonnees;
var
  i : Integer;
  v : Variant;
begin
  v := VarArrayCreate([0, ADonnees.Count - 1], varVariant);
  for i := 0 to ADonnees.Count - 1 do
    v[i] := ADonnees[i].Valeur;

  with TTraitementBD(TraitementEnCours) do
    Result := PHA.ExecuterPS(Fichier, ProcedureCreation, v);
end;

procedure TfrMIPI.TraiterDonnee(ATraitement: TTraitement);
begin
  if not Annulation and FConnecte and (TTraitementBD(ATraitement).RequeteSelection <> '') then
  begin
    TraitementEnCours := ATraitement;
    TraitementEnCours.Fait := False;

    with dmMIPIPHA.qryPI do
    begin
      try
        Ouvrir;
        while not Eof and not Annulation do
        begin
          FResultat := FaireTraitementDonnees(Champs);
          case FResultat of
            rcdImportee : TraitementEnCours.Succes := TraitementEnCours.Succes + 1;
            rcdAvertissement : TraitementEnCours.Avertissements := TraitementEnCours.Avertissements + 1;
            rcdRejetee : TraitementEnCours.Rejets := TraitementEnCours.Rejets + 1;
            rcdErreur : TraitementEnCours.Erreurs := TraitementEnCours.Erreurs + 1;
          else
            Abort;
          end;

          if EnregNo mod 20000 = 0 then
            PHA.DePreparerCreationDonnees(True);

          Suivant;
        end;
      except
        on E:Exception do
        begin
          Module.Projet.Console.AjouterLigne(ATraitement.Fichier + ' : ' + E.Message);
          FResultat := rcdErreurSysteme;
        end;
      end;

      PHA.DePreparerCreationDonnees(FResultat <> rcdErreurSysteme);
      if Ouvert then Fermer;
      if Assigned(TraitementEnCours) then TraitementEnCours.Fait := (FResultat <> rcdErreurSysteme) and not Annulation;
    end;
  end
  else
    inherited;
end;

end.
