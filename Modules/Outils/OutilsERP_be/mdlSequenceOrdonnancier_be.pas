unit mdlSequenceOrdonnancier_be;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Spin, Ora, OraError, mdlDialogue;

type
  TfrmSequenceOrdonnancier = class(TfrmDialogue)
    gBoxSeqOrdo: TGroupBox;
    btnOK: TButton;
    btnCancel: TButton;
    edtSeqOrdoLigne: TSpinEdit;
    Label1: TLabel;
    Label2: TLabel;
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
    function ShowModal: Integer; reintroduce;
  end;

var
  frmSequenceOrdonnancier: TfrmSequenceOrdonnancier;

implementation

uses mdlOutilsERPERP_be;

{$R *.dfm}

{ TfrmSequenceOrdonnancier }

function TfrmSequenceOrdonnancier.ShowModal: Integer;
var
  l: Integer;
begin
  l := dmOutilsERPERP_be.RenvoyerDebutSequence('BEL.SEQ_NO_ORDONNANCE')+1 ;

  edtSeqOrdoLigne.Text := IntToStr(l);

  Result := inherited ShowModal;

  // Chargement des nouvelles valeurs
  if Result = mrOk then
  begin
    if l <> edtSeqOrdoLigne.Value then
      dmOutilsERPERP_be.ReInitialiserSequence('BEL.SEQ_NO_ORDONNANCE',edtSeqOrdoLigne.Value);
      ShowMessage('Mise à jour du numéro d ordonnance  OK, Nouvelle valeur : '+ IntToStr(edtSeqOrdoLigne.Value));
      dmOutilsERPERP_be.ReInitialiserTable('BEL.T_NUMEROORDO_NONAFF');
      ShowMessage('Suppression de la table des ordonnances non affectées OK');
  end;
end;

end.
