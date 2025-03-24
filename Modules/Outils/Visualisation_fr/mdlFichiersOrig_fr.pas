unit mdlFichiersOrig_fr;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, mdlPIStringGrid, JvXPBar, JvExControls, JvXPCore,
  JvXPContainer, uib, mdlDialogue, ActnList, ImgList, mdlLectureFichierBinaire,
  StdCtrls, mdlModuleImport, StrUtils, Math, Buttons, mdlPISpeedButton,
  ExtCtrls, Generics.Collections, Rtti, TypInfo, mdlTypes, JclFileUtils;

type
  TfrmFichiersOrig = class(TfrmDialogue)
    qry: TUIBQuery;
    trErreurs: TUIBTransaction;
    grdDonneesImport: TPIStringGrid;
    JvXPContainer1: TJvXPContainer;
    JvXPContainer2: TJvXPContainer;
    pnlOutils: TPanel;
    xpbRecherche: TJvXPBar;
    pnlRecherche: TPanel;
    btnChercher: TPISpeedButton;
    chkFiltrage: TCheckBox;
    cbxAttributs: TComboBox;
    edtRecherche: TEdit;
    xpbInformations: TJvXPBar;
    sd: TSaveDialog;
    xpbExport: TJvXPBar;
    Panel1: TPanel;
    xpbEntetes: TJvXPBar;
    sbxFichierOrigines: TScrollBox;
    xpbFichiersOrigines: TJvXPBar;
    chkInversion: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure edtRechercheKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnChercherClick(Sender: TObject);
    procedure xpBTitreMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure xpbExportItemClick(Sender: TObject; Item: TJvXPBarItem);
  private
    { Déclarations privées }
    FItem : TJvXPBarItem;
    procedure AfficherFichier;
  public
    { Déclarations publiques }
  end;

var
  frmFichiersOrig: TfrmFichiersOrig;

implementation

uses mdlGenerationSQL;

const
  C_EXPORT_FICHIER_CSV = 0;
  C_EXPORT_GENERATION_SQL = 1;

{$R *.dfm}

procedure TfrmFichiersOrig.FormCreate(Sender: TObject);

  procedure AjouterItem(AParent : TJvXPBar);
  begin
    with AParent.Items.Add do
    begin
      Caption := qry.Fields.ByNameAsString['NOM'];
      Enabled := FileExists(Projet.RepertoireProjet + '\' + Caption);
      hint := qry.Fields.ByNameAsString['LIBELLE'];
      Tag := qry.Fields.ByNameAsInteger['T_FCT_FICHIER_ID'];
    end;
  end;

begin
  inherited;

  if not Projet.PHAConnexion.Connected then
    raise Exception.Create('Non-connecté à la base locale')
  else
  begin
    trErreurs.DataBase := Projet.PHAConnexion;
    qry.DataBase := Projet.PHAConnexion;

    trErreurs.StartTransaction;
    with qry do
    begin
      SQL.Clear;
      SQL.Add('select t_fct_fichier_id, nom, type_fichier , libelle ');
      SQL.Add('from v_fichier');
      SQL.Add('where substring(type_fichier from 2 for 1) not in (2, 3)');
      Open;

      while not Eof do
      begin
        if (Fields.ByNameAsString['TYPE_FICHIER'][1] <> '2') and (Fields.ByNameAsString['TYPE_FICHIER'][2] <> '2') then
          AjouterItem(xpbFichiersOrigines);

        Next;
      end;

      Close(etmStayIn);
    end;
  end;

  with xpbFichiersOrigines do
    sbxFichierOrigines.VertScrollBar.Range :=ItemHeight * Items.Count + 5  ;
end;

procedure TfrmFichiersOrig.edtRechercheKeyDown(
  Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;

  if Key = VK_RETURN then
    btnChercher.Click;
end;

procedure TfrmFichiersOrig.btnChercherClick(
  Sender: TObject);
var
  f : string;
begin
  inherited;

  if chkFiltrage.Checked then
  begin
    if Assigned(FItem) then
    begin
      if cbxAttributs.Text = '' then
        FItem.Tag := -1
      else
        FItem.Tag := grdDonneesImport.ColonneParNom(cbxAttributs.Text).Index;
      f := cbxAttributs.Text;
      AfficherFichier;
      cbxAttributs.Text := f;
    end;
  end
  else
    if cbxAttributs.Text = '' then
      grdDonneesImport.ChercherChaine(edtRecherche.Text)
    else
      grdDonneesImport.ChercherChaine(edtRecherche.Text, grdDonneesImport.ColonneParNom(cbxAttributs.Text).Index);
end;

procedure TfrmFichiersOrig.xpBTitreMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  lIntDistance : Integer;
begin
  inherited;

  lIntDistance := Y - xpbFichiersOrigines.HeaderHeight;
  if lIntDistance > 0 then
  begin
    with xpbFichiersOrigines do
      FItem := Items[lIntDistance div xpbFichiersOrigines.ItemHeight];

    if Assigned(FItem) then
      AfficherFichier;
  end;
end;

procedure TfrmFichiersOrig.xpbExportItemClick(Sender: TObject;
  Item: TJvXPBarItem);
const
  C_ACTION_SQL_MOT_CLE : array[0..2] of string = ('insert into %s (', 'update %s set ', 'delete from %s ');
  C_ACTION_SQL_VALEUR = '%s = ' + '' + '%s' + '';
  C_ACTION_SQL_WHERE = 'where ' + C_ACTION_SQL_VALEUR;
var
  lParametresSQL : TParametresGenerationSQL;
  lColonneCle : TColonne; laColonnes : array of TColonne;
  FSQL : TextFile;
  lStrBuffer : string;
  i, j, lIntMaxCol : Integer;
begin
  inherited;

  case Item.Index of
    C_EXPORT_FICHIER_CSV :
      begin
        sd.FileName := '';
        sd.FilterIndex := 1;
        if sd.Execute then
          grdDonneesImport.SauverVersCSV(sd.FileName);
      end;

    C_EXPORT_GENERATION_SQL :
      if TfrmGenerationSQL.Create(Self, Projet, cbxAttributs.Items).ShowModal(lParametresSQL) = mrOk then
      begin
        sd.FileName := '';
        sd.FilterIndex := 2;
        if sd.Execute then
        begin
          lIntMaxCol := High(lParametresSQL.Valeurs);

          // Recherche des colonnes
          lColonneCle := grdDonneesImport.ColonneParNom(lParametresSQL.ValeurCle);

          SetLength(laColonnes, lIntMaxCol + 1);
          for j := 0 to lIntMaxCol do
            if lParametresSQL.Valeurs[j].Valeur <> '' then
              laColonnes[j] := grdDonneesImport.ColonneParNom(lParametresSQL.Valeurs[j].Valeur)
            else
              laColonnes[j] := nil;

          AssignFile(FSQL, sd.FileName);
          Rewrite(FSQL);

          // Génération du script
          for i := 1 to grdDonneesImport.RowCount - 1 do
          begin
            lStrBuffer := Format(C_ACTION_SQL_MOT_CLE[lParametresSQL.Action], [lParametresSQL.Table]);

            // Corps de la requete
            for j := 0 to High(lParametresSQL.Valeurs) do
              if lParametresSQL.Valeurs[j].Valeur <> '' then
                case lParametresSQL.Action of
                  C_ACTION_INSERT :
                    lStrBuffer := lStrBuffer + lParametresSQL.Valeurs[j].Champs + ', ';
                  C_ACTION_UPDATE :
                    if Assigned(laColonnes[j]) then
                      lStrBuffer := lStrBuffer + Format(C_ACTION_SQL_VALEUR, [lParametresSQL.Valeurs[j].Champs, QuotedStr(Trim(laColonnes[j].Valeur[i]))]) + ', '
                    else
                      lStrBuffer := lStrBuffer + Format(C_ACTION_SQL_VALEUR, [lParametresSQL.Valeurs[j].Champs, QuotedStr(Trim(IfThen(lParametresSQL.Valeurs[j].Valeur = '<NULL>', 'NULL', lParametresSQL.Valeurs[j].Valeur)))]) + ', ';
                end;

            // Fin de la requete
            case lParametresSQL.Action of
              C_ACTION_INSERT :
                begin
                  lStrBuffer[Length(lStrBuffer) - 1] := ')';
                  lStrBuffer := lStrBuffer + 'values(';
                  for j := 0 to High(lParametresSQL.Valeurs) do
                    if lParametresSQL.Valeurs[j].Valeur <> '' then
                      if Assigned(laColonnes[j]) then
                        lStrBuffer := lStrBuffer + '' + QuotedStr(Trim(laColonnes[j].Valeur[i])) + '' + ', '
                      else
                        lStrBuffer := lStrBuffer + '' + QuotedStr(Trim(IfThen(lParametresSQL.Valeurs[j].Valeur = '<NULL>', 'NULL', lParametresSQL.Valeurs[j].Valeur))) + '' + ', ';
                  lStrBuffer[Length(lStrBuffer) - 1] := ')'
                end;

              C_ACTION_UPDATE :
                begin
                  Delete(lStrBuffer, Length(lStrBuffer) - 1, 1);
                  lStrBuffer := lStrBuffer + Format(C_ACTION_SQL_WHERE, [lParametresSQL.Cle, QuotedStr(Trim(lColonneCle.Valeur[i]))]);
                end;

              C_ACTION_DELETE :
                begin
                  lStrBuffer := lStrBuffer + Format(C_ACTION_SQL_WHERE, [lParametresSQL.Cle, QuotedStr(Trim(lColonneCle.Valeur[i]))]);
                end;
            end;
            Writeln(FSQL, lStrBuffer + ';');
          end;

          CloseFile(FSQL);
        end;
      end;
  end;
end;

procedure TfrmFichiersOrig.AfficherFichier;
const
  C_NOM_FICHIER = 'Nom : %s';
  C_TAILLE_FICHIER = 'Taille : %u Ko';
  C_DATE_MODIFICATION = 'Date : %s';
  C_NOMBRE_ENREGISTREMENT = '%u enregistrements';

var
  lFichier : TFichierBinaire;
  i : Integer;
  lBoolOkPourAff : Boolean;
  c : Cardinal;
begin
  inherited;

  grdDonneesImport.Hide;
  lFichier := TfrModuleImport(Projet.ModuleImport.IHM).LectureFichierBinaire.Create(Projet.RepertoireProjet + FItem.Caption,
                                                                                    Pointer(Projet.FichierProjet.DocumentElement.ChildNodes['modules'].ChildNodes['import'].ChildNodes['options']));
  if Assigned(lFichier) then
  begin
    Caption := FItem.Caption +' : '+ FItem.Hint;
    pnlRecherche.Enabled := False;
    xpbExport.Items[C_EXPORT_FICHIER_CSV].Enabled := False;
    xpbExport.Items[C_EXPORT_GENERATION_SQL].Enabled := False;

    with lFichier, grdDonneesImport do
    begin
      // Renseignements
      xpbInformations.Items[0].Caption := Format(C_NOM_FICHIER, [FItem.Caption]);
      if NbEnreg > 0 then
      begin
        c := NbEnreg;
        c := Round(c * Donnees.TailleBloc / 1024);

        xpbInformations.Items[1].Caption := Format(C_TAILLE_FICHIER, [c]);
        xpbInformations.Items[3].Caption := Format(C_NOMBRE_ENREGISTREMENT, [NbEnreg]);
      end
      else
      begin
        xpbInformations.Items[1].Caption := Format(C_TAILLE_FICHIER, [FileGetSize(Fichier)]);
        xpbInformations.Items[3].Caption := Format(C_NOMBRE_ENREGISTREMENT, [-1]);
      end;
      xpbInformations.Items[2].Caption := Format(C_DATE_MODIFICATION, [FormatDateTime('DD/MM/YYYY', FileDateToDateTime(FileAge(Fichier)))]);

      // Init
      Colonnes.Clear;
      cbxAttributs.Clear; cbxAttributs.Items.Add('');
      Colonnes.Add.Indicateur := True;

      // Remplissage des lignes
      RowCount := 2;
      Rows[1].Clear;
      repeat
        Suivant;
        try
          with DonneesBrut do
          begin
            // Définition des colonnes
            if ((Colonnes.Count = 1) and (RowCount = 2)) then
              for i := 0 to Count - 1 do
                with Colonnes.Add do
                begin
                  Nom := Names[i];
                  Titre.Libelle := Nom;
                  cbxAttributs.Items.Add(Nom);
                end;

            for i := 0 to Count - 1 do
              Cells[i + 1, RowCount - 1] := ValueFromIndex[i];
          end;

          if chkFiltrage.Checked then
            if FItem.Tag = -1 then
              lBoolOkPourAff := Pos(edtRecherche.Text, Rows[RowCount - 1].Text) > 0
            else
              lBoolOkPourAff := Pos(edtRecherche.Text, Cells[FItem.Tag, RowCount - 1]) > 0
          else
            lBoolOkPourAff := True;

          if chkInversion.Checked then lBoolOkPourAff := not lBoolOkPourAff;

          if lBoolOkPourAff then
            RowCount := RowCount + 1;

        except
          on E:Exception do
            Projet.Console.AjouterLigne('Erreur de lecture du fichier : ' + E.Message);
        end;
      until EOF or (RowCount >= 100000);

      if RowCount > 2 then
        RowCount := RowCount - 1;
    end;
    xpbExport.Items[C_EXPORT_FICHIER_CSV].Enabled := True;
    xpbExport.Items[C_EXPORT_GENERATION_SQL].Enabled := True;
    pnlRecherche.Enabled := True;
    FreeAndNil(lFichier);
  end
  else
    pnlRecherche.Enabled := False;

  grdDonneesImport.Show;
end;

end.

