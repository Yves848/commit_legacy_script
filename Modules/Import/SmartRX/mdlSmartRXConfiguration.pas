unit mdlSmartRXConfiguration;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, mdlConfiguration, mdlProjet, Mask, JvExMask, JvSpin,
  Grids, mdlPIStringGrid, StrUtils, XMLIntf, Buttons, Spin,mdlModule;

type
  TfrSmartRXConfiguration = class(TfrConfiguration)
    gbxMasquesIdNat: TGroupBox;
    grdDestinataires: TPIStringGrid;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    gbxCarteFi: TGroupBox;
    cbxAvantage: TComboBox;
    cbxCarteFi: TCheckBox;
    cbxDeclencheur: TComboBox;
    Label5: TLabel;
    Label6: TLabel;
    spnAvantage: TJvSpinEdit;
    spnDeclenchement: TJvSpinEdit;
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
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

const
  C_COLONNE_ID = 1;
  C_COLONNE_DESTINATAIRE = 2;
  C_COLONNE_DEBUT = 3;
  C_COLONNE_FIN = 4;

{ TfrSmartRXConfiguration }
constructor TfrSmartRXConfiguration.Create(Aowner: TComponent; AModule: TModule);
var
  lIntLigne : Integer;

  procedure AjouterDestinataire(AID, ANom : string);
  var
    lOptionDest : IXMLNode;
  begin
    with grdDestinataires,
         Projet.FichierProjet.DocumentElement.ChildNodes['modules'].ChildNodes['import'].ChildNodes['options'].ChildNodes['masque_identifiants_nationaux'].GetChildNodes do
    begin
      Cells[C_COLONNE_ID, lIntLigne] := AID;
      Cells[C_COLONNE_DESTINATAIRE, lIntLigne] := ANom;
      lOptionDest := FindNode(AID);
      if Assigned(lOptionDest) then
      begin
        Cells[C_COLONNE_DEBUT, lIntLigne] := lOptionDest.Attributes['debut'];
        Cells[C_COLONNE_FIN, lIntLigne] := lOptionDest.Attributes['fin'];
      end
      else
      begin
        Cells[C_COLONNE_DEBUT, lIntLigne] := '1';
        Cells[C_COLONNE_FIN, lIntLigne] := '16';
      end;
      RowCount := lIntLigne + 1;
    end;
  end;

begin
  inherited;

  with Projet.FichierProjet.DocumentElement.ChildNodes['modules'].ChildNodes['import'] do
  begin

    with ChildNodes['options'].ChildNodes['carte_fidelite'] do
    begin
      if HasAttribute('creation') then cbxCarteFi.Checked := strtobool(Attributes['creation']);
      if HasAttribute('avantage') then spnAvantage.Value := Attributes['avantage'];
      if HasAttribute('objectif') then spnDeclenchement.Value := Attributes['objectif'];
      if HasAttribute('type_avantage') then cbxAvantage.ItemIndex := Attributes['type_avantage'];
      if HasAttribute('type_objectif') then cbxDeclencheur.ItemIndex := Attributes['type_objectif'];
    end;

  // TODO : ajouter  un destinataire quand le fichier existera

 {   if FileExists(Projet.RepertoireProjet + 'A_FZDES.D') then
      with TFichierSmartRX.Create(Projet.RepertoireProjet + 'A_FZDES.D') do
      begin
        lIntLigne := 1;
        repeat
          Suivant;
          if ( not TFZDES(Donnees).Supprime )  and ( TFZDES(Donnees).DestinataireID <> 0 )  then
          begin
            AjouterDestinataire('_' + FloatToStr(TFZDES(Donnees).DestinataireID), TFZDES(Donnees).Nom);
            Inc(lIntLigne);
          end;
        until EOF;
        Free;
      end;
    //if HasAttribute('cadrage_auto') then cbCadrageAuto.Checked  := strtobool(Attributes['cadrage_auto'])  else cbCadrageAuto.Checked := C_CADRAGE_AUTO;
    AjouterDestinataire('_0', 'Pas de destinataire');
    }
  end;
end;

procedure TfrSmartRXConfiguration.Enregistrer;
var
  i : Integer;
begin
  inherited;

  with Projet.FichierProjet.DocumentElement.ChildNodes['modules'].ChildNodes['import']  do
  begin

    with ChildNodes['options'].ChildNodes['carte_fidelite'] do
    begin
      Attributes['creation'] := booltostr(cbxCarteFi.Checked);
      Attributes['avantage'] := spnAvantage.Value;
      Attributes['objectif'] := spnDeclenchement.Value;
      Attributes['type_avantage'] := cbxAvantage.ItemIndex;
      Attributes['type_objectif'] := cbxDeclencheur.ItemIndex;
    end;

// TODO : regarder purquoi option id vendeur  ou code vendeur
//AF23    Attributes['code_operateur'] := cbxCodeOperateur.ItemIndex;

    

    for i := 1 to grdDestinataires.RowCount - 1 do
      try
        with ChildNodes['masque_identifiants_nationaux'].ChildNodes[grdDestinataires.Cells[C_COLONNE_ID, i]] do
        begin
          Attributes['debut'] := trim(grdDestinataires.Cells[C_COLONNE_DEBUT, i]);
          Attributes['fin'] := trim(grdDestinataires.Cells[C_COLONNE_FIN, i]);
        end;
      except
        //
      end;
      //Attributes['cadrage_auto'] := BoolToStr(cbcadrageauto.Checked);
  end;
end;

procedure TfrSmartRXConfiguration.Initialiser(AOptions : IXMLNode);
begin
  inherited;

  AOptions.ChildNodes['masque_identifiants_nationaux'].ChildNodes['_0'].Attributes['debut'] := 1;
  AOptions.ChildNodes['masque_identifiants_nationaux'].ChildNodes['_0'].Attributes['fin'] := 16;
end;

procedure TfrSmartRXConfiguration.SpeedButton1Click(Sender: TObject);
begin
  inherited;
  Showmessage( 'début=1,  fin vide : 8 derniers caractères'+sLineBreak+'début vide, fin=16 : 8 premiers caractères'+sLineBreak+'début vide, fin vide : Automatique ( expérimental !)'  )

end;

procedure TfrSmartRXConfiguration.SpeedButton2Click(Sender: TObject);
var i : integer;
begin
  inherited;
  for i := 1 to grdDestinataires.RowCount - 1 do
      try
        with grdDestinataires do
        begin
          Cells[C_COLONNE_DEBUT, i] := '';
          Cells[C_COLONNE_FIN, i] := '';
        end;
      except
        //
      end;
end;

procedure TfrSmartRXConfiguration.SpeedButton3Click(Sender: TObject);
var i : integer;
begin
  inherited;
  for i := 1 to grdDestinataires.RowCount - 1 do
      try
        with grdDestinataires do
        begin
          Cells[C_COLONNE_DEBUT, i] := '1';
          Cells[C_COLONNE_FIN, i] := '16';
        end;
      except
        //
      end;
end;


end.
