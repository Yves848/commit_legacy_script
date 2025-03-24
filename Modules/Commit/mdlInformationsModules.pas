unit mdlInformationsModules;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, ExtCtrls, StdCtrls, ComCtrls, mdlPIMemo,
  mdlProjet, Menus, ImgList, StrUtils, Math,
  mdlPIPanel, mdlBase, ToolWin, JclPeImage,
  ActnList, JvXPBar, JvExControls, JvXPCore, JvXPContainer,
  VirtualTrees, mdlDialogue;

type
  TRepertoireScript = array[TTypeModule] of string;

  TfrmInformationsModules = class(TfrmBase)
    xpcInformationsModules: TJvXPContainer;
    xpbModules: TJvXPBar;
    xpbLibrairies: TJvXPBar;
    xpbScriptsSQL: TJvXPBar;
    ilXPBar: TImageList;
    vstDetailsFichiers: TVirtualStringTree;
    procedure xpbModulesItemClick(Sender: TObject; Item: TJvXPBarItem);
    procedure vstDetailsFichiersDblClick(Sender: TObject);
    procedure vstDetailsFichiersGetText(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
      var CellText: string);
    procedure FormCreate(Sender: TObject);
  private
    { Déclarations privées }
    FItemSelectionnee : TJvXPBarItem;
    const RepertoireScript : TRepertoireScript = ('Commun', 'Modules\Import', 'Modules\Transfert', 'Modules\Outils');
  public
    { Déclarations publiques }
  end;

const
  C_CAPTION_FENETRE = 'Informations [%s:%s]';

var
  frmInformationsModules: TfrmInformationsModules;

implementation

uses mdlInformationFichier, mdlVisualisationScriptSQL;

{$R *.dfm}

const
  C_BARRE_MODULES = 0;
  C_ITEM_MODULES_IMPORT = 0;
  C_ITEM_MODULES_TRANSFERT = 1;
  C_ITEM_MODULES_OUTILS = 2;

  C_BARRE_LIBRAIRIES = 1;
  C_ITEM_LIBRAIRIES_UDFS = 0;

  C_BARRE_SCRIPTS_SQL = 2;
  C_SCRIPTS_SQL_COMMUN = 0;
  C_SCRIPTS_SQL_IMPORT =3;
  C_SCRIPTS_SQL_OUTILS = 4;
  C_SCRIPTS_SQL_TRANSFERT = 5;

  C_COLONNE_NOM = 0;
  C_COLONNE_VERSION = 1;
  C_COLONNE_DATE_MODIFICATION = 2;

type
  PrecModule = ^TrecModule;
  TrecModule = record
    Repertoire : string;
    Nom : string;
    Version : string;
    Date : TDateTime;
  end;

{ TfrmModulesInformations }

procedure TfrmInformationsModules.xpbModulesItemClick(Sender: TObject;
  Item: TJvXPBarItem);
var
  lIntNbOcc : Integer;

  procedure RemplirVSTModules(ATypeModule : TTypeModule);
  var
    i : Integer;
    lpRecModule : PrecModule;
    lNoeud : PVirtualNode;
  begin
    vstDetailsFichiers.Clear;

    lIntNbOcc := Projet.TotalModules - 1;
    for i := 0 to lIntNbOcc do
      if Projet.ModulesParIndex[i].TypeModule = ATypeModule then
      begin
        lNoeud := vstDetailsFichiers.AddChild(nil);
        lpRecModule := vstDetailsFichiers.GetNodeData(lNoeud);

        with lpRecModule^ do
        begin
          Nom := Projet.ModulesParIndex[i].NomModule;
          Version := Projet.ModulesParIndex[i].Version;
          Date := Projet.ModulesParIndex[i].DerniereModification;
        end;
      end;
  end;

  procedure RemplirVSTUDF;
  var
    r : string;
    lpRecModule : PrecModule;
    lNoeud : PVirtualNode;
    lUDF : TSearchRec;
    lInfoUDF : TJclPeImage;
  begin
    vstDetailsFichiers.Clear;

    r := Projet.RepertoireApplication + '\UDF\';
    if FindFirst(r + '*.dll', faAnyFile, lUDF) = 0 then
    begin
      repeat
        lInfoUDF := TJclPeImage.Create;
        lInfoUDF.FileName := r + lUDF.Name;

        lNoeud := vstDetailsFichiers.AddChild(nil);
        lpRecModule := vstDetailsFichiers.GetNodeData(lNoeud);

        with lpRecModule^ do
        begin
          Repertoire := r;
          Nom := lUDF.Name;
          Version := lInfoUDF.VersionInfo.FileVersion;
          Date := lInfoUDF.FileProperties.LastWriteTime;
        end;
        FreeAndNil(lInfoUDF);
      until FindNext(lUDF) <> 0;
      FindClose(lUDF);
    end;
  end;

  procedure RemplirVSTScriptsSQL(ATypeModule : TTypeModule);
  var
    r : string;
    lpRecModule : PrecModule;
    lNoeud : PVirtualNode;
    lScriptsSQL : TSearchRec;
  begin
    vstDetailsFichiers.Clear;

    r := Projet.RepertoireApplication + '\Scripts\' + RepertoireScript[ATypeModule] + '\' + IfThen(Item.Tag = 1, Item.Caption + '\');
    if FindFirst(r + '*.sql', faAnyFile, lScriptsSQL) = 0 then
    begin
      repeat
        lNoeud := vstDetailsFichiers.AddChild(nil);
        lpRecModule := vstDetailsFichiers.GetNodeData(lNoeud);

        with lpRecModule^ do
        begin
          Repertoire := r;
          Nom := lScriptsSQL.Name;
          Version := '----';
          FileAge(r + lScriptsSQL.Name, Date)
        end;
      until FindNext(lScriptsSQL) <> 0;
      FindClose(lScriptsSQL);
    end;
  end;

begin
  inherited;

  Caption := Format(C_CAPTION_FENETRE, [(Item.WinXPBar as TJvXPBar).Caption, Item.Caption]);

  FItemSelectionnee := Item;
  vstDetailsFichiers.BeginUpdate;
  case Item.WinXPBar.Tag of
    C_BARRE_MODULES :
      case Item.Index of
        C_ITEM_MODULES_IMPORT : RemplirVSTModules(tmImport);
        C_ITEM_MODULES_TRANSFERT : RemplirVSTModules(tmTransfert);
        C_ITEM_MODULES_OUTILS : RemplirVSTModules(tmOutils);
      end;

    C_BARRE_LIBRAIRIES :
      case Item.Index of
        C_ITEM_LIBRAIRIES_UDFS : RemplirVSTUDF;
      end;

    C_BARRE_SCRIPTS_SQL :
      case Item.Index of
        C_SCRIPTS_SQL_COMMUN, C_SCRIPTS_SQL_COMMUN + 1, C_SCRIPTS_SQL_COMMUN + 2 : RemplirVSTScriptsSQL(tmCommit);
        C_SCRIPTS_SQL_IMPORT : RemplirVSTScriptsSQL(tmImport);
        C_SCRIPTS_SQL_OUTILS : RemplirVSTScriptsSQL(tmOutils);
        C_SCRIPTS_SQL_TRANSFERT : RemplirVSTScriptsSQL(tmTransfert);
      end;
  end;
  vstDetailsFichiers.EndUpdate;
end;

procedure TfrmInformationsModules.FormCreate(Sender: TObject);
begin
  inherited;

  vstDetailsFichiers.NodeDataSize := SizeOf(TrecModule);
end;

procedure TfrmInformationsModules.vstDetailsFichiersDblClick(
  Sender: TObject);
var
  lpRecModule : PrecModule;
begin
  inherited;

  with FItemSelectionnee do
    if WinXPBar.Tag = C_BARRE_SCRIPTS_SQL then
    begin
      lpRecModule := vstDetailsFichiers.GetNodeData(vstDetailsFichiers.GetFirstSelected);
      TfrmVisualisationScriptSQL.Create(Self, Module).ShowModal(lpRecModule^.Repertoire + lpRecModule^.Nom);
    end;
end;

procedure TfrmInformationsModules.vstDetailsFichiersGetText(
  Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex;
  TextType: TVSTTextType; var CellText: string);
var
  lpRecModule : PrecModule;
begin
  inherited;

  lpRecModule := vstDetailsFichiers.GetNodeData(Node);
  case Column of
    C_COLONNE_NOM : CellText := lpRecModule^.Nom;
    C_COLONNE_VERSION : CellText := lpRecModule^.Version;
    C_COLONNE_DATE_MODIFICATION : CellText := FormatDateTime('DD/MM/YYYY', lpRecModule^.Date);
  end;
end;

end.

