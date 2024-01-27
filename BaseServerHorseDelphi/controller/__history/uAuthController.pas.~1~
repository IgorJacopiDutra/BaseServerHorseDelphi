unit uAuthController;

interface

uses
   Winapi.Windows, Horse, System.JSON, System.SysUtils, uAuthModel,
   FireDAC.Comp.Client, Data.DB, DataSet.Serialize, JOSE.Core.JWT,
   JOSE.Core.Builder, REST.JSON, JOSE.Core.JWK, uAuth;

procedure Registry;

implementation

uses
   System.Generics.Collections, System.Classes, uConnection, uTools;

const
   author = 'IGORJACOPIDUTRA';

procedure Post(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
   LToken: TJWT;
   LCompactToken: string;
   JSON: TJSONObject;
   LParam: TStrings;
   i: Integer;
   username, password: string;

   function getValue(param: string): string;
   begin
      result := Copy(param, pos('=', param) + 1, length(param));
   end;

   function ExtractUsernameAndPasswordFromJSON(const AJSON: TJSONValue; var AUsername, APassword: string): Boolean;
   begin
      Result := False;

      if AJSON <> nil then
      begin
         if AJSON.TryGetValue<string>('username', AUsername) and AJSON.TryGetValue<string>('password', APassword) then
            Result := True;
      end;
   end;

begin
   Writeln(DateTimeToStr(Now) + '****************** INICIANDO (START) REQUISIÇÃO (LOGIN) ******************');
   try
      LToken := TJWT.Create;

      ExtractUsernameAndPasswordFromJSON(Req.Body<TJSONValue>, username, password);

      JSON := TJSONObject.Create;

      try
         if ((GetUserServer()) = (username)) and ((GetPasswordServer()) = (password)) then
         begin
            Writeln(DateTimeToStr(Now) + '[WAIT] Configurando TOKEN');

            LToken.Claims.Issuer := 'Igor Jacopi Dutra';
            LToken.Claims.Subject := 'Igor';
            LToken.Claims.Expiration := Now + 1;
            LCompactToken := TJOSE.SHA256CompactToken(author, LToken);
            LToken.Claims.SetClaimOfType<string>('username', '');
            LToken.Claims.SetClaimOfType<string>('password', '');

            JSON.AddPair('access_token', TJSONString.Create('Bearer ' + LCompactToken));
            JSON.AddPair('expires_in', TJSONNumber.Create(1));

            Writeln(DateTimeToStr(Now) + '[SUCESS] Token gerado: Bearer ' + LCompactToken);

            Res.Send(JSON).Status(200);
         end
         else
         begin
            Writeln(DateTimeToStr(Now) + '[UNAUTHORIZED] Usuário ou Senha Incorretas');

            JSON.AddPair('status', TJSONString.Create('Usuário ou Senha estão incorretos.'));
            Res.Send(JSON).Status(401);
         end;
      finally
         LToken.Free;
      end;
   except
      on E: Exception do
      begin
         Writeln(DateTimeToStr(Now) + '[UNAUTHORIZED] Problema na requisição: ' + E.Message);
         JSON.AddPair('status', TJSONString.Create(E.Message));

         Res.Send(JSON).Status(401);
      end;
   end;
   Writeln(DateTimeToStr(Now) + '****************** FINALIZAÇÃO (END) REQUISIÇÃO (LOGIN) ******************');
end;

procedure Registry;
begin
   THorse.Post('/api/v1/user/auth/', Post);
end;

end.

