unit mdlOpusConfiguration;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, 
  Dialogs, mdlConfiguration, StdCtrls, ExtCtrls, mdlModule, mdlProjet, xmlintf,
  Spin;

type
  TfrOpusConfiguration = class(TfrConfiguration)
    grbCartefi: TGroupBox;
    cbxCarteFi: TCheckBox;
    Label1: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    cbxTypeAvantage: TComboBox;
    cbxTypeObjectif: TComboBox;
    spnValeurAvantage: TSpinEdit;
    spnValeurObjectif: TSpinEdit;
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
    constructor Create(Aowner : TComponent; AModule : TModule); override;
    procedure Enregistrer; override;
    procedure Initialiser(AOptions : IXMLNode); override;
  end;

implementation

{$R *.dfm}

constructor TfrOpusConfiguration.Create(Aowner: TComponent; AModule: TModule);
begin
  inherited;

  with Projet.FichierProjet.DocumentElement.ChildNodes['modules'].ChildNodes['import'].ChildNodes['options'] do
  begin
    if HasAttribute('carte_avantage') then cbxCarteFi.Checked := Attributes['carte_avantage'];
    if HasAttribute('cf_type_avantage') then cbxTypeAvantage.ItemIndex := Attributes['cf_type_avantage']-1;
    if HasAttribute('cf_type_objectif') then cbxTypeObjectif.ItemIndex := Attributes['cf_type_objectif']-1;
    if HasAttribute('cf_valeur_avantage') then spnValeurAvantage.Value := Attributes['cf_valeur_avantage'];
    if HasAttribute('cf_valeur_objectif') then spnValeurObjectif.Value := Attributes['cf_valeur_objectif'];

  end;
end;

procedure TfrOpusConfiguration.Enregistrer;
begin
  inherited;

  with Projet.FichierProjet.DocumentElement.ChildNodes['modules'].ChildNodes['import'].ChildNodes['options'] do
  begin
    Attributes['carte_avantage'] := cbxCarteFi.Checked;
    Attributes['cf_type_avantage'] := cbxTypeAvantage.ItemIndex+1;
    Attributes['cf_type_objectif'] := cbxTypeObjectif.ItemIndex+1;
    Attributes['cf_valeur_avantage'] := spnValeurAvantage.Value;
    Attributes['cf_valeur_objectif'] := spnValeurObjectif.Value;
  end;
end;

procedure TfrOpusConfiguration.Initialiser(AOptions: IXMLNode);
begin
  inherited;

end;

end.
