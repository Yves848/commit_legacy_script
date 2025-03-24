unit mdlPurges;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, mdlDialogue, DB, Grids, DBGrids, mdlPIDBGrid, StdCtrls, StrUtils, Math,
  JvExControls, JvLabel, ExtCtrls, ComCtrls, ActnList, ImgList, DateUtils,
  UIBDataSet, UIB, UIBLib, mdlAttente, mdlUIBThread;

type
  TPageCourante = record
    Index : Integer;
    RadioGroup : TRadioGroup;
    Grille : TPIDBGrid;
    BoutonPurger : TButton;
    //Total : TStaticText;
  end;

  TfrmPurges = class(TfrmDialogue)
    iLstPageControl: TImageList;
    dsClients: TDataSource;
    dsProduits: TDataSource;
    dsOrganismes: TDataSource;
    actPurger: TAction;
    actReset: TAction;
    dsHistoriques: TDataSource;
    dsCredits: TDataSource;
    dsVignettes: TDataSource;
    dsFactures: TDataSource;
    dsProduitsDus: TDataSource;
    dsPraticiens: TDataSource;
    pCtlPurgeDonnees: TPageControl;
    tShPurgePraticiens: TTabSheet;
    rgPurgePraticiens: TRadioGroup;
    grdPurgePraticiens: TPIDBGrid;
    tShPurgeOrganismes: TTabSheet;
    rgPurgeOrganismes: TRadioGroup;
    grdPurgeOrganismes: TPIDBGrid;
    tShPurgeClients: TTabSheet;
    rgPurgeClients: TRadioGroup;
    grdPurgeClients: TPIDBGrid;
    tShPurgeProduits: TTabSheet;
    rgPurgeProduits: TRadioGroup;
    grdPurgeProduits: TPIDBGrid;
    tShPurgeHistoDeliv: TTabSheet;
    grdPurgeHistoriques: TPIDBGrid;
    tshEncours: TTabSheet;
    Bevel1: TBevel;
    Label1: TLabel;
    lblTypeEncours: TLabel;
    dtEncoursDateActe: TDateTimePicker;
    cbxTypeEncours: TComboBox;
    gpEncours: TGridPanel;
    dgPurgeCredits: TPIDBGrid;
    JvLabel1: TJvLabel;
    PIDBGrid2: TPIDBGrid;
    JvLabel3: TJvLabel;
    PIDBGrid3: TPIDBGrid;
    JvLabel2: TJvLabel;
    JvLabel4: TJvLabel;
    PIDBGrid4: TPIDBGrid;
    btnPurgeOrganismes: TButton;
    txtTotalPurgeOrganismes: TStaticText;
    txtTotalRestantOrganismes: TStaticText;
    txtTotalRestantPraticiens: TStaticText;
    txtTotalPurgePraticiens: TStaticText;
    btnPurgeEncours: TButton;
    btnPurgeHistoriques: TButton;
    btnPurgePraticiens: TButton;
    btnPurgeClients: TButton;
    btnPurgeProduits: TButton;
    txtTotalPurgeClients: TStaticText;
    txtTotalRestantClients: TStaticText;
    txtTotalRestantProduits: TStaticText;
    txtTotalPurgeProduits: TStaticText;
    txtTotalPurgeHistoriques: TStaticText;
    txtTotalRestantHistoriques: TStaticText;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    rgPurgeHistoriques: TRadioGroup;
    tshCommandes: TTabSheet;
    rgPurgeCommandes: TRadioGroup;
    Label2: TLabel;
    txtTotalPurgeCommandes: TStaticText;
    Label14: TLabel;
    txtTotalRestantCommandes: TStaticText;
    grdPurgeCommandes: TPIDBGrid;
    dsCommandes: TDataSource;
    btnPurgeCommandes: TButton;
    procedure rgChoixPurgeClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure actPurgerExecute(Sender: TObject);
    procedure actResetExecute(Sender: TObject);
    procedure actImprimerExecute(Sender: TObject);
    procedure pCtlPurgeDonneesChanging(Sender: TObject;
      var AllowChange: Boolean);
    procedure dtDateActeChange(Sender: TObject);
    procedure cbxTypeEncoursChange(Sender: TObject);
    procedure pCtlPurgeDonneesChange(Sender: TObject);


  private
    { Déclarations privées }
    FParametresPages : array of TPageCourante;
    procedure ResetFenetre;
    procedure ComptagePage;
  public
    { Déclarations publiques }
  end;

const
  C_PAGE_PURGE_PRATICIENS = 0;
  C_PAGE_PURGE_ORGANISMES = 1;
  C_PAGE_PURGE_CLIENTS = 2;
  C_PAGE_PURGE_PRODUITS = 3;
  C_PAGE_PURGE_HISTORIQUE_DELIVRANCE = 4;
  C_PAGE_PURGE_ENCOURS = 5;
  C_PAGE_PURGE_COMMANDES = 6; // attention commandes = page numero 6 mais traitement numero 10 ( car 4 trt dans la page precedente )
  // un tag = 4  a été renseigné pour la page 6 : 6 + 4 = 10

  C_PURGE_PRATICIEN_SANS_RPPS = 0;
  C_PURGE_PRATICIENS_DATE_DERN_PRESCRIPTION_LIBELLE = 'Date de dernière prescription (--/--/----)';
  C_PURGE_PRATICIENS_DATE_DERN_PRESCRIPTION = 1;

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

  C_PURGE_COMMANDE_DATE_COMMANDE = 0;
  C_PURGE_COMMANDE_DATE_COMMANDE_LIBELLE = 'Date de la commande (--/--/----)';

var
  frmPurges: TfrmPurges;


implementation

uses mdlChoixDate, mdlChoixID, mdlBase, mdlOutilsPHAPHA_fr;

{$R *.dfm}


procedure TfrmPurges.FormCreate(Sender: TObject);
var
  i : Integer;
begin
  inherited;
  // creation de la fenetre , initialisation des composants dynamiques , placement sur le premier
  pCtlPurgeDonnees.ActivePageIndex := C_PAGE_PURGE_PRATICIENS;    // onglet par defaut
  SetLength(FParametresPages, pCtlPurgeDonnees.PageCount);
  for i := 0 to pCtlPurgeDonnees.PageCount - 1 do
  begin
    FParametresPages[i].Index := i;
    FParametresPages[i].RadioGroup := TRadioGroup(pCtlPurgeDonnees.Pages[i].FindChildControl('rgPurge' + pCtlPurgeDonnees.Pages[i].Caption));
    FParametresPages[i].Grille := TPIDBGrid(pCtlPurgeDonnees.Pages[i].FindChildControl('grdPurge' + pCtlPurgeDonnees.Pages[i].Caption));
    FParametresPages[i].BoutonPurger := TButton(pCtlPurgeDonnees.Pages[i].FindChildControl('btnPurge' + pCtlPurgeDonnees.Pages[i].Caption));
  end;

  ComptagePage;
end;




procedure TfrmPurges.rgChoixPurgeClick(Sender: TObject);
var
  lDtDate : TDateTime;
  lVarFournisseurDirectID : Variant;
  nomPage : string;
begin
  inherited;
  // une purge à ete choisi ( cas des radio group : prat, org, client  )

  with dmOutilsPHAPHA_fr, FParametresPages[pCtlPurgeDonnees.ActivePageIndex] do
  begin
    if not trDataset.InTransaction then
      trDataset.StartTransaction;

    Grille.MultiSelection.Selections.Clear;
    if Grille.DataSource.DataSet.Active then
      Grille.DataSource.DataSet.Close;
    // si plusieurs type de purge recuperer l indice ( sinon 0 )
    TUIBDataset(Grille.DataSource.DataSet).Params.ByNameAsInteger['ATYPE'] := RadioGroup.ItemIndex;
  end;

  // Préparation au comptage des données à purger
  case pCtlPurgeDonnees.ActivePageIndex of
  C_PAGE_PURGE_PRATICIENS:
    begin
      rgPurgePraticiens.Items[C_PURGE_PRATICIENS_DATE_DERN_PRESCRIPTION] := C_PURGE_PRATICIENS_DATE_DERN_PRESCRIPTION_LIBELLE;
      case rgPurgePraticiens.ItemIndex of
        C_PURGE_PRATICIENS_DATE_DERN_PRESCRIPTION:
          begin
            if FaireChoixDate('', '', lDtDate) = mrOk then
            begin
              rgPurgePraticiens.Items[1] := 'Date de dernière visite (' + FormatDateTime('DD/MM/YYYY', lDtDate) + ')';
              dmOutilsPHAPHA_fr.setPraticiens.Params.ByNameAsString['APARAMETRE'] := FormatDateTime('YYYY-MM-DD', lDtDate);
              Screen.Cursor := crHourGlass;
              dmOutilsPHAPHA_fr.setPraticiens.Open;
              Screen.Cursor := crDefault;
            end
            else
              rgPurgePraticiens.ItemIndex := -1;
          end;
      else
        dmOutilsPHAPHA_fr.setPraticiens.Params.ByNameAsString['ATYPE'] := '0';
        dmOutilsPHAPHA_fr.setPraticiens.Open;
      end;
    end;

    C_PAGE_PURGE_ORGANISMES :
      begin
        dmOutilsPHAPHA_fr.setOrganismesAMC.Open;
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
                dmOutilsPHAPHA_fr.setClients.Params.ByNameAsString['APARAMETRE'] := FormatDateTime('YYYY-MM-DD', lDtDate);
                Screen.Cursor := crHourGlass;
                dmOutilsPHAPHA_fr.setClients.Open;
                Screen.Cursor := crDefault;
              end
              else
              begin
                rgPurgeClients.ItemIndex := -1;
                //txtTotalClientsAPurger.Caption := '';
              end;
            end;
        else
          dmOutilsPHAPHA_fr.setClients.Open;
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
                 dmOutilsPHAPHA_fr.setProduits.Params.ByNameAsString['APARAMETRE'] := FormatDateTime('YYYY-MM-DD', lDtDate);
                 Screen.Cursor := crHourGlass;
                 dmOutilsPHAPHA_fr.setProduits.Open;
                 Screen.Cursor := crDefault;
               end
               else
               begin
                 rgPurgeProduits.ItemIndex := -1;
                 //txtTotalProduitsAPurger.Caption := '';
               end;
             end;

          C_PURGE_PRODUIT_FOURNISSEUR :
             begin
               if FaireChoixID(dmOutilsPHAPHA_fr.setFournisseursDirect, 'Choix d''un fournisseur direct ...', lVarFournisseurDirectID) = mrOk then
               begin
                 rgPurgeProduits.Items[C_PURGE_PRODUIT_FOURNISSEUR] := 'Laboratoire (' + VarAsType(lVarFournisseurDirectID, varString) + ')';
                 dmOutilsPHAPHA_fr.setProduits.Params.ByNameAsString['APARAMETRE'] := VarAsType(lVarFournisseurDirectID, varString);
                 Screen.Cursor := crHourGlass;
                 dmOutilsPHAPHA_fr.setProduits.Open;
                 Screen.Cursor := crDefault;
               end
               else
               begin
                 rgPurgeProduits.ItemIndex := -1;
                 //txtTotalProduitsAPurger.Caption := '';
               end;
             end;

        else
          dmOutilsPHAPHA_fr.setProduits.Open;
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
                dmOutilsPHAPHA_fr.setHistoriques.Params.ByNameAsString['APARAMETRE'] := FormatDateTime('YYYY-MM-DD', lDtDate);
                Screen.Cursor := crHourGlass;
                dmOutilsPHAPHA_fr.setHistoriques.Open;
                Screen.Cursor := crDefault;
              end
              else
              begin
                rgPurgeHistoriques.ItemIndex := -1;
              end;
        end
        else
          dmOutilsPHAPHA_fr.setHistoriques.Open;
        end;
      end;


    C_PAGE_PURGE_COMMANDES :
      begin
        rgPurgeCommandes.Items[C_PURGE_COMMANDE_DATE_COMMANDE] := C_PURGE_COMMANDE_DATE_COMMANDE_LIBELLE;

        case rgPurgeCommandes.ItemIndex of
          C_PURGE_COMMANDE_DATE_COMMANDE :
            begin
              if FaireChoixDate('', '', lDtDate) = mrOk then
              begin
                rgPurgeCommandes.Items[C_PURGE_COMMANDE_DATE_COMMANDE] := 'Date de l''acte (' + FormatDateTime('DD/MM/YYYY', lDtDate) + ')';
                dmOutilsPHAPHA_fr.setCommandes.Params.ByNameAsString['APARAMETRE'] := FormatDateTime('YYYY-MM-DD', lDtDate);
                Screen.Cursor := crHourGlass;
                dmOutilsPHAPHA_fr.setCommandes.Open;
                Screen.Cursor := crDefault;
              end
              else
              begin
                rgPurgeCommandes.ItemIndex := -1;
              end;
        end
        else
          dmOutilsPHAPHA_fr.setCommandes.Open;
        end;
      end;
  end;


  with FParametresPages[pCtlPurgeDonnees.ActivePageIndex], Grille.DataSource.DataSet do
    if Active then
    begin
      DisableControls;   // desactive le rafraichissement de la grille
      Last;              // pour compter le nb de records de la grille
      nomPage :=  pCtlPurgeDonnees.Pages[pCtlPurgeDonnees.ActivePageIndex].Caption;
      
      if RecordCount > 0 then
      begin
        // on rend visibles les elements necessaires
        grille.Visible := true;
        BoutonPurger.visible := true;
        actPurger.Enabled := true;
        BoutonPurger.Caption := 'Purger ces '+IntToStr(RecordCount)+' '+ nomPage ;
        First;
        EnableControls;
      end
      else
      begin
        Showmessage('Pas de '+ nomPage +' à purger selon ces criteres'+ #13 + #10
                   +' ( RESET pour retablir l''état initial des '+ nomPage +' )');
      end;

    end
    else
      ActiveControl := pCtlPurgeDonnees.ActivePage;


end;

procedure TfrmPurges.actPurgerExecute(Sender: TObject);
var
  lParametresPurge : TParametresThreadRequeteFB;
  lBoolEtatPurge : Boolean;
  i : Integer;
  lIntPurgees, lIntNonPurgees : Integer;
begin
  inherited;

  // Lancement de la purge  ( traitement sql )
  if Projet.Thread then
  begin
    lParametresPurge := TParametresThreadRequeteFB.Create(Projet.PHAConnexion, 'PS_UTL_PHA_PURGER', 4);
    with lParametresPurge do
    begin
      ParametresProc[C_PARAMETRE_PURGE_DONNEES] := pCtlPurgeDonnees.ActivePageIndex;
        if pCtlPurgeDonnees.ActivePageIndex = C_PAGE_PURGE_ENCOURS then
        begin   // tous les encours   tous = 5 , credit = 6,  ...   Prd dus 9

          ParametresProc[C_PARAMETRE_PURGE_DONNEES] := ParametresProc[C_PARAMETRE_PURGE_DONNEES] + cbxTypeEncours.ItemIndex;
          ParametresProc[C_PARAMETRE_PURGE_TYPE] := null;
          ParametresProc[C_PARAMETRE_PURGE_PARAMETRE] := FormatDateTime('YYYY-MM-DD', dtEncoursDateActe.Date);
        end
        else
        begin  // une seule page parmi les encours
          ParametresProc[C_PARAMETRE_PURGE_DONNEES] := ParametresProc[C_PARAMETRE_PURGE_DONNEES] +pCtlPurgeDonnees.Pages[pCtlPurgeDonnees.ActivePageIndex].tag;
          ParametresProc[C_PARAMETRE_PURGE_TYPE] := FParametresPages[pCtlPurgeDonnees.ActivePageIndex].RadioGroup.ItemIndex;
          ParametresProc[C_PARAMETRE_PURGE_PARAMETRE] := TUIBDataset(FParametresPages[pCtlPurgeDonnees.ActivePageIndex].Grille.DataSource.DataSet).Params.ByNameAsString['APARAMETRE'];
        end;
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
    with dmOutilsPHAPHA_fr.sp do
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

  // Gestion des exceptions de la purge : on decoche ce qu on ne veut pas purger
  if lBoolEtatPurge and (pCtlPurgeDonnees.ActivePageIndex in [C_PAGE_PURGE_PRATICIENS, C_PAGE_PURGE_ORGANISMES, C_PAGE_PURGE_CLIENTS, C_PAGE_PURGE_PRODUITS, C_PAGE_PURGE_HISTORIQUE_DELIVRANCE]) then
  begin
    with dmOutilsPHAPHA_fr.sp, FParametresPages[pCtlPurgeDonnees.ActivePageIndex] do
      if Grille.MultiSelection.Active then
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

        // maj des compteurs au cochage/décochage
        Inc(lIntNonPurgees, Grille.MultiSelection.Selections.Count);
        Dec(lIntPurgees, Grille.MultiSelection.Selections.Count);

      end;

    MessageDlg('Etat de la base locale : '#13#10#13#10 +
               pCtlPurgeDonnees.ActivePage.Caption + ' non purgé(e)s : ' + IntToStr(lIntNonPurgees) + #13#10 +
               pCtlPurgeDonnees.ActivePage.Caption + ' purgé(e)s : ' + IntToStr(lIntPurgees), mtInformation, [mbOk], 0);
  end;

  ResetFenetre;
  ComptagePage;
end;

procedure TfrmPurges.actResetExecute(Sender: TObject);
var
  lParametresPurge : TParametresThreadRequeteFB;
begin
  inherited;

  // Annulation de la purge
  if Projet.Thread then
  begin
    lParametresPurge := TParametresThreadRequeteFB.Create(Projet.PHAConnexion, 'PS_UTL_PHA_PURGER', 4);
    with lParametresPurge do
    begin
      if pCtlPurgeDonnees.ActivePageIndex = C_PAGE_PURGE_ENCOURS then
        ParametresProc[C_PARAMETRE_PURGE_DONNEES] := pCtlPurgeDonnees.ActivePageIndex + cbxTypeEncours.ItemIndex
      else
        ParametresProc[C_PARAMETRE_PURGE_DONNEES] := pCtlPurgeDonnees.ActivePageIndex + pCtlPurgeDonnees.Pages[pCtlPurgeDonnees.ActivePageIndex].tag; // le tag n intervient que pour les pages apres "En cours"
      ParametresProc[C_PARAMETRE_PURGE_TYPE] := null;
      ParametresProc[C_PARAMETRE_PURGE_PARAMETRE] := null;
      ParametresProc[C_PARAMETRE_PURGE_RESET] := '1'; // 1 = reset
    end;
    AttendreFinExecution(Self, taLibelle, TThreadRequeteFB, lParametresPurge, 'Remise à zéro des ' + LowerCase(pCtlPurgeDonnees.ActivePage.Caption) + ' ...');
    if not lParametresPurge.Erreur.Etat then
      MessageDlg('Erreur lors du reset des données !'#13#10#13#10 +
                 'Message : ' + lParametresPurge.Erreur.Message, mtError, [mbOk], 0);
  end
  else
    with dmOutilsPHAPHA_fr.sp do
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

  ResetFenetre;
  ComptagePage;
end;

// -----------------------------------------------------------------------
//           ENCOURS : cas special avec 4 grilles
// -----------------------------------------------------------------------
procedure TfrmPurges.cbxTypeEncoursChange(Sender: TObject);
var
 i, h : Integer;
begin
  inherited;

  dmOutilsPHAPHA_fr.setEncours.Params.ByNameAsString['ADATE_ENCOURS'] := FormatDateTime('YYYY-MM-DD', dtEncoursDateActe.Date);
  Screen.Cursor := crHourGlass;
  dmOutilsPHAPHA_fr.setEncours.Open;
  Screen.Cursor := crDefault;

  // choix du traitement fait disparaitre les autres grilles via le gridpanel ( composant de mise  en forme )
  with gpEncours do
    if cbxTypeEncours.ItemIndex = 0 then   // Tous
    begin
      h := Height div 4;
      for i  := 0 to 3 do
        RowCollection[i].Value :=  h
    end
    else
    begin
      for i  := 3 downto 0 do   // celui choisi prend toute la hauteur; les autres 0
        RowCollection[i].Value :=  IfThen(i = cbxTypeEncours.ItemIndex - 1, Height);
    end;


   actPurger.Enabled := true;
   actReset.Enabled := true;
end;

procedure TfrmPurges.dtDateActeChange(Sender: TObject);
begin
  inherited;

  //choix de la purge : cas des dates
  case pCtlPurgeDonnees.ActivePageIndex of
    C_PAGE_PURGE_ENCOURS :
      begin
        gpEncours.Visible := true;
        dmOutilsPHAPHA_fr.setEncours.Params.ByNameAsString['ADATE_ENCOURS'] := FormatDateTime('YYYY-MM-DD', dtEncoursDateActe.Date);
        Screen.Cursor := crHourGlass;
        dmOutilsPHAPHA_fr.setEncours.Open;
        Screen.Cursor := crDefault;
      end;
  end;

  actPurger.Enabled := true;
  actReset.Enabled := true;

  // ComptagePage; pas de compteur sur la fenetre des encours
end;

procedure TfrmPurges.ResetFenetre;
begin
  // RESET de l'etat de la fenetre

  // si "en cours" fermer les 4 dataset de la page
  if pCtlPurgeDonnees.ActivePageIndex = C_PAGE_PURGE_ENCOURS then
    with dmOutilsPHAPHA_fr do
    begin
      if setCredits.Active then setCredits.Close;
      if setVignettes.Active then setVignettes.Close;
      if setFactures.Active then setFactures.Close;
      if setProduitsDus.Active then setProduitsDus.Close;
      gpEncours.Visible := false;
    end
  else
  begin   // CAS GENERAL  sinon un seul dataset
    with FParametresPages[pCtlPurgeDonnees.ActivePageIndex].Grille.DataSource.DataSet do
      if Active then
        Close;

    // on fait disparaitre les controleurs inutiles
    FParametresPages[pCtlPurgeDonnees.ActivePageIndex].Grille.Visible := false;
    FParametresPages[pCtlPurgeDonnees.ActivePageIndex].BoutonPurger.Visible := false;
    actPurger.Enabled := false;


    // et on decoche le radiogroup
    if Assigned(FParametresPages[pCtlPurgeDonnees.ActivePageIndex].RadioGroup) then
      FParametresPages[pCtlPurgeDonnees.ActivePageIndex].RadioGroup.ItemIndex := -1;
  end;

  if dmOutilsPHAPHA_fr.trDataset.InTransaction then
    dmOutilsPHAPHA_fr.trDataset.Commit;


end;

procedure TfrmPurges.actImprimerExecute(Sender: TObject);
begin
  inherited;

  dmOutilsPHAPHA_fr.impDonnees.Imprimer(FParametresPages[pCtlPurgeDonnees.ActivePageIndex].Grille.GenererImpression);
end;

procedure TfrmPurges.pCtlPurgeDonneesChange(Sender: TObject);
begin
  inherited;
  //showmessage( ' Entree dans la page '+inttostr(pCtlPurgeDonnees.ActivePageIndex));


  // entree dans une page
  case pCtlPurgeDonnees.ActivePageIndex of
    C_PAGE_PURGE_ENCOURS :
    begin
      dtEncoursDateActe.Date :=  IncYear(Date, -2);
      actPurger.Enabled := false;
      actReset.Enabled := true;
    end;
  else
    ComptagePage;
  end;


end;

procedure TfrmPurges.pCtlPurgeDonneesChanging(Sender: TObject;
  var AllowChange: Boolean);
begin
  inherited;
  // a la sortie de la page on ferme les ds particuliers
  case pCtlPurgeDonnees.ActivePageIndex of
//    C_PAGE_PURGE_HISTORIQUE_DELIVRANCE :
//      dmOutilsPHAPHA_fr.setHistoriques.Close;
    C_PAGE_PURGE_ENCOURS :
      dmOutilsPHAPHA_fr.setEncours.Close;
  else
    with FParametresPages[pCtlPurgeDonnees.ActivePageIndex] do
    begin  // cas general
      if Grille.DataSource.DataSet.Active then
        Grille.DataSource.DataSet.Close;

      RadioGroup.ItemIndex := -1;
      //Total.Caption := '';
    end;
  end;

   ResetFenetre;

end;

procedure TfrmPurges.ComptagePage;
var
  lParametresPurge : TParametresThreadRequeteFB;
  lIntPurgees, lIntNonPurgees : integer;
  ctrlPurge, ctrlRestant : string;
begin
  inherited;
  // recupere l etat de la purge en cours
  // execute la requete, affiche les resultats
  // mieux vaut afficher une fenetre d attente si le comptage est long
  if Projet <> nil then
  begin
    if Projet.Thread  then
    begin
      lParametresPurge := TParametresThreadRequeteFB.Create(Projet.PHAConnexion, 'PS_UTL_PHA_PURGER', 4);
      with lParametresPurge do
      begin
        ParametresProc[C_PARAMETRE_PURGE_DONNEES] := pCtlPurgeDonnees.ActivePageIndex+pCtlPurgeDonnees.Pages[pCtlPurgeDonnees.ActivePageIndex].tag;
        ParametresProc[C_PARAMETRE_PURGE_TYPE] := null;
        ParametresProc[C_PARAMETRE_PURGE_PARAMETRE] := null;
        ParametresProc[C_PARAMETRE_PURGE_RESET] := '2'; // 2 = comptage
      end;
      AttendreFinExecution(Self, taLibelle, TThreadRequeteFB, lParametresPurge, 'Comptage des ' + LowerCase(pCtlPurgeDonnees.ActivePage.Caption) + ' purgés ...');

      lIntPurgees := VarAsType(lParametresPurge.ParametresProc[C_PARAMETRE_PURGE_DONNEES_SUPPRIMEES], varInteger);
      lIntNonPurgees := VarAsType(lParametresPurge.ParametresProc[C_PARAMETRE_PURGE_DONNEES_RESTANTES], varInteger);

      ctrlPurge := 'txtTotalPurge' + pCtlPurgeDonnees.Pages[pCtlPurgeDonnees.ActivePageIndex].Caption;
      ctrlRestant := 'txtTotalRestant' + pCtlPurgeDonnees.Pages[pCtlPurgeDonnees.ActivePageIndex].Caption;

      // maj des compteurs qui apparaissent sur la page
      TStaticText(pCtlPurgeDonnees.Pages[pCtlPurgeDonnees.ActivePageIndex].FindChildControl(ctrlPurge)).Caption := inttostr(lIntPurgees);
      TStaticText(pCtlPurgeDonnees.Pages[pCtlPurgeDonnees.ActivePageIndex].FindChildControl(ctrlRestant)).caption := inttostr(lIntNonPurgees);

      if not lParametresPurge.Erreur.Etat then
        MessageDlg('Erreur lors du comptage des données !'#13#10#13#10 +
                   'Message : ' + lParametresPurge.Erreur.Message, mtError, [mbOk], 0);
    end
  end
  else
  begin
    with dmOutilsPHAPHA_fr.sp do
      try
        Transaction.StartTransaction;
        BuildStoredProc('PS_UTL_PHA_PURGER');
        Params.AsString[C_PARAMETRE_PURGE_DONNEES] := IntToStr(pCtlPurgeDonnees.ActivePageIndex);
        Params.IsNull[C_PARAMETRE_PURGE_TYPE] := True;
        Params.IsNull[C_PARAMETRE_PURGE_PARAMETRE] := True;
        Params.AsString[C_PARAMETRE_PURGE_RESET] := '2';  // mode comptage
        Open;
        Close(etmCommit);
        lIntPurgees := Fields.AsInteger[C_PARAMETRE_PURGE_DONNEES_SUPPRIMEES];
        lIntNonPurgees := Fields.AsInteger[C_PARAMETRE_PURGE_DONNEES_RESTANTES];

        ctrlPurge := 'txtTotalPurge' + pCtlPurgeDonnees.Pages[pCtlPurgeDonnees.ActivePageIndex].Caption;
        ctrlRestant := 'txtTotalRestant' + pCtlPurgeDonnees.Pages[pCtlPurgeDonnees.ActivePageIndex].Caption;

        // maj des compteurs qui apparaissent sur la page
        TStaticText(pCtlPurgeDonnees.Pages[pCtlPurgeDonnees.ActivePageIndex].FindChildControl(ctrlPurge)).Caption := inttostr(lIntPurgees);
        TStaticText(pCtlPurgeDonnees.Pages[pCtlPurgeDonnees.ActivePageIndex].FindChildControl(ctrlRestant)).caption := inttostr(lIntNonPurgees);

      except
        on E:Exception do
        begin
          MessageDlg('Erreur lors du comptage des données !'#13#10#13#10 +
                     'Message : ' + E.Message, mtError, [mbOk], 0);
          Close(etmRollback);
        end;
      end;
  end;

  // si rien n' a été purgé , reset inutile bouton à desactiver
  if lIntPurgees = 0 then
    actReset.Enabled := false
  else
    actReset.Enabled := true;
end;



procedure TfrmPurges.FormDestroy(Sender: TObject);
begin
  ResetFenetre;

  inherited;
end;

end.
