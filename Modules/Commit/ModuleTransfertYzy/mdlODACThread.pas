unit mdlODACThread;

interface

uses
  Windows, SysUtils, Messages, mdlAttente, DB, Ora, OraScript, Variants;
  
type
  TThreadPSORA = class(TAttente)
  protected
    procedure LancerExecution; override;
  end;

  TThreadScriptORA = class(TAttente)
  protected
    procedure LancerExecution; override;
  end;

  procedure TransfererParametres(AValeurs : TFields; AParametres : TOraParams); overload;
  procedure TransfererParametres(AValeurs : Variant; AParametres : TOraParams); overload;

implementation

uses Classes;

procedure TransfererParametres(AValeurs : Variant;
  AParametres : TOraParams);
var
  i : Integer;
  lStrTemp : string;
  lDtTemp : TDateTime;
begin
  for i := 0 to AParametres.Count - 1 do
    if VarIsNull(AValeurs[i]) then
      AParametres[i].Value := null
    else
      case AParametres[i].DataType of
         ftString :
           AParametres[i].AsString := AValeurs[i];
         ftInteger, ftSmallint :
           AParametres[i].AsInteger := AValeurs[i];
         ftFloat :
           AParametres[i].AsFloat := AValeurs[i];
         ftDate, ftTime, ftDateTime :
            if (VarType(AValeurs[i]) = varOleStr) or (VarType(AValeurs[i]) = varString) then
            begin
              lStrTemp := Copy(AValeurs[i], 1, 4) + '/' +
                          Copy(AValeurs[i], 5, 2) + '/' +
                          Copy(AValeurs[i], 7, 2);
              if not TryStrToDate(lStrTemp, lDtTemp) then
                AParametres[i].Value := null
              else
                AParametres[i].AsDateTime := lDtTemp
            end
            else
              if AValeurs[i] = 0 then
                AParametres[i].Value := null
              else
                AParametres[i].AsDateTime := AValeurs[i];
      else
        AParametres[i].AsString := AValeurs[i];
      end;
end;

procedure TransfererParametres(AValeurs : TFields;
  AParametres : TOraParams);
var
  i : Integer;
  laValeurs : Variant;
begin
  laValeurs := VarArrayCreate([0, AValeurs.Count - 1], varVariant);
  for i := 0 to AParametres.Count - 1 do
    if AValeurs[i].IsNull then
      laValeurs[i] := null
    else
      laValeurs[i] := AValeurs[i].Value;
  TransfererParametres(laValeurs, AParametres);
end;

{ TThreadRequeteORA }

procedure TThreadPSORA.LancerExecution;
begin
  inherited;

  try
    TOraStoredProc(FParametres).Tag := 1;
    TOraStoredProc(FParametres).Execute;
  except
    TOraStoredProc(FParametres).Tag := 0;
  end;
  Terminate;
end;

{ TThreadScriptORA }

procedure TThreadScriptORA.LancerExecution;
begin
  inherited;

  try
    TOraScript(FParametres).Tag := 1;
    TOraScript(FParametres).Execute;
  except
    TOraScript(FParametres).Tag := 0;
  end;
  Terminate;
end;

end.