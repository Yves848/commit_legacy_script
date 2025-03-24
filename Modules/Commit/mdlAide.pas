unit mdlAide;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, OleCtrls, SHDocVw, mdlDialogue, VirtualTrees, ActnList, ImgList,
  HTTPApp;

type
  TfrmAide = class(TfrmDialogue)
    wbAide: TWebBrowser;
    vstAide: TVirtualStringTree;
    actEnLigne: TAction;
    ilAide: TImageList;
    procedure FormCreate(Sender: TObject);
    procedure actImprimerExecute(Sender: TObject);
    procedure actEnLigneExecute(Sender: TObject);
    procedure vstAideGetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType;
      var CellText: string);
    procedure vstAideClick(Sender: TObject);
    procedure vstAideGetImageIndex(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Kind: TVTImageKind; Column: TColumnIndex;
      var Ghosted: Boolean; var ImageIndex: Integer);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
    function ShowModal(ANom : string) : Integer; reintroduce;
  end;

implementation

uses mdlProjet;

type
  TrecModule = record
    Libelle : string;
    Nom : string;
    TypeModule : TTypeModule;
    IndexImage : Integer;
  end;
  PrecModule = ^TrecModule;

{$R *.dfm}

procedure TfrmAide.FormCreate(Sender: TObject);
var
  i : Integer;
  laPtrNoeuds : array[TTypeModule] of PVirtualNode;

  function AjouterNoeud(ALibelle : string; ANom : string = ''; ATypeModule : TTypeModule = tmCOMMIT; AIndexImage : Integer = -1) : PVirtualNode; overload;
  var
    lpDonneesNoeud : PrecModule;
  begin
    if ATypeModule = tmCOMMIT then
      Result := vstAide.AddChild(nil)
    else
      Result := vstAide.AddChild(laPtrNoeuds[ATypeModule]);
    lpDonneesNoeud := vstAide.GetNodeData(Result);
    lpDonneesNoeud^.Libelle := ALibelle;
    lpDonneesNoeud^.Nom := ANom;
    lpDonneesNoeud^.TypeModule := ATypeModule;
    lpDonneesNoeud^.IndexImage := AIndexImage;
  end;

  function AjouterNoeud(AModule : TModule) : PVirtualNode; overload;
  begin
    with AModule do
      Result := AjouterNoeud(Description, NomModule, TypeModule);
  end;

begin
  inherited;

  vstAide.NodeDataSize := SizeOf(TrecModule);

  vstAide.Clear;
  vstAide.BeginUpdate;

  // Ajout des noeuds principaux
  laPtrNoeuds[tmCOMMIT] := AjouterNoeud('COMMIT', '', tmCOMMIT, 0);
  laPtrNoeuds[tmImport] := AjouterNoeud('Modules d''import', '', tmCOMMIT, 1);
  laPtrNoeuds[tmTransfert] := AjouterNoeud('Modules de transfert', '', tmCOMMIT, 2);
  laPtrNoeuds[tmOutils] := AjouterNoeud('Outils', '', tmCOMMIT, 3);

  for i := 0 to Projet.TotalModules - 1 do
    AjouterNoeud(Projet.ModulesParIndex[i]);
  vstAide.EndUpdate;
end;

procedure TfrmAide.actImprimerExecute(Sender: TObject);
begin
  inherited;

  wbAide.ExecWB(OLECMDID_PRINT, OLECMDEXECOPT_DODEFAULT);
end;

procedure TfrmAide.actEnLigneExecute(Sender: TObject);
begin
  inherited;

  wbAide.Offline := not actEnLigne.Checked;
  vstAide.Visible := not actEnLigne.Checked;
  if not wbAide.Offline then
    wbAide.Navigate('http://repf.groupe.pharmagest.com');
end;

procedure TfrmAide.vstAideGetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: string);
var
  lpDonneesNoeud : PrecModule;
begin
  inherited;

  lpDonneesNoeud := vstAide.GetNodeData(Node);
  CellText := lpDonneesNoeud^.Libelle;
end;

procedure TfrmAide.vstAideClick(Sender: TObject);
var
  lpDonneesNoeud : PrecModule;
begin
  inherited;

  lpDonneesNoeud := vstAide.GetNodeData(vstAide.GetFirstSelected);
  if Assigned(lpDonneesNoeud) then
    if lpDonneesNoeud^.TypeModule = tmCOMMIT then
    begin
      if lpDonneesNoeud^.IndexImage = 0 then
        wbAide.Navigate('file://' + Projet.RepertoireApplication + '/Aide/COMMIT.html');
    end
    else
      wbAide.Navigate('file://' + Projet.RepertoireApplication + '/Aide/' + lpDonneesNoeud^.Nom + '.xml');
end;

procedure TfrmAide.vstAideGetImageIndex(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Kind: TVTImageKind; Column: TColumnIndex;
  var Ghosted: Boolean; var ImageIndex: Integer);
var
  lpDonneesNoeud : PrecModule;
begin
  inherited;

  lpDonneesNoeud := vstAide.GetNodeData(Node);
  if lpDonneesNoeud^.TypeModule = tmCOMMIT then
    ImageIndex := lpDonneesNoeud^.IndexImage
end;

function TfrmAide.ShowModal(ANom: string): Integer;
var
  i, lIntMaxOcc : Cardinal;
  lpNoeud : PVirtualNode;
  lpDonneesNoeud : PrecModule;
begin
  if ANom <> '' then
  begin
    // Sélection du noeud
    i := 0; lIntMaxOcc := vstAide.ChildCount[nil]; lpNoeud := vstAide.GetFirst;
    while (i < lIntMaxOcc) and not vstAide.Selected[lpNoeud] do
    begin
      lpDonneesNoeud := vstAide.GetNodeData(lpNoeud);
      if lpDonneesNoeud^.Nom = ANom then
      begin
        vstAide.Expanded[vstAide.NodeParent[lpNoeud]] := True;
        vstAide.Selected[lpNoeud] := True;
      end
      else
      begin
        lpNoeud := vstAide.GetNext(lpNoeud);
        Inc(i);
      end;
    end;

    // Affichage de l'aide
    wbAide.Navigate('file://' + Projet.RepertoireApplication + '/Aide/' + ANom + '.xml');
  end;

  Result := inherited ShowModal;
end;

end.
