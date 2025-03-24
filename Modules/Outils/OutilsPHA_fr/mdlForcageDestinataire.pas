unit mdlForcageDestinataire;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, mdlChoixID, ExtCtrls, StdCtrls;

type
  TfrmForcageDestinataire = class(TForm)
    btnOk: TButton;
    btnAnnuler: TButton;
    lblTypeOrganisme: TLabel;
    cbxChoixTypeOrganismes: TComboBox;
    frChoixDestinataire: TfrChoixID;
    lblDestinataire: TLabel;
    bvlSeparateur_1: TBevel;
    lblDepartement: TLabel;
    frChoixDepartement: TfrChoixID;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
    function ShowModal(var ATypeOrganisme : Integer; var ADestinataire : Variant; var ADepartement : Variant) : Integer; reintroduce;
  end;

const
  C_TELETRANS_TOUS_ORGANISMES = 0;
  C_TELETRANS_ORGANISMES_AMO = 1;
  C_TELETRANS_ORGANISMES_AMC = 2;

var
  frmForcageDestinataire: TfrmForcageDestinataire;

implementation

{$R *.dfm}

procedure TfrmForcageDestinataire.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

function TfrmForcageDestinataire.ShowModal(var ATypeOrganisme: Integer; var ADestinataire,
  ADepartement: Variant): Integer;
begin
  frChoixDestinataire.dsChoix.DataSet.Open; frChoixDestinataire.cbxChoix.KeyValue := null;
  frChoixDepartement.dsChoix.DataSet.Open; frChoixDepartement.cbxChoix.KeyValue := null;
  cbxChoixTypeOrganismes.ItemIndex := C_TELETRANS_TOUS_ORGANISMES;

  Result := inherited ShowModal;
  if Result = mrOk then
  begin
    ADestinataire := frChoixDestinataire.cbxChoix.KeyValue;
    ADepartement := frChoixDepartement.cbxChoix.KeyValue;
    ATypeOrganisme := cbxChoixTypeOrganismes.ItemIndex;
  end;

  frChoixDepartement.dsChoix.DataSet.Close;
  frChoixDestinataire.dsChoix.DataSet.Close;
end;

end.
