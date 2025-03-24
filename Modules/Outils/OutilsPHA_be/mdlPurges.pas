unit mdlPurges;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, mdlDialogue, DB, Grids, DBGrids, mdlPIDBGrid, StdCtrls,
  ExtCtrls, ComCtrls, ActnList, ImgList, ToolWin, uib, mdlAttente, mdlPHA, uibdataset,
  mdlUIBThread;

type
  TPageCourante = record
    Index : Integer;
    RadioGroup : TRadioGroup;
    Grille : TPIDBGrid;
    Total : TStaticText;
  end;

  TfrmPurges = class(TfrmDialogue)
    pCtlPurgeDonnees: TPageControl;
    tShPurgeClients: TTabSheet;
    tShPurgeProduits: TTabSheet;
    iLstPageControl: TImageList;
    rgPurgeClients: TRadioGroup;
    rgPurgeProduits: TRadioGroup;
    dsClients: TDataSource;
    dsProduits: TDataSource;
    tShPurgeOrganismes: TTabSheet;
    rgPurgeOrganismes: TRadioGroup;
    dsOrganismes: TDataSource;
    actPurger: TAction;
    actReset: TAction;
    grdPurgeOrganismes: TPIDBGrid;
    grdPurgeClients: TPIDBGrid;
    grdPurgeProduits: TPIDBGrid;
    tShPurgeHistoDeliv: TTabSheet;
    rgPurgeHistoriques: TRadioGroup;
    grdPurgeHistoriques: TPIDBGrid;
    dsHistoriques: TDataSource;
    lblTotalOrgAMCAPurger: TLabel;
    txtTotalOrganismesAPurger: TStaticText;
    lblTotalClientsAPurger: TLabel;
    txtTotalClientsAPurger: TStaticText;
    lblTotalHistoriquesAPurger: TLabel;
    txtTotalHistoriquesAPurger: TStaticText;
    lblTotalProduitsAPurger: TLabel;
    txtTotalProduitsAPurger: TStaticText;
    procedure rgPurgeClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure actPurgerExecute(Sender: TObject);
    procedure actResetExecute(Sender: TObject);
    procedure actImprimerExecute(Sender: TObject);
    procedure pCtlPurgeDonneesChanging(Sender: TObject;
      var AllowChange: Boolean);
  private
    { Déclarations privées }
    FParametresPages : array of TPageCourante;
    procedure ResetEtatPurge;
  public
    { Déclarations publiques }
  end;

const
  C_PAGE_PURGE_ORGANISMES = 0;
  C_PAGE_PURGE_CLIENTS = 1;
  C_PAGE_PURGE_PRODUITS = 2;
  C_PAGE_PURGE_HISTORIQUE_DELIVRANCE = 3;

  C_PURGE_ORGANISME_SANS_CLIENT = 0;

  C_PURGE_CLIENT_DATE_DERN_VISITE = 0;
  C_PURGE_CLIENT_DATE_DERN_VISITE_LIBELLE = 'Date de dernière visite (--/--/----)';
  C_PURGE_CLIENT_BENEF_ORPHELINS = 1;
  C_PURGE_CLIENT_NUMERO_SS = 2;
  C_PURGE_CLIENT_ORG_AMO_AMC = 3;

  C_PURGE_PRODUIT_DATE_DERN_VENTE = 0;
  C_PURGE_PRODUIT_DATE_DERN_VENTE_LIBELLE = 'Date de dernière vente (--/--/----)';
  C_PURGE_PRODUIT_FOURNISSEUR = 1;
  C_PURGE_PRODUIT_FOURNISSEUR_LIBELLE = 'Fournisseur (-)';

  C_PURGE_HISTORIQUE_DELIVRANCE_DATE_ACTE = 0;
  C_PURGE_HISTORIQUE_DELIVRANCE_DATE_ACTE_LIBELLE = 'Date de l''acte (--/--/----)';

var
  frmPurges: TfrmPurges;


implementation

uses mdlChoixDate, mdlChoixID, mdlBase, mdlOutilsPHAPHA_be;

{$R *.dfm}

procedure TfrmPurges.rgPurgeClick(Sender: TObject);
var
  lDtDate : TDateTime;
  lVarFournisseurDirectID : Variant;
begin
  inherited;

  with dmOutilsPHAPHA_be, FParametresPages[pCtlPurgeDonnees.ActivePageIndex] do
  begin
    if not trDataset.InTransaction then
      trDataset.StartTransaction;

    Grille.MultiSelection.Selections.Clear;
    if Grille.DataSource.DataSet.Active then
      Grille.DataSource.DataSet.Close;

    TUIBDataset(Grille.DataSource.DataSet).Params.ByNameAsInteger['ATYPE'] := RadioGroup.ItemIndex;
  end;

  // Préparation au comptage des données à purger
  case pCtlPurgeDonnees.ActivePageIndex of
    C_PAGE_PURGE_ORGANISMES :
      begin
        dmOutilsPHAPHA_be.setOrganismesAMC.Open;
      end;

    C_PAGE_PURGE_CLIENTS :
      begin
        rgPurgeClients.Items[C_PURGE_CLIENT_DATE_DERN_VISITE] := C_PURGE_CLIENT_DATE_DERN_VISITE_LIBELLE;

        case rgPurgeClients.ItemIndex of
          C_PURGE_CLIENT_DATE_DERN_VISITE :
            begin
              if FaireChoixDate('', '', lDtDate) = mrOk then
              begin
                rgPurgeClients.Items[C_PURGE_CLIENT_DATE_DERN_VISITE] := 'Date de dernière visite (' + FormatDateTime('DD/MM/YYYY', lDtDate) + ')';
                dmOutilsPHAPHA_be.setClients.Params.ByNameAsString['APARAMETRE'] := FormatDateTime('YYYY-MM-DD', lDtDate);
                dmOutilsPHAPHA_be.setClients.Open;
              end
              else
              begin
                rgPurgeClients.ItemIndex := -1;
                txtTotalClientsAPurger.Caption := '';
              end;
            end;
        else
          dmOutilsPHAPHA_be.setClients.Open;
        end;
      end;

    C_PAGE_PURGE_PRODUITS :
      begin
        rgPurgeProduits.Items[C_PURGE_PRODUIT_DATE_DERN_VENTE] := C_PURGE_PRODUIT_DATE_DERN_VENTE_LIBELLE;
        rgPurgeProduits.Items[C_PURGE_PRODUIT_FOURNISSEUR] := C_PURGE_PRODUIT_FOURNISSEUR_LIBELLE;

        case rgPurgeProduits.ItemIndex of
          C_PURGE_PRODUIT_DATE_DERN_VENTE :
             begin
               if FaireChoixDate('', '', lDtDate) = mrOk then
               begin
                 rgPurgeProduits.Items[C_PURGE_PRODUIT_DATE_DERN_VENTE] := 'Date de dernière vente (' + FormatDateTime('DD/MM/YYYY', lDtDate) + ')';
                 dmOutilsPHAPHA_be.setProduits.Params.ByNameAsString['APARAMETRE'] := FormatDateTime('YYYY-MM-DD', lDtDate);
                 dmOutilsPHAPHA_be.setProduits.Open;
               end
               else
               begin
                 rgPurgeProduits.ItemIndex := -1;
                 txtTotalProduitsAPurger.Caption := '';
               end;
             end;

          C_PURGE_PRODUIT_FOURNISSEUR :
             begin
               if FaireChoixID(dmOutilsPHAPHA_be.setFournisseursDirect, 'Choix d''un fournisseur direct ...', lVarFournisseurDirectID) = mrOk then
               begin
                 rgPurgeProduits.Items[C_PURGE_PRODUIT_FOURNISSEUR] := 'Laboratoire (' + VarAsType(lVarFournisseurDirectID, varString) + ')';
                 dmOutilsPHAPHA_be.setProduits.Params.ByNameAsString['APARAMETRE'] := VarAsType(lVarFournisseurDirectID, varString);
                 dmOutilsPHAPHA_be.setProduits.Open;
               end
               else
               begin
                 rgPurgeProduits.ItemIndex := -1;
                 txtTotalProduitsAPurger.Caption := '';
               end;
             end;
        else
          dmOutilsPHAPHA_be.setProduits.Open;
        end;
      end;

    C_PAGE_PURGE_HISTORIQUE_DELIVRANCE :
      begin
        rgPurgeHistoriques.Items[C_PURGE_HISTORIQUE_DELIVRANCE_DATE_ACTE] := C_PURGE_HISTORIQUE_DELIVRANCE_DATE_ACTE_LIBELLE;

        case rgPurgeHistoriques.ItemIndex of
          C_PURGE_HISTORIQUE_DELIVRANCE_DATE_ACTE :
             begin
               if FaireChoixDate('', '', lDtDate) = mrOk then
               begin
                 rgPurgeHistoriques.Items[C_PURGE_HISTORIQUE_DELIVRANCE_DATE_ACTE] := 'Date de l''acte (' + FormatDateTime('DD/MM/YYYY', lDtDate) + ')';
                 dmOutilsPHAPHA_be.setHistoriques.Params.ByNameAsString['APARAMETRE'] := FormatDateTime('YYYY-MM-DD', lDtDate);
                 dmOutilsPHAPHA_be.setHistoriques.Open;
               end
               else
               begin
                 rgPurgeHistoriques.ItemIndex := -1;
                 txtTotalHistoriquesAPurger.Caption := '';
               end;
             end;
        end;
      end;
  end;

  with FParametresPages[pCtlPurgeDonnees.ActivePageIndex], Grille.DataSource.DataSet do
    if Active then
    begin
      DisableControls;
      Last;
      Total.Caption := IntToStr(RecordCount);
      First;
      EnableControls;
    end
    else
      ActiveControl := pCtlPurgeDonnees.ActivePage;
end;

procedure TfrmPurges.FormCreate(Sender: TObject);
var
  i : Integer;
begin
  inherited;

  pCtlPurgeDonnees.ActivePageIndex := C_PAGE_PURGE_ORGANISMES;
  SetLength(FParametresPages, pCtlPurgeDonnees.PageCount);
  for i := 0 to pCtlPurgeDonnees.PageCount - 1 do
  begin
    FParametresPages[i].Index := i;
    FParametresPages[i].RadioGroup := TRadioGroup(pCtlPurgeDonnees.Pages[i].FindChildControl('rgPurge' + pCtlPurgeDonnees.Pages[i].Caption));
    FParametresPages[i].Grille := TPIDBGrid(pCtlPurgeDonnees.Pages[i].FindChildControl('grdPurge' + pCtlPurgeDonnees.Pages[i].Caption));
    FParametresPages[i].Total := TStaticText(pCtlPurgeDonnees.Pages[i].FindChildControl('txtTotal' + pCtlPurgeDonnees.Pages[i].Caption + 'APurger'));
  end;
end;

procedure TfrmPurges.FormDestroy(Sender: TObject);
begin
  ResetEtatPurge;

  inherited;
end;

procedure TfrmPurges.actPurgerExecute(Sender: TObject);
var
  lParametresPurge : TParametresThreadRequeteFB;
  lBoolEtatPurge : Boolean;
  i : Integer;
  lIntPurgees, lIntNonPurgees : Integer;
begin
  inherited;

  // Lancement de la purge
  if Projet.Thread then
  begin
    lParametresPurge := TParametresThreadRequeteFB.Create(Projet.PHAConnexion, 'PS_UTL_PHA_PURGER', 4);
    with lParametresPurge do
    begin
      ParametresProc[C_PARAMETRE_PURGE_DONNEES] := pCtlPurgeDonnees.ActivePageIndex;
      ParametresProc[C_PARAMETRE_PURGE_TYPE] := FParametresPages[pCtlPurgeDonnees.ActivePageIndex].RadioGroup.ItemIndex;
      ParametresProc[C_PARAMETRE_PURGE_PARAMETRE] := TUIBDataset(FParametresPages[pCtlPurgeDonnees.ActivePageIndex].Grille.DataSource.DataSet).Params.ByNameAsString['APARAMETRE'];
      ParametresProc[C_PARAMETRE_PURGE_RESET] := '0';
    end;
    AttendreFinExecution(Self, taLibelle, TThreadRequeteFB, lParametresPurge, 'Purge des ' + LowerCase(pCtlPurgeDonnees.ActivePage.Caption) + ' ...');
    if not lParametresPurge.Erreur.Etat then
      MessageDlg('Erreur lors de la purge des données !'#13#10#13#10 +
                 'Message : ' + lParametresPurge.Erreur.Message, mtError, [mbOk], 0);

    lIntPurgees := VarAsType(lParametresPurge.ParametresProc[C_PARAMETRE_PURGE_DONNEES_SUPPRIMEES], varInteger);
    lIntNonPurgees := VarAsType(lParametresPurge.ParametresProc[C_PARAMETRE_PURGE_DONNEES_RESTANTES], varInteger);
    lBoolEtatPurge := lParametresPurge.Erreur.Etat;
  end
  else
    with dmOutilsPHAPHA_be.sp do
      try
        Transaction.StartTransaction;
        BuildStoredProc('PS_UTL_PHA_PURGER');
        Params.AsString[C_PARAMETRE_PURGE_DONNEES] := IntToStr(pCtlPurgeDonnees.ActivePageIndex);
        Params.AsString[C_PARAMETRE_PURGE_TYPE] := IntToStr(FParametresPages[pCtlPurgeDonnees.ActivePageIndex].RadioGroup.ItemIndex);
        Params.AsString[C_PARAMETRE_PURGE_PARAMETRE] := TUIBDataset(FParametresPages[pCtlPurgeDonnees.ActivePageIndex].Grille.DataSource.DataSet).Params.ByNameAsString['APARAMETRE'];;
        Params.AsString[C_PARAMETRE_PURGE_RESET] := '0';
        Open;

        lIntPurgees := Fields.AsInteger[C_PARAMETRE_PURGE_DONNEES_SUPPRIMEES];
        lIntNonPurgees := Fields.AsInteger[C_PARAMETRE_PURGE_DONNEES_RESTANTES];
        lBoolEtatPurge := True;

        Close(etmCommit);
      except
        on E:Exception do
        begin
          MessageDlg('Erreur lors de la purge des données !'#13#10#13#10 +
                     'Message : ' + E.Message, mtError, [mbOk], 0);
          Close(etmRollback);

          lIntPurgees := -1;
          lIntNonPurgees := -1;
          lBoolEtatPurge := False;
        end;
      end;

  // Gestion des exceptions de la purge
  if lBoolEtatPurge then
    with dmOutilsPHAPHA_be.sp, FParametresPages[pCtlPurgeDonnees.ActivePageIndex] do
    begin
      Transaction.StartTransaction;
      BuildStoredProc('PS_UTL_PHA_EXCEPTIONS_PURGE');
      Prepare;

      Params.ByNameAsString['ATYPEDONNEES'] := IntToStr(Index);
      with Grille do
      begin
        DataSource.DataSet.DisableControls;
        for i := 0 to MultiSelection.Selections.Count - 1 do
        begin
          DataSource.DataSet.Bookmark := TBytes(MultiSelection.Selections[i]);
          Params.ByNameAsString['AID'] := DataSource.DataSet.Fields[0].AsString;
          Execute;
        end;
        DataSource.DataSet.EnableControls;
      end;
      Close(etmCommit);

      Dec(lIntNonPurgees, Grille.MultiSelection.Selections.Count);
      Inc(lIntPurgees, Grille.MultiSelection.Selections.Count);

      ResetEtatPurge;
    end;

    MessageDlg('Etat de la base locale : '#13#10#13#10 +
               pCtlPurgeDonnees.ActivePage.Caption + ' non purgé(e)s : ' + IntToStr(lIntNonPurgees) + #13#10 +
               pCtlPurgeDonnees.ActivePage.Caption + ' purgé(e)s : ' + IntToStr(lIntPurgees), mtInformation, [mbOk], 0);
end;

procedure TfrmPurges.actResetExecute(Sender: TObject);
var
  lParametresPurge : TParametresThreadRequeteFB;
begin
  inherited;

  if Projet.Thread then
  begin
    lParametresPurge := TParametresThreadRequeteFB.Create(Projet.PHAConnexion, 'PS_UTL_PHA_PURGER', 4);
    with lParametresPurge do
    begin
      ParametresProc[C_PARAMETRE_PURGE_DONNEES] := pCtlPurgeDonnees.ActivePageIndex;
      ParametresProc[C_PARAMETRE_PURGE_TYPE] := null;
      ParametresProc[C_PARAMETRE_PURGE_PARAMETRE] := null;
      ParametresProc[C_PARAMETRE_PURGE_RESET] := '1';
    end;
    AttendreFinExecution(Self, taLibelle, TThreadRequeteFB, lParametresPurge, 'Remise à zéro des ' + LowerCase(pCtlPurgeDonnees.ActivePage.Caption) + ' ...');
    if not lParametresPurge.Erreur.Etat then
      MessageDlg('Erreur lors du reset des données !'#13#10#13#10 +
                 'Message : ' + lParametresPurge.Erreur.Message, mtError, [mbOk], 0);
  end
  else
    with dmOutilsPHAPHA_be.sp do
      try
        Transaction.StartTransaction;
        BuildStoredProc('PS_UTL_PHA_PURGER');
        Params.AsString[C_PARAMETRE_PURGE_DONNEES] := IntToStr(pCtlPurgeDonnees.ActivePageIndex);
        Params.IsNull[C_PARAMETRE_PURGE_TYPE] := True;
        Params.IsNull[C_PARAMETRE_PURGE_PARAMETRE] := True;
        Params.AsString[C_PARAMETRE_PURGE_RESET] := '1';
        Open;
        Close(etmCommit);
      except
        on E:Exception do
        begin
          MessageDlg('Erreur lors du reset des données !'#13#10#13#10 +
                     'Message : ' + E.Message, mtError, [mbOk], 0);
          Close(etmRollback);
        end;
      end;

  ResetEtatPurge;
end;

procedure TfrmPurges.ResetEtatPurge;
begin
  with FParametresPages[pCtlPurgeDonnees.ActivePageIndex].Grille.DataSource.DataSet do
    if Active then
      Close;

  if dmOutilsPHAPHA_be.trDataset.InTransaction then
    dmOutilsPHAPHA_be.trDataset.Commit;

  FParametresPages[pCtlPurgeDonnees.ActivePageIndex].RadioGroup.ItemIndex := -1;
end;

procedure TfrmPurges.actImprimerExecute(Sender: TObject);
begin
  inherited;

  dmOutilsPHAPHA_be.impDonnees.Imprimer(FParametresPages[pCtlPurgeDonnees.ActivePageIndex].Grille.GenererImpression);
end;

procedure TfrmPurges.pCtlPurgeDonneesChanging(Sender: TObject;
  var AllowChange: Boolean);
begin
  inherited;

  with FParametresPages[pCtlPurgeDonnees.ActivePageIndex] do
  begin
    if Grille.DataSource.DataSet.Active then
      Grille.DataSource.DataSet.Close;
    RadioGroup.ItemIndex := -1;
    Total.Caption := '';
  end;
end;

end.
