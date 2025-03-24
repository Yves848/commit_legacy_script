unit mdlImportUltimatePHA;

interface

uses
  SysUtils, Classes, mdlPHA, DBAccess, Ora, OraError, DB, mdlProjet, mdlModuleImportPHA,
  uib, mydbunit, fbcustomdataset, uibdataset, MemDS, Dialogs, mdlModule, mdlTypes,
  Generics.Collections, Variants, mdlActionTransaction, Controls, OraCall, XMLDoc;

type
  TdmImportUltimatePHA = class(TdmModuleImportPHA, IRequeteur)
    dbUltimate: TOraSession;
    qryUltimate: TOraQuery;
    procedure DataModuleCreate(Sender: TObject);
  private
    FVersionUltimate: string;
    { Déclarations privées }
  public
    { Déclarations publiques }
    property VersionUltimate: string read FVersionUltimate;
    procedure ConnexionBD; override;
    procedure DeconnexionBD; override;
    function RenvoyerChaineConnexion : string; override;
    function RenvoyerDataSet : TDataSet;
    function RenvoyerTables : TStringList;
    procedure ChargerDataSet(ADataSet : TDataSet; ARequeteSQL : string);
    procedure ExecuterScript(AScript : TStrings);
    procedure Commit;
    procedure Rollback;
    function GererExceptionDataSet(E : Exception) : Exception;
    function LibererDataSet(ADataSet : TDataSet) : Boolean;
    function RenvoyerLignesAffectees(ADataSet : TDataSet) : Integer;
  end;

var
  dmImportUltimatePHA: TdmImportUltimatePHA;

implementation

{$R *.dfm}

{ TdmImportUltimatePHA }

procedure TdmImportUltimatePHA.ConnexionBD;
var
  iVersion: Integer;
  bSupportee: Boolean;
  validVersions: TStringList;
  FichierParametres: tXMLDocument;

  procedure RenvoyerListeVersions;
  var
    iPays: Integer;
    iVersion: Integer;
    pVersionObj: TVersionObject;
    pays, version: string;

  begin
    validVersions.Clear;
    FichierParametres := Module.Projet.FichierParametres;

    with FichierParametres.DocumentElement.ChildNodes['import'] do
    begin
      pays := 'be';
      iVersion := 0;
      while (iVersion <= ChildNodes[pays].ChildNodes.count - 1) do
      begin
        version := ChildNodes[pays].ChildNodes[iVersion].NodeValue;
        pVersionObj := TVersionObject.Create(pays, version);
        ValidVersions.addObject('', pVersionObj);
        inc(iVersion)
      end;
    end;

  end;

begin
  validVersions := TStringList.Create;
  RenvoyerListeVersions;
  with dbUltimate do
  begin
    ConnectString := ParametresConnexion.Values['utilisateur'] + '/' +
                     ParametresConnexion.Values['mot_de_passe'] + '@' +
                     ParametresConnexion.Values['serveur'] + ':1521:PHAL1';

    try
      Connect;
    except
      on E: Exception do
        raise Exception.Create('Connexion impossible : ' + sLineBreak +
            ' Verifier vos informations de connexion ');
    end;

    ExecSQLEx('begin select valeur into :valeur from bel.t_parametres where cle = ' + '''' + 'rpm_version_lgpi' + '''' + '; end;',
      ['valeur', '']);
    FVersionUltimate := ParamByName('valeur').AsString;

    // #YGO Tester par rapport à la liste du fichier XML.
    iVersion := 0;
    bSupportee := false;

    while iVersion <= ValidVersions.count - 1 do
    begin
      if TVersionObject(ValidVersions.objects[iVersion]).pays = 'be' then
      begin
        if pos(TVersionObject(ValidVersions.objects[iVersion]).version, FVersionUltimate) = 1 then
        begin
          FVersionUltimate := stringReplace(FVersionUltimate, '.', '', [rfReplaceAll]);
          bSupportee := true;
          iVersion := ValidVersions.count;
        end;
      end;
      inc(iVersion);
    end;

    if not bSupportee then
      raise Exception.Create('Version de Ultimate (' + FVersionUltimate + ') non-supportée');
  end;

  FreeAndNil(validVersions);
end;

procedure TdmImportUltimatePHA.DeconnexionBD;
begin
  dbUltimate.Disconnect;
end;

function TdmImportUltimatePHA.RenvoyerChaineConnexion: string;
begin
  Result := ParametresConnexion.Values['serveur'];
end;

procedure TdmImportUltimatePHA.DataModuleCreate(Sender: TObject);
begin
  inherited;

  dmImportUltimatePHA := Self;
end;

{ IRequeteur }

procedure TdmImportUltimatePHA.ChargerDataSet(ADataSet: TDataSet;
  ARequeteSQL: string);
begin
  with qryUltimate do
  begin
    if Active then
      Close;

    SQL.Text := ARequeteSQL;
    Open;
  end;
end;

procedure TdmImportUltimatePHA.Commit;
begin
  dbUltimate.Commit;
end;

procedure TdmImportUltimatePHA.ExecuterScript(AScript: TStrings);
begin
  raise EAbstractError.Create('Fonctionnalité non-prise en charge');
end;

function TdmImportUltimatePHA.GererExceptionDataSet(E: Exception) : Exception;
begin
  Result := EDatabaseError.Create(E.Message)
end;

function TdmImportUltimatePHA.LibererDataSet(ADataSet: TDataSet): Boolean;
begin
  Result := True;
  if dbUltimate.InTransaction then
    case ActionTransaction(ParametresConnexion.Values['bd']) of
      mrOk : Commit;
      mrAbort : Rollback;
    else
      Result := False;
    end;

  if Result then
    if qryUltimate.Active then
      qryUltimate.Close;
end;

function TdmImportUltimatePHA.RenvoyerDataSet: TDataSet;
begin
  Result := qryUltimate;
end;

function TdmImportUltimatePHA.RenvoyerTables: TStringList;
begin
  Result := TStringList.Create;
  dbUltimate.GetTableNames(Result);
end;

function TdmImportUltimatePHA.RenvoyerLignesAffectees(ADataSet: TDataSet): Integer;
begin
  Result := -1;
end;

procedure TdmImportUltimatePHA.Rollback;
begin
  dbUltimate.Rollback;
end;

end.

