program BaseServerHorseDelphi;

{$APPTYPE CONSOLE}
{$R *.res}

uses
   System.IniFiles,
   Horse,
   Horse.Jhonson,
   System.JSON,
   Horse.Commons,
   System.SysUtils,
   JOSE.Core.JWT,
   JOSE.Core.Builder,
   FireDAC.Comp.Client,
   uClientesController in 'controller\uClientesController.pas',
   uJsonFunctionModel in 'model\uJsonFunctionModel.pas',
   uClientesModel in 'model\uClientesModel.pas',
   uClientesDao in 'dao\uClientesDao.pas',
   uAuthController in 'controller\uAuthController.pas',
   uConst in 'tools\uConst.pas',
   uTools in 'tools\uTools.pas',
   uConnection in 'dao\uConnection.pas',
   uSystem.JSONUtil in 'tools\uSystem.JSONUtil.pas',
   uAuthModel in 'model\uAuthModel.pas',
   uAuth in 'tools\uAuth.pas';

var
   ini: TIniFile;
   arq_ini: string;
   port: Integer;
   qry: TFDQuery;
   conn: TConnection;

function testConnection(): boolean;
begin
   conn := TConnection.Create;
   if conn.Active then
   begin

   end;
end;

begin
   try
      arq_ini := GetCurrentDir + '\config\ConfigServer.ini';

      if not FileExists(arq_ini) then
      begin
         writeLn('Arquivo INI n�o encontrado: ' + arq_ini);
         exit;
      end;

      try
         ini := TIniFile.Create(arq_ini);
         port := StrToInt(ini.ReadString('Server', 'Port', '9000'));
      finally
         ini.Free;
      end;

      THorse.Use(Jhonson());

      testConnection();

      uClientesController.Registry;
      uAuthController.Registry;

      THorse.Listen(port,
         procedure(Horse: THorse)
         begin
            writeLn('[NOME DA EMPRESA]');
            writeLn('[DESCRICAO DA EMPRESA]');
            writeLn('Nome da Empresa � 2024. Todos os direitos reservados.');
         end);

   except
      on E: Exception do
      begin
         writeLn('Erro: ' + E.Message);
      end;
   end;

end.

