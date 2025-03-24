unit mdlFrameVisualisation_be;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, Grids, DBGrids, mdlPIDBGrid, Buttons,
  StdCtrls, DB, Menus, mdlProjet, mdlPISpeedButton, JvMenus;

type
  TfrFrameVisualisation_be = class(TFrame)
    pnlCritere: TPanel;
    lblCritere: TLabel;
    edtCritere: TEdit;
    grdResultat: TPIDBGrid;
    Splitter: TSplitter;
    ScrollBox: TScrollBox;
    dsResultat: TDataSource;
    pmnMenuFrame: TJvPopupMenu;
    btnChercher: TPISpeedButton;
    procedure edtCritereKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtCritereEnter(Sender: TObject);
    procedure edtCritereExit(Sender: TObject);
  private
    FProjet: TProjet;
    FCaption: TCaption;
  protected
    FClientHeight: Integer;
    FClientWidth: Integer;
    procedure grilleLGPI(Sender: TObject;  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure grilleLGPIsimple(Sender: TObject;  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
    { Déclarations privées }
  public
    { Déclarations publiques }
    property Caption : TCaption read FCaption write FCaption;
    property ClientHeight : Integer read FClientHeight;
    property ClientWidth : Integer read FClientWidth;
    property Projet : TProjet read FProjet;
    constructor Create(Aowner : TComponent; AProjet : TProjet); reintroduce; virtual;
    destructor Destroy; override;
    procedure Show; reintroduce; virtual;
    procedure Hide; reintroduce; virtual;

  end;
  TFrFrameVisualisationClasse = class of TfrFrameVisualisation_be;

const
  CL_GRIS_TRES_CLAIR = $00F3F3F3;
  CL_GRIS_CLAIR = $00E0E0E0;
  CL_BLEU_ENTETE = $00E3B29A;
  CL_JAUNE_SELECTION = $008FF4F4;
  CL_VERT_GRILLE =$00CCE0D5 ;
  CL_GRIS_CLAIR_GRILLE =$00EDEDED ;
  CL_ORANGE = $028A1F5  ;
implementation

{$R *.dfm}

{ TfrViewFrame }

constructor TfrFrameVisualisation_be.Create(Aowner: TComponent; AProjet : TProjet);
begin
  inherited Create(Aowner);

  grdResultat.OnDrawColumnCell := self.grilleLGPI ;
  FProjet := AProjet;
end;

procedure TfrFrameVisualisation_be.Hide;
begin
  inherited;

  if Assigned(dsResultat) then
    if Assigned(dsResultat.DataSet) then
      dsResultat.DataSet.Close;
end;

destructor TfrFrameVisualisation_be.Destroy;
begin
  Hide;

  inherited;
end;

procedure TfrFrameVisualisation_be.edtCritereEnter(Sender: TObject);
begin
  edtCritere.Color := CL_JAUNE_SELECTION;
end;

procedure TfrFrameVisualisation_be.edtCritereExit(Sender: TObject);
begin
 edtCritere.Color := CL_GRIS_CLAIR;
end;

procedure TfrFrameVisualisation_be.edtCritereKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_RETURN then
    btnChercher.Click;
end;

procedure TfrFrameVisualisation_be.grilleLGPI(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
    TDBGrid(Sender).BorderStyle := bsNone;
    TDBGrid(Sender).DefaultDrawing := False;
    TDBGrid(Sender).DrawingStyle := gdsGradient;
    TDBGrid(Sender).GradientEndColor := 14790035;
    TDBGrid(Sender).GradientStartColor := 15584957 ;
    TDBGrid(Sender).Options := [dgTitles, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit];
    TDBGrid(Sender).ParentColor := True;


    // OK
    if (gdFocused in State)  or (gdSelected in State) then
      begin
        TDBGrid(Sender).Canvas.Brush.Color := CL_JAUNE_SELECTION
      end
    else
    if (TDBGrid(Sender).DataSource.DataSet.RecNo mod 2) <> 0 then
      TDBGrid(Sender).Canvas.Brush.Color := CL_GRIS_CLAIR_GRILLE
    else
      TDBGrid(Sender).Canvas.Brush.Color := CL_VERT_GRILLE;

    TDBGrid(Sender).Canvas.FillRect(Rect);    // effacement des pixels parasites si fonte differente
end;

procedure TfrFrameVisualisation_be.grilleLGPIsimple(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin

    TDBGrid(Sender).BorderStyle := bsNone;
    TDBGrid(Sender).DefaultDrawing := False;
    TDBGrid(Sender).DrawingStyle := gdsGradient;
    TDBGrid(Sender).GradientEndColor := 14790035;
    TDBGrid(Sender).GradientStartColor := 15584957 ;
    TDBGrid(Sender).Options := [dgTitles, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit];
    TDBGrid(Sender).ParentColor := True;

    if (TDBGrid(Sender).DataSource.DataSet.RecNo mod 2) <> 0 then
      TDBGrid(Sender).Canvas.Brush.Color := CL_GRIS_CLAIR_GRILLE
    else
      TDBGrid(Sender).Canvas.Brush.Color := CL_VERT_GRILLE;

    TDBGrid(Sender).Canvas.FillRect(Rect);    // effacement des pixels parasites si fonte differente
end;

procedure TfrFrameVisualisation_be.Show;
begin
  inherited;

  if Parent.Visible and pnlCritere.Visible then
  begin
    edtCritere.SetFocus;
    edtCritere.Text := '';
  end;
end;

end.




