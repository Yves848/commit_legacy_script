unit mdlConvertfournisseur;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs,mdldialog, ImgList, ComCtrls, ToolWin, DB, Grids, DBGrids,
  Ora, OraError, mdlPIOraStoredProc, OraSmart, mdlPIOraScript,
  mdlPIDBGrid,mdlconvert,mdlproject;

type
  TfrConvertFournisseur = class(TfrConversions)
    PIDBGrid1: TPIDBGrid;
    Dsfournisseur: TDataSource;
    procedure PIDBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure PIDBGrid1DblClick(Sender: TObject);
  private
    FOldValue : string;
    listFouNbPdt : TStringList;
    { Déclarations privées }
  public
    { Déclarations publiques }
    destructor Destroy; override;
    procedure PrintData; override;
    function ConvertData : Boolean; override;
    procedure ImportData;override;
    procedure ExportData; override;
    procedure RefreshFrame; override;
    procedure ShowFrame; override;
    procedure HideFrame; override;

  end;

implementation

{$R *.dfm}

uses mdlcommitpha, mdlSearchfournisseur;
function TfrConvertFournisseur.ConvertData: Boolean;
begin
  result:= true;
end;


destructor TfrConvertFournisseur.Destroy;
begin
  dmCommitPHA.dSetfournisseur.Close;

  inherited;
end;

procedure TfrConvertFournisseur.ExportData;
begin
  inherited;

end;


procedure TfrConvertFournisseur.HideFrame;
begin
 dmCommitPHA.dSetfournisseur.Close;
 dmCommitPHA.dSetfournisseur.commit;

 inherited;

end;

procedure TfrConvertFournisseur.ImportData;
begin
  inherited;

end;

procedure TfrConvertFournisseur.PrintData;
begin
  inherited;

end;

procedure TfrConvertFournisseur.RefreshFrame;
begin
  inherited;
  Screen.Cursor := crHourGlass;
  dmCommitPHA.dSetFournisseur.Close;
  dmCommitPHA.dSetFournisseur.Open;
  Screen.Cursor := crDefault;
end;

procedure TfrConvertFournisseur.ShowFrame;
begin
  Screen.Cursor := crHourGlass;
  dmCommitPHA.dSetFournisseur.Open;
  
  {if (listFouNbPdt = nil) then
  begin
    listFouNbPdt := TStringList.Create;
    dmCommitPHA.dSetFournisseur.First;

    while dmCommitPHA.dSetFournisseur.Eof do
    begin
       if length(trim(VarToStr(dmCommitPHA.dSetFournisseur.FieldValues['ANOM']))) > 0 then
        listFouNbPdt.AddObject(VarToStr(dmCommitPHA.dSetFournisseur.FieldValues['ANOM']),dmCommitPHA.dSetFournisseur.FieldValues['ACOUNT']);
       dmCommitPHA.dSetFournisseur.Next;
    end;


  end;}
  
  Screen.Cursor := crDefault;

  inherited;

end;

procedure TfrConvertFournisseur.PIDBGrid1DrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin
  inherited;

  if (Column.FieldName = 'ATR_FOURNISSEUR') then
  begin
    // Recherche d'un fournisseur
    if (gdFocused in State) and (not Assigned(frmSearchfournisseur)) then
      with dmCommitPHA.dSetfournisseur do
      begin
        if FieldByName('ATR_fournisseur').AsString = '*' then
        begin
          frmSearchfournisseur := TfrmSearchfournisseur.Create(Self, FOldValue, '%');
          if frmSearchfournisseur.ShowModal = mrOk then
            begin
              if dmCommitPHA.dSetRechfournisseur.Active then
              begin
                Edit;
                FieldByName('ATR_FOURNISSEUR').Value := dmCommitPHA.dSetRechfournisseur.FieldByName('CODE').Value;
                Post;
                //Next;
              end;
            end
            else
              dmCommitPHA.dSetfournisseur.Cancel;

          frmSearchfournisseur := nil;
        end;
      end;
  end

end;

procedure TfrConvertFournisseur.PIDBGrid1DblClick(Sender: TObject);
var
  createFou, testConnexion : Boolean;
  reqIns, nomFou : String;
  numLig : Integer;
  marq : TBookmark;
  lORAExec : TOraStoredProc;
begin
  inherited;
  createFou := false;

  with PIDBGrid1 do
  begin
    if (SelectedField.FieldName = 'ANOM') then
    begin
        nomFou := SelectedField.AsString;
        marq := dmCommitPHA.dSetFournisseur.GetBookmark;
        
        if (MessageDlg('Voulez-vous créer le fournisseur: '+ nomFou + '?', mtWarning, [mbYes, mbNo], 0) = mrYes) then
        begin
           try
              lORAExec := TOraStoredProc.Create(Project);
              with lORAExec do
              begin
                // Paramètre de connexion
                Debug := True;

                if not(Project.TransfertModule.Connection.Connected) then
                begin
                    //LoginOutSystem('migration', 'migration')
                    testConnexion := Project.TransfertModule.LoginOutSystem('migration','migration');
                    if not testConnexion then
                    begin
                        ShowMessage('Veuillez vérifier que le kit d''installation est installé et que la connexion est établie!');
                        exit; 
                    end;
                end;
                
                Session := TOraSession(Project.TransfertModule.Connection);
                AutoCommit := False;

                reqIns := 'INSERT INTO bel.t_fournisseurdirect(T_FOURNISSEURDIRECT_ID,RAISONSOCIALE,VITESSE171,PAUSE171,NBTENTATIVES,';
                reqIns := reqIns + 'DATEMAJFOURNISSEURDIRECT,MODETRANSMISSION,FOUPARTENAIRE,MONOGAMME,T_ADRESSE_ID)';
		            reqIns := reqIns + ' VALUES(bel.seq_id_fournisseur.NEXTVAL,:RAISONSOCIALE,:VITESSE171,:PAUSE171,:NBTENTATIVES,';
                reqIns := reqIns + 'to_date(to_char(sysdate, ''DD/MM/YYYY''),''DD/MM/YYYY''),:MODETRANSMISSION,:FOUPARTENAIRE,';
                reqIns := reqIns + ':MONOGAMME,NULL)';

                Session.StartTransaction;
                Active := false;
                SQL.Clear;
                SQL.Add(reqIns);

                //TDBGrid(Sender).DataSource.DataSet.FieldByName('AFOURNISSEUR').AsString;
                ParamByName('RAISONSOCIALE').AsString := nomFou;
                ParamByName('VITESSE171').AsInteger:= 0;
                ParamByName('PAUSE171').AsString := '0';
                ParamByName('NBTENTATIVES').AsInteger:= 0;
                ParamByName('MODETRANSMISSION').AsString := '5';
                ParamByName('FOUPARTENAIRE').AsString := '0';
                ParamByName('MONOGAMME').AsString := '0';
                ExecSQL;
                Session.Commit;

                Session.StartTransaction;
                Active := false;
                SQL.Clear;
                SQL.Add('SELECT max(t_fournisseurdirect_id) as IDFou FROM bel.t_fournisseurdirect');
                Active := true;

                RefreshFrame;
                dmCommitPHA.dSetFournisseur.GotoBookmark(marq);
                dmCommitPHA.dSetfournisseur.Edit;
                dmCommitPHA.dSetfournisseur.FieldByName('ATR_FOURNISSEUR').AsString := IntToStr(FieldByName('IDFou').AsInteger);
                dmCommitPHA.dSetfournisseur.Post;

                Session.Commit;

                lORAExec.Free;
                lORAExec := nil;
              end;

            Except
              On E: Exception do
              begin
                ShowMessage('Erreur lors de la création du fournisseur propre');
                if lORAExec <> nil then
                begin
                   lORAExec.Free;
                   lORAExec := nil;
                end;
              end;
            end;

        end;
    end;
  end;
end;

end.
