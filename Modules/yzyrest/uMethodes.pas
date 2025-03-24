unit uMethodes;

interface

uses
  System.SysUtils,
  System.Classes,
  System.JSON,
  REST.Client,
  REST.Response.Adapter,
  Data.Bind.Components,
  Data.Bind.ObjectScope,
  REST.Types,
  uYZYRecords,
  Quick.Console,
  Quick.Logger,
  Quick.Logger.Provider.Console,
  Quick.Logger.Provider.Files,
  Quick.Logger.Provider.SysLog,
  Quick.logger.Provider.IDEDebug;

var
  _RESTRequest: TRESTRequest;
  _RESTClient: TRESTClient;
  _url: String;

procedure InitializeRestObject; stdcall;
procedure FinalizeRestObject; stdcall;
function tsfProduits(pYZYProduct: tYZYPOSTProducts; var Response: tYZYResponse) : pChar; stdCall;
Procedure SetUrl(pUrl: pChar); stdCall;
Procedure YZYLogger(pLog : tYZYLog); stdCall;

implementation

procedure InitializeRestObject; stdcall;
begin
  _RESTClient := TRESTClient.Create
    ('https://api-france-1.durnal.groupe.pharmagest.com/api/durnal-import/v1/jobs/start/repro-import');
  _RESTRequest := TRESTRequest.Create(nil);
  _RESTRequest.Client := _RESTClient;
end;

procedure FinalizeRestObject; stdcall;
begin
  Logger.info('Start Finalize');
  _RESTRequest.free;
  _RESTClient.free;
  Logger.info('YzyRest dll - Unloading');
end;

Procedure SetUrl(pUrl: pChar); stdCall;
begin
  Logger.info('SetUrl %s', [string(pUrl)]);
  _RESTClient.BaseURL := string(pUrl);
end;

function tsfProduits(pYZYProduct: tYZYPOSTProducts; var Response: tYZYResponse)
  : pChar; stdCall;
var
  sUrl: String;
  sFile: String;
  jResponse: tJSONValue;
begin
  sUrl := pYZYProduct.sUrl;
  sFile := pYZYProduct.sFile;
  Logger.info('[tsfProduits]');
  Logger.info(' >>>>>>>>> ');
  Logger.info(' - Fichier :  %s', [sFile]);
  Logger.info(' - Url     :  %s', [sUrl]);
  _RESTClient.BaseURL := sUrl;
  _RESTRequest.Method := rmPOST;
  _RESTRequest.Params.Clear;
  _RESTRequest.Params.AddItem('startDto',
    '{ "parameters": [ { "name": "JOB", "value": "IMPORT" } ]}', pkGETorPOST,
    [], 'application/json');
  _RESTRequest.Params.AddItem('file', sFile, pkFILE, [], 'text/csv');
  // TODO: Attraper, logguer et traiter les erreurs
  try
    _RESTRequest.Execute;
    result := pChar(_RESTRequest.Response.Content);
    jResponse := TJSONObject.ParseJSONValue(result);
    jResponse.TryGetValue<string>('id', Response.Id);
    Logger.info(' <<<<<<<<< ');
    Logger.info(' - Id      : %s', [Response.Id]);
    Logger.info(' - Reponse : %s', [_RESTRequest.Response.Content]);
  except
    on e: Exception do
    begin
      Logger.Error('%s',[e.Message]);
    end;

  end;
end;

{ TRESTYZYResponse }


Procedure YZYLogger(pLog : tYZYLog); stdCall;
var
  eventType : TEventType;
begin
     eventType := Quick.Logger.TEventType(pLog.sType);
     Logger.add(plog.sMessage,eventType);
end;

initialization

begin
  Logger.Providers.add(GlobalLogFileProvider);
  With GlobalLogFileProvider do
  begin
    FileName := './YzyRest.log';
    LogLevel := LOG_ALL;
    TimePrecission := true;
    MaxRotateFiles := 3;
    MaxFileSizeInMB := 5;
    RotatedFilesPath := './RotatedLogs';
    CompressRotatedFiles := False;
    Enabled := true;
  end;

  Logger.info('YzyRest dll - loaded');
  InitializeRestObject;
end;

end.
