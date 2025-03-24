unit mdlViewDataDestinataires;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, mdlViewFrame, Mask, DBCtrls, mdlViewDataAdresse, ComCtrls,
  Menus, DB, Grids, DBGrids, mdlPIDBGrid, StdCtrls, Buttons,
  mdlPISpeedButton, ExtCtrls, mdlPIIBParser, ImgList;

type
  TfrViewDataDestinataire = class(TfrViewFrame)
    pCtrlDetailDest: TPageControl;
    tShGeneral: TTabSheet;
    frViewDataAdresse: TfrViewDataAdresse;
    tShMessSMTP: TTabSheet;
    lblNetwork: TLabel;
    lblUserName: TLabel;
    lblPassWord: TLabel;
    lblAdrDNS: TLabel;
    lblEMailOCT: TLabel;
    lblFichierAller: TLabel;
    lblFichierRetour: TLabel;
    edtUserName: TDBEdit;
    edtPassWord: TDBEdit;
    edtAddrDNS: TDBEdit;
    edtEMailOCT: TDBEdit;
    edtFichierAller: TDBEdit;
    edtfichierRetour: TDBEdit;
    lblBoiteLettre: TLabel;
    lnlPOP3: TLabel;
    lblSMTP: TLabel;
    lblUserNamePOP3: TLabel;
    lblPassWordPOP3: TLabel;
    lblEMail: TLabel;
    lblTempo: TLabel;
    edtPOP3: TDBEdit;
    edtSMTP: TDBEdit;
    edtUserNamePOP3: TDBEdit;
    edtPassWordPOP3: TDBEdit;
    edtEMail: TDBEdit;
    edtTempo: TDBEdit;
    lblNom: TLabel;
    lblNormes: TLabel;
    lblDestinataire: TLabel;
    lblZoneMessage: TLabel;
    edtNom: TDBEdit;
    lblNormeAller: TLabel;
    lblNormeRetour: TLabel;
    edtNormeAller: TDBEdit;
    edtNormeRetour: TDBEdit;
    lblDestNO: TLabel;
    edtDestNO: TDBEdit;
    lblDestType: TLabel;
    edtNormeType: TDBEdit;
    lblDestApplication: TLabel;
    edtDestApplication: TDBEdit;
    edtZoneMessage: TDBEdit;
    chkOCT: TDBCheckBox;
    lblProtocole: TLabel;
    chkRefusHTP: TDBCheckBox;
    chkGereLot: TDBCheckBox;
    edtProtocole: TDBEdit;
    chkAuthentification: TDBCheckBox;
    lblXSL: TLabel;
    edtXSL: TDBEdit;
    iLstDetailDest: TImageList;
    procedure sBtnSearchClick(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
    constructor Create(Aowner: TComponent); override;
    procedure Hide; override;
  end;

const
  PAGE_GENERAL = 0;
  PAGE_SMTP = 1;

implementation

uses mdlViewDataPHA;

{$R *.dfm}

constructor TfrViewDataDestinataire.Create(Aowner: TComponent);
begin
  inherited;

  // Détails par défaut
  pCtrlDetailDest.ActivePageIndex := PAGE_GENERAL;

  Caption := 'Visualisation destinataires';
end;

procedure TfrViewDataDestinataire.sBtnSearchClick(Sender: TObject);
begin
  inherited;

  Screen.Cursor := crSQLWait;

  if Mode = vmView then
    // Modification requete
    with dmViewDataPHA.dSetViewDataDestinataires do
    begin
      Parser.SetExpression(0, cWhere, 'nom like  ' + QuotedStr(txtCriteria.Text + '%'));
      Open;
    end;

  Screen.Cursor := crDefault;
end;

procedure TfrViewDataDestinataire.Hide;
begin
  inherited;

  txtCriteria.Text := '';
end;

end.
