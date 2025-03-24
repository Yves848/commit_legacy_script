unit mdlFluxRSS;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, mdlLecteurRSS, StdCtrls, ComCtrls, ToolWin, ShellAPI, ImgList,
  ExtCtrls, mdlPIPanel;

type
  TfrmItemRSS = class(TForm)
    ToolBar1: TToolBar;
    btnPrecedent: TToolButton;
    btnSuivant: TToolButton;
    txtDescription: TStaticText;
    txtLien: TStaticText;
    ImageList1: TImageList;
    pnlTitre: TPIPanel;
    ToolButton3: TToolButton;
    procedure btnPrecedentClick(Sender: TObject);
    procedure btnSuivantClick(Sender: TObject);
    procedure txtLienClick(Sender: TObject);
    procedure FormShortCut(var Msg: TWMKey; var Handled: Boolean);
  private
    { Déclarations privées }
    FFluxRSS : TlecteurRSS;
    FItemEnCours : Integer;
    procedure AfficherItem(AItem : Integer);
  public
    { Déclarations publiques }
    function ShowModal(AFluxRSS : TLecteurRSS; AItemRSS : Integer) : Integer; reintroduce;
  end;

var
  frmItemRSS: TfrmItemRSS;

implementation

{$R *.dfm}

{ TfrmItemRSS }

function TfrmItemRSS.ShowModal(AFluxRSS : TLecteurRSS; AItemRSS : Integer) : Integer;
begin
  FFluxRSS := AFluxRSS;
  Caption := FFluxRSS.Description;

  FItemEnCours := AItemRSS;
  AfficherItem(FItemEnCours);

  Result := inherited ShowModal;
end;

procedure TfrmItemRSS.btnPrecedentClick(Sender: TObject);
begin
  Dec(FItemEnCours);
  AfficherItem(FItemEnCours);
end;

procedure TfrmItemRSS.AfficherItem(AItem: Integer);
begin
  if FItemEnCours = 0 then
  begin
    btnPrecedent.Enabled := False;
    btnSuivant.Enabled := True;
  end
  else
    if FItemEnCours = FFluxRSS.Total - 1 then
    begin
      btnPrecedent.Enabled := True;
      btnSuivant.Enabled := False;
    end
    else
    begin
      btnPrecedent.Enabled := True;
      btnSuivant.Enabled := True;
    end;                         

  with FFluxRSS.Items[AItem] do
  begin
    pnlTitre.Caption := Categorie + ' : ' + Titre;
    txtDescription.Caption := Description;
    txtLien.Caption := Lien;
  end;
end;

procedure TfrmItemRSS.btnSuivantClick(Sender: TObject);
begin
  Inc(FItemEnCours);
  AfficherItem(FItemEnCours);
end;

procedure TfrmItemRSS.txtLienClick(Sender: TObject);
begin
  ShellExecute(0, 'open', PChar(txtLien.Caption), nil, nil, SW_NORMAL);
end;

procedure TfrmItemRSS.FormShortCut(var Msg: TWMKey; var Handled: Boolean);
begin
  if Msg.CharCode = VK_ESCAPE then
  begin
    ModalResult := mrOk;
    Handled := True;
  end;
end;

end.
