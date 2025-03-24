unit mdlIcmp;

interface

uses
  Windows, SysUtils, Classes, IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient,
  IdRawBase, IdRawClient, IdIcmpClient;

  function Ping(const AHost: string; const ATimes: integer; out AvgMS: Double): Boolean;

implementation

function Ping(const AHost: string; const ATimes: integer; out AvgMS: Double): Boolean;
var
  R: array of Cardinal;
  i: integer;
begin
  Result := True;
  AvgMS := 0;
  if ATimes>0 then
    with TIdIcmpClient.Create(Nil) do
    try
      Host := AHost;
      ReceiveTimeout := 999;
      SetLength(R, ATimes);
      for i := 0 to Pred(ATimes) do
      begin
        try
          Ping();
          R[i] := ReplyStatus.MsRoundTripTime;
        except
          Result := False;
          Exit;
        end;
        if ReplyStatus.ReplyStatusType <> rsEcho then result := False;
      end;
      for i := Low(R) to High(R) do
      begin
        AvgMS := AvgMS + R[i];
      end;
      AvgMS := AvgMS / High(R);
    finally
      Free;
    end;
end;

end.
