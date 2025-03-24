unit mdlPHARMONYFR;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, ioutils,
  Dialogs, mdlModule, mdlModuleImport, DB, PdfDoc, PReport, ExtCtrls, Menus, mdlAttente,
  JvMenus, JvWizard, JvWizardRouteMapNodes, mdlPIPanel, ComCtrls, Grids, mdlProjet,
  mdlPIStringGrid, DBGrids, mdlPIDBGrid, JvExControls, uib,
  JvXPCore, JvXPContainer, ImgList, ActnList, JclStrings, StrUtils, JvXPBar,
  StdCtrls, mdlPIButton, mdlConversionsTIFF, VirtualTrees, JvExExtCtrls, JvNetscapeSplitter,
  mdlTypes, mdlMIPostgreSQL, XMLIntf, JclFileUtils, jclPcre, ZSqlProcessor, ZAbstractConnection, ZConnection, Types;

type

  tSearchPj4 = class(tThread)
  protected
    Procedure Execute; override;
    Procedure DoTerminate; override;
  end;

  TfrPHARMONYFR = class(TfrMIPostgreSQL)
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
    procedure TraiterDonneesPraticiens; override;
    procedure TraiterDonneesOrganismes; override;
    procedure TraiterDonneesClients; override;
    procedure TraiterDonneesProduits; override;
    procedure TraiterDonneesEncours; override;
    procedure TraiterAutresDonnees; override;
    procedure TraiterDonnee(ATraitement: TTraitement); override;
    procedure TraiterProgrammesFidelites;
    function readline(var stream: tStream; var sLine: String): Boolean;
    function FaireTraitementDocumentSF(ARepertoire, afichier: string): TResultatCreationDonnees; override;

  public
    { Déclarations publiques }
    constructor Create(AOwner: TComponent; AModule: TModule); override;
    procedure MakeTemplate(csvFile: String);
  end;

implementation

uses mdlPHARMONYFRPHA, uImportCSV;
{$R *.dfm}

constructor TfrPHARMONYFR.Create(AOwner: TComponent; AModule: TModule);
begin
  inherited;
  ModeConnexion := mcServeurSQL;
end;

procedure TfrPHARMONYFR.wzDonneesActivePageChanged(Sender: TObject);
const
  C_INDEX_PAGE_PROGRAMMES_FIDELITES = 7;
  // pages non traites en automatique Programme Fidelites : parce que pas dans module import
  procedure TraiterDonnee;
  begin
    case wzDonnees.ActivePageIndex of
      C_INDEX_PAGE_PROGRAMMES_FIDELITES:
        TraiterProgrammesFidelites;
    end;
  end;

begin
  inherited;
  if Assigned(Module) and Module.Projet.Ouvert and (wzDonnees.ActivePageIndex = wipProgrammesFidelites.PageIndex) then
    TraiterDonnees(wipProgrammesFidelites, grdProgrammesFidelites, false, TPIList<Integer>.Create([Ord(suppCarteFidelite)]),
      TraiterProgrammesFidelites);
  // on ne touche pas à suppCarteFidelite (qui devrait être suppprogrammefidelits car ça vient de projet
end;

procedure TfrPHARMONYFR.RenvoyerParametresConnexion;
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
    // 'PHARMONYFR';
    if HasAttribute('utilisateur') then
      PHA.ParametresConnexion.Values['utilisateur'] := Attributes['utilisateur']
    else
      PHA.ParametresConnexion.Values['utilisateur'] := 'postgres';
    if HasAttribute('mot_de_passe') then
      PHA.ParametresConnexion.Values['mot_de_passe'] := Attributes['mot_de_passe']
    else
      PHA.ParametresConnexion.Values['mot_de_passe'] := 'postgres';

    // if HasAttribute('dump_postgres') then
    // PHA.ParametresConnexion.Values['dump_postgres'] := Attributes['dump_postgres']
    // else

    // PHA.ParametresConnexion.Values['dump_postgres'] := Module.Projet.RepertoireProjet + 'dump.sql';
    // YG : temporaire.  Le temps de résoudre jira REPF-2995
    PHA.ParametresConnexion.Values['dump_postgres'] := IncludeTrailingBackslash(Module.RepertoireRessources) + 'dump.sql'
  end;
end;

procedure TfrPHARMONYFR.StockerParametresConnexion;
begin
  with Module.Projet.FichierProjet.DocumentElement.ChildNodes['modules'].ChildNodes['import'].ChildNodes['acces_base'] do
  begin
    Attributes['serveur'] := PHA.ParametresConnexion.Values['serveur'];
    Attributes['bd'] := PHA.ParametresConnexion.Values['bd'];
    Attributes['utilisateur'] := PHA.ParametresConnexion.Values['utilisateur'];
    Attributes['mot_de_passe'] := PHA.ParametresConnexion.Values['mot_de_passe'];
  end;
end;

procedure TfrPHARMONYFR.TraiterDonneesPraticiens;
begin
  inherited;
  TraiterDonnee(Traitements.Traitements['Hopitaux']);
  TraiterDonnee(Traitements.Traitements['Praticiens']);
end;

procedure TfrPHARMONYFR.TraiterDonneesOrganismes;
begin
  inherited;
  TraiterDonnee(Traitements.Traitements['Organismes AMO']);
  TraiterDonnee(Traitements.Traitements['Organismes AMC']);
  TraiterDonnee(Traitements.Traitements['Couvertures AMO']);
  TraiterDonnee(Traitements.Traitements['Couvertures AMC']);
  //PHA.ExecuterPS('Destinataire','PS_PHARMONYFR_DESTINATAIRE', null, True, etmCommit);
  TraiterDonnee(Traitements.Traitements['PS_PHARMONYFR_DESTINATAIRE']);
end;

procedure TfrPHARMONYFR.TraiterDonneesClients;
begin
  inherited;
  TraiterDonnee(Traitements.Traitements['Collectivités']);
  TraiterDonnee(Traitements.Traitements['Clients']);
  TraiterDonnee(Traitements.Traitements['Couvertures Clients']);

end;


procedure TfrPHARMONYFR.TraiterAutresDonnees;
begin
    inherited;
    TraiterDonnee(Traitements.Traitements['Historiques clients entetes']);
    TraiterDonnee(Traitements.Traitements['Historiques clients lignes']);
end;

procedure TfrPHARMONYFR.MakeTemplate(csvFile : String);
  const
    CReadBuffer = 2400;
  var
    saSecurity: TSecurityAttributes;
    hRead: THandle;
    hWrite: THandle;
    suiStartup: TStartupInfo;
    piProcess: TProcessInformation;
    pBuffer: array [0 .. CReadBuffer] of AnsiChar;
    dBuffer: array [0 .. CReadBuffer] of AnsiChar;
    dRead: DWORD;
    dRunning: DWORD;
    dAvailable: DWORD;
    aCommand : string;
  begin
    csvFile := StringReplace(csvfile,' ','` ',[rfReplaceAll]);
    aCommand := Format('powershell -noprofile "%s\Modules\Import\Ressources\Nev\make_pg.ps1" -path "%s"',[Module.Projet.RepertoireApplication,csvfile]);
    saSecurity.nLength := SizeOf(TSecurityAttributes);
    saSecurity.bInheritHandle := True;
    saSecurity.lpSecurityDescriptor := nil;

    FillChar(suiStartup, SizeOf(TStartupInfo), #0);
    suiStartup.cb := SizeOf(TStartupInfo);
    suiStartup.hStdInput := hRead;
    suiStartup.hStdOutput := hWrite;
    suiStartup.hStdError := hWrite;
    suiStartup.dwFlags := STARTF_USESTDHANDLES or STARTF_USESHOWWINDOW;
    suiStartup.wShowWindow := SW_HIDE;
    // TODO: Build ACommand
    if CreateProcess(nil, PChar(ACommand), @saSecurity, @saSecurity, True, NORMAL_PRIORITY_CLASS, nil, nil, suiStartup,
      piProcess) then
      try
        repeat
          dRunning := WaitForSingleObject(piProcess.hProcess, 100);
          Application.ProcessMessages;
        until (dRunning <> WAIT_TIMEOUT);
      finally
        CloseHandle(piProcess.hProcess);
        CloseHandle(piProcess.hThread);
      end;

  end;

procedure TfrPHARMONYFR.TraiterDonnee(ATraitement: TTraitement);
var
  sPAth: String;

  Function GetHeaders(csvFile: String): String;
  var
    fCSV: tStream;
  begin
    fCSV := TFileStream.Create(csvFile, fmOpenRead);
    readline(fCSV, result);
    fCSV.free;
  end;

  Procedure SetHeaders(sStrings: tStrings; Headers: String);
  var
    i: Integer;
  begin
    i := 0;
    while i <= sStrings.Count - 1 do
    begin
      if pos('##FIELDS##', sStrings[i]) > 0 then
      begin
        sStrings[i] := StringReplace(sStrings[i], '##FIELDS##', Headers, [rfReplaceAll, rfIgnoreCase]);
        i := sStrings.Count;
      end;
      inc(i);
    end;
  end;

  procedure Execute;
  begin
    ZSQLProc.Connection := ZConnection1;
    if not ZConnection1.Connected then
    begin
      ZConnection1.HostName := PHA.ParametresConnexion.Values['serveur'];
      ZConnection1.Port := 5432;
      ZConnection1.Database := PHA.ParametresConnexion.Values['bd'];
      ZConnection1.Connect;
    end;
    ZSQLProc.Execute;
  end;

  procedure RemoveStartingNewLineFromFile(const FileName: string);
  var
    Reader: TStreamReader;
    Writer: TStreamWriter;
    Line: String;
    DoSearch: Boolean;
    DoWrite: Boolean;

  begin
    Reader := TStreamReader.Create(FileName);
    Writer := TStreamWriter.Create(TPath.ChangeExtension(FileName, '.new'));
    try
      DoSearch := True;
      DoWrite := True;
      while Reader.Peek >= 0 do
      begin
        Line := Reader.readline;
        if DoSearch then
        begin
          DoSearch := not(Line = '');
          DoWrite := DoSearch;
        end;
        if DoWrite then
          Writer.WriteLine(Line)
        else
          DoWrite := True;
      end;
    finally
      Reader.free;
      Writer.free;
      DeleteFile(FileName);
      RenameFile(TPath.ChangeExtension(FileName, '.new'), FileName);
    end;
  end;

  procedure importCSV(csvFile: String);
  var
    sCsv: String;
    sHeaders: String;
    tfImportCSV: TtfImportCSV;
  begin
    screen.Cursor := crSQLWait;
    tfImportCSV := TtfImportCSV.Create(self);
    tfImportCSV.Caption := 'Import CSV en cours';
    tfImportCSV.lblCSV.Caption := Format('%s : %s', [ATraitement.Fichier, csvFile]);
    tfImportCSV.Show;
    Application.ProcessMessages;
    sCsv := Format('%s%s.csv', [sPAth, csvFile]);
    ZSQLProc.Script.LoadFromFile(Format('%s\%s.pg', [Module.RepertoireRessources, csvFile]));
    // set fields list.
    RemoveStartingNewLineFromFile(sCsv);
    sHeaders := GetHeaders(sCsv);
    SetHeaders(ZSQLProc.Script, sHeaders);
    Execute;

    ZSQLProc.Script.Clear;
    ZSQLProc.Script.Text := Format('select fctCreate%s(''%s'')', [csvFile, sCsv]);
    Execute;
    screen.Cursor := crDefault;
    tfImportCSV.free;
  end;


  procedure LaunchImport(csvFile: String);
  var
    filepath : string;
  begin
    filepath := Format('%s%s.csv', [sPAth, csvFile]);
    if fileExists(filepath) then
    begin
//      MakeTemplate(filepath);
      importCSV(csvFile);
    end;
  end;

begin
  // traiter les csv;
  sPAth := IncludeTrailingBackslash(Module.Projet.RepertoireProjet);

  if (ATraitement.Fichier = 'Hopitaux') or (ATraitement.Fichier = 'Praticiens') then
  begin
    LaunchImport('prescribers');
  end;

  if (ATraitement.Fichier = 'Organismes AMO')
      or (ATraitement.Fichier = 'Couvertures AMO')
      or (ATraitement.Fichier = 'Couvertures AMC') then
  begin
    LaunchImport('insurance_covers');
  end;

  if ATraitement.Fichier = 'Organismes AMC' then
  begin
    LaunchImport('supplementary_insurances');
  end;

  if ATraitement.Fichier = 'Collectivités' then
  begin
    LaunchImport('collectivities');
  end;

  if ATraitement.Fichier = 'Clients' then
  begin
    LaunchImport('patients');
  end;


  if ATraitement.Fichier = 'Couvertures Clients' then
  begin
    LaunchImport('insurance_covers');
  end;

  if ATraitement.Fichier = 'Historiques Ventes' then
  begin
    LaunchImport('history_products');
  end;


  if ATraitement.Fichier = 'Produits' then
  begin
    LaunchImport('products');
    LaunchImport('product_codes');
    LaunchImport('product_lpps');
  end;

  if ATraitement.Fichier = 'Stocks' then
  begin
    LaunchImport('Product_stocks');
  end;

  if ATraitement.Fichier = 'Codes Produits' then
  begin
    LaunchImport('afb1cod');
  end;

  if ATraitement.Fichier = 'Fournisseurs - Répartiteurs' then
  begin
    LaunchImport('suppliers');
    LaunchImport('supplier_products');
//    LaunchImport('af30');
//    LaunchImport('af07');
//    LaunchImport('af09');
//    LaunchImport('afnota');
  end;


  if ATraitement.Fichier = 'Zones Geo' then
  begin
    LaunchImport('storage_spaces');
    LaunchImport('storage_locations');
  end;

   if ATraitement.Fichier = 'Vignettes Avancées' then
  begin
    LaunchImport('af37');
  end;

  if ATraitement.Fichier = 'Produits Dus' then
  begin
    LaunchImport('af37');
  end;

  if ATraitement.Fichier = 'Factures en attente' then
  begin
    LaunchImport('af21');
  end;

  if ATraitement.Fichier = 'Credits' then
  begin
    LaunchImport('af04');
  end;

  if ATraitement.Fichier = 'Historiques clients entetes' then
  begin
    LaunchImport('history_patients');
  end;

  if ATraitement.Fichier = 'Historiques clients lignes' then
  begin
    LaunchImport('history_patients');
  end;

//  if ATraitement.Fichier = 'Historiques clients'
  if ATraitement.Fichier = 'Commandes' then
  begin
    LaunchImport('af31');
  end;

  if ATraitement.Fichier = 'Commandes lignes' then
  begin
    LaunchImport('af32');
  end;

  if ATraitement.Fichier = 'Catalogues fournisseurs' then
  begin
    LaunchImport('aff5');
  end;

  if ATraitement.Fichier = 'Catalogues fourn - Prod' then
  begin
    LaunchImport('aff81lp');
    LaunchImport('aff82ps');
  end;

  if ATraitement.Fichier = 'Opérateurs' then
  begin
    LaunchImport('af23');
  end;

  if ATraitement.Fichier = 'Cartes Programmes Relationnels' then
  begin
    LaunchImport('fidrxcartes');
  end;

  inherited TraiterDonnee(ATraitement);

end;



procedure TfrPHARMONYFR.TraiterDonneesProduits;
begin
  inherited;

  TraiterDonnee(Traitements.Traitements['Fournisseurs - Répartiteurs']);
  TraiterDonnee(Traitements.Traitements['Zones Geo']);
  TraiterDonnee(Traitements.Traitements['Produits']);
  TraiterDonnee(Traitements.Traitements['Stocks']);
  //TraiterDonnee(Traitements.Traitements['Codes Produits']);
  TraiterDonnee(Traitements.Traitements['Historiques Ventes']);
  //TraiterDonnee(Traitements.Traitements['Produits - Lpp']);
end;

procedure TfrPHARMONYFR.TraiterDonneesEncours;
begin
  inherited;
  //TraiterDonnee(Traitements.Traitements['Vignettes Avancées']);
  //TraiterDonnee(Traitements.Traitements['Produits Dus']);
  TraiterDonnee(Traitements.Traitements['Crédits']);
  // TraiterDonnee(Traitements.Traitements['Factures en attente']);
end;
//
//procedure TfrPHARMONYFR.TraiterAutresDonnees;
//begin
//  inherited;
//  TraiterDonnee(Traitements.Traitements['Opérateurs']);
//  TraiterDonnee(Traitements.Traitements['Historique délivrances entêtes']);
//  TraiterDonnee(Traitements.Traitements['Historique délivrances lignes']);
//  TraiterDonnee(Traitements.Traitements['Commandes']);
//  TraiterDonnee(Traitements.Traitements['Commandes lignes']);
//  TraiterDonnee(Traitements.Traitements['Catalogues fournisseurs']);
//  TraiterDonnee(Traitements.Traitements['Catalogues fourn - Prod']);
//
//  // pas de traitement auto pour les scans
//  // TraiterDocumentSF(Traitements.Traitements['SCANS'], Module.Projet.RepertoireProjet, '.pdf', True, True);
//
//end;

procedure TfrPHARMONYFR.TraiterProgrammesFidelites;
begin
  TraiterDonnee(Traitements.Traitements['Cartes Programmes Relationnels']);
end;

function TfrPHARMONYFR.FaireTraitementDocumentSF(ARepertoire, afichier: string): TResultatCreationDonnees;
var
  s: string;
  i: Integer;
begin
  s := ExtractFileName(Copy(ARepertoire, 1, Length(ARepertoire) - 1));
  if TryStrToInt(s, i) then
  begin
    result := dmPHARMONYFRPHA.CreerDocument(i, afichier, ARepertoire + afichier);
  end
  else
    result := rcdRejetee;
end;

function TfrPHARMONYFR.readline(var stream: tStream; var sLine: String): Boolean;
var
  ligne: String;
  ch: AnsiChar;
begin
  result := false;
  ch := #0;
  while (stream.read(ch, 1) = 1) and (ch <> #10) do
  begin
    result := True;
    ligne := ligne + ch;
  end;
  sLine := ligne;
  if ch = #10 then
  begin
    result := True;
    // if (stream.read(ch, 1) = 1) and (ch <> #10) then
    // stream.Seek(-1, soCurrent)
  end;
end;

{ tSearchPj4 }

procedure tSearchPj4.DoTerminate;
begin
  inherited;

end;

procedure tSearchPj4.Execute;
begin
  inherited;
  Application.ProcessMessages;
end;

initialization

RegisterClasses([TfrPHARMONYFR, TdmPHARMONYFRPHA]);

finalization

UnRegisterClasses([TfrPHARMONYFR, TdmPHARMONYFRPHA]);

end.
