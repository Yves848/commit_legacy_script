unit mdlCondifCdf;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, mdlPIShape, Buttons, mdlPIPanel, mdlProject, mdlProjectFile,
  ComCtrls, ImgList, ToolWin, IBSQL, StrUtils, mdlDialog, mdlPIXPMenu;

type
  TCodifCfg = record
    PHACodif : TPoint;
    ERPCodif : TPoint;
  end;

  TfrmConfigCdf = class(TfrmDialog)
    bvlPHACodifs: TBevel;
    bvlERPCodifs: TBevel;
    shPHACodif1: TPIShape;
    shPHACodif2: TPIShape;
    shPHACodif3: TPIShape;
    shPHACodif4: TPIShape;
    shPHACodif5: TPIShape;
    shPHACodif6: TPIShape;
    shPHACodif7: TPIShape;
    shPHAZoneGeo: TPIShape;
    lblPHACodifs: TPIPanel;
    shERPCodif1: TPIShape;
    shERPCodif2: TPIShape;
    shERPCodif3: TPIShape;
    shERPCodif4: TPIShape;
    shERPCodif5: TPIShape;
    shERPClIntPrt: TPIShape;
    shERPClIntEnf: TPIShape;
    lblERPCodifs: TPIPanel;
    stbCodifs: TStatusBar;
    tBtnSupprimer: TToolButton;
    tBtnDetails: TToolButton;
    chkInfoZoneGeo: TCheckBox;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure PHACodifsMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ERPCodifsMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure shPHACodifsClick(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure tBtnFermerClick(Sender: TObject);
    procedure tBtnSupprimerClick(Sender: TObject);
    procedure tBtnDetailsClick(Sender: TObject);
  private
    { Déclarations privées }
    FIsSecondPoint : Boolean;
    FFirstPoint : TPoint;
    FOldPHACodifs : TPIShape;
    FPoint : array[PHA_CODIF1..PHA_ZONEGEO] of TCodifCfg;
    FfrViewDataCodifs : TClass;
  public
    { Déclarations publiques }
    constructor Create(Aowner : TComponent; AProject : TProject; AXPMenu : TPIXPMenu); override;
  end;

var
  frmConfigCdf: TfrmConfigCdf;

implementation

uses Types, IBDatabase, mdlCommitViewData, mdlCommitPHA;

{$R *.dfm}

//***
//* Constructeur & Initialisation de la fiche
//***

constructor TfrmConfigCdf.Create(Aowner: TComponent;
  AProject: TProject; AXPMenu : TPIXPMenu);
begin
  inherited Create(Aowner, AProject, AXPMenu);

  // Recherche del'interface de visu
  FfrViewDataCodifs := GetClass('TfrViewDataCodifs');
end;

procedure TfrmConfigCdf.FormCreate(Sender: TObject);
var
  i, lIntIndex : Integer;
  lControl : TControl;
  lBoolTrans : Boolean;

  function GetControlFromTag(ATag : Integer) : TControl;
  var
    i, lIntMaxOcc : Integer;
  begin
    Result := nil;

    lIntMaxOcc := ControlCount - 1;
    for i := 0 to lIntMaxOcc do
      if Controls[i].Tag = ATag then
      begin
        Result := Controls[i];
        Exit;
      end
      else
        Result := nil;
  end;

begin
  // Initialisation
  for i := PHA_CODIF1 to PHA_ZONEGEO do
    with Project.ProjectFileAccess.ProjectFileCodifsSection do
    begin
      // PHA
      lIntIndex := CodifsLabels.IndexOfName('CODIF' + IntToStr(i));
      if lIntIndex <> -1 then
      begin
        lControl := GetControlFromTag(StrToInt(Copy(CodifsLabels.Names[lIntIndex], 6, Length(CodifsLabels.Names[lIntIndex]))));
        if Assigned(lControl) then
          (lControl as TPIShape).Caption := CodifsLabels.ValueFromIndex[lIntIndex];
      end;

      // ERP
      lIntIndex := Codifs.IndexOfName(IntToStr(i));
      if lIntIndex <> -1 then
      begin
        // Association
        lControl := GetControlFromTag(StrToInt(Codifs.Names[lIntIndex]));
        if Assigned(lControl) then
          with lControl do
            FPoint[i].PHACodif := Point(Left + Width, Top + Height div 2);

        if Codifs.ValueFromIndex[lIntIndex] <> '' then
        begin
          lControl := GetControlFromTag(StrToInt(Codifs.ValueFromIndex[lIntIndex]));
          if Assigned(lControl) then
            with lControl do
              FPoint[i].ERPCodif := Point(Left, Top + Height div 2);
        end;
      end
      else
      begin
        FPoint[i].PHACodif := Point(0, 0);
        FPoint[i].ERPCodif := Point(0, 0);
      end;
    end;

  // Libéllé ERP
  with dmCommitPHA.sql do
  begin
    if Transaction.InTransaction then
      lBoolTrans := True
    else
    begin
      lBoolTrans := False;
      Transaction.StartTransaction;
    end;

    SQL.Clear;
    SQL.Add('select (select valeur from t_parametre where cle = ' + '''' + 'prod.libelcodif1' + '''' + ') ERPCodif1,');
    SQL.Add('       (select valeur from t_parametre where cle = ' + '''' + 'prod.libelcodif2' + '''' + ') ERPCodif2,');
    SQL.Add('       (select valeur from t_parametre where cle = ' + '''' + 'prod.libelcodif3' + '''' + ') ERPCodif3,');
    SQL.Add('       (select valeur from t_parametre where cle = ' + '''' + 'prod.libelcodif4' + '''' + ') ERPCodif4,');
    SQL.Add('       (select valeur from t_parametre where cle = ' + '''' + 'prod.libelcodif5' + '''' + ') ERPCodif5');;
    SQL.Add('from rdb$database');
    ExecQuery;

    shERPCodif1.Caption := IfThen(FieldByName('ERPCodif1').AsString = '', 'CODIF1', FieldByName('ERPCodif1').AsString);
    shERPCodif2.Caption := IfThen(FieldByName('ERPCodif2').AsString = '', 'CODIF2', FieldByName('ERPCodif2').AsString);
    shERPCodif3.Caption := IfThen(FieldByName('ERPCodif3').AsString = '', 'CODIF3', FieldByName('ERPCodif3').AsString);
    shERPCodif4.Caption := IfThen(FieldByName('ERPCodif4').AsString = '', 'CODIF4', FieldByName('ERPCodif4').AsString);
    shERPCodif5.Caption := IfThen(FieldByName('ERPCodif5').AsString = '', 'CODIF5', FieldByName('ERPCodif5').AsString);
    Close;

    if lBoolTrans then
      Transaction.RollbackRetaining
    else
      Transaction.Rollback;
  end;

  // Config
  chkInfoZoneGeo.Checked := Project.ProjectFileAccess.ProjectFileCodifsSection.InfoZoneGeoStock;

  // Fonte
  Canvas.Pen.Width := 2;

  // Mode
  if Project.ProjectFileAccess.ProjectFileCodifsSection.Mode = cmManual then
  begin
    shERPClIntPrt.Enabled := False;
    shERPClIntEnf.Enabled := False;
  end;
end;

//***
//* Libération de la fenetre à la sortie
//* Fermeture de la fiche par ESC
//***

procedure TfrmConfigCdf.FormClose(Sender: TObject;
  var Action: TCloseAction);

  procedure Update(ACle, AValeur : string);
  begin
    with dmCommitPHA.sql do
    begin
      ParamByName('cle').AsString := ACle;
      ParamByName('valeur').AsString := AValeur;
      ExecQuery;
    end;
  end;

begin
  // Sauvagarde des libéllés
  with dmCommitPHA.sql do
  begin
    // Sauvegarde des libellés
    Transaction.StartTransaction;
    SQL.Clear;
    SQL.Add('update t_parametre');
    SQL.Add('set valeur = :valeur');
    SQL.Add('where cle = :cle');
    Prepare;

    Update('prod.libelcodif1', shERPCodif1.Caption);
    Update('prod.libelcodif2', shERPCodif2.Caption);
    Update('prod.libelcodif3', shERPCodif3.Caption);
    Update('prod.libelcodif4', shERPCodif4.Caption);
    Update('prod.libelcodif5', shERPCodif5.Caption);

    FreeHandle;
    Transaction.Commit;
  end;

  // Sauvegarde config
  Project.ProjectFileAccess.ProjectFileCodifsSection.InfoZoneGeoStock := chkInfoZoneGeo.Checked;

  Modalresult := mrOk;
  Action := caFree;
end;

procedure TfrmConfigCdf.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
    VK_ESCAPE :
      if FIsSecondPoint then
      begin
        // Annulation de l'action en cours
        FIsSecondPoint := False;

        with FOldPHACodifs do
        begin
          Brush.Color := clWindow;
          Font.Color := clWindowText;
        end;

        stbCodifs.Panels[0].Text := 'Sélectionnez la codification source ...';
      end
      else
        // Fermeture
        ModalResult := mrOk;

    VK_DELETE :
      if Sender is TShape then
        if (Sender as TShape).Tag in [PHA_CODIF1..PHA_CODIF7] then
          tBtnSupprimer.Click;

    VK_RETURN :
      if Sender is TShape then
        if (Sender as TShape).Tag in [PHA_CODIF1..PHA_CODIF7] then
          tBtnDetails.Click;
  end;
end;

procedure TfrmConfigCdf.tBtnFermerClick(Sender: TObject);
begin
  Close;
end;

//***
//* Tracage de la ligne
//***

//*** Changement de couleur sur le 1er click
procedure TfrmConfigCdf.shPHACodifsClick(Sender: TObject);
begin
  // On remet l'ancien bouton en blanc
  if Assigned(FOldPHACodifs) then
    with FOldPHACodifs do
    begin
      Brush.Color := clWindow;
      Font.Color := clWindowText;
    end;

  // Changement de couleur
  with (Sender as TPIShape) do
  begin
    Brush.Color := $0000B700;
    Font.Color := clWhite;
  end;

  // Stockage ancien Shape
  FOldPHACodifs := (Sender as TPIShape);
end;

//*** 1er click ...
procedure TfrmConfigCdf.PHACodifsMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  with Sender as TShape do
    FFirstPoint := Point(Left + Width, Top + (Height div 2));

  FIsSecondPoint := True;
  stbCodifs.Panels[0].Text := 'Sélectionnez la codification de destination ...';
end;

//*** ... puis le deuxième
procedure TfrmConfigCdf.ERPCodifsMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if FIsSecondPoint then
    with Sender as TShape do
    begin
      // Stockage de l'info conf.
      Project.ProjectFileAccess.ProjectFileCodifsSection.Codifs.Add(IntToStr(FOldPHACodifs.Tag) + '=' + IntToStr(Tag));

      // Stockage de l'info dessin
      FPoint[FOldPHACodifs.Tag].PHACodif := FFirstPoint;
      FPoint[FOldPHACodifs.Tag].ERPCodif := Point(Left, Top + (Height div 2));
    end;

  // On remet l'ancien bouton en blanc
  if Assigned(FOldPHACodifs) then
    with FOldPHACodifs do
    begin
      Brush.Color := clWindow;
      Font.Color := clWindowText;
    end;

  FIsSecondPoint := False;
  stbCodifs.Panels[0].Text := 'Sélectionnez la codification source ...';

  Invalidate;
end;

//*** Suppression d'une association
procedure TfrmConfigCdf.tBtnSupprimerClick(Sender: TObject);
var
  lIntIndex, lIntIndexPrt : Integer;
begin
  with Project.ProjectFileAccess.ProjectFileCodifsSection.Codifs do
  begin
    lIntIndex := IndexOfName(IntToStr(FOldPHACodifs.Tag));
    if ValueFromIndex[lIntIndex] = IntToStr(ERP_CLINT_PRT) then
    begin
      lIntIndexPrt := IndexOfValue(IntToStr(ERP_CLINT_ENF));
      if lIntIndexPrt <> -1 then
      begin
        FPoint[StrToInt(Names[lIntIndexPrt])].ERPCodif := Point(0, 0);
        Delete(lIntIndexPrt);
      end;
    end;


    if lIntIndex <> -1 then
    begin
      FIsSecondPoint := False;
      Delete(lIntIndex);
      FPoint[FOldPHACodifs.Tag].ERPCodif := Point(0, 0);

      // On remet l'ancien bouton en blanc
      if Assigned(FOldPHACodifs) then
        with FOldPHACodifs do
        begin
          Brush.Color := clWindow;
          Font.Color := clWindowText;
        end;

      FIsSecondPoint := True;
      stbCodifs.Panels[0].Text := 'Sélectionnez la codification source ...';

      Invalidate;
    end
    else
      MessageDlg('Impossible de supprimer une association inexistante !', mtError, [mbOk], 0);
  end;
end;

//*** Dessin des associations
procedure TfrmConfigCdf.FormPaint(Sender: TObject);
var
  i : Integer;
begin
  for i := PHA_CODIF1 to PHA_ZONEGEO do
    with FPoint[i] do
      if (ERPCodif.X <> 0) and (ERPCodif.Y <> 0) then
      begin
        // Dessin de la ligne
        Canvas.MoveTo(PHACodif.X, PHACodif.Y);
        Canvas.LineTo(ERPCodif.X, ERPCodif.Y);
      end;
end;

procedure TfrmConfigCdf.tBtnDetailsClick(Sender: TObject);
var
  lStrFilter : string;
begin
  if FOldPHACodifs.Tag <> PHA_ZONEGEO then
    if Assigned(FfrViewDataCodifs) then
    begin
      lStrFilter := IntToStr(FOldPHACodifs.Tag);
      TfrmCommitViewData.Create(Self, 'Visualisation codifications : CODIF ' + lStrFilter, lStrFilter, '', FfrViewDataCodifs).ShowModal;
    end
    else
      MessageDlg('Aucun module de visualisation des données n''a été trouvé ! Si vous en possèdez un (par ex: ViewData.BPL), celui-ci n''a pas été chargé en mémoire.'#10#13'Contactez le service développpement', mtWarning, [mbOk], 0);
end;

end.
