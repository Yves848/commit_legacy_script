unit mdlGestionCarteRistourne;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Ora, OraSmart, mdlPIDBGrid, OraError, mdlDialogue, Spin;

type
  TfrmGestionCarteRistourne = class(TfrmDialogue)
    btnCarteVirt: TRadioButton;
    btnDynaphar: TRadioButton;
    btnPharmapass: TRadioButton;
    btnMonPharmacien: TRadioButton;
    btnPreimprim: TRadioButton;
    btnCarteImprPlastif: TRadioButton;
    btnCarteImprOffEtiq: TRadioButton;
    btnValider: TButton;
    btnPasCarte: TRadioButton;
    btnVPharma: TRadioButton;
    gBoxSeqCrist: TGroupBox;
    Label1: TLabel;
    edtSeqCrist: TSpinEdit;
    Label2: TLabel;
    procedure btnValiderClick(Sender: TObject);
  private
    { Déclarations privées }
      l: Integer;
  public
    { Déclarations publiques }
    function ShowModal: Integer; reintroduce;
  end;

var
  GestionCarteRistourne: TfrmGestionCarteRistourne;

implementation

uses mdlOutilsERPERP_be;

{$R *.dfm}

{ TfrmGestionCarteRistourne }

function TfrmGestionCarteRistourne.ShowModal: Integer;
begin
  try
    begin
      l := dmOutilsERPERP_be.RenvoyerNumMaxCrist;
    end;
    except
      on E:EOraError do
        begin
          MessageDlg('Impossible de changer la séquence des cartes ristournes : certain numéro de cartes ne sont pas valide, merci de les corriger d abord!',mtError, [mbOk], 0);
          edtSeqCrist.Enabled := false;
        end;
      end;

  edtSeqCrist.Text := IntToStr(l);

  Result := inherited ShowModal;

end;

procedure TfrmGestionCarteRistourne.btnValiderClick(Sender: TObject);
var
   typeCarte : String;
begin

 if (btnCarteImprOffEtiq.Checked) then
    typeCarte := '2'
 else if (btnCarteImprPlastif.Checked) then
    typeCarte := '3'
 else if (btnPreimprim.Checked) then
    typeCarte := '4'
 else if (btnMonPharmacien.Checked) then
    typeCarte := '5'
 else if (btnPharmapass.Checked) then
    typeCarte := '6'
 else if (btnDynaphar.Checked) then
    typeCarte := '7'
 else if (btnCarteVirt.Checked) then
    typeCarte := '1'
 else if (btnPasCarte.Checked) then
    typeCarte := '0'
 else if (btnVPharma.checked) then
    typeCarte := '8'
 else
    typeCarte := '0';

 //Dans le cas des cartes suivantes il faut rajouter le parametre crist.gropement = à
 //0, "Dynaphar", "A"
 //1, "PharmaPass (APPL)", "B"
 //2, "Mon Pharmacien", "C"
 //3, "Lloydspharma" , "1"
 //4 iasis
 //5 vpharma

 dmOutilsERPERP_be.ChangerGestionCarte(typeCarte);
 ShowMessage('Mise à jour cartes ristournes OK');


 dmOutilsERPERP_be.ReInitialiserSequence('BEL.SEQ_NO_CRIST',edtSeqCrist.Value);
 ShowMessage('Mise à jour de la séquence des cartes ristournes OK');

 close;
end;

end.
