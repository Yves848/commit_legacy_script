program CommitMaintenance;

uses
  Forms,
  umain in 'umain.pas' {Form2},
  uConsts in 'uConsts.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm2, Form2);
  Application.Run;
end.
