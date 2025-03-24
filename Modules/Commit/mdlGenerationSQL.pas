unit mdlGenerationSQL;

interface

uses

  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, ValEdit, StdCtrls, uib,
  mdlDialogue, UIBMetadata, mdlPIStringGrid, mdlProjet,
  ExtCtrls, JvExExtCtrls, JvRadioGroup;

type
  TParametresGenerationSQL = record
    Action : Integer;
    Table : string;
    Cle : string;
    ValeurCle : string;
    Valeurs : array of record
      Champs : string;
      Valeur : string;
    end;
  end;

  TfrmGenerationSQL = class(TfrmDialogue)
    gbxTableMAJ: TGroupBox;
    lblTable: TLabel;
    cbxTable: TComboBox;
    lblCle: TLabel;
    cbxCle: TComboBox;
    grdChampsMAJ: TPIStringGrid;
    btnValider: TButton;
    btnAnnuler: TButton;
    lblValeurCle: TLabel;
    cbxValeurCle: TComboBox;
    rdgAction: TJvRadioGroup;
    procedure cbxTableChange(Sender: TObject);
    procedure cbxCleChange(Sender: TObject);
    procedure rdgActionClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Déclarations privées }
    FMetaDonnees : TMetaDataBase;
  public
    { Déclarations publiques }
    function ShowModal(var AParametresSQL : TParametresGenerationSQL) : Integer; reintroduce;
    constructor Create(AOwner : TComponent; AProjet : TProjet; AListeAttributs : TStrings); reintroduce;
  end;

const
  C_ACTION_INSERT = 0;
  C_ACTION_UPDATE = 1;
  C_ACTION_DELETE = 2;

var
  frmGenerationSQL: TfrmGenerationSQL;

implementation

{$R *.dfm}

const
  C_COLONNE_CHAMPS = 1;
  C_COLONNE_VALEUR = 2;

  C_VALEUR_NULLE = '<NULL>';

procedure TfrmGenerationSQL.cbxTableChange(Sender: TObject);
var
  i : Integer;
begin
  inherited;

  if cbxTable.ItemIndex = -1 then exit;
  cbxCle.Clear;
  grdChampsMAJ.RowCount := 2;
  for i := 0 to FMetaDonnees.Tables[cbxTable.ItemIndex].FieldsCount - 1 do
  begin
    cbxCle.AddItem(FMetaDonnees.Tables[cbxTable.ItemIndex].Fields[i].Name, nil);

    with grdChampsMAJ do
    begin
      Cells[C_COLONNE_CHAMPS, RowCount - 1] := FMetaDonnees.Tables[cbxTable.ItemIndex].Fields[i].Name;
      Cells[C_COLONNE_VALEUR, RowCount - 1] := '';

      RowCount := RowCount + 1;
    end;
  end;
  grdChampsMAJ.RowCount := grdChampsMAJ.RowCount - 1;
    
  if rdgAction.ItemIndex <> C_ACTION_INSERT then
  begin
    cbxCle.Enabled := True; lblCle.Font.Color := clWindowText;
    cbxValeurCle.Enabled := True; lblValeurCle.Font.Color := clWindowText;
    cbxCleChange(Sender);
  end
  else
    grdChampsMAJ.Enabled := True;

  if rdgAction.ItemIndex = C_ACTION_DELETE then
    grdChampsMAJ.Enabled := false;

end;

constructor TfrmGenerationSQL.Create(AOwner: TComponent; AProjet: TProjet;
  AListeAttributs: TStrings);
begin
  inherited Create(AOwner, AProjet);

  if AListeAttributs.Count = 0 then
  begin
    MessageDlg('Impossible de générer un script SQL sans valeur !', mtWarning, [mbOk], 0);
    raise Exception.Create('Impossible de générer un script SQL sans valeur, executez une requete')
  end
  else
  begin
    cbxValeurCle.Items.AddStrings(AListeAttributs);

    grdChampsMAJ.Colonnes[C_COLONNE_VALEUR].OptionsControle.ComboBox.Liste.AddStrings(AListeAttributs);
    grdChampsMAJ.Colonnes[C_COLONNE_VALEUR].OptionsControle.ComboBox.Liste.Add(C_VALEUR_NULLE);
  end;
end;

procedure TfrmGenerationSQL.FormCreate(Sender: TObject);
var
  i : Integer;
begin
  inherited;

  FMetaDonnees := TMetaDataBase(Projet.PHAConnexion.GetMetadata());

  cbxTable.Clear;
  for i := 0 to FMetaDonnees.TablesCount - 1 do
    cbxTable.AddItem(FMetaDonnees.Tables[i].Name, nil);
end;

procedure TfrmGenerationSQL.rdgActionClick(Sender: TObject);
begin
  inherited;

  if rdgAction.ItemIndex = C_ACTION_INSERT then
  begin
    grdChampsMAJ.Visible := true;
    cbxCle.Visible := false;
    cbxValeurCle.Visible := false;
  end;

  if rdgAction.ItemIndex = C_ACTION_UPDATE then
  begin
    grdChampsMAJ.Visible := true;
    cbxCle.Visible := true;
    cbxValeurCle.Visible := true;
  end;

  if rdgAction.ItemIndex = C_ACTION_DELETE then
  begin
    grdChampsMAJ.Visible := false;
    cbxCle.Visible := true;
    cbxValeurCle.Visible := true;
  end;

end;

procedure TfrmGenerationSQL.cbxCleChange(Sender: TObject);
begin
  inherited;

  grdChampsMAJ.Enabled := (cbxCle.Text <> '') and (rdgAction.ItemIndex <> C_ACTION_DELETE);
end;

function TfrmGenerationSQL.ShowModal(
  var AParametresSQL: TParametresGenerationSQL): Integer;
var
  i, lIntMaxCol : Integer;

  procedure AnnulerGenerationScript;
  begin
    MessageDlg('Impossible de générer un script SQL sans valeur !', mtWarning, [mbOk], 0);
    Result := mrNone;
  end;

begin
  Result := inherited ShowModal;

  if Result = mrOk then
    if ((rdgAction.ItemIndex <> C_ACTION_INSERT) and (cbxTable.Text <> '') and (cbxCle.Text <> '') and (cbxValeurCle.Text <> '')) or
       ((rdgAction.ItemIndex = C_ACTION_INSERT) and (cbxTable.Text <> '')) then
      with AParametresSQL do
      begin
        Action := rdgAction.ItemIndex;
        Table := cbxTable.Text;
        Cle := cbxCle.Text;
        ValeurCle := cbxValeurCle.Text;

        lIntMaxCol := 0; SetLength(AParametresSQL.Valeurs, grdChampsMAJ.RowCount);
        for i := 1 to grdChampsMAJ.RowCount - 1 do
        begin
          AParametresSQL.Valeurs[i - 1].Champs := grdChampsMAJ.Cells[C_COLONNE_CHAMPS, i];
          AParametresSQL.Valeurs[i - 1].Valeur := grdChampsMAJ.Cells[C_COLONNE_VALEUR, i];

          if grdChampsMAJ.Cells[C_COLONNE_VALEUR, i] <> '' then
            Inc(lIntMaxCol);
        end;

        if (lIntMaxCol = 0) and (rdgAction.ItemIndex <> C_ACTION_DELETE) then
          AnnulerGenerationScript;
      end
    else
      AnnulerGenerationScript
end;

end.
