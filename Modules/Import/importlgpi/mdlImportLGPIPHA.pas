unit mdlImportLGPIPHA;

interface

uses
  SysUtils, Classes, mdlPHA, DBAccess, Ora, OraError, DB, mdlProjet, mdlModuleImportPHA,
  uib, mydbunit, fbcustomdataset, uibdataset, MemDS, Dialogs, mdlModule, mdlTypes,
  Generics.Collections, Variants, mdlActionTransaction, Controls, OraCall, XMLDoc;

type
  TdmImportLGPIPHA = class(TdmModuleImportPHA, IRequeteur)
    dbLGPI: TOraSession;
    qryLGPI: TOraQuery;
    procedure DataModuleCreate(Sender: TObject);
  private
    FVersionLGPI: string;
    { Déclarations privées }
  public
    { Déclarations publiques }
    property VersionLGPI: string read FVersionLGPI;
    procedure ConnexionBD; override;
    procedure DeconnexionBD; override;
    function RenvoyerChaineConnexion: string; override;
    function CreerDocument(AIDClient, AIDDoc, AContentType, APage : Integer;AMusePath, ADocument, ACommentaire: string): TResultatCreationDonnees; reintroduce;
    function RenvoyerDataSet: TDataSet;
    function RenvoyerTables: TStringList;
    procedure ChargerDataSet(ADataSet: TDataSet; ARequeteSQL: string);
    procedure ExecuterScript(AScript: TStrings);
    procedure Commit;
    procedure Rollback;
    function GererExceptionDataSet(E: Exception): Exception;
    function LibererDataSet(ADataSet: TDataSet): Boolean;
    function RenvoyerLignesAffectees(ADataSet: TDataSet): Integer;
  end;

var
  dmImportLGPIPHA: TdmImportLGPIPHA;

implementation

{$R *.dfm}
{ TdmImportLGPIPHA }

procedure TdmImportLGPIPHA.ConnexionBD;
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
      pays := 'fr';
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
  with dbLGPI do
  begin
        dbLGPI.Username := ParametresConnexion.Values['utilisateur'];
        dbLGPI.Password := ParametresConnexion.Values['mot_de_passe'];
        dbLGPI.Server := '(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=' + ParametresConnexion.Values['serveur'] +
                           ')(PORT=1521))(CONNECT_DATA=(SERVICE_NAME=PHAL1)))';
    try
      Connect;
    except
      on E: Exception do
        raise Exception.Create('Connexion impossible : ' + sLineBreak +
            ' Verifier vos informations de connexion ');
    end;

    ExecSQLEx('begin select valeur into :valeur from erp.t_parametres where cle = ' + '''' + 'rpm_version_lgpi' + '''' + '; end;',
      ['valeur', '']);
    FVersionLGPI := ParamByName('valeur').AsString;

    // #YGO Tester par rapport à la liste du fichier XML.
    iVersion := 0;
    bSupportee := false;

    while iVersion <= ValidVersions.count - 1 do
    begin
      if TVersionObject(ValidVersions.objects[iVersion]).pays = 'fr' then
      begin
        if pos(TVersionObject(ValidVersions.objects[iVersion]).version, FVersionLGPI) = 1 then
        begin
          FVersionLGPI := stringReplace(FVersionLGPI, '.', '', [rfReplaceAll]);
          bSupportee := true;
          iVersion := ValidVersions.count;
        end;
      end;
      inc(iVersion);
    end;

    if not bSupportee then
      raise Exception.Create('Version du LGPI (' + FVersionLGPI + ') non-supportée');
  end;

  FreeAndNil(validVersions);
end;

procedure TdmImportLGPIPHA.DeconnexionBD;
begin
  dbLGPI.Disconnect;
end;

function TdmImportLGPIPHA.RenvoyerChaineConnexion: string;
begin
  Result := ParametresConnexion.Values['serveur'];
end;

function TdmImportLGPIPHA.CreerDocument(AIDClient, AIDDoc, AContentType, APage: Integer; AMusePath, ADocument, ACommentaire: string): TResultatCreationDonnees;
begin
  Result := ExecuterPS('Attestations mutuelles',
                       'PS_IMPORTLGPI_CREER_DOC',
                       VarArrayOf([ AIDDoc,
                                    APage,
                                    AIDClient,
                                    AContentType,
                                    AMusePath,
                                    ADocument,
                                    ACommentaire
                                    ]));
end;

procedure TdmImportLGPIPHA.DataModuleCreate(Sender: TObject);
begin
  inherited;

  dmImportLGPIPHA := Self;
end;

{ IRequeteur }

procedure TdmImportLGPIPHA.ChargerDataSet(ADataSet: TDataSet; ARequeteSQL: string);
begin
  with qryLGPI do
  begin
    if Active then
      Close;

    SQL.Text := ARequeteSQL;
    Open;
  end;
end;

procedure TdmImportLGPIPHA.Commit;
begin
  dbLGPI.Commit;
end;

procedure TdmImportLGPIPHA.ExecuterScript(AScript: TStrings);
begin
  raise EAbstractError.Create('Fonctionnalité non-prise en charge');
end;

function TdmImportLGPIPHA.GererExceptionDataSet(E: Exception): Exception;
begin
  Result := EDatabaseError.Create(E.Message)
end;

function TdmImportLGPIPHA.LibererDataSet(ADataSet: TDataSet): Boolean;
begin
  Result := true;
  if dbLGPI.InTransaction then
    case ActionTransaction(ParametresConnexion.Values['bd']) of
      mrOk:
        Commit;
      mrAbort:
        Rollback;
    else
      Result := false;
    end;

  if Result then
    if qryLGPI.Active then
      qryLGPI.Close;
end;

function TdmImportLGPIPHA.RenvoyerDataSet: TDataSet;
begin
  Result := qryLGPI;
end;

function TdmImportLGPIPHA.RenvoyerTables: TStringList;
begin
  Result := TStringList.Create;
  dbLGPI.GetTableNames(Result);
end;

function TdmImportLGPIPHA.RenvoyerLignesAffectees(ADataSet: TDataSet): Integer;
begin
  Result := -1;
end;

procedure TdmImportLGPIPHA.Rollback;
begin
  dbLGPI.Rollback;
end;

end.
