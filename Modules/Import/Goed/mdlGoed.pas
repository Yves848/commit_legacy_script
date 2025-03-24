unit mdlGoed;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, ioutils,
  Dialogs, mdlModule, mdlModuleImport, DB, PdfDoc, PReport, ExtCtrls, Menus,mdlAttente,
  JvMenus, JvWizard, JvWizardRouteMapNodes, mdlPIPanel, ComCtrls, Grids, mdlProjet,
  mdlPIStringGrid, DBGrids, mdlPIDBGrid, JvExControls, uib, mdlGoedPha,
  JvXPCore, JvXPContainer, ImgList, ActnList, JclStrings, StrUtils, JvXPBar,
  StdCtrls, mdlPIButton, mdlConversionsTIFF, VirtualTrees, JvExExtCtrls, JvNetscapeSplitter,
  mdlTypes, mdlMIPostgreSQL, XMLIntf, JclFileUtils, jclPcre, ZSqlProcessor, ZAbstractConnection, ZConnection;

type
  TfrGoed = class(TfrMIPostgreSQL)
    grdProgrammesFidelites: TPIStringGrid;
    wipProgrammesFidelites: TJvWizardInteriorPage;
    ZConnection1: TZConnection;
    ZSQLProc: TZSQLProcessor;
    procedure wzDonneesActivePageChanged(Sender: TObject);
  private
    { Déclarations privées }

  protected
    procedure RenvoyerParametresConnexion; override;
    procedure StockerParametresConnexion; override;
    procedure TraiterDonneesClients; override;
    procedure TraiterDonneesProduits; override;
    procedure TraiterAutresDonnees; override;
    procedure TraiterDonnee(ATraitement: TTraitement); override;
    function readline(var stream: tStream; var sLine: String): Boolean;


  public
    { Déclarations publiques }
    constructor Create(AOwner: TComponent; AModule: TModule); override;
  end;

implementation


{$R *.dfm}

constructor TfrGoed.Create(AOwner: TComponent; AModule: TModule);
begin
  inherited;
  ModeConnexion := mcServeurSQL;
end;

procedure TfrGoed.wzDonneesActivePageChanged(Sender: TObject);
const
  C_INDEX_PAGE_PROGRAMMES_FIDELITES = 7;
  // pages non traites en automatique Programme Fidelites : parce que pas dans module import


begin
  inherited;
  
  // on ne touche pas à suppCarteFidelite (qui devrait être suppprogrammefidelits car ça vient de projet
end;

procedure TfrGoed.RenvoyerParametresConnexion;
begin
  if PHA.ParametresConnexion.IndexOfName('serveur') = -1 then
    PHA.ParametresConnexion.Add('serveur=');
  if PHA.ParametresConnexion.IndexOfName('bd') = -1 then
    PHA.ParametresConnexion.Add('bd=');
  if PHA.ParametresConnexion.IndexOfName('utilisateur') = -1 then
    PHA.ParametresConnexion.Add('utilisateur=');
  if PHA.ParametresConnexion.IndexOfName('mot_de_passe') = -1 then
    PHA.ParametresConnexion.Add('mot_de_passe=');
  if PHA.ParametresConnexion.IndexOfName('dump_postgres') = -1 then
    PHA.ParametresConnexion.Add('dump_postgres=');

  with Module.Projet.FichierProjet.DocumentElement.ChildNodes['modules'].ChildNodes['import'].ChildNodes['acces_base'] do
  begin
    if HasAttribute('serveur') then
      PHA.ParametresConnexion.Values['serveur'] := Attributes['serveur']
    else
      PHA.ParametresConnexion.Values['serveur'] := '127.0.0.1';
    if HasAttribute('bd') then
      PHA.ParametresConnexion.Values['bd'] := Attributes['bd']
    else
      PHA.ParametresConnexion.Values['bd'] := changeFileExt(ExtractFileName(Module.Projet.FichierProjet.FileName), '');
    // 'DynaCaisse';
    if HasAttribute('utilisateur') then
      PHA.ParametresConnexion.Values['utilisateur'] := Attributes['utilisateur']
    else
      PHA.ParametresConnexion.Values['utilisateur'] := 'postgres';
    if HasAttribute('mot_de_passe') then
      PHA.ParametresConnexion.Values['mot_de_passe'] := Attributes['mot_de_passe']
    else
      PHA.ParametresConnexion.Values['mot_de_passe'] := 'postgres';

    if HasAttribute('dump_postgres') then
      PHA.ParametresConnexion.Values['dump_postgres'] := Attributes['dump_postgres']
    else
      PHA.ParametresConnexion.Values['dump_postgres'] := Module.Projet.RepertoireProjet + 'global.dumpall.gz';
  end;
end;

procedure TfrGoed.StockerParametresConnexion;
begin
  with Module.Projet.FichierProjet.DocumentElement.ChildNodes['modules'].ChildNodes['import'].ChildNodes['acces_base'] do
  begin
    Attributes['serveur'] := PHA.ParametresConnexion.Values['serveur'];
    Attributes['bd'] := PHA.ParametresConnexion.Values['bd'];
    Attributes['utilisateur'] := PHA.ParametresConnexion.Values['utilisateur'];
    Attributes['mot_de_passe'] := PHA.ParametresConnexion.Values['mot_de_passe'];
  end;
end;



procedure TfrGoed.TraiterDonnee(ATraitement: TTraitement);
var
  sPAth : String;

  Function GetHeaders(csvFile : String) : String;
  var
    fCSV : tStream;
  begin
      fCSV := TFileStream.Create(csvFile, fmOpenRead);
      readline(fCSV,result);
      fCSV.free;
  end;

  Procedure SetHeaders(sStrings : tStrings; Headers : String);
  var
     i : Integer;
  begin
     i := 0;
     while i <= sStrings.Count -1 do
     begin
       if pos('##FIELDS##',sStrings[i]) > 0 then
       begin
          sStrings[i]  := StringReplace(sStrings[i], '##FIELDS##', Headers,[rfReplaceAll, rfIgnoreCase]);
          i := sStrings.Count;
       end;
       inc(i);
     end;
  end;

  procedure execute;
  begin
    ZSQLProc.Connection := ZConnection1;
    if not ZConnection1.Connected then
    begin
      ZConnection1.HostName := PHA.ParametresConnexion.Values['serveur'];
      zConnection1.Port := 5432;
      zConnection1.Database := PHA.ParametresConnexion.Values['bd'];
      ZConnection1.Connect;
    end;
    ZSQLProc.execute;
  end;

  procedure importCSV(csvFile : String);
  var
    sCsv : String;
    sHeaders : String;
  begin
    screen.Cursor := crSQLWait;
    sCSV := format('%s%s.csv',[sPath,csvFile]);
    ZSQLProc.Script.LoadFromFile(format('%s\%s.pg', [Module.RepertoireRessources, csvFile]));
    // set fields list.
    sHeaders := GetHeaders(sCSV);
    SetHeaders(ZSQLProc.Script,sHeaders);
    execute;

    zSQLProc.Script.Clear;
    ZsqlProc.Script.Text := format('select fctCreate%s(''%s'')',[csvfile,sCSV]);
    execute;
    screen.Cursor := crDefault;
  end;

  procedure LaunchImport(csvFile : String);
  begin
    if fileExists(format('%s%s.csv',[sPath,csvFile])) then
       importCSV(csvFile);
  end;

begin
  // traiter les csv;
   sPath := IncludeTrailingBackslash(Module.Projet.RepertoireProjet);
  // if ATraitement.Fichier = 'Clients' then    // clients-full.csv
  // begin
  //    LaunchImport('Clients');
  // end;

  // if ATraitement.Fichier = 'Produits' then
  // begin
  //   LaunchImport('Produits');
  // end;

  // if ATraitement.Fichier = 'Ventes' then
  // begin
  //   LaunchImport('Ventes');
  // end;

  // if ATraitement.Fichier = 'ClientsSuite' then  // clients.csv
  // begin
  //   LaunchImport('ClientsSuite');
  // end;

  inherited TraiterDonnee(ATraitement);

end;

procedure TfrGoed.TraiterDonneesClients;
begin
  inherited;

  TraiterDonnee(Traitements.Traitements['Clients']);
  TraiterDonnee(Traitements.Traitements['Attestations']);


end;

procedure TfrGoed.TraiterDonneesProduits;
begin
  inherited;

  TraiterDonnee(Traitements.Traitements['Produits']);
  TraiterDonnee(Traitements.Traitements['Codes Barres']);
end;

procedure TfrGoed.TraiterAutresDonnees;
begin
  inherited;
  TraiterDonnee(Traitements.Traitements['Historiques clients']);
  TraiterDonnee(Traitements.Traitements['Historiques clients lignes']);
end;



function TfrGoed.readline(var stream: tStream; var sLine: String): Boolean;
var
  ligne: String;
  ch: ansiChar;
begin
  result := false;
  ch := #0;
  while (stream.read(ch, 1) = 1) and (ch <> #10) do
  begin
    result := true;
    ligne := ligne + ch;
  end;
  sLine := ligne;
  if ch = #10 then
  begin
    result := true;
    //if (stream.read(ch, 1) = 1) and (ch <> #10) then
    //  stream.Seek(-1, soCurrent)
  end;
end;





initialization

RegisterClasses([TfrGoed, TdmGoedPHA]);

finalization

UnRegisterClasses([TfrGoed, TdmGoedPHA]);

end.
