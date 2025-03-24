unit mdlClientFTP;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, IdBaseComponent, IdComponent, IdTCPConnection,
  IdTCPClient, IdFTP, mdlBase, mdlDialogue, StdCtrls, Mask, JvExMask,
  JvSpin, JvExControls, JvComCtrls, ActnList, ImgList, Buttons,
  mdlPISpeedButton, ComCtrls, DateUtils, IdFTPList, JclUnicode,
  IdExplicitTLSClientServerBase, StrUtils, IdFTPListParseBase,
  IdFTPListParseUnix, IdGlobal, Math, VirtualExplorerTree, VirtualTrees,
  mdlPIPanel, mdlListesFichiers, MPShellUtilities;

type
  TConnexion = class
    Serveur : string;
    Port : Integer;
    Utilisateur : string;
    MotDePasse : string;
    RepertoireBase : string;
  end;

  TfrmClientFTP = class(TfrmDialogue)
    pnlConnexion: TPanel;
    lblServeur: TLabel;
    edtServeur: TJvIPAddress;
    lblPort: TLabel;
    edtPort: TJvSpinEdit;
    lblUtilisateur: TLabel;
    edtUtilisateur: TEdit;
    lblMotDePasse: TLabel;
    edtMotDePasse: TEdit;
    bvl: TBevel;
    btnConnexion: TPISpeedButton;
    pnl: TPanel;
    pnlLocal: TPanel;
    spl2: TSplitter;
    vetLocal: TVirtualExplorerTreeview;
    velLocal: TVirtualExplorerListview;
    pnlBandeauLocal: TPIPanel;
    pnlDistant: TPanel;
    spl1: TSplitter;
    pnlBandeauDistant: TPIPanel;
    vstDistantRepertoire: TVirtualStringTree;
    vstDistantFichier: TVirtualStringTree;
    spl3: TSplitter;
    procedure btnConnexionClick(Sender: TObject);
    procedure edtServeurKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ftpClientDisconnected(Sender: TObject);
    procedure vstDistantFichierGetText(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
      var CellText: string);
    procedure vstDistantFichierGetImageIndex(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Kind: TVTImageKind; Column: TColumnIndex;
      var Ghosted: Boolean; var ImageIndex: Integer);
    procedure vstDistantRepertoireClick(Sender: TObject);
    procedure vstDistantFichierDblClick(Sender: TObject);
    procedure velLocalTreeDblClick(Sender: TCustomVirtualExplorerTree;
      Node: PVirtualNode; Button: TMouseButton; Point: TPoint);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    { Déclarations privées }
    FRepertoireLocal : string;
    FRepertoireDistant : PVirtualNode;
    procedure ListerRepertoireDistant(ARepertoire : PVirtualNode);
    function AjouterNoeud(AArbre : TCustomVirtualStringTree; AParent : PVirtualNode;
      ANom, ARepertoire : string;
      ATypeFichier : TIdDirItemType; ATaille : Int64; AModification : TDateTime) : PVirtualNode;
    procedure AjouterTelechargement(AFichier : PRecFichier; ASens : TSensTelechargement);
  public
    { Déclarations publiques }
    function ShowModal(AListe : TStrings; AAutoLogin : TConnexion;
      ARecursif, AVerification : Boolean) : Integer; reintroduce; overload;
  end;

const
  C_REPERTOIRE_FTP = '\Téléchargements\';

var
  frmClientFTP: TfrmClientFTP;

implementation

{$R *.dfm}

const
  C_ICONE_REPERTOIRE = 3;
  C_ICONE_FICHIER = 4;

  C_COLONNE_LIBELLE = 0;
  C_COLONNE_TAILLE = 1;
  C_COLONNE_TYPE = 2;
  C_COLONNE_MODIFICATION = 3;

function SiNoeudExistant(AParent : PVirtualNode; ANoeud : string; AArbre : TBaseVirtualTree = nil) : PVirtualNode;
var
  lNoeud : PVirtualNode;
  lpRecFichier : PRecFichier;
begin
  Result := nil;

  if not Assigned(AArbre) then AArbre := TreeFromNode(AParent);
  if Assigned(AArbre) then
  begin
    lNoeud := AArbre.GetFirstChild(AParent);
    if Assigned(lNoeud) then
      repeat
        lpRecFichier := AArbre.GetNodeData(lNoeud);
        if Assigned(lpRecFichier) then
          if lpRecFichier^.Nom = ANoeud then
            Result := lNoeud
          else
            lNoeud := AArbre.GetNextSibling(lNoeud);
      until not Assigned(lNoeud) or Assigned(Result);
  end
  else
    raise Exception.Create('Arbre non affecté !');
end;

procedure TfrmClientFTP.FormCreate(Sender: TObject);
begin
  inherited;

  FRepertoireLocal := Projet.RepertoireApplication + C_REPERTOIRE_FTP;
  if not DirectoryExists(FRepertoireLocal) then
    CreateDir(FRepertoireLocal);

  vetLocal.RootFolderCustomPath := FRepertoireLocal;
  vstDistantRepertoire.NodeDataSize := SizeOf(TrecFichier);
  vstDistantFichier.NodeDataSize := SizeOf(TrecFichier);

  frmListeFichiers := TfrmListeFichiers.Create(nil);
  frmListeFichiers.Show;

  frmListeFichiers.UtilisationListe := False;
end;

procedure TfrmClientFTP.FormDestroy(Sender: TObject);
begin
  inherited;

  if Assigned(frmListeFichiers) then FreeAndNil(frmListeFichiers);
end;

procedure TfrmClientFTP.btnConnexionClick(Sender: TObject);

  procedure EmpecherFermeture(AEtat : Boolean);
  const
    C_ETAT_CROIX : array[Boolean] of LongWord = (MF_DISABLED, MF_ENABLED);
    C_LIBELLE_BOUTON : array[Boolean] of string = ('Annuler', 'Connexion');
  var
    lHdlMenu : HMENU;
  begin
    lHdlMenu := GetSystemMenu(Handle, False);
    EnableMenuItem(lHdlMenu, SC_CLOSE, C_ETAT_CROIX[AEtat]);

    btnConnexion.Caption := C_LIBELLE_BOUTON[AEtat];
  end;

begin
  inherited;

  if not frmListeFichiers.EnTelechargement then
    with frmListeFichiers.ftpClient do
    begin
      if Connected then
        Disconnect;

      Host := edtServeur.Text;
      Port := edtPort.AsInteger;
      UserName := IfThen(edtUtilisateur.Text <> '', edtUtilisateur.Text, 'anonymous');
      Password := IfThen(edtUtilisateur.Text <> 'anonymous', edtMotDePasse.Text, 'serveur@anonymous');
      Connect;

      if frmListeFichiers.UtilisationListe then
      begin
        EmpecherFermeture(False);
        frmListeFichiers.Telecharger;
        if frmListeFichiers.Annule then
          ModalResult := mrCancel
        else
          if ModalResult = mrCancel then
            ModalResult := mrNone
          else
            ModalResult := mrOk;
      end
      else
      begin
        pnlBandeauDistant.Caption := UserName + '@' + Host;

        FRepertoireDistant := AjouterNoeud(vstDistantRepertoire, nil, '/', '', ditDirectory, -1, 0);
        if Assigned(FRepertoireDistant)then
          ListerRepertoireDistant(FRepertoireDistant);
      end;
    end
  else
  begin
    EmpecherFermeture(True);
    frmListeFichiers.AnnulerTelechargement;
    frmListeFichiers.ftpClient.Disconnect;
    ModalResult := mrCancel;
  end;
end;

procedure TfrmClientFTP.ListerRepertoireDistant(ARepertoire: PVirtualNode);
var
  i : Integer;
  lStrRepertoire : string;
  lpRecFichier : PrecFichier;
begin
  with frmListeFichiers.ftpClient do
    if Connected then
    begin
      lpRecFichier := vstDistantRepertoire.GetNodeData(ARepertoire);
      if Assigned(lpRecFichier) then
      begin
        lStrRepertoire := lpRecFichier^.Source + lpRecFichier^.Nom + '/';
        lStrRepertoire := StringReplace(lStrRepertoire, '//', '/', [rfReplaceAll]);
        ChangeDir(lStrRepertoire);
      end;
      TreeFromNode(ARepertoire).DeleteChildren(ARepertoire);

      try
        List;

        // Suppression de l'existant
        vstDistantFichier.Clear; vstDistantFichier.BeginUpdate;
        vstDistantRepertoire.BeginUpdate;
        for i := 0 to DirectoryListing.Count - 1 do
          // Ajout dans la liste
          with DirectoryListing[i] do
          begin
            AjouterNoeud(vstDistantFichier, nil, FileName, lStrRepertoire, ItemType, Size, ModifiedDate);

            if ItemType = ditDirectory then
              AjouterNoeud(vstDistantRepertoire, ARepertoire, FileName, lStrRepertoire, ditDirectory, 0, -1);
          end;
        vstDistantRepertoire.Expanded[ARepertoire] := True;
        vstDistantRepertoire.Selected[ARepertoire] := True;
      finally
        vstDistantRepertoire.EndUpdate;
        vstDistantFichier.EndUpdate;
      end;
    end;
end;

procedure TfrmClientFTP.edtServeurKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  if Key = VK_RETURN then
    btnConnexion.Click;
end;

procedure TfrmClientFTP.ftpClientDisconnected(Sender: TObject);
begin
  inherited;

  pnlBandeauDistant.Caption := '';
end;

procedure TfrmClientFTP.vstDistantFichierGetText(
  Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex;
  TextType: TVSTTextType; var CellText: string);
var
  lpRecFichier : PrecFichier;
begin
  inherited;

  lpRecFichier := Sender.GetNodeData(Node);
  if Assigned(lpRecFichier) then
  begin
    case Column of
      -1, C_COLONNE_LIBELLE :
        CellText := lpRecFichier^.Nom;

      C_COLONNE_TAILLE :
        if lpRecFichier^.TypeFichier = ditFile then
          CellText := IntToStr(lpRecFichier^.Taille)
        else
          CellText := '';

      C_COLONNE_TYPE :
        if lpRecFichier^.TypeFichier = ditFile then
          CellText := 'Fichier ' + Copy(ExtractFileExt(lpRecFichier^.Nom), 1, Length(lpRecFichier^.Nom))
        else
          CellText := 'Dossier de fichiers';

      C_COLONNE_MODIFICATION :
        CellText := FormatDateTime('DD/MM/YYYY', lpRecFichier^.Modification);
    end;
  end;
end;

function TfrmClientFTP.AjouterNoeud(AArbre : TCustomVirtualStringTree; AParent : PVirtualNode;
  ANom, ARepertoire: string;
  ATypeFichier : TIdDirItemType; ATaille: Int64; AModification: TDateTime) : PVirtualNode;
var
  lpRecFichier : PrecFichier;
begin
  Result := AArbre.AddChild(AParent);
  if Assigned(Result) then
  begin
    lpRecFichier := AArbre.GetNodeData(Result);
    if Assigned(lpRecFichier) then
    begin
      with lpRecFichier^ do
      begin
        Nom := ANom;
        Source := ARepertoire;
        TypeFichier := ATypeFichier;
        Taille := ATaille;
        Modification := AModification;
      end;
    end;
  end;
end;

procedure TfrmClientFTP.vstDistantFichierGetImageIndex(
  Sender: TBaseVirtualTree; Node: PVirtualNode; Kind: TVTImageKind;
  Column: TColumnIndex; var Ghosted: Boolean; var ImageIndex: Integer);
var
  lpRecFichier : PRecFichier;
begin
  inherited;

  lpRecFichier := vstDistantRepertoire.GetNodeData(Node);
  if Assigned(lpRecFichier) and ((Column = -1) or (Column = C_COLONNE_LIBELLE)) then
    ImageIndex := IfThen(lpRecFichier^.TypeFichier = ditDirectory, C_ICONE_REPERTOIRE, C_ICONE_FICHIER)
  else
    ImageIndex := -1;
end;

procedure TfrmClientFTP.vstDistantRepertoireClick(Sender: TObject);
var
  lNoeud : PVirtualNode;
begin
  inherited;

  if not frmListeFichiers.EnTelechargement then
  begin
    lNoeud := vstDistantRepertoire.GetFirstSelected;
    if Assigned(lNoeud) then
      ListerRepertoireDistant(lNoeud);
  end;
end;

procedure TfrmClientFTP.vstDistantFichierDblClick(Sender: TObject);
var
  lNoeud : PVirtualNode;
  lpRecFichier : PRecFichier;
begin
  inherited;

  lpRecFichier := vstDistantFichier.GetNodeData(vstDistantFichier.GetFirstSelected);
  if Assigned(lpRecFichier) then
    if lpRecFichier^.TypeFichier = ditDirectory then
    begin
      lNoeud := SiNoeudExistant(vstDistantRepertoire.GetFirstSelected, lpRecFichier^.Nom);
      if Assigned(lNoeud) then
      begin
        vstDistantRepertoire.Expanded[lNoeud] := True;
        vstDistantRepertoire.Selected[lNoeud] := True;
        vstDistantRepertoireClick(Self);
      end;
    end
    else
      AjouterTelechargement(lpRecFichier, stDownload);
end;

procedure TfrmClientFTP.AjouterTelechargement(AFichier: PRecFichier; ASens : TSensTelechargement);
var
  lNoeud : PVirtualNode;
  lpRecSource, lpRecTelechargement : PRecFichier;
begin
  if Assigned(AFichier) then
  begin
    lNoeud := SiNoeudExistant(nil, AFichier^.Nom, frmListeFichiers.vstListesFichiers);
    if not Assigned(lNoeud) then
    begin
      lNoeud := frmListeFichiers.vstListesFichiers.AddChild(nil);
      if Assigned(lNoeud) then
      begin
        lpRecTelechargement := frmListeFichiers.vstListesFichiers.GetNodeData(lNoeud);
        if Assigned(lpRecTelechargement) then
          with lpRecTelechargement^ do
          begin
            Nom := AFichier^.Nom;
            Source := AFichier^.Source;
            Taille := AFichier^.Taille;
            SensTelechargement := ASens;
            Resursif := AFichier^.Resursif;
            Verification := AFichier^.Verification;
            Progression := 0;
            case ASens of
              stDownload :
                if frmListeFichiers.UtilisationListe then
                  Destination := AFichier^.Destination
                else
                  Destination := IncludeTrailingPathDelimiter(IfThen(vetLocal.SelectedPath = '', FRepertoireLocal, vetLocal.SelectedPath));
              stUpload :
                begin
                  lpRecSource := vstDistantFichier.GetNodeData(vstDistantFichier.GetFirstSelected);
                  if not Assigned(lpRecSource) then
                    lpRecSource := vstDistantRepertoire.GetNodeData(vstDistantRepertoire.GetFirstSelected);

                  if Assigned(lpRecSource) then
                    Destination := lpRecSource^.Source + lpRecSource^.Nom;
                end;
            end;
          end;

        if not frmListeFichiers.UtilisationListe then
          frmListeFichiers.Telecharger;

        if not frmListeFichiers.EnTelechargement then
          ListerRepertoireDistant(vstDistantRepertoire.GetFirstSelected);
      end;
    end;

    if Assigned(lNoeud) then
      frmListeFichiers.vstListesFichiers.Selected[lNoeud] := True;
  end;
end;

procedure TfrmClientFTP.velLocalTreeDblClick(
  Sender: TCustomVirtualExplorerTree; Node: PVirtualNode;
  Button: TMouseButton; Point: TPoint);
var
  lStrTmp : string;
  lNS : TNameSpace;
  lRecFichier : TrecFichier;

  function OkPourTelecharger : Boolean;
  begin
    if Assigned(SiNoeudExistant(nil, ExtractFileName(lStrTmp), vstDistantFichier)) then
      Result := MessageDlg('Ce fichier est déjà présent sur le serveur. Télécharger ?', mtConfirmation, [mbYes, mbNo], 0) = mrYes
    else
      Result := True;
  end;

begin
  inherited;

  if velLocal.ValidateNamespace(Node, lNS) then
    if not lNS.Folder then
    begin
      lStrTmp := lNS.NameForParsing;
      if OkPourTelecharger then
      begin
        FillChar(lRecFichier, SizeOf(TrecFichier), #0);
        with lRecFichier do
        begin
          Nom := ExtractFileName(lStrTmp);
          Source := ExtractFilePath(lStrTmp);
          Taille := lNS.SizeOfFileInt64;

          AjouterTelechargement(@lRecFichier, stUpload);
        end;
      end;
    end;
end;

function TfrmClientFTP.ShowModal(AListe: TStrings; AAutoLogin : TConnexion;
  ARecursif, AVerification : Boolean): Integer;
var
  i : Integer;
  laRecFichier : array of TrecFichier;
begin
  if Assigned(AListe) then
    if AListe.Count > 0 then
    begin
      // Paramètrage de la connexion
      if Assigned(AAutoLogin) then
        if AAutoLogin.Serveur <> '' then
        begin
          edtServeur.Text := AAutoLogin.Serveur;
          edtPort.Value := AAutoLogin.Port;
          edtUtilisateur.Text := AAutoLogin.Utilisateur;
          edtMotDePasse.Text := AAutoLogin.MotDePasse;

          edtServeur.Enabled := False;
          edtPort.Enabled := False;
          edtUtilisateur.Enabled := False;
          edtMotDePasse.Enabled := False;
        end;

      frmListeFichiers.UtilisationListe := True;

      pnlLocal.Hide;
      spl3.Hide;
      pnlDistant.Hide;

      // Liste des fichiers => panel principale
      BorderStyle := bsDialog;
      with frmListeFichiers do
      begin
        ManualDock(pnl);
        SetBounds(0, 0, Self.ClientWidth, Self.ClientHeight);
      end;

      SetLength(laRecFichier, AListe.Count);
      for i := 0 to AListe.Count - 1 do
      begin
        with laRecFichier[i] do
        begin
          Nom := ExtractFileName(StringReplace(AListe.Names[i], '/', '\', [rfReplaceAll]));
          Source := StringReplace(ExtractFilePath(StringReplace(AListe.Names[i], '/', '\', [rfReplaceAll])), '\', '/', [rfReplaceAll]);
          Destination := AListe.ValueFromIndex[i];
          Resursif := ARecursif;
          Verification := AVerification;
        end;

        AjouterTelechargement(@laRecFichier[i], stDownload);
      end;

      Result := inherited ShowModal;
    end
    else
      Result := mrNone
  else
    Result := mrNone;
end;

procedure TfrmClientFTP.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
var
  lNoeud : PVirtualNode;
begin
  inherited;

  if frmListeFichiers.EnTelechargement then
    if MessageDlg('Annuler tous les téléchargements ?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
      with frmListeFichiers do
      begin
        lNoeud := vstListesFichiers.GetFirst;
        if Assigned(lNoeud) then
          repeat
            if lNoeud = NoeudEnCours then
              AnnulerTelechargement
            else
              vstListesFichiers.DeleteNode(lNoeud);
            vstListesFichiers.GetNextSibling(lNoeud);
          until not Assigned(lNoeud);
      end
    else
      CanClose := False;
end;

end.
