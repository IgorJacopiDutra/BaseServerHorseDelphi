unit uTools;

interface

uses
   System.IniFiles, System.SysUtils, System.JSON, FireDAC.Comp.Client,
   XSBuiltins, Data.DB;

procedure Log(_message: string; _lineseparator, _showdate, _resetinformation: boolean);

procedure TrimAppMemorySize;

function CreatDefaultResultWithId(id: Integer): TJSONObject;

function CreatDefaultResult(code: Integer; messages, detalhe: string): TJSONObject;

function CreatDefaultResultWithAgente(code: Integer; messages, detalhe, agente: string): TJSONObject;

function CreatDefaultResultRelatorioClienteVadu(code: Integer; messages, detalhe: string; temCadastro, temDividas: boolean; valorDivida: Double; mediaAtraso: Integer; atrasoVolume: Double; historicoNovacao, liquidadoAC, aVencerVencidoAC: Boolean; diasSemPedido: Integer; teveCompra: Boolean; diasNaoComprou: Integer; dataCadastro: integer): TJSONObject;

implementation

uses
   System.Classes, System.DateUtils, uConnection, Winapi.Windows;


{ TTools }

function CreatDefaultResultWithId(id: integer): TJSONObject;
var
   jsonResult, jsonResultInformation: TJSONObject;
begin
   jsonResultInformation := TJSONObject.Create;
   jsonResultInformation.AddPair(TJSONPair.Create('id', TJSONNumber.Create(id)));
   jsonResult := TJSONObject.Create;
   jsonResult.AddPair(TJSONPair.Create('result', jsonResultInformation));
   result := jsonResult;
end;

function CreatDefaultResult(code: Integer; messages, detalhe: string): TJSONObject;
var
   jsonResult, jsonResultInformation: TJSONObject;
begin
   jsonResultInformation := TJSONObject.Create;
   jsonResultInformation.AddPair(TJSONPair.Create('code', TJSONNumber.Create(code)));
   jsonResultInformation.AddPair(TJSONPair.Create('message', TJSONString.Create(messages)));
   jsonResultInformation.AddPair(TJSONPair.Create('detalhe', TJSONString.Create(detalhe)));
   jsonResult := TJSONObject.Create;
   jsonResult.AddPair(TJSONPair.Create('result', jsonResultInformation));
   result := jsonResult;
end;

function CreatDefaultResultWithAgente(code: Integer; messages, detalhe, agente: string): TJSONObject;
var
   jsonResult, jsonResultInformation: TJSONObject;
begin
   jsonResultInformation := TJSONObject.Create;
   jsonResultInformation.AddPair(TJSONPair.Create('code', TJSONNumber.Create(code)));
   jsonResultInformation.AddPair(TJSONPair.Create('message', TJSONString.Create(messages)));
   jsonResultInformation.AddPair(TJSONPair.Create('detalhe', TJSONString.Create(detalhe)));
   jsonResultInformation.AddPair(TJSONPair.Create('agente', TJSONString.Create(agente)));
   jsonResult := TJSONObject.Create;
   jsonResult.AddPair(TJSONPair.Create('result', jsonResultInformation));
   result := jsonResult;
end;

function CreatDefaultResultRelatorioClienteVadu(code: Integer; messages, detalhe: string; temCadastro, temDividas: boolean; valorDivida: Double; mediaAtraso: Integer; atrasoVolume: Double; historicoNovacao, liquidadoAC, aVencerVencidoAC: Boolean; diasSemPedido: Integer; teveCompra: Boolean; diasNaoComprou: Integer; dataCadastro: integer): TJSONObject;
var
   jsonResult, jsonResultInformation: TJSONObject;
begin
   jsonResultInformation := TJSONObject.Create;
   jsonResultInformation.AddPair(TJSONPair.Create('code', TJSONNumber.Create(code)));
   jsonResultInformation.AddPair(TJSONPair.Create('message', TJSONString.Create(messages)));
   jsonResultInformation.AddPair(TJSONPair.Create('detalhe', TJSONString.Create(detalhe)));
   jsonResultInformation.AddPair(TJSONPair.Create('temCadastro', TJSONBool.Create(temCadastro)));
   jsonResultInformation.AddPair(TJSONPair.Create('temDividas', TJSONBool.Create(temDividas)));
   jsonResultInformation.AddPair(TJSONPair.Create('valorDivida', TJSONNumber.Create(valorDivida)));
   jsonResultInformation.AddPair(TJSONPair.Create('mediaAtraso', TJSONNumber.Create(mediaAtraso)));
   jsonResultInformation.AddPair(TJSONPair.Create('atrasoVolume', TJSONNumber.Create(atrasoVolume)));
   jsonResultInformation.AddPair(TJSONPair.Create('historicoNovacao', TJSONBool.Create(historicoNovacao)));
   jsonResultInformation.AddPair(TJSONPair.Create('liquidadoAC', TJSONBool.Create(liquidadoAC)));
   jsonResultInformation.AddPair(TJSONPair.Create('aVencerVencidoAC', TJSONBool.Create(aVencerVencidoAC)));
   jsonResultInformation.AddPair(TJSONPair.Create('diasSemPedido', TJSONNumber.Create(diasSemPedido)));
   jsonResultInformation.AddPair(TJSONPair.Create('teveCompra', TJSONBool.Create(teveCompra)));
   jsonResultInformation.AddPair(TJSONPair.Create('diasNaoComprou', TJSONNumber.Create(diasNaoComprou)));
   jsonResultInformation.AddPair(TJSONPair.Create('dataCadastro', TJSONNumber.Create(dataCadastro)));

   jsonResult := TJSONObject.Create;
   jsonResult.AddPair(TJSONPair.Create('result', jsonResultInformation));
   result := jsonResult;
end;

procedure TrimAppMemorySize;
var
   MainHandle: THandle;
begin
   try
      MainHandle := OpenProcess(PROCESS_ALL_ACCESS, false, GetCurrentProcessID);
      SetProcessWorkingSetSize(MainHandle, $FFFFFFFF, $FFFFFFFF);
      CloseHandle(MainHandle);
   except
   end;
end;

procedure Log(_message: string; _lineseparator, _showdate, _resetinformation: boolean);
var
   logname: string;
   archive: TextFile;
begin
   logname := ExtractFilePath(ParamStr(0)) + '\json' + formatdatetime('yyyy_mm_dd_hh_nn_ss_zz', Now) + '.log';
   if _resetinformation then
      if FileExists(logname) then
         System.SysUtils.DeleteFile(logname);
   AssignFile(archive, logname);
   if FileExists(logname) then
      Append(archive)
   else
      ReWrite(archive);
   try
      if _showdate then
         WriteLn(archive, DateTimeToStr(Now) + ': ' + _message)
      else
         WriteLn(archive, DateTimeToStr(Now) + ' Erro: ' + _message);
      if _lineseparator then
         WriteLn(archive, DateTimeToStr(Now) + '----------------------------------------------------------------------');
   finally
      CloseFile(archive)
   end;
end;

end.

