unit uAuth;

interface

uses
   System.Generics.Collections, System.JSON, REST.JSON, Datasnap.DBClient,
   uTools, System.SysUtils, uConst, uSystem.JSONUtil;

function GetUserServer: string;
function GetPasswordServer: string;

implementation

uses
   JOSE.Types.JSON;

function GetUserServer: string;
begin
   Result := 'userserver';
end;

function GetPasswordServer: string;
begin
   Result := 'passserver';
end;

end.

