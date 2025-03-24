unit mdlDetails_fr;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, mdlBase, mdlProjet, mdlFrameVisualisation_fr;

type
  TfrmDetails = class(TfrmBase)
  private
    { Déclarations privées }
    FFrameDetails : TfrFrameVisualisation;
  public
    { Déclarations publiques }
    property FrameDetails : TfrFrameVisualisation read FFrameDetails;
    constructor Create(Aowner : TComponent; AProjet : TProjet;
      AFrameVisualisation : TfrFrameVisualisationClasse); reintroduce;
    destructor Destroy; override;
    function ShowModal(APanelCritere: Boolean = False; AGrille : Boolean = False): Integer; reintroduce;
  end;

var
  frmDetails: TfrmDetails;

implementation

{$R *.dfm}

constructor TfrmDetails.Create(Aowner: TComponent; AProjet : TProjet;
  AFrameVisualisation : TfrFrameVisualisationClasse);
begin
  inherited Create(Aowner, AProjet);

  if Assigned(AFrameVisualisation) then
  begin
    FFrameDetails := AFrameVisualisation.Create(Self, AProjet);
    if Assigned(FFrameDetails) then
    begin
      FFrameDetails.Parent := Self;

      // Gestion de l'affichage
      Caption := FFrameDetails.Caption;
      Height := FFrameDetails.ClientHeight;
      Width := FFrameDetails.ClientWidth;

      // Go ! ! !
      FFrameDetails.Show;
    end;
  end
  else
    raise Exception.Create('Impossible de construire une frame inexistante !');
end;

destructor TfrmDetails.Destroy;
begin
  if Assigned(FFrameDetails) then
    FreeAndNil(FFrameDetails);

  inherited;
end;

function TfrmDetails.ShowModal(APanelCritere: Boolean = False;
  AGrille : Boolean = False): Integer;
begin
  with FFrameDetails do
  begin
    pnlCritere.Visible := APanelCritere;
    Splitter.Visible := APanelCritere;
    grdResultat.Visible := AGrille;
  end;
  Result := inherited ShowModal;
end;

end.
