unit mdlSequenceTUH_be;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Spin, Ora, OraError, mdlDialogue;

type
  TfrmSequenceTUH = class(TfrmDialogue)
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
  frmSequenceTUH: TfrmSequenceTUH;

implementation

uses mdlOutilsERPERP_be;

{$R *.dfm}

{ TfrmSequenceTUH }

function TfrmSequenceTUH.ShowModal: Integer;
var
  l: Integer;
begin
  l := dmOutilsERPERP_be.RenvoyerDebutSequence('BEL.SEQ_NO_SCHEMA_MEDICATION') +1 ;

  edtSeqOrdoLigne.Text := IntToStr(l);

  Result := inherited ShowModal;

  // Chargement des nouvelles valeurs
  if Result = mrOk then
  begin
    if l <> edtSeqOrdoLigne.Value then
      dmOutilsERPERP_be.ReInitialiserSequence('BEL.SEQ_NO_SCHEMA_MEDICATION',edtSeqOrdoLigne.Value);
      ShowMessage('Mise à jour du numéro de bloc/schéma TUH   OK, Nouvelle valeur : '+ IntToStr(edtSeqOrdoLigne.Value));
  end;
end;

end.
