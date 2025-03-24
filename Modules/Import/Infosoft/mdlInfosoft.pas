unit mdlInfosoft;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, mdlModule, mdlModuleImport, DB, PdfDoc, PReport, ExtCtrls, Menus, JvMenus,
  JvWizard, JvWizardRouteMapNodes, mdlPIPanel, ComCtrls, Grids, mdlProjet,
  mdlPIStringGrid, DBGrids, mdlPIDBGrid, JvExControls, mdlLectureFichierBinaire, uib,
  JvXPCore, JvXPContainer, ImgList, ActnList, JclStrings, StrUtils, JvXPBar,
  StdCtrls, mdlPIButton, mdlConversionsTIFF, mdlInformationFichier,
  VirtualTrees, JvExExtCtrls, JvNetscapeSplitter;

type
  TfrInfosoft = class(TfrModuleImport)
  private
    { Déclarations privées }
    procedure CreationScan;
  protected
    procedure TraiterDonnee(ATraitement : TTraitement); override;
    function FaireTraitementDonnees(ADonnees : TDonneesFormatees) : TResultatCreationDonnees; override;
    procedure TraiterDonneesPraticiens; override;
    procedure TraiterDonneesOrganismes; override;
    procedure TraiterDonneesClients; override;
    procedure TraiterDonneesProduits; override;
    procedure TraiterDonneesEncours; override;
    procedure TraiterAutresDonnees; override;
  public
    { Déclarations publiques }
    constructor Create(AOwner : TComponent; AModule : TModule); override;
  end;


implementation

uses mdlInfosoftPHA, mdlInfosoftLectureFichier, mdlInfosoftMEDECINS , mdlInfosoftLABFOUR ,
  mdlInfosoftPRODUITS, mdlInfosoftASSURE, mdlInfosoftORGANISM, mdlInfosoftMESSAGES,
  mdlInfosoftCODEREMB, mdlInfosoftLIBCREMB, mdlInfosoftHISTO,
  mdlInfosoftCREDITS, mdlInfosoftAVANCESV, mdlInfosoftSCANCLT,
  mdlInfosoftCOMMANDE, mdlInfosoftPERSONEL;

{$R *.dfm}

constructor TfrInfosoft.Create(AOwner: TComponent; AModule: TModule);
begin
  inherited;

  LectureFichierBinaire := TFichierInfosoft;
end;

procedure TfrInfosoft.TraiterDonneesPraticiens;
begin
  inherited;

  TraiterDonnee(Traitements.Traitements['MEDECINS.DBI']);
end;

procedure TfrInfosoft.TraiterAutresDonnees;
begin
  TraiterDonnee(Traitements.Traitements['HISTO.DBI']);
  TraiterDonnee(Traitements.Traitements['SCANS']);
  TraiterDonnee(Traitements.Traitements['SCANCLT.IDX']);
end;

procedure TfrInfosoft.TraiterDonnee(ATraitement: TTraitement);
begin
  if ATraitement.Fichier = 'SCANS' then
    CreationScan
  else
    //begin
    if ATraitement.Fichier = 'HISTO.DBI' then
      dmInfosoftPHA.HistoriqueClient.Clear;
    {else if ATraitement.Fichier = 'SCANCLT.IDX' then
      begin
        frmConversionTIFF.Show;
        frmConversionTIFF.Initialiser(Module.Projet.RepertoireApplication);
      end;    }

    inherited;
    //end;
end;


procedure TfrInfosoft.TraiterDonneesClients;
begin
  inherited;

  TraiterDonnee(Traitements.Traitements['ASSURES.DBI']);
end;


procedure TfrInfosoft.TraiterDonneesEncours;
begin
  inherited;

  TraiterDonnee(Traitements.Traitements['PERSONEL.IDX']);
  TraiterDonnee(Traitements.Traitements['CREDITS.DBI']);
  TraiterDonnee(Traitements.Traitements['AVANCESV.DBI']);
  TraiterDonnee(Traitements.Traitements['COMMANDE.LST']);
end;

procedure TfrInfosoft.TraiterDonneesOrganismes;
begin
  inherited;

  TraiterDonnee(Traitements.Traitements['ORGANISM.DBI']);
  TraiterDonnee(Traitements.Traitements['LIBCREMB.AMO']);
  TraiterDonnee(Traitements.Traitements['CODEREMB.AMO']);
  TraiterDonnee(Traitements.Traitements['LIBCREMB.AMC']);
  TraiterDonnee(Traitements.Traitements['CODEREMB.AMC']);
  dmInfosoftPHA.ExecuterPS('Destinataire','PS_FORCETRANS', null, True, etmCommit);
end;

procedure TfrInfosoft.TraiterDonneesProduits;
begin
  inherited;

    TraiterDonnee(Traitements.Traitements['LABFOUR.DBI']);
    TraiterDonnee(Traitements.Traitements['PRODUITS.DBI']);
    TraiterDonnee(Traitements.Traitements['MESSAGES.PDT']);
end;

function TfrInfosoft.FaireTraitementDonnees(
  ADonnees: TDonneesFormatees): TResultatCreationDonnees;
var
  s : string;
begin
  if (ADonnees is TMEDECINS) then Result := dmInfosoftPHA.CreerDonnees(TMEDECINS(ADonnees));
  if (ADonnees is TORGANISM) then Result := dmInfosoftPHA.CreerDonnees(TORGANISM(ADonnees));
  if (ADonnees is TLIBCREMB) then Result := dmInfosoftPHA.CreerDonnees(TLIBCREMB(ADonnees));
  if (ADonnees is TCODEREMB) then Result := dmInfosoftPHA.CreerDonnees(TCODEREMB(ADonnees));
  if (ADonnees is TASSURES) then Result := dmInfosoftPHA.CreerDonnees(TASSURES(ADonnees));
  if (ADonnees is TLABFOUR) then Result := dmInfosoftPHA.CreerDonnees(TLABFOUR(ADonnees));
  if (ADonnees is TPRODUITS) then Result := dmInfosoftPHA.CreerDonnees(TPRODUITS(ADonnees));
  if (ADonnees is TMESSAGES) then Result := dmInfosoftPHA.CreerDonnees(TMESSAGES(ADonnees));
  if (ADonnees is THISTO) then Result := dmInfosoftPHA.CreerDonnees(THISTO(ADonnees));
  if (ADonnees is TCREDITS) then Result := dmInfosoftPHA.CreerDonnees(TCREDITS(ADonnees));
  if (ADonnees is TAVANCESV) then Result := dmInfosoftPHA.CreerDonnees(TAVANCESV(ADonnees));

  // Traitement document scan
  if (ADonnees is TSCANCLT) then
    with TSCANCLT(ADonnees) do
    begin
      IDDocument := Module.Projet.RepertoireProjet + 'SCANS\C' + IDDocument + IntToStr(NumeroDocument);
      IDDocument := IDDocument + '.PNG';
      Result := dmInfosoftPHA.CreerDonnees(TSCANCLT(ADonnees));
      {s := IDDocument + '.png';
      IDDocument := IDDocument + '.tif';
      Result := dmInfosoftPHA.CreerDonnees(TSCANCLT(ADonnees));
      if Result = rcdImportee then
        frmConversionTIFF.AjouterDocumentAConvertir(s);}
    end;

  // Traitement commande
  if (ADonnees is TCOMMANDE_LST) then
  begin
    Result := dmInfosoftPHA.CreerDonnees(TCOMMANDE_LST(ADonnees));
    if Result = rcdImportee then
    begin
      s := 'COMMANDE.' + TCOMMANDE_LST(ADonnees).ID;
      with TFichierInfosoft.Create(Module.Projet.RepertoireProjet+s), TCOMMANDE(Donnees) do
      begin
        repeat
          Suivant;
          try
            PHA.ExecuterPS(s, 'PS_INFOSOFT_CREER_LIGNE_CMD',
                         VarArrayOf([TCOMMANDE_LST(ADonnees).ID, CodeCIP, QuantiteCommandee, QuantiteReceptionnee, Prix1, Prix2, Prix3, Prix4]));

          except
          on e:exception do
            showmessage(e.message+', cip='+CodeCIP);
          end;

        until EOF;
        Free;
      end;
    end;
  end;

  if (ADonnees is TPERSONEL) then Result := dmInfosoftPHA.CreerDonnees(TPERSONEL(ADonnees));
end;

procedure TfrInfosoft.CreationScan;
type
  TEnteteArchive = record
    nom_fichier : array[0..11] of AnsiChar;
    filler_1 : array[0..3] of Byte;
    taille : array[0..3] of Byte;
    filler_2 : array[0..3] of Byte;
    type_png : Byte;
    id_png : array[0..2] of AnsiChar;
    desc_png : array[0..3] of Byte;
  end;

var
  tt : TTraitement;
  t : Integer;
  r : TSearchRec;
  f, img : TFileStream;
  e : TEnteteArchive;
  buf_img : TBytes;

begin
  // Extraction des fichiers PNG
  tt := Traitements.Traitements['SCANS'];
  TraitementEnCours := tt;
  if FindFirst(Module.Projet.RepertoireProjet +  '\SCANS'+ '\'+ 'ARCH*.DBI', faAnyFile, r) = 0 then
    if not ForceDirectories(Module.Projet.RepertoireProjet + '\SCANS') then
      Module.Projet.Console.AjouterLigne('Création du répertoire des Scans impossible, traitement annulé !')
  else
    begin
      repeat
        f := TFileStream.Create(Module.Projet.RepertoireProjet + r.Name, fmOpenRead or fmShareDenyWrite);
        while not Annulation and ((f.Position + SizeOf(TEnteteArchive)) < f.Size) do
        begin
          f.ReadBuffer(e, SizeOf(TEnteteArchive));
          with e do
            if (type_png = $89) and (id_png = 'PNG') and
               (desc_png[0] = $D) and (desc_png[1] = $A) and (desc_png[2] = $1A) and (desc_png[3] = $A) then
            begin
              Move(taille, t, 4);
              f.Seek(-8, soCurrent);
              if nom_fichier[0] = 'C' then
              begin
                SetLength(buf_img, t);
                f.ReadBuffer(buf_img[0], t);

                img := TFileStream.Create(Module.Projet.RepertoireProjet + 'SCANS\' +nom_fichier, fmCreate);
                img.WriteBuffer(buf_img[0], t);
                img.Free;

                tt.Succes := tt.Succes + 1;
              end
              else
              begin
                f.Seek(t, soCurrent);
                tt.Rejets := tt.Rejets +1;
              end;
            end;
        end;
        FreeAndNil(f);
      until FindNext(r) <> 0;
      FindClose(r);
      tt.Fait := True;
    end;
end;

initialization
  RegisterClasses([TfrInfosoft, TdmInfosoftPHA]);

finalization
  UnRegisterClasses([TfrInfosoft, TdmInfosoftPHA]);

end.
