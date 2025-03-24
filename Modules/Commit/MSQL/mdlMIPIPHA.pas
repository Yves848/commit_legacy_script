unit mdlMIPIPHA;

interface

uses
  Windows, SysUtils, Classes, mdlPHA, Generics.Collections, Variants,
  IniFiles, Registry, mdlProjet, mdlModuleImportPHA, mdlODBC, Math,
  StrUtils, mdlPIDataSet, DB, fbcustomdataset, mydbunit, uib, uibdataset, DBClient,
  ADODB;

type
  TdmMIPIPHA = class(TdmModuleImportPHA, IRequeteur)
    dataset: TClientDataSet;
    procedure DataModuleCreate(Sender: TObject);
  private
    Fqry : TPIRequete;
    { Déclarations privées }
  protected
    FdbPI : TPIConnexion;
    FqryPI : TPIRequete;
  public
    { Déclarations publiques }
    property dbPI : TPIConnexion read FdbPI;
    property qryPI : TPIRequete read FqryPI;
    function RenvoyerDataSet : TDataSet; virtual;
    function RenvoyerTables : TStringList; virtual;
    procedure ChargerDataSet(ADataSet : TDataSet; ARequeteSQL : string); virtual;
    function RenvoyerLignesAffectees(ADataSet : TDataSet) : Integer; virtual;
    procedure ExecuterScript(AScript : TStrings); virtual;
    procedure Commit; virtual;
    procedure Rollback; virtual;
    function GererExceptionDataSet(E : Exception) : Exception; virtual;
    function LibererDataSet(ADataSet : TDataSet) : Boolean; virtual;
  end;

var
  dmMIPIPHA : TdmMIPIPHA;

implementation

{$R *.dfm}

procedure TdmMIPIPHA.ChargerDataSet(ADataSet: TDataSet; ARequeteSQL: string);
begin
  Fqry.SQL.Text := ARequeteSQL;
  Fqry.CopierVersDataSet;
  dataset.Open;
end;

procedure TdmMIPIPHA.Commit;
begin
  raise EAbstractError.Create('Fonctionnalité non-supporté !');
end;

procedure TdmMIPIPHA.DataModuleCreate(Sender: TObject);
begin
  inherited;

  dmMIPIPHA := Self;
end;

procedure TdmMIPIPHA.ExecuterScript(AScript: TStrings);
begin
  raise EAbstractError.Create('Fonctionnalité non-supporté !');
end;

function TdmMIPIPHA.GererExceptionDataSet(E: Exception): Exception;
begin
  Result := E;
end;

function TdmMIPIPHA.LibererDataSet(ADataSet: TDataSet): Boolean;
begin
  Fqry.Fermer;
  FreeAndNil(Fqry);
  dataset.Close;
end;

function TdmMIPIPHA.RenvoyerDataSet: TDataSet;
begin
  Fqry := TClassePIRequete(FqryPI.ClassType).Create(Self);
  Fqry.PIConnexion := FdbPI;
  Fqry.DataSet := dataset;
  Result := dataset;
end;

function TdmMIPIPHA.RenvoyerLignesAffectees(ADataSet: TDataSet): Integer;
begin
  Result := -1;
end;

function TdmMIPIPHA.RenvoyerTables: TStringList;
begin
  Result := TStringList.Create;
  Result.AddStrings(FdbPI.Tables);
end;

procedure TdmMIPIPHA.Rollback;
begin
  raise EAbstractError.Create('Fonctionnalité non-supporté !');
end;

end.