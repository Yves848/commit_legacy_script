unit mdlMIODBCPHA;

interface

uses
  Windows, SysUtils, Classes, mdlPHA, Generics.Collections, Variants,
  IniFiles, Registry, mdlProjet, mdlModuleImportPHA, Math, mdlMIPIPHA,
  StrUtils, mdlPIODBC, DB, fbcustomdataset, mydbunit, uib, uibdataset, DBClient,
  mdlPIDataSet;

type
  TdmMIODBCPHA = class(TdmMIPIPHA)
    procedure DataModuleCreate(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
    procedure ConnexionBD; override;
    procedure DeConnexionBD; override;
  end;

var
  dmMIODBCPHA : TdmMIODBCPHA;

implementation

{$R *.dfm}

procedure TdmMIODBCPHA.ConnexionBD;
begin
  inherited;

  if Assigned(FqryPI) then FreeAndNil(FqryPI);
  if Assigned(FdbPI) then FreeAndNil(FdbPI);

  FdbPI := TPIODBCConnexion.Create(Self);
  TPIODBCConnexion(FdbPI).MettreNullSiErreur := False;

  FqryPI := TPIODBCRequete.Create(Self);
  FqryPI.PIConnexion := FdbPI;
end;

procedure TdmMIODBCPHA.DataModuleCreate(Sender: TObject);
begin
  inherited;

  dmMIODBCPHA := Self;
end;

procedure TdmMIODBCPHA.DeConnexionBD;
begin
  if Assigned(FdbPI) and FdbPI.Connected then
    FdbPI.Close;

  inherited;

end;

end.