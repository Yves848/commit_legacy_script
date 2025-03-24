unit mdlPrincipale;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, StrUtils,
  Dialogs, StdCtrls, DB, ADODB, Mask, JvExMask, JvToolEdit, ExtCtrls, JclSysInfo, JclFileUtils,
  JclShell, ComCtrls, OleDB, ADOInt, ComObj, ActiveX, JwaLmServer, JwaLmApiBuf, IDUDPClient,
  JwaWinSock, JvExComCtrls, JvStatusBar;

type
  TForm1 = class(TForm)
    GroupBox1: TGroupBox;
    ComboBox2: TComboBox;
    Bevel1: TBevel;
    Label3 : TLabel;
    LabeledEdit2: TLabeledEdit;
    LabeledEdit3: TLabeledEdit;
    GroupBox2: TGroupBox;
    JvDirectoryEdit1: TJvDirectoryEdit;
    Label1: TLabel;
    CheckBox1: TCheckBox;
    Button1: TButton;
    Button2: TButton;
    ADOConnection1: TADOConnection;
    Label2: TLabel;
    ComboBox1: TComboBox;
    CheckBox2: TCheckBox;
    Label4 : TLabel;
    ComboBox3: TComboBox;
    ADOQuery1: TADOQuery;
    ProgressBar1: TProgressBar;
    JvStatusBar1: TJvStatusBar;
    procedure Button2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure CheckBox2Click(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure LabeledEdit4Enter(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Déclarations privées }
    FAnnulation : Boolean;
    FEnExecution : Boolean;
  public
    { Déclarations publiques }
    property Annulation : Boolean read FAnnulation;
  end;

var
  Form1: TForm1;

const
  C_DRIVER_ADO_SQLOLEDB = 'SQLOLEDB';
  C_DRIVER_ADO_SQL_NATIVE = 'SQLNCLI';
  C_DRIVERS : array[0..1] of string = (C_DRIVER_ADO_SQLOLEDB, C_DRIVER_ADO_SQL_NATIVE);
  C_SQL_SERVER_CHAINE_CONNEXION = 'Provider=%s.1;%sPersist Security Info=False;User ID=%s;Password=%s;Initial Catalog=master;Data Source=%s';
  C_SQL_SERVER_SECURITE_NT = 'Integrated Security=SSPI;';

implementation

uses sevenzip;

{$R *.dfm}

procedure RenvoyerListeServeurs(AServeurs : TStrings);
var
  hStatus : HRESULT;
  recordset : ADORecordsetConstruction;
  rowset : IRowset;
  sRowSet : ISourcesRowset;
  sRecordSet : _Recordset;
  sName, sType : TField;
  s, rec, ip  : string;
  udp : TIdUDPClient;
  p : Word;
  host : PHostEnt;
  lintIP : Integer;
  laBtIP : array[0..3] of Byte absolute lintIP;
  host_info : TStringList;
  idx : Integer;
begin
  OleCheck(CoCreateInstance(CLASS_Recordset, nil, CLSCTX_INPROC_SERVER or CLSCTX_LOCAL_SERVER, IUnknown, sRecordSet));
  recordset := sRecordSet as ADORecordsetConstruction;
  sRowSet := CreateComObject(ProgIDToClassID('SQLOLEDB Enumerator')) as ISourcesRowset;
  OleCheck(sRowSet.GetSourcesRowset(nil, IRowSet, 0, nil, IUnknown(rowset)));
  recordset.Rowset := rowset;

  with TADODataSet.Create(nil) do
    try
      Recordset := sRecordSet;
      sName := FieldByName('SOURCES_NAME');
      sType := FieldByName('SOURCES_TYPE');
      AServeurs.BeginUpdate;
      try
        udp := TIdUDPClient.Create(nil);
        host_info := TStringList.Create;
        while not EOF do
        begin
          if (sType.AsInteger = DBSOURCETYPE_DATASOURCE) and (sName.AsString <> '') then
          begin
            // IP du serveur trouvé
            host := GetHostByName(PAnsiChar(sName.AsAnsiString));
            if Assigned(host) then
            begin
              lIntIP := LongInt(Pointer(host^.h_addr_list^)^);
              lIntIP := ntohl(lIntIP);
            end
            else
              lIntIP := ntohl($07000001);

            // Lancement d'une requete broadcast
            udp.Host := Format('%d.%d.%d.%d', [laBtIP[3], laBtIP[2], laBtIP[1], 255]);
            udp.Port := 1434;
            udp.BroadcastEnabled := True;
            udp.ReceiveTimeout := 6000;
            udp.Send(#2);
            repeat
              rec := udp.ReceiveString(ip, p);
              if rec <> '' then
              begin
                host_info.Clear;
                ExtractStrings([';'], [' '], PChar(Copy(rec, 4, Length(rec))), host_info);
                idx := host_info.IndexOf('InstanceName');
                if idx <> -1 then
                  AServeurs.Add(sName.AsString + '\' + host_info[idx + 1]);
              end;
            until (rec = '');
            Next;
          end;
        end;
      finally
        FreeAndNil(host_info);
        FreeAndNil(udp);
        AServeurs.EndUpdate;
      end;
    finally
      Free;
    end;
end;

function ProgressCallback(sender: Pointer; total: boolean; value: int64): HRESULT; stdcall;
begin
  if not Form1.Annulation then
  begin
    if total then
      Form1.ProgressBar1.Tag := value div 1024
    else
      Form1.ProgressBar1.Position := (value div 1024) div Form1.ProgressBar1.Tag * 100;
    Application.ProcessMessages;
    Result := S_OK;
  end
  else
    Result := S_FALSE;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  if FEnExecution then
    FAnnulation := MessageDlg('Annuler la sauvegarde de la base ' + ComboBox3.Text + ' ?', mtConfirmation, [mbYes, mbNo], 0) = mrYes
  else
    Close;
end;

procedure TForm1.Button2Click(Sender: TObject);
var
  f : TStringList;
  i : Integer;
  a : I7zOutArchive;
  s : string;
begin
  FEnExecution := True;
  GroupBox1.Enabled := False;
  GRoupBox2.Enabled := False;
  Button2.Enabled := False;

  // Connexion à SQL Server
  FAnnulation := False;
  with ADOConnection1 do
  begin
    try
      if Connected then
        Close;

      ConnectionString := Format(C_SQL_SERVER_CHAINE_CONNEXION, [C_DRIVERS[ComboBox1.ItemIndex], // Driver
                                                                 IfThen(CheckBox2.Checked, C_SQL_SERVER_SECURITE_NT), // Sécurité Windows
                                                                 LabeledEdit2.Text,              // Utilisateur
                                                                 LabeledEdit3.Text,              // Mot de passe,
                                                                 ComboBox2.Text]);            // Serveur
      Connected := True;

      // Déttachement de la BD
      ADOConnection1.Execute('use ' + ComboBox3.Text);

      ADOQuery1.SQL.Clear;
      ADOQuery1.SQL.Add('select physical_name from sys.database_files where type_desc = ''ROWS''');
      ADOQuery1.Open; f := TStringList.Create;
      while not ADOQuery1.EOF do
      begin
        f.Add(ADOQuery1.Fields[0].AsString);
        ADOQuery1.Next;
      end;
      ADOQuery1.Close;

      ADOConnection1.Execute('use master');
      ADOConnection1.Execute('exec sp_detach_db ' + QuotedStr(ComboBox3.Text));

      // Copie
      for i := 0 to f.Count - 1 do
      begin
        s := JvDirectoryEdit1.Directory + '\' + ExtractFileName(f[i]) + '.bak';
        SHCopy(Self.Handle, f[i], s, []);
        f[i] := f[i] + '=' + s;
      end;

      // Rattachement de la BD
      try
        ADOQuery1.SQL.Clear;
        ADOQuery1.SQL.Add('exec sp_attach_db ' + QuotedStr(ComboBox3.Text) + ', :1');
        ADOQuery1.Prepared := True;
        for i := 0 to f.Count - 1 do
        begin
          ADOQuery1.Parameters[0].Value := f.Names[i];
          ADOQuery1.ExecSQL;
        end;
        ADOQuery1.Prepared := False;
      except
        on E:Exception do
           MessageDlg('Erreur durant le processus de rattachement de la base. Vérifiez que la base de données ' + ComboBox3.Text + ' est toujours attachée et fonctionnel !', mtError, [mbOk], 0);
      end;

      if Connected then
        Connected := False;

      // Archivage
      if CheckBox1.Checked then
      begin
        a := CreateOutArchive(CLSID_CFormat7z);
        a.SetProgressCallback(Pointer(Handle), ProgressCallback);
        for i := 0 to f.Count - 1 do
        begin
          s := f.ValueFromIndex[i];
          a.AddFile(s, ExtractFileName(s));
        end;
        a.SaveToFile(JvDirectoryEdit1.Directory + '\' + ComboBox3.Text + '.7z');
        a := nil;

        for i := 0 to f.Count - 1 do
          s := f.ValueFromIndex[i] + #0;
        SHDeleteFiles(Self.Handle, s, [doSilent]);
      end;

      MessageDlg('Sauvegarde terminée !', mtInformation, [mbOK], 0);
    except
      on E:Exception do
        if Annulation then
          MessageDlg('Sauvegarde annulée !', mtWarning, [mbOk], 0)
        else
          MessageDlg('Une erreur est survenue durant le processus de sauvegarde ! Message : ' + E.Message, mtError, [mbOk], 0);
    end;
  end;

  GroupBox2.Enabled := True;
  GroupBox1.Enabled := True;
  Button2.Enabled := True;
  FEnExecution := False;
end;

procedure TForm1.CheckBox2Click(Sender: TObject);
begin
  if CheckBox2.Checked then
  begin
    LabeledEdit2.Enabled := False;
    LabeledEdit3.Enabled := False;
  end
  else
  begin
    LabeledEdit2.Enabled := True;
    LabeledEdit3.Enabled := True;
  end;
end;

procedure TForm1.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  CanClose := not FEnExecution;
end;

procedure TForm1.FormCreate(Sender: TObject);
var
  p : TStringList;
  ok : Boolean;
  r : Integer;
begin
  // Vérification que SQL Server fonctionne
  try
    p := TStringList.Create;
    RunningProcessesList(p, False);
    ok := p.IndexOf('sqlservr.exe') <> -1;
  finally
    FreeAndNil(p);
  end;

  if ok then
  begin
    // Liste des serveurs SQL présents
    //RenvoyerListeServeurs(ComboBox2.Items);
    if ComboBox2.Items.Count > 0 then
      ComboBox2.ItemIndex := 0;
  end
  else
  begin
    MessageDlg('Ce programme doit être utilisé sur un poste éxécutant une instance SQL Server !', mtError, [mbOk], 0);
    Application.Terminate;
  end;
end;

procedure TForm1.LabeledEdit4Enter(Sender: TObject);
begin
  if ComboBox3.Text = '' then
    with ADOConnection1 do
    begin
      ConnectionString := Format(C_SQL_SERVER_CHAINE_CONNEXION, [C_DRIVERS[ComboBox1.ItemIndex], // Driver
                                                                   IfThen(CheckBox2.Checked, C_SQL_SERVER_SECURITE_NT), // Sécurité Windows
                                                                   LabeledEdit2.Text,              // Utilisateur
                                                                   LabeledEdit3.Text,              // Mot de passe,
                                                                   ComboBox2.Text]);            // Serveur
      Connected := True;

      ADOConnection1.Execute('use master');
      ADOQuery1.SQL.Clear;
      ADOQuery1.SQL.Add('select name from sys.databases');
      ADOQuery1.SQL.Add('where name not in (' + QuotedStr('master') + ', ' + QuotedStr('tempdb') + ', ' + QuotedStr('model') + ', ' + QuotedStr('msdb') + ')');
      ADOQuery1.Open;
      while not ADOQuery1.EOF do
      begin
        ComboBox3.Items.Add(ADOQuery1.Fields[0].AsString);
        ADOQuery1.Next;
      end;
      ADOQuery1.Close;

      Close;

      if ComboBox3.Items.Count > 0 then
        ComboBox3.ItemIndex := 0;
    end;
end;

end.
