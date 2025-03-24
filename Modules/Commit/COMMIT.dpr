program COMMIT;

{$R 'rdm_commit.res' 'rdm_commit.rc'}

uses
  Windows,
  SysUtils,
  Forms,
  mdlAide in 'mdlAide.pas' {frmAide},
  mdlAProposDe in 'mdlAProposDe.pas' {frmAProposDe},
  mdlClientFTP in 'mdlClientFTP.pas' {frmClientFTP},
  mdlCreationProjet in 'mdlCreationProjet.pas' {frmCreationProjet},
  mdlDetailTraitementEnCours in 'mdlDetailTraitementEnCours.pas' {frmDetailTraitementEnCours},
  mdlFichierProjet in 'mdlFichierProjet.pas',
  mdlFluxRSS in 'mdlFluxRSS.pas' {frmItemRSS},
  mdlIcmp in 'mdlIcmp.pas',
  mdlInformationsModules in 'mdlInformationsModules.pas' {frmInformationsModules},
  mdlLecteurRSS in 'mdlLecteurRSS.pas',
  mdlListesFichiers in 'mdlListesFichiers.pas' {frmListeFichiers},
  mdlMAJCommit in 'mdlMAJCommit.pas',
  mdlOptionsReprise in 'mdlOptionsReprise.pas' {frmOptionsReprise},
  mdlPrincipale in 'mdlPrincipale.pas' {frmPrincipale},
  mdlSplash in 'mdlSplash.pas' {frmSplash},
  mdlFTPDev in 'mdlFTPDev.pas' {frmFTPDev};

{$R *.res}

const
  SE_SHUTDOWN_NAME = 'SeShutdownPrivilege';

var
  lIntErreur : Integer;
begin
  SetLastError(NO_ERROR);
  CreateMutex (nil, False, 'COMMIT');
  lIntErreur := GetLastError;
  if ( lIntErreur = ERROR_ALREADY_EXISTS ) or ( lIntErreur = ERROR_ACCESS_DENIED ) then
    Application.Terminate
  else
  begin
    Application.Initialize;
    with TfrmSplash.Create(Application) do
    begin
      Show;
      Update;
      Application.Title := 'Transfert de données vers les solutions Pharmagest Inter@ctive';
      Application.CreateForm(TfrmPrincipale, frmPrincipale);
  Application.CreateForm(TfrmItemRSS, frmItemRSS);
  Close;
      Release;
      Application.Run;
    end;
  end;
end.
