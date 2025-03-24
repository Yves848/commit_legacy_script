unit mdlTransfertLGPIConfiguration;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, mdlConfiguration, StdCtrls, ExtCtrls, mdlProjet, XMLIntf, DBCtrls, DB,
  uibdataset, uib, dblookup;

type
  TfrTransfertLGPIConfiguration = class(TfrConfiguration)
    grdFusion: TGroupBox;
    chkPraticiensNonReconnus: TCheckBox;
    bvlPraticiens: TBevel;
    chkFusionStock: TCheckBox;
    lblPraticiens: TLabel;
    lblProduits: TLabel;
    Bevel1: TBevel;
    chkHopitauxNonReconnus: TCheckBox;
    GroupBox1: TGroupBox;
    Bevel2: TBevel;
    lblProduit140: TLabel;
	chkStup: TCheckBox;
    chkPrix: TCheckBox;
    lblCritere: TLabel;
    Bevel3: TBevel;
    Transaction_prog_rel: TUIBTransaction;
    ComboBox_prog_rel: TComboBox;
    qLibellesProgRel: TUIBQuery;
  private
    { Déclarations privées }
    procedure remplir_combo;
  public
    { Déclarations publiques }
    constructor Create(AOwner : TComponent; AModule : TModule); override;
    procedure Enregistrer; override;
    procedure Initialiser(AOptions : IXMLNode); override;
  end;

implementation

{$R *.dfm}

{ TfrLGPIConfiguration }

procedure TfrTransfertLGPIConfiguration.remplir_combo;
begin
    qLibellesProgRel.DataBase := Projet.PHAConnexion;
    qLibellesProgRel.Transaction := Transaction_prog_rel;
    qLibellesProgRel.Open;
    ComboBox_prog_rel.Items.Clear;
    qLibellesProgRel.First;
    while not qLibellesProgRel.eof do
    begin
      ComboBox_prog_rel.Items.Add(qLibellesProgRel.Fields.AsString[1]);
      qLibellesProgRel.Next;
    end;
    ComboBox_prog_rel.ItemIndex := 0;
    qLibellesProgRel.Close;

end;

constructor TfrTransfertLGPIConfiguration.Create(AOwner: TComponent;
  AModule: TModule);
begin
  inherited;


  Transaction_prog_rel.DataBase := Projet.PHAConnexion;
  remplir_combo;

  with Projet.FichierProjet.DocumentElement.ChildNodes['modules'].ChildNodes['transfert'] do
  begin
    with ChildNodes['options'].ChildNodes['fusion'] do
    begin
      if HasAttribute('creation_hopitaux_non_reconnus') then chkHopitauxNonReconnus.State := TCheckBoxState(StrToInt(Attributes['creation_hopitaux_non_reconnus'])) else chkHopitauxNonReconnus.Checked := False;
      if HasAttribute('creation_praticiens_non_reconnus') then chkPraticiensNonReconnus.State := TCheckBoxState(StrToInt(Attributes['creation_praticiens_non_reconnus'])) else chkPraticiensNonReconnus.Checked := False;
      if HasAttribute('fusion_stock') then chkFusionStock.State := TCheckBoxState(StrToInt(Attributes['fusion_stock'])) else chkFusionStock.Checked := False;
      if HasAttribute('ecraser_prix') then chkPrix.State := TCheckBoxState(StrToInt(Attributes['ecraser_prix'])) else chkPrix.Checked := False;
    end;
    with ChildNodes['options'].ChildNodes['sv140'] do
    begin
      if HasAttribute('deconditionnement_stup') then chkStup.State := TCheckBoxState(StrToInt(Attributes['deconditionnement_stup'])) else chkStup.Checked := true;
    end;
    with ChildNodes['options'] do
      if HasAttribute('programme_relationnel') then ComboBox_prog_rel.ItemIndex := StrToInt(Attributes['programme_relationnel']);
  end;

end;

procedure TfrTransfertLGPIConfiguration.Enregistrer;
begin
  inherited;

  with Projet.FichierProjet.DocumentElement.ChildNodes['modules'].ChildNodes['transfert'] do
  begin
    with ChildNodes['options'].ChildNodes['fusion'] do
    begin
      Attributes['creation_hopitaux_non_reconnus'] := chkHopitauxNonReconnus.State;
      Attributes['creation_praticiens_non_reconnus'] := chkPraticiensNonReconnus.State;
      Attributes['fusion_stock'] := chkFusionStock.State;
      Attributes['ecraser_prix'] := chkPrix.State;
    end;
    with ChildNodes['options'].ChildNodes['sv140'] do
    begin
      Attributes['deconditionnement_stup'] := chkStup.State;
    end;
    with ChildNodes['options'] do
      Attributes['programme_relationnel'] := IntToStr(ComboBox_prog_rel.ItemIndex);
  end;
end;

procedure TfrTransfertLGPIConfiguration.Initialiser(AOptions: IXMLNode);
begin
  inherited;

  with Projet.FichierProjet.DocumentElement.ChildNodes['modules'].ChildNodes['transfert'] do
  begin
    with ChildNodes['options'].ChildNodes['fusion'] do
    begin
      Attributes['creation_hopitaux_non_reconnus'] := '0';
      Attributes['creation_praticiens_non_reconnus'] := '0';
      Attributes['fusion_stock'] := '0';
      Attributes['ecraser_prix'] := '0';
    end;
    with ChildNodes['options'].ChildNodes['sv140'] do
    begin
      Attributes['deconditionnement_stup'] := '0';
    end;
    with ChildNodes['options'] do
       Attributes['programme_relationnel'] :='0';
  end;
end;

end.

