unit mdlSequenceOrdonnancier_fr;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Spin, Ora, OraError, mdlDialogue;

type
  TfrmSequenceOrdonnancier = class(TfrmDialogue)
    gBoxSeqOrdo: TGroupBox;
    gBoxSeqFact: TGroupBox;
    lblSeqOrdoLigne: TLabel;
    lblSeqOrdoStup: TLabel;
    lblSeqFact: TLabel;
    btnOK: TButton;
    btnCancel: TButton;
    edtSeqOrdoLigne: TSpinEdit;
    edtSeqOrdoStup: TSpinEdit;
    edtSeqFact: TSpinEdit;
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
    function ShowModal: Integer; reintroduce;
  end;

var
  frmSequenceOrdonnancier: TfrmSequenceOrdonnancier;

implementation

uses mdlOutilsERPERP_fr;

{$R *.dfm}

{ TfrmSequenceOrdonnancier }

function TfrmSequenceOrdonnancier.ShowModal: Integer;
var
  l, s, f : Integer;
begin
  l := dmOutilsERPERP_fr.RenvoyerDebutSequence('ERP.SEQ_ID_ORDONNANCIER_LISTE');
  s := dmOutilsERPERP_fr.RenvoyerDebutSequence('ERP.SEQ_ID_ORDONNANCIER_STUP');
  f := dmOutilsERPERP_fr.RenvoyerDebutSequence('ERP.SEQ_NO_FACTURE');

  edtSeqOrdoLigne.Text := IntToStr(l);
  edtSeqOrdoStup.Text := IntToStr(s);
  edtSeqFact.Text := IntToStr(f);

  Result := inherited ShowModal;

  // Chargement des nouvelles valeurs
  if Result = mrOk then
  begin
    if l <> edtSeqOrdoLigne.Value then dmOutilsERPERP_fr.ReInitialiserSequence('ERP.SEQ_ID_ORDONNANCIER_LISTE', edtSeqOrdoLigne.Value);
    if s <> edtSeqOrdoStup.Value then dmOutilsERPERP_fr.ReInitialiserSequence('ERP.SEQ_ID_ORDONNANCIER_STUP', edtSeqOrdoStup.Value);
    if f <> edtSeqFact.Value then dmOutilsERPERP_fr.ReInitialiserSequence('ERP.SEQ_NO_FACTURE', edtSeqFact.Value);
  end;
end;

end.