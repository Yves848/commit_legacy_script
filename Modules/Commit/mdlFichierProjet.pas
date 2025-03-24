unit mdlFichierProjet;

interface

uses Windows, SysUtils, Classes, IniFiles;

type
  TData = (dHopital, dPraticien,
           dDestinataire, dOrganismePayeur, dOrganisme, dOrganismeAmoAssAmc, dCouvertureAMC, dTauxPriseEnCharge,
           dClient, dAssureRattache, dCouvertureClient, dParamRemiseFixe, dProfilRemise, dParamRemiseTVA, dFourchetteRemise, dProfilEdition, dCompte, dCompteClient,
           dFournisseur, dRepartiteur, dCodif, dClassifIntParent, dClassifIntEnfant, dZoneGeographique, dProduit, dCodeEAN13, dProduitLPP, dProduitGeographique, dHistoriqueVente, dHistoriqueAchatEntete, dHistoriqueAchatLigne, dTarif, dPromotion, dProduitPromotion,
           dProduitLocation, dProduitLocationLPP, dProduitNoSerie, dDossierLocation, dDossierLocationLigne, dLocationSuspension,
           dHisto_Client_Entete, dHisto_Client_Ligne,
           dParametre, dOperateur,
           dVignetteAvancee, dFactureAttenteEntete, dFactureAttenteLigne, dCredit, dCommandeAttenteEntete, dCommandeAttenteLigne, dProduitDuEntete, dProduitDuLigne);

  TCodifMode = (cmAuto, cmManual);

  TSectionChangedEvent = procedure (ASection, AValue : string) of object;

  TProjetFileSection = class(TPersistent)
  private
    FOnChanged: TSectionChangedEvent;
  protected
    FProjetFile : TMemIniFile;
    FSection : string;
    FValues : TStringList;
    function GetDateValue(AValue : string) : TDateTime;
    function GetIntegerValue(AValue : string) : Integer;
    procedure Changed(AValue : string); virtual; 
  public
    property ProjetFile : TMemIniFile read FProjetFile;
    property Section : string read FSection;
    property OnChanged : TSectionChangedEvent read FOnChanged write FOnChanged;
    constructor Create(AProjetFile: TMemIniFile; ASection : string); reintroduce; virtual;
    destructor Destroy; override;
  end;

  TProjetFileGeneralSection = class(TProjetFileSection)
  private
    FCurrentModule: string;
    FName: string;
    FCreated: TDateTime;
    FOraNet: Boolean;
    FConversionCouvAMO: TDateTime;
    FConversionCouvAMC: TDateTime;    
    FConversionOrgAMC: TDateTime;
    FConversionOrgAMO: TDateTime;
    FConversionProduitLocation: TDateTime;
    procedure SetCurrentModule(const Value: string);
    procedure SetOraNet(const Value: Boolean);
    procedure SetConversionCouvAMO(const Value: TDateTime);
    procedure SetConversionOrgAMC(const Value: TDateTime);
    procedure SetConversionOrgAMO(const Value: TDateTime);
    procedure SetConversionCouvAMC(const Value: TDateTime);
    procedure SetConversionProduitLocation(const Value: TDateTime);
  public
    property Created : TDateTime read FCreated;
    property CurrentModule : string read FCurrentModule write SetCurrentModule;
    property Name : string read FName;
    property OraNet : Boolean read FOraNet write SetOraNet;
    property ConversionOrgAMO : TDateTime read FConversionOrgAMO write SetConversionOrgAMO;
    property ConversionCouvAMO : TDateTime read FConversionCouvAMO write SetConversionCouvAMO;
    property ConversionOrgAMC : TDateTime read FConversionOrgAMC write SetConversionOrgAMC;
    property ConversionCouvAMC : TDateTime read FConversionCouvAMC write SetConversionCouvAMC;
    property ConversionProduitLocation : TDateTime read FConversionProduitLocation write SetConversionProduitLocation;
    constructor Create(AProjetFile: TMemIniFile; ASection : string); override;
    procedure Assign(Source : TPersistent); override;
    procedure IniTProjet;
  end;

  TProjetFileImportSection = class(TProjetFileSection)
  private
    FModule: string;
    FVersion: string;
  public
    property Module : string read FModule;
    property Version : string read FVersion;
    constructor Create(AProjetFile: TMemIniFile; ASection : string); override;
    procedure Assign(Source : TPersistent); override;
    procedure SetImport(AImportModule, AVersion: string);
  end;

  TCodifList = class(TStringList)
  private
    FSection : TProjetFileSection;
  protected
    procedure InsertItem(Index: Integer; const S: string; AObject: TObject); override; 
  public
    constructor Create(ASection : TProjetFileSection); reintroduce;
    procedure Clear; override;
    procedure Delete(Index: Integer); override;
    function IndexOfValue(S : string) : Integer;
  end;

  TCodifLabelList = class(TStringList)
  private
    FSection : TProjetFileSection;
  protected
    procedure InsertItem(Index: Integer; const S: string; AObject: TObject); override;
  public
    constructor Create(ASection : TProjetFileSection); reintroduce;
    procedure Clear; override;
  end;

  TProjetFileCodifsSection = class(TProjetFileSection)
  private
    FCodifs: TCodifList;
    FMode: TCodifMode;
    FCodifsLabels: TCodifLabelList;
    FInfoZoneGeoStock: Boolean;
    procedure SetCodifs(const Value: TCodifList);
    procedure SetMode(const Value: TCodifMode);
    procedure SetCodifsLabel(const Value: TCodifLabelList);
    procedure SetInfoZoneGeoStock(const Value: Boolean);
    function GetClassIntParent: string;
    function GetClassIntEnfant: string;
  public
    property ClassIntParent : string read GetClassIntParent;
    property ClassIntEnfant : string read GetClassIntEnfant;
    property Codifs : TCodifList read FCodifs write SetCodifs;
    property CodifsLabels : TCodifLabelList read FCodifsLabels write SetCodifsLabel;
    property Mode : TCodifMode read FMode write SetMode;
    property InfoZoneGeoStock : Boolean read FInfoZoneGeoStock write SetInfoZoneGeoStock;
    constructor Create(AProjetFile : TMemIniFile; ASection : string); override;
    procedure Assign(Source : TPersistent); override;
    procedure SetDefaultCodifs;
  end;

  TProjetFileTransfertSection = class(TProjetFileSection)
  private
    FModule: string;
    FVersion: string;
    FFileNameOrgAMCRef: TFileName;
    FSynchronization: TDateTime;
    FExportData: Boolean;
    FConnectString: string;
    procedure SetFileNameOrgAMCRef(const Value: TFileName);
    procedure SetSynchronization(const Value: TDateTime);
    procedure SetExportData(const Value: Boolean);
    procedure SetConnectString(const Value: string);
    procedure SetModule(const Value: string);
  public
    property Module : string read FModule write SetModule;
    property Version : string read FVersion;
    property FileNameOrgAMCRef : TFileName read FFileNameOrgAMCRef write SetFileNameOrgAMCRef;
    property ConnectString : string read FConnectString write SetConnectString;
    property Synchronization : TDateTime read FSynchronization write SetSynchronization;
    property ExportData : Boolean read FExportData write SetExportData;
    constructor Create(AProjetFile: TMemIniFile; ASection : string); override;
    procedure Assign(Source : TPersistent); override;
    procedure SetTransfert(ATransfertModule, AVersion : string);
  end;

  TProjetFileDataSection = class(TProjetFileSection)
  private
    FFinished: Boolean;
    FTotal: LongInt;
    FSuccess: LongInt;
    FReject: LongInt;
    FIndex: TData;
    FCaption: string;
    FDiffered: Boolean;
    FImport: string;
    FTransfert: string;
    FWorkTable: string;
    FKeyTf: string;
    FKeyImp: string;
    procedure SetFinished(const Value: Boolean);
    procedure SetReject(const Value: LongInt);
    procedure SetSuccess(const Value: LongInt);
    procedure SetTotal(const Value: LongInt);
    procedure SetDiffered(const Value: Boolean);
    procedure SetImport(const Value: string);
    procedure SetTransfert(const Value: string);
    procedure SetWorkTable(const Value: string);
    procedure SetKeyImp(const Value: string);
    procedure SetKeyTf(const Value: string);
  public
    property Caption : string read FCaption;
    property Finished : Boolean read FFinished write SetFinished;
    property Total : LongInt read FTotal write SetTotal;
    property Success : LongInt read FSuccess write SetSuccess;
    property Reject : LongInt read FReject write SetReject;
    property Differed : Boolean read FDiffered write SetDiffered;
    property KeyImp : string read FKeyImp write SetKeyImp;
    property KeyTf : string read FKeyTf write SetKeyTf;    
    property WorkTable : string read FWorkTable write SetWorkTable;
    property Import : string read FImport write SetImport;
    property Transfert : string read FTransfert write SetTransfert;
    property Index : TData read FIndex;
    constructor Create(AProjetFile : TMemIniFile; AData : string; ACaption : string; AIndex : TData); reintroduce;
  end;

  TProjetFile = class
  private
    FDataList : TList;
    FProjetFile : TMemIniFile;
    FProjetFileImportSection: TProjetFileImportSection;
    FProjetFileTransfertSection: TProjetFileTransfertSection;
    FProjetFileGeneralSection: TProjetFileGeneralSection;
    FProjetFileCodifsSection: TProjetFileCodifsSection;
    procedure SeTProjetFileImportSection(
      const Value: TProjetFileImportSection);
    procedure SeTProjetFileTransfertSection(
      const Value: TProjetFileTransfertSection);
    function GetData(const Name: string): TProjetFileDataSection;
    procedure SetData(const Name: string;
      const Value: TProjetFileDataSection);
    function FindData(AIndex : TData) : TProjetFileDataSection; overload;
    function FindData(AData : string) : TProjetFileDataSection; overload;
    procedure SeTProjetFileGeneralSection(
      const Value: TProjetFileGeneralSection);
    function GetDatasCount: Integer;
    procedure SeTProjetFileCodifsSection(
      const Value: TProjetFileCodifsSection);
  public
    property DatasCount : Integer read GetDatasCount;
    property ProjetFile : TMemIniFile read FProjetFile;
    property ProjetFileGeneralSection : TProjetFileGeneralSection read FProjetFileGeneralSection write SeTProjetFileGeneralSection;
    property ProjetFileImportSection : TProjetFileImportSection read FProjetFileImportSection write SeTProjetFileImportSection;
    property ProjetFileTransfertSection : TProjetFileTransfertSection read FProjetFileTransfertSection write SeTProjetFileTransfertSection;
    property ProjetFileCodifsSection : TProjetFileCodifsSection read FProjetFileCodifsSection write SeTProjetFileCodifsSection;
    property Datas[const Name : string] : TProjetFileDataSection read GetData write SetData;
    function DataByIndex(AIndex : TData) : TProjetFileDataSection;
    constructor Create(AProjetFile : string; ANewProjet : Boolean = False);
    destructor Destroy; override;
    function AddData(ADataName, ACaption : string; AIndex : TData): TProjetFileDataSection; virtual;
    procedure SaveProjetFile;
  end;

const
  PHA_CODIF1 = 1;
  PHA_CODIF2 = 2;
  PHA_CODIF3 = 3;
  PHA_CODIF4 = 4;
  PHA_CODIF5 = 5;
  PHA_CODIF6 = 6;
  PHA_CODIF7 = 7;
  PHA_ZONEGEO = 8;

  ERP_CODIF1 = 11;
  ERP_CODIF2 = 12;
  ERP_CODIF3 = 13;
  ERP_CODIF4 = 14;
  ERP_CODIF5 = 15;
  ERP_CLINT_PRT = 16;
  ERP_CLINT_ENF = 17;

implementation

uses Math, DateUtils;

{ TProjetFileSection }

procedure TProjetFileSection.Changed(AValue : string);
begin
  if Assigned(FOnChanged) then
    FOnChanged(FSection, AValue);
end;

constructor TProjetFileSection.Create(AProjetFile: TMemIniFile; ASection : string);
begin
  if Assigned(AProjetFile) then
    FProjetFile := AProjetFile
  else
    raise Exception.Create('Fichier Projet incorrect !');

  FSection := ASection;

  FValues := TStringList.Create;
  FProjetFile.ReadSectionValues(FSection, FValues);
end;

destructor TProjetFileSection.Destroy;
begin
  FValues.Free;

  inherited;
end;

function TProjetFileSection.GetDateValue(AValue: string): TDateTime;
var
  lDtTemp : TDateTime;
begin
  if TryStrToDate(AValue, lDtTemp) then
    Result := lDtTemp
  else
    Result := 0;
end;

function TProjetFileSection.GetIntegerValue(AValue: string): Integer;
var
  lIntTemp : Integer;
begin
  if TryStrToInt(AValue, lIntTemp) then
    Result := lIntTemp
  else
    Result := 0;
end;

{ TProjetFileGeneralSection }

procedure TProjetFileGeneralSection.Assign(Source: TPersistent);
begin
  inherited;

  if Source is TProjetFileGeneralSection then
  begin
    FCurrentModule := TProjetFileGeneralSection(Source).CurrentModule;
    FName := TProjetFileGeneralSection(Source).Name;
    FCreated := TProjetFileGeneralSection(Source).Created;
    FConversionCouvAMO := TProjetFileGeneralSection(Source).ConversionCouvAMO;
    FConversionOrgAMC := TProjetFileGeneralSection(Source).ConversionOrgAMC;
    FConversionOrgAMO := TProjetFileGeneralSection(Source).ConversionOrgAMO;
  end
  else
    raise Exception.Create('Impossible de copier ce type de données (' + Source.ClassName + ')');
end;

constructor TProjetFileGeneralSection.Create(AProjetFile: TMemIniFile;
  ASection: string);
begin
  inherited;

  with FValues do
  begin
    FName := FValues.Values['REPRISE'];
    FCurrentModule := FValues.Values['MODULE'];
    FCreated := GetDateValue(FValues.Values['CREATION']);
    FOraNet := FValues.Values['ORANET'] = '1';
    FConversionCouvAMO := GetDateValue(FValues.Values['CONVERSION_COUVAMO']);
    FConversionOrgAMO := GetDateValue(FValues.Values['CONVERSION_ORGAMO']);
    FConversionOrgAMC := GetDateValue(FValues.Values['CONVERSION_ORGAMC']);
    FConversionCouvAMC := GetDateValue(FValues.Values['CONVERSION_COUVAMC']);
  end;
end;

procedure TProjetFileGeneralSection.IniTProjet;
var
  lStrProjetFileName : string;
begin
  FCreated := Now; FProjetFile.WriteDate('GENERAL', 'CREATION', FCreated);
  FCurrentModule := 'IMPORT'; SetCurrentModule(FCurrentModule);
  lStrProjetFileName := ExtractFileName(FProjetFile.FileName);
  FName := Copy(ExtractFileName(FProjetFile.FileName), 1, Pos(ExtractFileExt(lStrProjetFileName), lStrProjetFileName) - 1);
  FProjetFile.WriteString('GENERAL', 'REPRISE', FName);
  FOraNet := True; FProjetFile.WriteBool('GENERAL', 'ORANET', FOraNet);
end;

procedure TProjetFileGeneralSection.SetCurrentModule(const Value: string);
begin
  FProjetFile.WriteString('GENERAL', 'MODULE', Value);
  FCurrentModule := Value;
end;

procedure TProjetFileGeneralSection.SetOraNet(const Value: Boolean);
begin
  FProjetFile.WriteBool('GENERAL', 'ORANET', Value);
  FOraNet := Value;
end;

procedure TProjetFileGeneralSection.SetConversionCouvAMO(
  const Value: TDateTime);
begin
  FProjetFile.WriteDate('GENERAL', 'CONVERSION_COUVAMO', Value);
  FConversionCouvAMO := Value;

  if Assigned(FOnChanged) then
    FOnChanged('GENERAL', 'CONVERSION_COUVAMO');
end;

procedure TProjetFileGeneralSection.SetConversionOrgAMC(
  const Value: TDateTime);
begin
  FProjetFile.WriteDate('GENERAL', 'CONVERSION_ORGAMC', Value);
  FConversionOrgAMC := Value;

  if Assigned(FOnChanged) then
    FOnChanged('GENERAL', 'CONVERSION_ORGAMC');
end;

procedure TProjetFileGeneralSection.SetConversionCouvAMC(
  const Value: TDateTime);
begin
  FProjetFile.WriteDate('GENERAL', 'CONVERSION_COUVAMC', Value);
  FConversionCouvAMC := Value;

  if Assigned(FOnChanged) then
    FOnChanged('GENERAL', 'CONVERSION_COUVAMC');
end;

procedure TProjetFileGeneralSection.SetConversionOrgAMO(
  const Value: TDateTime);
begin
  FProjetFile.WriteDate('GENERAL', 'CONVERSION_ORGAMO', Value);
  FConversionOrgAMO := Value;

  if Assigned(FOnChanged) then
    FOnChanged('GENERAL', 'CONVERSION_ORGAMO');
end;

procedure TProjetFileGeneralSection.SetConversionProduitLocation(
  const Value: TDateTime);
begin
  FProjetFile.WriteDate('GENERAL', 'CONVERSION_PRDLOC', Value);
  FConversionProduitLocation := Value;

  if Assigned(FOnChanged) then
    FOnChanged('GENERAL', 'CONVERSION_PRDLOC');
end;

{ TProjetFileTransfertSection }

constructor TProjetFileTransfertSection.Create(AProjetFile: TMemIniFile;
  ASection: string);
begin
  inherited;

  with FValues do
  begin
    FModule := FValues.Values['MODULE'];
    FConnectString := FValues.Values['CONNECTSTRING'];
    FSynchronization := GetDateValue(FValues.Values['SYNCHRONISATION']);
    FFileNameOrgAMCRef := FValues.Values['CONVERSION_ORGAMC_FICHIER'];
    FExportData := FValues.Values['EXPORT_DONNEES'] = '1';
  end;
end;

procedure TProjetFileTransfertSection.SetExportData(const Value: Boolean);
begin
  FProjetFile.WriteBool('TRANSFERT', 'EXPORT_DONNEES', Value);
  FExportData := Value;
end;

procedure TProjetFileTransfertSection.SetFileNameOrgAMCRef(
  const Value: TFileName);
begin
  FProjetFile.WriteString('TRANSFERT', 'CONVERSION_ORGAMC_FICHIER', Value);
  FileNameOrgAMCRef := Value;
end;

procedure TProjetFileTransfertSection.SetSynchronization(
  const Value: TDateTime);
begin
  FProjetFile.WriteDate('TRANSFERT', 'SYNCHRONISATION', Value);
  FSynchronization := Value;

  if Assigned(FOnChanged) then
    FOnChanged('TRANSFERT', 'SYNCHRONISATION');
end;

procedure TProjetFileTransfertSection.SetTransfert(
  ATransfertModule, AVersion: string);
begin
  if FModule = '' then
  begin
    // Modification du module de transfert
    FProjetFile.WriteString('TRANSFERT', 'MODULE', ATransfertModule);
    FProjetFile.WriteString('TRANSFERT', 'VERSION', AVersion);
    FModule := ATransfertModule;
    FVersion := AVersion;
  end;
end;

procedure TProjetFileTransfertSection.Assign(Source: TPersistent);
begin
  inherited;

  if Source is TProjetFileTransfertSection then
  begin
    FModule := TProjetFileTransfertSection(Source).Module;
    FVersion := TProjetFileTransfertSection(Source).Version;
    FConnectString := TProjetFileTransfertSection(Source).ConnectString;
    FFileNameOrgAMCRef := TProjetFileTransfertSection(Source).FileNameOrgAMCRef;
    FSynchronization := TProjetFileTransfertSection(Source).Synchronization;
    FExportData := TProjetFileTransfertSection(Source).FExportData;
  end
  else
    raise Exception.Create('Impossible de copier ce type de données (' + Source.ClassName + ')');
end;

procedure TProjetFileTransfertSection.SetConnectString(
  const Value: string);
begin
  FProjetFile.WriteString('TRANSFERT', 'CONNECTSTRING', Value);
  FConnectString := Value;
end;

procedure TProjetFileTransfertSection.SetModule(const Value: string);
begin
  FProjetFile.WriteString('TRANSFERT', 'MODULE', Value);
  FModule := Value;
end;

{ TProjetFileDataSection }

constructor TProjetFileDataSection.Create(AProjetFile : TMemIniFile; AData: string; ACaption : string; AIndex : TData);
begin
  inherited Create(AProjetFile, AData);

  if AData <> '' then
  begin
    FSection := AData;
    FCaption := ACaption;
    FIndex := AIndex;
    FDiffered := False;

    // Définition des procédures d'import & transfert
    FKeyImp := 'A' + AData;
    FKeyTf := 'T_' + AData + '_ID';
    FImport := 'SELECTION' + AData;
    FTransfert := 'PK_CREATIONDONNEES.CREATION' + AData;
    FWorkTable := 'TW_' + AData;
  end
  else
    raise Exception.Create('Données inconnue !');

  with FValues do
  begin
    FFinished := FValues.Values[FSection] = '1';
    FTotal := GetIntegerValue(FValues.Values['TOTAL']);
    FSuccess := GetIntegerValue(FValues.Values['SUCCES']);
    FReject := GetIntegerValue(FValues.Values['REJETS']);
  end;
end;

procedure TProjetFileDataSection.SetDiffered(const Value: Boolean);
begin
  FDiffered := Value;
end;

procedure TProjetFileDataSection.SetFinished(const Value: Boolean);
begin
  FProjetFile.WriteBool(FSection, FSection, Value);
  FFinished := Value;
end;

procedure TProjetFileDataSection.SetImport(const Value: string);
begin
  FImport := Value;
end;

procedure TProjetFileDataSection.SetKeyImp(const Value: string);
begin
  FKeyImp := Value;
end;

procedure TProjetFileDataSection.SetKeyTf(const Value: string);
begin
  FKeyTf := Value;
end;

procedure TProjetFileDataSection.SetReject(const Value: LongInt);
begin
  FProjetFile.WriteInteger(FSection, 'REJETS', Value);
  FReject := Value;
end;

procedure TProjetFileDataSection.SetSuccess(const Value: LongInt);
begin
  FProjetFile.WriteInteger(FSection, 'SUCCES', Value);
  FSuccess := Value;
end;

procedure TProjetFileDataSection.SetTotal(const Value: LongInt);
begin
  FProjetFile.WriteInteger(FSection, 'TOTAL', Value);
  FTotal := Value;
end;

procedure TProjetFileDataSection.SetTransfert(const Value: string);
begin
  FTransfert := Value;
end;

procedure TProjetFileDataSection.SetWorkTable(const Value: string);
begin
  FWorkTable := Value;
end;

{ TProjetFile }

function TProjetFile.AddData(ADataName, ACaption : string; AIndex : TData): TProjetFileDataSection;
begin
  Result := TProjetFileDataSection.Create(FProjetFile, ADataName, ACaption, AIndex);
  FDataList.Add(Result);
end;

constructor TProjetFile.Create(AProjetFile: string; ANewProjet : Boolean = False);
begin
  // Création du support pour le fichier projet
  if AProjetFile <> '' then
    FProjetFile := TMemIniFile.Create(AProjetFile)
  else
    raise Exception.Create('Fichier Projet incorrect !');

  // Création des différentes section
  FProjetFileGeneralSection := TProjetFileGeneralSection.Create(FProjetFile, 'GENERAL');
  FProjetFileImportSection := TProjetFileImportSection.Create(FProjetFile, 'IMPORT');
  FProjetFileTransfertSection := TProjetFileTransfertSection.Create(FProjetFile, 'TRANSFERT');
  FProjetFileCodifsSection := TProjetFileCodifsSection.Create(FProjetFile, 'CONFIG_CODIFS');
  FDataList := TList.Create;

  // Initialisation du projet si nouveau
  if ANewProjet then
    FProjetFileGeneralSection.IniTProjet;
end;

function TProjetFile.DataByIndex(
  AIndex: TData): TProjetFileDataSection;
begin
  Result := FindData(AIndex);
end;

destructor TProjetFile.Destroy;
begin
  // Sauvegarde
  SaveProjetFile;

  // Destruction de toutes les sections de données
  if Assigned(FDataList) then
  begin
    if FDataList.Count <> 0 then
      FDataList.Clear;

    FreeAndNil(FDataList);
  end;

  // Les autres sections
  if Assigned(FProjetFileTransfertSection) then FreeAndNil(FProjetFileTransfertSection);
  if Assigned(FProjetFileImportSection) then FreeAndNil(FProjetFileImportSection);
  if Assigned(FProjetFileGeneralSection) then FreeAndNil(FProjetFileGeneralSection);
  if Assigned(FProjetFile) then FreeAndNil(FProjetFile);
end;

function TProjetFile.FindData(AData: string): TProjetFileDataSection;
var
  i : Integer;
begin
  for i := 0 to FDataList.Count - 1 do
  begin
    Result := FDataList.Items[i];
    if Result.Section = AData then Exit;
  end;
  Result := nil;
end;

function TProjetFile.FindData(AIndex: TData): TProjetFileDataSection;
var
  i : Integer;
begin
  for i := 0 to FDataList.Count - 1 do
  begin
    Result := FDataList.Items[i];
    if Result.Index = AIndex then Exit;
  end;
  Result := nil;
end;

function TProjetFile.GetData(const Name: string): TProjetFileDataSection;
begin
  Result := FindData(Name);
end;

function TProjetFile.GetDatasCount: Integer;
begin
  Result := FDataList.Count;
end;

procedure TProjetFile.SaveProjetFile;
begin
  FProjetFile.UpdateFile;
end;

procedure TProjetFile.SetData(const Name: string;
  const Value: TProjetFileDataSection);
begin
  Datas[Name].Assign(Value);
end;

procedure TProjetFile.SeTProjetFileCodifsSection(
  const Value: TProjetFileCodifsSection);
begin
  FProjetFileCodifsSection.Assign(Value);
end;

procedure TProjetFile.SeTProjetFileGeneralSection(
  const Value: TProjetFileGeneralSection);
begin
  FProjetFileGeneralSection.Assign(Value);
end;

procedure TProjetFile.SeTProjetFileImportSection(
  const Value: TProjetFileImportSection);
begin
  FProjetFileImportSection.Assign(Value);
end;

procedure TProjetFile.SeTProjetFileTransfertSection(
  const Value: TProjetFileTransfertSection);
begin
  FProjetFileTransfertSection.Assign(Value);
end;

{ TProjetFileImportSection }

procedure TProjetFileImportSection.Assign(Source: TPersistent);
begin
  inherited;

  if Source is TProjetFileImportSection then
  begin
    FModule := TProjetFileImportSection(Source).Module;
    FVersion := TProjetFileImportSection(Source).Version;
  end
  else
    raise Exception.Create('Impossible de copier ce type de données (' + Source.ClassName + ')');
end;

constructor TProjetFileImportSection.Create(AProjetFile: TMemIniFile;
  ASection: string);
begin
  inherited;

  with FValues do
  begin
    FModule := FValues.Values['MODULE'];
  end;
end;

procedure TProjetFileImportSection.SetImport(AImportModule, AVersion: string);
begin
  if FModule = '' then
  begin
    // Modification du module de transfert
    FProjetFile.WriteString('IMPORT', 'MODULE', AImportModule);
    FProjetFile.WriteString('IMPORT', 'VERSION', AVersion);
    FModule := AImportModule;
    FVersion := AVersion;
  end;
end;

{ TProjetFileCodifSection }

procedure TProjetFileCodifsSection.Assign(Source: TPersistent);
begin
  inherited;

  if Source is TProjetFileCodifsSection then
  begin
    FCodifs.Assign(TProjetFileCodifsSection(Source).Codifs);
  end
  else
    raise Exception.Create('Impossible de copier ce type de données (' + Source.ClassName + ')');
end;

constructor TProjetFileCodifsSection.Create(AProjetFile: TMemIniFile; ASection : string);
var
  lValues : TStringList;
  i, lIntIndex : Integer;

  function IndexOfValue(AValue: string) : Integer;
  var
    i : Integer;
  begin
    Result := -1; i := 0;
    while (i < lValues.Count) and (Result = -1) do
      if lValues.ValueFromIndex[i] = AValue then
        Result := i
      else
        i := i + 1;
  end;

begin
  inherited;

  FInfoZoneGeoStock := FProjetFile.ReadBool('CONFIG_CODIFS', 'INFO_ZONEGEOSTOCK', True);

  // Lecture de la config. des codifs
  FCodifs := TCodifList.Create(Self);
  FCodifsLabels := TCodifLabelList.Create(Self);

  lValues := TStringList.Create;
  // Lecture de la configuration
  FProjetFile.ReadSectionValues('CONFIG_CODIFS', lValues);
  for i := ERP_CODIF1 to ERP_CLINT_ENF do
  begin
    lIntIndex := IndexOfValue(IntToStr(i));
    if lIntIndex <> -1 then
      FCodifs.Add(lValues.Strings[lIntIndex])
  end;

  // Lecture des libéllés
  for i := PHA_CODIF1 to PHA_CODIF7 do
  begin
    lIntIndex := lValues.IndexOfName('CODIF' + IntToStr(i));
    if lIntIndex <> -1 then
      FCodifsLabels.Add(lValues[lIntIndex]);
  end;
  FreeAndNil(lValues);
  
  FMode := TCodifMode(FProjetFile.ReadInteger(FSection, 'MODE', 0));
end;

function TProjetFileCodifsSection.GetClassIntParent: string;
var
  i, lIntMaxOcc : Integer;
  lInt : Integer;
begin
  Result := ''; lIntMaxOcc := Codifs.Count - 1;
  for i := 0 to lIntMaxOcc do
    if TryStrToInt(Codifs.ValueFromIndex[i], lInt) then
    begin
      if lInt = ERP_CLINT_PRT then
        result := 'CODIF' + Codifs.Names[i];
    end;
end;

function TProjetFileCodifsSection.GetClassIntEnfant: string;
var
  i, lIntMaxOcc : Integer;
  lInt : Integer;
begin
  Result := ''; lIntMaxOcc := Codifs.Count - 1;
  for i := 0 to lIntMaxOcc do
    if TryStrToInt(Codifs.ValueFromIndex[i], lInt) then
    begin
      if lInt = ERP_CLINT_ENF then
        result := 'CODIF' + Codifs.Names[i];
    end;
end;

procedure TProjetFileCodifsSection.SetCodifs(const Value: TCodifList);
begin
  FCodifs.Assign(Value);
end;

{ TCodifList }

procedure TCodifList.Clear;
var
  i : Integer;
begin
  // On efface la section
  for i := 0 to Count - 1 do
    FSection.ProjetFile.WriteString(FSection.Section, Names[i], '');

  inherited;
end;

constructor TCodifList.Create(ASection: TProjetFileSection);
begin
  inherited Create;

  FSection := ASection;
end;

procedure TCodifList.Delete(Index: Integer);
begin
  FSection.ProjetFile.WriteString(FSection.Section, Names[Index], '');

  inherited;
end;

function TCodifList.IndexOfValue(S: string): Integer;
var
  i : Integer;
begin
  Result := -1; i := 0;
  while (i < Count) and (Result = -1) do
    if ValueFromIndex[i] = S then
      Result := i
    else
      i := i + 1;
end;

procedure TCodifList.InsertItem(Index: Integer; const S: string; AObject: TObject);
var
  lIntIndex : Integer;
  lIntPos : Integer;
  lStrName, lStrValue : string;
  i : Integer;
  lIntTemp : Integer;
  lBoolPrt : Boolean;
begin
  // Vérification de la relation
  lIntPos := Pos('=', S);
  if lIntPos <> 0 then
  begin
    lStrName := Copy(S, 1, lIntPos - 1);
    lStrValue := Copy(S, lIntPos + 1, Length(S));

    // Vérification des interdits
   TryStrToInt(lStrValue, lIntTemp);
    if (lStrName = IntToStr(PHA_ZONEGEO)) and (lIntTemp in [ERP_CLINT_PRT, ERP_CLINT_ENF]) then
      raise Exception.Create('Impossible d''associer la zone géographique avec le champ classification interne parent ou enfant !');

    // Recherche de l'existant
    lIntIndex := IndexOfName(lStrName);

    lBoolPrt := False;
    for i := 0 to Count -1 do
    begin
      if (lStrName <> Names[i]) and (lStrValue = ValueFromIndex[i]) and (ValueFromIndex[i] <> '') then
        raise Exception.Create('Impossible d''associer deux codifications PHA vers la même codifications ERP !');

      // Classification interne
      if (ValueFromIndex[i] <> '') and not lBoolPrt then
        lBoolPrt := StrToInt(ValueFromIndex[i]) = ERP_CLINT_PRT;
    end;

    if lStrValue <> '' then
      if not lBoolPrt and (StrToInt(lStrValue) = ERP_CLINT_ENF) then
        raise Exception.Create('Impossible d''associer la classification interne enfant sans avoir associer la classification interne parent !');

    if lIntIndex <> -1 then
      Strings[lIntIndex] := S
    else
      inherited InsertItem(Index, S, AObject);

    // MAJ fichier projet
    FSection.FProjetFile.WriteString(FSection.Section, lStrName, lStrValue);
  end
  else
    inherited;
end;

procedure TProjetFileCodifsSection.SetCodifsLabel(const Value: TCodifLabelList);
begin
  FCodifsLabels.Assign(Value);
end;

procedure TProjetFileCodifsSection.SetDefaultCodifs;
begin
  // Codifs par défaut
  FCodifs.Add('1=11');
  FCodifs.Add('2=12');
  FCodifs.Add('3=13');
  FCodifs.Add('4=14');
  FCodifs.Add('5=15');
  FCodifs.Add('6=16');
  FCodifs.Add('7=17');
end;

procedure TProjetFileCodifsSection.SetInfoZoneGeoStock(
  const Value: Boolean);
begin
  FProjetFile.WriteBool(FSection, 'INFO_ZONEGEOSTOCK', Value);
  FInfoZoneGeoStock := Value;
end;

procedure TProjetFileCodifsSection.SetMode(const Value: TCodifMode);
begin
  FProjetFile.WriteInteger(FSection, 'MODE', Integer(Value));
  FMode := Value;
end;

{ TCodifLabelList }

procedure TCodifLabelList.Clear;
var
  i : Integer;
begin
  // On efface la section
  for i := 0 to Count - 1 do
    FSection.ProjetFile.WriteString(FSection.Section, Names[i], '');

  inherited;
end;


constructor TCodifLabelList.Create(ASection: TProjetFileSection);
begin
  inherited Create;

  FSection := ASection;
end;

procedure TCodifLabelList.InsertItem(Index: Integer; const S: string;
  AObject: TObject);
var
  lIntIndex : Integer;
  lIntPos : Integer;
  lStrName, lStrValue : string;
begin
  // Vérification de la relation
  lIntPos := Pos('=', S);
  if lIntPos <> 0 then
  begin
    lStrName := Copy(S, 1, lIntPos - 1);
    lStrValue := Copy(S, lIntPos + 1, Length(S));

    // Recherche de l'existant
    lIntIndex := IndexOfName(lStrName);

    if lIntIndex <> -1 then
      inherited InsertItem(lIntIndex, S, AObject)
    else
      inherited InsertItem(Index, S, AObject);

    // MAJ fichier projet
    FSection.FProjetFile.WriteString(FSection.Section, lStrName, lStrValue);
  end
  else
    inherited;
end;

end.


