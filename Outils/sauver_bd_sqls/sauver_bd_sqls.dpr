program sauver_bd_sqls;

uses
  Forms,
  sevenzip in 'sevenzip.pas',
  mdlPrincipale in 'mdlPrincipale.pas' {Form1};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'Sauvegarde de BD SQL Server';
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
