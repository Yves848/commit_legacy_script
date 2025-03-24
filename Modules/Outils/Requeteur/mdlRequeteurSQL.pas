unit mdlRequeteurSQL;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, SynEditHighlighter, SynHighlighterSQL, StdCtrls, Grids,
  DBGrids, mdlPIDBGrid, SynEdit, SynMemo, ExtCtrls, JvXPBar, JvExControls,
  JvXPCore, JvXPContainer, mdlDialogue, ActnList, ImgList, mdlBase, mdlModule,
  mdlPHA, Menus, JvMenus, Clipbrd, StrUtils, ComCtrls, mdlProjet,
  mdlPIStringGrid, JvExGrids, JvStringGrid, JvExStdCtrls, JvListBox, Mask,
  JvExMask, JvToolEdit, SynCompletionProposal;

type
  TRequeteur = class
  private
    FListeTables: TStringList;
    FIntfRequeteur: IRequeteur;
    FDataSet: TDataset;
    FRequeteEnCours: string;
    FPlanExecutionEnCours: string;
    FModule: TModule;
  public
    property Module : TModule read FModule;
    property IntfRequeteur : IRequeteur read FIntfRequeteur;
    property DataSet : TDataset read FDataSet;
    property ListeTables : TStringList read FListeTables;
    property RequeteEnCours : string read FRequeteEnCours write FRequeteEnCours;
    property PlanExecutionEnCours : string read FPlanExecutionEnCours write FPlanExecutionEnCours;
    constructor Create(AModule : TModule); reintroduce;
    destructor Destroy; override;
    function Connecter : Boolean;
    procedure RafraichirListeTables;
  end;

  TfrmRequeteurSQL = class(TfrmDialogue)
    sqlHighLight: TSynSQLSyn;
    dsResultat: TDataSource;
    xpcListeTablesVues: TJvXPContainer;
    actExecuter: TAction;
    actExecuterScript: TAction;
    actOuvrir: TAction;
    od: TOpenDialog;
    actSauvegarderCSV: TAction;
    actCommit: TAction;
    actRollback: TAction;
    pnlTitreFiltre: TPanel;
    xpbTitre: TJvXPBar;
    mnuEditeur: TJvPopupMenu;
    sd: TSaveDialog;
    actSauvegarderSQL: TAction;
    actExecuterSelection: TAction;
    Edition1: TMenuItem;
    mnuEditionColler: TMenuItem;
    mnuEditionCopier: TMenuItem;
    mnuEditionCouper: TMenuItem;
    mnuEditionSeparateur_1: TMenuItem;
    mnuEditionSelectionnerTout: TMenuItem;
    mnuSeparateur_1: TMenuItem;
    tcBD: TTabControl;
    grdResultat: TPIDBGrid;
    mmErreurs: TMemo;
    spl2: TSplitter;
    N1: TMenuItem;
    Rafraichirlalistedestables1: TMenuItem;
    ilBase: TImageList;
    mnugrille: TJvPopupMenu;
    Compter: TMenuItem;
    Copier: TMenuItem;
    Collerdanslditeur1: TMenuItem;
    CopierLigne: TMenuItem;
    CopierTout: TMenuItem;
    xpchaut: TPanel;
    lbxTables: TJvListBox;
    exporterSQL: TMenuItem;
    cmbFiltre: TJvComboEdit;
    SynCompletionProposal1: TSynCompletionProposal;
    xpcBas: TPanel;
    xpchistosql: TPanel;
    HistoSQL: TJvListBox;
    edtChercheHisto: TJvComboEdit;
    mmSQL: TSynMemo;
    spl1: TSplitter;
    procedure FormCreate(Sender: TObject);
    procedure actExecuterExecute(Sender: TObject);
    procedure actExecuterScriptExecute(Sender: TObject);
    procedure actOuvrirExecute(Sender: TObject);
    procedure actSauvegarderCSVExecute(Sender: TObject);
    procedure actCommitExecute(Sender: TObject);
    procedure actRollbackExecute(Sender: TObject);
    procedure actImprimerExecute(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure actSauvegarderSQLExecute(Sender: TObject);
    procedure actExecuterSelectionExecute(Sender: TObject);
    procedure mnuEditionCouperClick(Sender: TObject);
    procedure mnuEditionCopierClick(Sender: TObject);
    procedure mnuEditionCollerClick(Sender: TObject);
    procedure mnuEditionSelectionnerToutClick(Sender: TObject);
    procedure mnuEditeurPopup(Sender: TObject);
    procedure tcBDChange(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Rafraichirlalistedestables1Click(Sender: TObject);
    procedure tcBDChanging(Sender: TObject; var AllowChange: Boolean);
	  procedure mmSQLChange(Sender: TObject);
    procedure grdResultatTitleClick(Column: TColumn);
    procedure mnuGrillePopup(Sender: TObject);
    procedure CopierClick(Sender: TObject);
    procedure CompterClick(Sender: TObject);
    procedure SelectAllClick(Sender: TObject);
    procedure Collerdanslditeur1Click(Sender: TObject);
    procedure CopierLigneClick(Sender: TObject);
    procedure CopierToutClick(Sender: TObject);
    procedure HistoSQLMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure HistoSQLMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure pnlTitreFiltreMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure lbxTablesMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure lbxTablesMouseEnter(Sender: TObject);
    procedure lbxTablesMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure HistoSQLDrawItem(Control: TWinControl; Index: Integer;
      Rect: TRect; State: TOwnerDrawState);
    procedure edtChercheHistoChange(Sender: TObject);
    procedure exporterSQLClick(Sender: TObject);
    procedure cmbFiltreChange(Sender: TObject);
    procedure grdResultatDblClick(Sender: TObject);
    procedure listechampClick(Sender: TObject);
    procedure CopierCellule(Origine : TPoint);
    procedure mmSQLKeyPress(Sender: TObject; var Key: Char);
    procedure SynCompletionProposal1AfterCodeCompletion(Sender: TObject;
      const Value: string; Shift: TShiftState; Index: Integer; EndToken: Char);
  private
    { Déclarations privées }
    FTabCourant : Integer;
    procedure CreerListeTables;
    procedure ChargerHistoriqueRequetes(filtre : string = '' );
    procedure ExecuterRequete(ASQL : string);
    procedure ChargerListeChamps;

  public
    { Déclarations publiques }
  end;

implementation

uses mdlRequeteurBaseLocale, mdlGenerationSQL;

{$R *.dfm}

const
  C_MAX_HISTORIQUE_REQUETES = 12;
  LISTECOUNT = 20;
  CHEMIN : array[0..2] of string = ('Import' , 'Locale', 'Transfert');
{ TTfrRequeteurSQL }


procedure TfrmRequeteurSQL.tcBDChange(Sender: TObject);
var
  i : Integer;
  r : TRequeteur;
begin
  inherited;

  r := TRequeteur(tcBD.Tabs.Objects[tcBD.TabIndex]);
  with r do
  begin
    if not Assigned(DataSet) or not Assigned(ListeTables) then
    begin
      if Connecter then
      begin
        RafraichirListeTables;

        for i := 0 to alActionsSupp.ActionCount - 1 do
          TAction(alActionsSupp[i]).Enabled := True;

        mmSQL.Lines.Clear;
        mmErreurs.Lines.Clear;
      end
      else
        tcBD.TabIndex := FTabCourant;
    end;

    CreerListeTables;
    ChargerHistoriqueRequetes;
    dsResultat.DataSet := TRequeteur(tcBD.Tabs.Objects[tcBD.TabIndex]).IntfRequeteur.RenvoyerDataSet;
    mmSQL.Lines.Text := RequeteEnCours;
    mmErreurs.Lines.Text  := PlanExecutionEnCours;

    ActiveControl := mmSQL;
  end;
end;

procedure TfrmRequeteurSQL.tcBDChanging(Sender: TObject;
  var AllowChange: Boolean);
begin
  inherited;

  FTabCourant := tcBD.TabIndex;
  with TRequeteur(tcBD.Tabs.Objects[tcBD.TabIndex]) do
  begin
    RequeteEnCours := mmSQL.Lines.Text;
    PlanExecutionEnCours := mmErreurs.Lines.Text;
  end;
end;

procedure TfrmRequeteurSQL.ChargerHistoriqueRequetes(filtre : string  );
var
  i : integer ;
  ListeRequetes : TsearchRec;
  fichiers,contenufichier : TStringList;
  requete : string;

  function FileTimeToDateTime(FileTime: TFileTime): TDateTime;
  var
    ModifiedTime: TFileTime;
    SystemTime: TSystemTime;
  begin
    Result := 0;
    if (FileTime.dwLowDateTime = 0) and (FileTime.dwHighDateTime = 0) then
      Exit;
    try
      FileTimeToLocalFileTime(FileTime, ModifiedTime);
      FileTimeToSystemTime(ModifiedTime, SystemTime);
      Result := SystemTimeToDateTime(SystemTime);
    except
      Result := Now;
    end;
  end;
begin

  fichiers := TStringList.Create;
  contenufichier := TStringList.Create;

  if FindFirst(projet.RepertoireProjet+'\Requetes\'+CHEMIN[tcBD.TabIndex]+'\'+'*.sql',faAnyFile,ListeRequetes)=0 then
  repeat
    contenufichier.LoadFromFile(projet.RepertoireProjet+'\Requetes\'+CHEMIN[tcBD.TabIndex]+'\'+ListeRequetes.FindData.cFileName);
    requete := '';
    for i := 0 to contenufichier.Count - 1 do
    begin
     requete := requete + contenufichier[i]+ #13#10;
    end;
    fichiers.Add(DateTimeToStr(FileTimeToDateTime( ListeRequetes.FindData.ftCreationTime )) +';'+ trim(requete) );

  until FindNext(ListeRequetes)<> 0;
  fichiers.Sort;
  HistoSQL.Clear;
  for i :=  fichiers.Count - 1  downto 0 do
  begin
   requete := copy(fichiers[i],pos(';',fichiers[i])+1,length(fichiers[i])-pos(fichiers[i],';'));
   if ( ((trim(filtre)='') or  (pos(uppercase(filtre),uppercase(requete)) > 0)) // filtre
   and (HistoSQL.SearchExactString(requete,false) < 1 )   )  // doublons
    then
      HistoSQL.Items.Add(requete);

  end;


  fichiers.Free;
  contenufichier.Free

end;

procedure TfrmRequeteurSQL.cmbFiltreChange(Sender: TObject);
var
  l : Integer;
begin
  inherited;

    CreerListeTables;
end;

procedure TfrmRequeteurSQL.CompterClick(Sender: TObject);
var nombrerecord : longint;
begin
  inherited;

  nombrerecord :=0;
  grdResultat.DataSource.DataSet.DisableControls;
  Screen.Cursor := crHourGlass;
  with grdResultat.datasource.dataset do
  begin
    first;
    while not EOF do
    begin
      inc(nombrerecord);
      next;
    end;
  end;
  grdResultat.DataSource.DataSet.EnableControls;
  Screen.Cursor := crDefault;
  mmErreurs.Lines.Add('Nombres de lignes : '+ inttostr(NombreRecord) ) ;

  end;

procedure TfrmRequeteurSQL.Collerdanslditeur1Click(Sender: TObject);
begin
  inherited;
  Clipboard.AsText := Clipboard.AsText;
  mmSQL.PasteFromClipboard;

end;

procedure TfrmRequeteurSQL.CopierClick(Sender: TObject);
begin
  inherited;

  CopierCellule( mnugrille.PopupPoint ) ;

end;

procedure TfrmRequeteurSQL.CopierCellule( Origine : TPoint);
var GC : TGridCoord;
    Point1 : TPoint;
begin
  inherited;

  point1 := Origine ;
  point1 := grdResultat.ScreenToClient(point1);
  GC := grdResultat.MouseCoord(Point1.X,Point1.Y);

  if GC.Y = 0 then
    Clipboard.AsText := grdResultat.Columns[GC.X-1].FieldName
  else if GC.X >= 1 then
     if (grdResultat.Columns[GC.X-1].field.DataType  in [ftInteger,ftSmallint,ftFloat,ftBCD]) then
      Clipboard.AsText := grdResultat.Columns[GC.X-1].field.asstring
     else
      Clipboard.AsText := AnsiQuotedStr(grdResultat.Columns[GC.X-1].field.asstring ,'''') ;
end;

procedure TfrmRequeteurSQL.CopierLigneClick(Sender: TObject);
var GC : TGridCoord;
    Point1 : TPoint;
    i : integer;
    PressePapier : string;
begin
  inherited;

  grdResultat.DataSource.DataSet.DisableControls;
  Screen.Cursor := crHourGlass;
  point1 := mnugrille.PopupPoint ;
  point1 := grdResultat.ScreenToClient(point1);
  GC := grdResultat.MouseCoord(Point1.X,Point1.Y);
  Clipboard.Clear;
  PressePapier := '';
  for i := 0 to grdResultat.DataSource.DataSet.FieldCount -1 do
    if GC.Y = 0 then
      PressePapier := PressePapier + grdResultat.Columns[i].FieldName + #9
    else
      PressePapier := PressePapier + grdResultat.Columns[i].field.asstring + #9;

  Clipboard.AsText := PressePapier;
  grdResultat.DataSource.DataSet.EnableControls;
  Screen.Cursor := crDefault;
end;

procedure TfrmRequeteurSQL.CopierToutClick(Sender: TObject);
var i,j : integer;
    PressePapier : string;
begin
  inherited;
  grdResultat.DataSource.DataSet.DisableControls;
  with grdResultat.datasource.dataset do
  begin
    first;
    Clipboard.Clear;
    PressePapier := '';
    Screen.Cursor := crHourGlass;
    j := 0 ;
    while not EOF do
    begin
      for i := 0 to grdResultat.DataSource.DataSet.FieldCount -1 do
        if ((j = 0) and ((sender as TMenuItem).tag = 1)) then
          PressePapier := PressePapier + grdResultat.Columns[i].FieldName + #9 ;
      //PressePapier := PressePapier + #13#10 ;

      for i := 0 to grdResultat.DataSource.DataSet.FieldCount -1 do
        PressePapier := PressePapier + grdResultat.Columns[i].field.asstring + #9;

      Inc(j);
      PressePapier := PressePapier + #13#10 ;
      next;
    end;
  end;
  Clipboard.AsText := PressePapier;
  Screen.Cursor := crDefault;
  grdResultat.DataSource.DataSet.EnableControls;
end;

procedure TfrmRequeteurSQL.CreerListeTables;
var
  i : Integer;

  procedure AjouterTable(ATable : string);
  begin
   lbxTables.Items.Add(ATable);
  end;

begin
// recuperation de la liste des tables et vue
  lbxTables.Items.Clear;
  with TRequeteur(tcBD.Tabs.Objects[tcBD.TabIndex]) do
    for i := 0 to ListeTables.Count - 1 do
    begin
      SynCompletionProposal1.ItemList.Add(ListeTables[i]);
      if cmbFiltre.text <> '' then
      begin
        if Pos(UpperCase(cmbFiltre.text), UpperCase(ListeTables[i])) > 0  then
          AjouterTable(ListeTables[i]);
      end
      else
        AjouterTable(ListeTables[i]);
     end;
end;

procedure TfrmRequeteurSQL.ChargerListeChamps;
var
 i : Integer;
 lMenu : TMenuItem;
begin
  // mise a jour du menu contextuel de l editeur = liste des tables et champs


  // on garde toujours les 2 premiers items Edition
  while mnuEditeur.Items.Count > 3 do
    mnuEditeur.Items.Delete(3);
  // les champs suivant etant les champs de la derniere requete executée

  // pour l auto completion le debut de liste est statique = mots, fonctions SQL ...
  with  TRequeteur(tcBD.Tabs.Objects[tcBD.TabIndex]) do
    while SynCompletionProposal1.ItemList.Count > ( LISTECOUNT -1) do
      SynCompletionProposal1.ItemList.Delete(LISTECOUNT -1);
  // le reste de la liste est dynamique = champs issus de la derniere requete

  // d'abords les champs
  // premier passage pour proposer en priorite les ID
  for i := 0 to dsResultat.DataSet.FieldCount - 1 do
  begin
  if ( pos('_ID',UpperCase(dsResultat.DataSet.Fields[i].FieldName)) > 0  ) then
    begin
      lMenu := TMenuItem.Create(Self);
      lMenu.Caption := dsResultat.DataSet.Fields[i].FieldName ;
      SynCompletionProposal1.ItemList.add(dsResultat.DataSet.Fields[i].FieldName );
      lMenu.OnClick := listechampclick;
      mnuEditeur.Items.Add(lMenu);
    end;
  end ;

  for i := 0 to dsResultat.DataSet.FieldCount - 1 do
  begin
  if ( pos('_ID',UpperCase(dsResultat.DataSet.Fields[i].FieldName)) = 0  ) then
    begin
      lMenu := TMenuItem.Create(Self);
      lMenu.Caption := dsResultat.DataSet.Fields[i].FieldName ;
      SynCompletionProposal1.ItemList.add(dsResultat.DataSet.Fields[i].FieldName );
      lMenu.OnClick := listechampclick;
      mnuEditeur.Items.Add(lMenu);
    end;
  end;

  // puis les nom des tables
  with TRequeteur(tcBD.Tabs.Objects[tcBD.TabIndex]) do
  for i := 0 to ListeTables.Count - 1 do
  begin
    SynCompletionProposal1.ItemList.Add(ListeTables[i]);
  end;

end;


procedure TfrmRequeteurSQL.edtChercheHistoChange(Sender: TObject);
var
  l : Integer;
begin
  inherited;

  l := Length(edtChercheHisto.Text);
  if (l = 0) or(l >= 1) then
    ChargerHistoriqueRequetes(edtChercheHisto.Text);
end;

procedure TfrmRequeteurSQL.FormCreate(Sender: TObject);
const
  C_LIBELLE_BASE_IMPORT = 'Import';
  C_LIBELLE_BASE_LOCALE = 'Base locale';
  C_LIBELLE_BASE_TRANSFERT = 'Transfert';

begin
  inherited;

  dmRequeteurBaseLocale := TdmRequeteurBaseLocale.Create(Self, Projet);

  if Supports(TfrModule(Projet.ModuleImport.IHM).PHA, IRequeteur) then
    tcBD.Tabs.AddObject(C_LIBELLE_BASE_IMPORT, TRequeteur.Create(Projet.ModuleImport))
  else
    ilBase.Delete(0);
  tcBD.Tabs.AddObject(C_LIBELLE_BASE_LOCALE, TRequeteur.Create(nil));
  if Supports(TfrModule(Projet.ModuleTransfert.IHM).PHA, IRequeteur) then
    tcBD.Tabs.AddObject(C_LIBELLE_BASE_TRANSFERT, TRequeteur.Create(Projet.ModuleTransfert));

  tcBD.TabIndex := tcBD.Tabs.IndexOf(C_LIBELLE_BASE_LOCALE);
  tcBDChange(Self);

end;

procedure TfrmRequeteurSQL.FormDestroy(Sender: TObject);
var
  I: Integer;
begin
  inherited;

  for I := 0 to tcBD.Tabs.Count - 1 do
    if Assigned(tcBD.Tabs.Objects[i]) then
      tcBD.Tabs.Objects[i].Free;
end;



procedure TfrmRequeteurSQL.grdResultatDblClick(Sender: TObject);
begin
  inherited;
  CopierCellule(Mouse.CursorPos);
  mmSQL.PasteFromClipboard;
end;

procedure TfrmRequeteurSQL.grdResultatTitleClick(Column: TColumn);
begin
  inherited;

  Clipboard.AsText  := Column.FieldName;
end;



procedure TfrmRequeteurSQL.actExecuterExecute(Sender: TObject);
begin
  inherited;
 if trim(mmSQL.Lines.Text)<> '' then
  ExecuterRequete(mmSQL.Lines.Text);
end;

procedure TfrmRequeteurSQL.actExecuterScriptExecute(Sender: TObject);
begin
  inherited;

  with TRequeteur(tcBD.Tabs.Objects[tcBD.TabIndex]) do
    if Assigned(IntfRequeteur) then
    begin
      mmErreurs.Lines.Clear;
      try
        IntfRequeteur.ExecuterScript(mmSQL.Lines);
        mmErreurs.Lines.Add('Script éxécutée');
      except
        on E:Exception do
        begin
          E := IntfRequeteur.GererExceptionDataSet(E);
          mmErreurs.Lines.Add(E.Message);
        end;
      end;
    end;
end;

procedure TfrmRequeteurSQL.actOuvrirExecute(Sender: TObject);
begin
  inherited;

  mmSQL.ActiveLineColor := clWhite;


  od.FileName := '';

  if not DirectoryExists(projet.RepertoireProjet+'Requetes\'+CHEMIN[tcBD.TabIndex]) then     // verif  de l existence du dossier
     CreateDir(projet.RepertoireProjet+'Requetes\'+CHEMIN[tcBD.TabIndex]);

  od.InitialDir :=  projet.RepertoireProjet+'Requetes\'+CHEMIN[tcBD.TabIndex];


  if od.Execute then
    mmSQL.Lines.LoadFromFile(od.FileName);


end;

procedure TfrmRequeteurSQL.actSauvegarderCSVExecute(Sender: TObject);
begin
  inherited;

  with TRequeteur(tcBD.Tabs.Objects[tcBD.TabIndex]) do
    if Assigned(DataSet) then
      if DataSet.Active then
      begin
        sd.FileName := '';
        if sd.Execute then
          grdResultat.SauverVersCSV(sd.FileName);
      end
      else
        MessageDlg('Aucune donnée à sauvegarder !', mtInformation, [mbOk], 0);
end;

procedure TfrmRequeteurSQL.actCommitExecute(Sender: TObject);
begin
  inherited;

  with TRequeteur(tcBD.Tabs.Objects[tcBD.TabIndex]) do
    if Assigned(IntfRequeteur) then
    begin
      IntfRequeteur.Commit;
      mmErreurs.Lines.Text := 'Validation effectuéee';
    end;
end;

procedure TfrmRequeteurSQL.actRollbackExecute(Sender: TObject);
begin
  inherited;

  with TRequeteur(tcBD.Tabs.Objects[tcBD.TabIndex]) do
    if Assigned(IntfRequeteur) then
    begin
      IntfRequeteur.Rollback;
      mmErreurs.Lines.Text := 'Annulation effectuéee';
    end;
end;

procedure TfrmRequeteurSQL.actImprimerExecute(Sender: TObject);
begin
  inherited;

  with TRequeteur(tcBD.Tabs.Objects[tcBD.TabIndex]) do
    if Assigned(DataSet) then
      if DataSet.Active then
        grdResultat.Imprimer;
end;

procedure TfrmRequeteurSQL.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
var
  i : Integer;
begin
  inherited;

  i := 0;
  while (i < tcBD.Tabs.Count) and CanClose do
  begin
    with TRequeteur(tcBD.Tabs.Objects[i]) do
      if Assigned(IntfRequeteur) and Assigned(DataSet) then
        CanClose := IntfRequeteur.LibererDataSet(DataSet);
    Inc(i);
  end;
end;





procedure TfrmRequeteurSQL.actSauvegarderSQLExecute(Sender: TObject);
const
  C_ACTION_SQL_MOT_CLE : array[0..2] of string = ('insert into %s (', 'update %s set ', 'delete from %s ');
  C_ACTION_SQL_VALEUR = '%s = ' + '' + '%s' + '';
  C_ACTION_SQL_WHERE = 'where ' + C_ACTION_SQL_VALEUR;
var
  lChamps : TStringList;
  lParametresSQL : TParametresGenerationSQL;
  lColonneCle : TField; laColonnes : array of TField;
  FSQL : TextFile;
  lStrBuffer : string;
  j, lIntMaxCol : Integer;
begin
  inherited;

  try
    lChamps := TStringList.Create;
    for j := 0 to dsResultat.DataSet.FieldCount - 1 do
      lChamps.Add(dsResultat.DataSet.Fields[j].FieldName);

    if TfrmGenerationSQL.Create(Self, Projet, lChamps).ShowModal(lParametresSQL) = mrOk then
    begin
      sd.FileName := '';
      sd.FilterIndex := 2;
      if sd.Execute then
      begin
        lIntMaxCol := High(lParametresSQL.Valeurs);

        // Recherche des colonnes
        if lParametresSQL.ValeurCle <> '' then
          lColonneCle := dsResultat.DataSet.FieldByName(lParametresSQL.ValeurCle);

        SetLength(laColonnes, lIntMaxCol + 1);
        for j := 0 to lIntMaxCol do
          if (lParametresSQL.Valeurs[j].Champs <> '') and (lParametresSQL.Valeurs[j].Valeur <> '') then
            laColonnes[j] := dsResultat.DataSet.FieldByName(lParametresSQL.Valeurs[j].Valeur)
          else
            laColonnes[j] := nil;

        AssignFile(FSQL, sd.FileName);
        Rewrite(FSQL);

        // Génération du script
        dsResultat.DataSet.DisableControls;
        dsResultat.DataSet.First;
        while not dsResultat.DataSet.Eof do
        begin
          lStrBuffer := Format(C_ACTION_SQL_MOT_CLE[lParametresSQL.Action], [lParametresSQL.Table]);

          // Corps de la requete
          for j := 0 to High(lParametresSQL.Valeurs) do
            if lParametresSQL.Valeurs[j].Valeur <> '' then
              case lParametresSQL.Action of
                C_ACTION_INSERT :
                  lStrBuffer := lStrBuffer + lParametresSQL.Valeurs[j].Champs + ', ';
                C_ACTION_UPDATE :
                  if Assigned(laColonnes[j]) then
                    lStrBuffer := lStrBuffer + Format(C_ACTION_SQL_VALEUR, [lParametresSQL.Valeurs[j].Champs, QuotedStr(Trim(laColonnes[j].AsString))]) + ', '
                  else
                    lStrBuffer := lStrBuffer + Format(C_ACTION_SQL_VALEUR, [lParametresSQL.Valeurs[j].Champs, QuotedStr(Trim(IfThen(lParametresSQL.Valeurs[j].Valeur = '<NULL>', 'NULL', lParametresSQL.Valeurs[j].Valeur)))]) + ', ';
              end;

          // Fin de la requete
          case lParametresSQL.Action of
            C_ACTION_INSERT :
              begin
                lStrBuffer[Length(lStrBuffer) - 1] := ')';
                lStrBuffer := lStrBuffer + 'values(';
                for j := 0 to High(lParametresSQL.Valeurs) do
                  if lParametresSQL.Valeurs[j].Valeur <> '' then
                    if Assigned(laColonnes[j]) then
                      lStrBuffer := lStrBuffer + '' + IfThen(laColonnes[j].datatype=ftBCD,stringreplace( Trim(laColonnes[j].AsString) ,',','.',[]),QuotedStr(Trim(laColonnes[j].AsString))) + '' + ', '
                    else
                      lStrBuffer := lStrBuffer + '' + QuotedStr(Trim(IfThen(lParametresSQL.Valeurs[j].Valeur = '<NULL>', NULL, lParametresSQL.Valeurs[j].Valeur))) + '' + ', ';
                lStrBuffer[Length(lStrBuffer) - 1] := ')'
              end;

            C_ACTION_UPDATE :
              begin
                Delete(lStrBuffer, Length(lStrBuffer) - 1, 1);
                lStrBuffer := lStrBuffer + Format(C_ACTION_SQL_WHERE, [lParametresSQL.Cle, IfThen(lColonneCle.DataType=ftBCD,stringreplace(Trim(lColonneCle.AsString),',','.',[]),QuotedStr(Trim(lColonneCle.AsString))) ]);
              end;

            C_ACTION_DELETE :
              begin
                lStrBuffer := lStrBuffer + Format(C_ACTION_SQL_WHERE, [lParametresSQL.Cle, IfThen(lColonneCle.DataType=ftBCD,stringreplace(Trim(lColonneCle.AsString),',','.',[]),QuotedStr(Trim(lColonneCle.AsString))) ]);
              end;
          end;
          Writeln(FSQL, lStrBuffer + ';');

          dsResultat.DataSet.Next;
        end;
        dsResultat.DataSet.First;
        dsResultat.DataSet.EnableControls;

        CloseFile(FSQL);
      end;
    end;
  finally
    if Assigned(lChamps) then
      FreeAndNil(lChamps);
  end;
end;

procedure TfrmRequeteurSQL.ExecuterRequete(ASQL: string);
var
  positiondepart : TBufferCoord;
  function getLigneErreur( messageErreur :string ): integer;
  var posligne,posvirgule : integer;
    souschaine : string;
  begin
   posLigne := pos('line', messageErreur);
   if posligne > 0 then
   begin
      //recherche de la virgule
      souschaine := copy( messageErreur,posligne+5, 10 );
      posvirgule := pos( ',' , souschaine );

   end;
     Result := strtointdef(copy(souschaine, 1, posvirgule-1),0) ;

  end;
  function getColonneErreur( messageErreur :string ): integer;
  var poscolonne,posCR : integer;
    souschaine : string;
  begin
   posColonne := pos('column', messageErreur);
   if posColonne > 0 then
   begin
      //recherche de la virgule
      souschaine := copy( messageErreur,poscolonne+6, 10 );
      posCR := pos( chr($d) , souschaine );

   end;
     Result := strtointdef(copy(souschaine, 1, posCR-1),0) ;

  end;
  function nom_requete( requete : string):string;
  var debut, fin  : integer;
  sreq :string;
  begin
    // remplacement des CRLF + suppression des espaces inutiles
    requete := stringreplace(requete,chr($d)+chr($a),' ', [rfReplaceAll]);
    while ( pos('  ',requete) > 0 ) do
     requete := stringreplace(requete,'  ',' ', [rfReplaceAll]);

    // chercher le from
    if ((pos('SELECT',UpperCase(requete)) > 0)) then
    begin
        debut :=  pos('FROM',UpperCase(requete))+5;
        sreq :=  copy(requete,debut,length(requete)-debut+1);

        if pos(' ',sreq)>0 then
          fin :=  pos(' ',sreq)
        else
          fin := length(sreq)+1;
        sreq := 'select_'+copy(sreq,1,fin);

    end
    else
       if (pos('DELETE',UpperCase(requete)) > 0) then
       begin
        debut :=  pos('FROM',UpperCase(requete))+5;
        sreq :=  copy(requete,debut,length(requete)-debut+1);

        if pos(' ',sreq)>0 then
          fin :=  pos(' ',sreq)
        else
          fin := length(sreq)+1;
        sreq := 'delete_'+copy(sreq,1,fin);
       end
       else
       if (pos('UPDATE',UpperCase(requete)) > 0) then
       begin
          debut :=  pos('UPDATE',UpperCase(requete))+6;
          sreq :=  copy(requete,debut,length(requete)-debut+1);

          if pos(' ',sreq)>0 then
            fin :=  pos(' ',sreq)
          else
            fin := length(sreq)+1;
          sreq := 'update_'+copy(sreq,fin,length(sreq)-fin)
       end
       else
        sreq :='';

      Result := stringreplace(sreq+ stringreplace(datetimetostr(now()),'/','_', [rfReplaceAll]),':',' ',[rfReplaceAll])+'.sql' ;

  end;

begin
  Screen.Cursor := crSQLWait;
  if not DirectoryExists(projet.RepertoireProjet+'Requetes\') then     // verif  de l existence du dossier
     CreateDir(projet.RepertoireProjet+'Requetes\');
  if not DirectoryExists(projet.RepertoireProjet+'Requetes\'+CHEMIN[tcBD.TabIndex]) then     // verif  de l existence du sous dossier
     CreateDir(projet.RepertoireProjet+'Requetes\'+CHEMIN[tcBD.TabIndex]);
  with TRequeteur(tcBD.Tabs.Objects[tcBD.TabIndex]) do
    if Assigned(IntfRequeteur) and Assigned(DataSet) then
    begin
      mmErreurs.Lines.Clear;
      try
        IntfRequeteur.ChargerDataSet(DataSet, ASQL);
        mmErreurs.Lines.Add(IntToStr(IntfRequeteur.RenvoyerLignesAffectees(FDataSet)) + ' lignes modifiée(s)');
        mmSQL.ActiveLineColor := clLime;
        try
          mmSQL.Lines.SaveToFile(projet.RepertoireProjet+'\Requetes\'+CHEMIN[tcBD.TabIndex]+'\'+nom_requete(ASQL));
        except
          mmErreurs.Lines.Add('Problème sauvegarde requete');
        end;

         ChargerHistoriqueRequetes('');
         ChargerListeChamps;
      except
        on E:Exception do
        begin
          E := IntfRequeteur.GererExceptionDataSet(E);
          mmSQL.ActiveLineColor:= clRed;
          mmErreurs.Lines.Add(E.Message);
          //placer le curseur a l endroit de l lerreur
          mmSQL.CaretX :=  getColonneErreur(E.Message);
          mmSQL.CaretY := getLigneErreur(E.Message);
        end;
      end;
    end;
    Screen.Cursor := crDefault;
end;

procedure TfrmRequeteurSQL.exporterSQLClick(Sender: TObject);
var i,j : integer;
    nom_table : string;
    ClipboardAsText :  string;
begin
  inherited;

  nom_table := copy(  StringReplace(mmSQL.text,#13#10,' ',[rfReplaceall]) , pos( 'FROM', uppercase(mmSQL.text) ) + 5 , length(mmSQL.text)-5 );
  if (pos( ' ', nom_table )>0) then
    nom_table := copy(  nom_table , 1, pos( ' ', nom_table ) );


  if Length(nom_table) < 3 then exit;

  grdResultat.DataSource.DataSet.DisableControls;
  with grdResultat.datasource.dataset do
  begin
    first;
    Clipboard.Clear;
    Screen.Cursor := crHourGlass;

    
    try
      while not EOF do
      begin
        DecimalSeparator := '.';
        ClipboardAsText := ClipboardAsText + 'INSERT INTO '+nom_table+' VALUES ( ';
        for i := 0 to grdResultat.DataSource.DataSet.FieldCount -1 do
        begin
          if grdResultat.Columns[i].field.IsNull = true then
            ClipboardAsText := ClipboardAsText + 'null'
          else
            if (grdResultat.Columns[i].field.DataType in [ftInteger,ftSmallint,ftFloat,ftBCD]) then
              ClipboardAsText := ClipboardAsText + grdResultat.Columns[i].field.asstring
            else
              ClipboardAsText := ClipboardAsText + AnsiQuotedStr(grdResultat.Columns[i].field.asstring,'''') ;
            if i < grdResultat.DataSource.DataSet.FieldCount -1 then  ClipboardAsText := ClipboardAsText + ',';

        end;
          ClipboardAsText := ClipboardAsText +' );'+ #13#10 ;
          next;
      end;
    except
         on EClipboardException do
         mmErreurs.Lines.Add('probleme presse papier')
    end;
  end;

  Clipboard.AsText := ClipboardAsText ;
  Screen.Cursor := crDefault;
  grdResultat.DataSource.DataSet.EnableControls;
end;

procedure TfrmRequeteurSQL.actExecuterSelectionExecute(Sender: TObject);
begin
  inherited;

  ExecuterRequete(mmSQL.SelText);
end;

procedure TfrmRequeteurSQL.mnuEditionCouperClick(Sender: TObject);
begin
  inherited;

  mmSQL.CutToClipboard;
end;

procedure TfrmRequeteurSQL.mnuEditionCopierClick(Sender: TObject);
begin
  inherited;

  mmSQL.CopyToClipboard;
end;

procedure TfrmRequeteurSQL.mmSQLChange(Sender: TObject);
begin
  inherited;

  mmSQL.ActiveLineColor := clYellow;
end;




procedure TfrmRequeteurSQL.mmSQLKeyPress(Sender: TObject; var Key: Char);
var mot : string;

begin
  inherited;

  mot := mmSQL.SelText ;

  if Key = '(' then
  begin
    mmSQL.SelText := mot+')' ;
    mmSQL.CaretX :=  mmSQL.CaretX - length(mot) - 1;
  end;

  if Key = '{' then
  begin
    mmSQL.SelText := mot+'}' ;
    mmSQL.CaretX :=  mmSQL.CaretX - length(mot) - 1;
  end;

  if Key = '[' then
  begin
    mmSQL.SelText := mot+']' ;
    mmSQL.CaretX :=  mmSQL.CaretX - length(mot) - 1;
  end;

  if (Key = '"') or (Key = '''') then
  begin
    mmSQL.SelText := mot+Key ;
    mmSQL.CaretX :=  mmSQL.CaretX - length(mot) - 1;
  end;

  if Key = '|' then
  begin
    mmSQL.SelText := mot+'|' ;

  end;

end;

procedure TfrmRequeteurSQL.mnuEditionCollerClick(Sender: TObject);
begin
  inherited;

  Clipboard.AsText := Clipboard.AsText;
  mmSQL.PasteFromClipboard;
end;

procedure TfrmRequeteurSQL.mnuEditionSelectionnerToutClick(
  Sender: TObject);
begin
  inherited;

  mmSQL.SelectAll;
end;

procedure TfrmRequeteurSQL.mnuGrillePopup(Sender: TObject);
var
  lBoolDonnees : Boolean;
  point1 : TPoint;
  GC : TGridCoord;
begin
  inherited;

  point1 := mnugrille.PopupPoint ;
  point1 := grdResultat.ScreenToClient(point1);
  GC := grdResultat.MouseCoord(Point1.X,Point1.Y);

  if GC.Y = 0 then
  begin
   //CopierTout.:= CopierToutClick(sender);
   CopierTout.Caption := 'Copier tout avec entetes';
   CopierTout.tag := 1
  end
  else
  begin
   //CopierTout.Click := CopierToutClick(sender);
   CopierTout.Caption := 'Copier tout sans entetes';
   CopierTout.tag := 2;
  end;
  lBoolDonnees := Clipboard.AsText <> '';

  Copier.Enabled := false ;
  CopierLigne.Enabled := false ;
  CopierTout.Enabled := false ;
  exporterSQL.Enabled  := false ;

  with TRequeteur(tcBD.Tabs.Objects[tcBD.TabIndex]) do
  if Assigned(DataSet) then
      if DataSet.Active then
         if grdResultat.DataSource.DataSet.RecordCount > 0 then
         begin
          Copier.Enabled := true ;
          CopierLigne.Enabled := true ;
          CopierTout.Enabled := true ;
          exporterSQL.Enabled := true ;
         end;

  Collerdanslditeur1.Enabled := lBoolDonnees;

end;

procedure TfrmRequeteurSQL.pnlTitreFiltreMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
  inherited;

 // sbxListeTables.SetFocus;
end;

procedure TfrmRequeteurSQL.mnuEditeurPopup(Sender: TObject);
var
  lBoolDonnees : Boolean;
begin
  inherited;

  // Gestion des états des commandes du menu "Edition"
  lBoolDonnees := Clipboard.AsText <> '';
  mnuEditionColler.Enabled := lBoolDonnees;
  mnuEditionCopier.Enabled := mmSQL.SelAvail;
  mnuEditionCouper.Enabled := mmSQL.SelAvail;
end;

procedure TfrmRequeteurSQL.Rafraichirlalistedestables1Click(Sender: TObject);
begin
  inherited;

  TRequeteur(tcBD.Tabs.Objects[tcBD.TabIndex]).RafraichirListeTables;
  CreerListeTables;
end;


procedure TfrmRequeteurSQL.SelectAllClick(Sender: TObject);
begin
  inherited;
   grdResultat.SelectedRows.Clear;

   with grdResultat.DataSource.DataSet do
   begin
    DisableControls;
     First;
     try
       while not EOF do
       begin
         grdResultat.SelectedRows.CurrentRowSelected := True;
         Next;
       end;
     finally
       EnableControls;
     end;
   end;
end;

procedure TfrmRequeteurSQL.SynCompletionProposal1AfterCodeCompletion(
  Sender: TObject; const Value: string; Shift: TShiftState; Index: Integer;
  EndToken: Char);
  var position : integer;
begin
  inherited;

  // recalage auto du curseur quand '' () ...
  position := pos( '()', value) +pos( '''''', value)  +pos( '  ', value);  // astuce car ne sont jamais en meme temps

  if position > 0 then
    mmSQL.CaretX := mmSQL.CaretX - length(Value) + position ;

end;

procedure TfrmRequeteurSQL.HistoSQLDrawItem(Control: TWinControl;
  Index: Integer; Rect: TRect; State: TOwnerDrawState);
begin
  inherited;
  HistoSQL.Items[index] := StringReplace(HistoSQL.items[index],#13#10,' ',[rfReplaceall]);
end;

procedure TfrmRequeteurSQL.HistoSQLMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  inherited;

  if HistoSQL.ItemIndex > -1 then
   mmSQL.Text := HistoSQL.Items[HistoSQL.ItemIndex];

  case Button of
    mbRight : actExecuterExecute(Self);
  end;

end;

procedure TfrmRequeteurSQL.HistoSQLMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
  var lstIndex : integer;
begin
  inherited;

  with HistoSQL do
  begin
    lstIndex:=SendMessage(Handle, LB_ITEMFROMPOINT, 0, MakeLParam(x,y)) ;
    if (lstIndex >= 0) and (lstIndex <= Items.Count) then
      Hint := copy(Items[lstIndex],1,1000)  // limitation du hint sinon prends trop de place a l ecran
    else
      Hint := '' ;
     //SetFocus;
  end;
  Application.ActivateHint(mouse.CursorPos);

end;
procedure TfrmRequeteurSQL.lbxTablesMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  if lbxTables.ItemIndex > -1 then
  begin
      case Button of
        mbLeft : mmSQL.Text := 'select * from ' + lbxTables.Items[lbxTables.ItemIndex];
        mbRight : mmSQL.Text := 'select count(*) from ' + lbxTables.Items[lbxTables.ItemIndex];
      end;
      actExecuterExecute(Self);
  end;
end;

procedure TfrmRequeteurSQL.lbxTablesMouseEnter(Sender: TObject);
begin
  inherited;
    SetFocus;
end;

procedure TfrmRequeteurSQL.lbxTablesMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
var lstIndex : integer;
begin
  inherited;

  with lbxTables do
  begin
    lstIndex:=SendMessage(Handle, LB_ITEMFROMPOINT, 0, MakeLParam(x,y)) ;
    if (lstIndex >= 0) and (lstIndex <= Items.Count) then
    begin
      Hint :=  'Clic Gauche : Ouvrir ' + Items[lstIndex] + #10#13 + 'Clic Droit : Compter les elements de ' + Items[lstIndex] ;
      selected[lstIndex] := true
    end
    else
      Hint := '' ;

    //SetFocus;
  end;
  Application.ActivateHint(mouse.CursorPos);

end;

procedure TfrmRequeteurSQL.listechampClick(Sender: TObject);
begin
  inherited;
  Clipboard.AsText := ' '+ StringReplace((Sender as TMenuItem).Caption, '&', '', [rfReplaceAll])+ ' ';
  mmSQL.PasteFromClipboard;

end;

{ TRequeteur }

function TRequeteur.Connecter : Boolean;
begin
  Result := True;
  try
    if Assigned(FModule) then
      if not TfrModule(FModule.IHM).Connecte  then
        TfrModule(FModule.IHM).Connecter;

    if not Assigned(FModule) or (Assigned(FModule) and TfrModule(FModule.IHM).Connecte) then
    begin
      FDataSet := FIntfRequeteur.RenvoyerDataSet;
      if Assigned(FDataSet) then
      begin
        FListeTables := FIntfRequeteur.RenvoyerTables;
      end;
    end
    else
      Result := False;
  except
    Result := False;
  end;
end;

constructor TRequeteur.Create(AModule : TModule);
begin

  FModule := AModule;
  if Assigned(FModule) then
    FIntfRequeteur := TfrModule(FModule.IHM).PHA as IRequeteur
  else
    FIntfRequeteur := dmRequeteurBaseLocale;
end;

destructor TRequeteur.Destroy;
begin
  if Assigned(FListeTables) then FreeAndNil(FListeTables);
  if Assigned(FIntfRequeteur) then FIntfRequeteur := nil;

  inherited;
end;

procedure TRequeteur.RafraichirListeTables;
begin
  if Assigned(FListeTables) then
    FreeAndNil(FListeTables);
  FListeTables := FIntfRequeteur.RenvoyerTables;
end;

end.
