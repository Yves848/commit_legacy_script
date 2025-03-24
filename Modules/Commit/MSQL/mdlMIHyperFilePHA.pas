unit mdlMIHyperFilePHA;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, mdlModuleImportPHA, mdlPIODBC, mdlMIOLEDBPHA, DB, fbcustomdataset, mydbunit, uib, uibdataset,
  IniFiles, Registry, StrUtils, DBClient, mdlPIDataSet, JclShell, ADODB, mdlProjet;//,mdlMIODBCPHA;

type
  TdmMIHyperFilePHA = class(TdmMIOLEDBPHA)
    procedure DataModuleCreate(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
    procedure ConnexionBD; override;
    function RenvoyerChaineConnexion : string; override;
  end;

var
  dmMIHyperFilePHA: TdmMIHyperFilePHA;

const
  //C_CHAINE_CONNEXION_HYPERFILE = 'Driver=HyperFile;REP=%s';
  //C_CHAINE_CONNEXION_HYPERFILE_SQL = 'Driver=HyperFile;ANA=%s;REP=;Server Name=%s;Server Port=4900;Database=%s;UID=%s;PWDXX=%s;Encryption=';
  C_CHAINE_CONNEXION_HYPERFILE = 'Provider=PCSoft.HFSQL;Initial Catalog=%s;Extended Properties="Language=UTF-8"';

implementation

{$R *.dfm}

procedure TdmMIHyperFilePHA.ConnexionBD;
var
  d : string;
begin
  inherited;

  //  Avec le driver hfsql oledb de Windev, plus besoin d'analyse

  //if FileExists(ParametresConnexion.Values['analyse']) then
  begin
    // Installation ODBC
    //d := Module.Projet.RepertoireApplication + '\WD160HFO.DLL';
    //ShellExec(0, 'open', Module.Projet.RepertoireApplication + '\Outils\install_odbc.exe', '-install nom=hyperfile driver="' + d + '" setup="' + d + '"', '', SW_NORMAL);
 //   if (ParametresConnexion.Values['connexion_locale'] = '0') then
      //c := Format(C_CHAINE_CONNEXION_HYPERFILE_SQL, [[ParametresConnexion.Values['analyse'],
   //   c := Format(C_CHAINE_CONNEXION_HYPERFILE_SQL, [ParametresConnexion.Values['serveur'],
//                                                     ParametresConnexion.Values['bd'],
  //                                                   ParametresConnexion.Values['utilisateur'],
    //                                                 ParametresConnexion.Values['mot_de_passe']])
    //else
      //c := Format(C_CHAINE_CONNEXION_HYPERFILE, [[ParametresConnexion.Values['analyse'],
      //c := Format(C_CHAINE_CONNEXION_HYPERFILE_OLEDB, [ParametresConnexion.Values['bd']]);

    //TPIODBCConnexion(dbPI).ChaineConnexion := C_CHAINE_CONNEXION_HYPERFILE_OLEDB;
    //TPIODBCConnexion(dbPI).MettreNullSiErreur := True;
    //TPIODBCConnexion(dbPI).Open

    dbOLEDB.ConnectionString := Format(C_CHAINE_CONNEXION_HYPERFILE, [ParametresConnexion.Values['bd'],
                                            ParametresConnexion.Values['utilisateur'],
                                            ParametresConnexion.Values['mot_de_passe']]);
    dbOLEDB.Connected := True;


  end
 // else
 //   raise EDatabaseError.Create('Impossible de se connecter, fichier analyse introuvable !');
end;

procedure TdmMIHyperFilePHA.DataModuleCreate(Sender: TObject);
begin
  inherited;

  dmMIHyperFilePHA := Self;

    if not (DirectoryExists(GetEnvironmentVariable('ProgramFiles')+'\Common Files\PC SOFT\20.0\OLEDB')
      or DirectoryExists(GetEnvironmentVariable('ProgramFiles')+'\Fichiers communs\PC SOFT\20.0\OLEDB')
      or DirectoryExists(GetEnvironmentVariable('ProgramFiles(x86)')+'\Fichiers communs\PC SOFT\20.0\OLEDB')
      or DirectoryExists(GetEnvironmentVariable('ProgramFiles(x86)')+'\Fichiers communs\PC SOFT\20.0\OLEDB')) then
    raise EProjet.Create('Attention : le répertoire des drivers OLEDB n''a pas été trouvé, pour lancer l''import il faut d''abord les installer, consultez l''aide du module ');

end;

function TdmMIHyperFilePHA.RenvoyerChaineConnexion: string;
var
  bd : string;
begin
  //bd := ParametresConnexion.Values['analyse'];
  //Result := IfThen(ParametresConnexion.Values['connexion_locale'] = '0',
    //               ParametresConnexion.Values['utilisateur'] + '@' + ParametresConnexion.Values['serveur'] + ':' + bd, bd);
//  if (ParametresConnexion.Values['utilisateur'] <> '') then bd := 'Utilisateur : ' + ParametresConnexion.Values['utilisateur'];
  Result := bd+ 'Connecté sur le repértoire : '+ ParametresConnexion.Values['bd']
end;

end.
