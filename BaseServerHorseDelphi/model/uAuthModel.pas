unit uAuthModel;

interface

uses
   System.Generics.Collections, System.JSON, REST.JSON, Datasnap.DBClient,
   uTools, System.SysUtils, uConst, uSystem.JSONUtil;

type
   TAuthModel = class
   private
      FPassWord: string;
      FUser: string;
      procedure setUser(const Value: string);
   public
      property User: string read FUser write setUser;
      property PassWord: string read FPassWord write FPassWord;
   end;

implementation

uses
   JOSE.Types.JSON;
{ TAuthModel }

{ TAuthModel }

procedure TAuthModel.setUser(const Value: string);
begin
   FUser := Value;
end;

end.

