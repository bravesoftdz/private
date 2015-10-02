unit uMain;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  IdBaseComponent,
  IdContext,
  IdComponent,
  IdCustomTCPServer,
  IdCustomHTTPServer,
  IdHTTPServer,
  Vcl.StdCtrls,
  Vcl.ExtCtrls,
  IdServerIOHandler,
  IdSSL,
  IdSSLOpenSSL;

type
  TfmServer = class(TForm)
    HTTPServer: TIdHTTPServer;
    pnButtons: TPanel;
    mmLogs: TMemo;
    btClearLog: TButton;
    ServerIOHandlerSSLOpenSS: TIdServerIOHandlerSSLOpenSSL;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure HTTPServerCommandGet(AContext: TIdContext;
      ARequestInfo: TIdHTTPRequestInfo; AResponseInfo: TIdHTTPResponseInfo);
    procedure btClearLogClick(Sender: TObject);
    procedure HTTPServerQuerySSLPort(APort: Word; var VUseSSL: Boolean);
    procedure HTTPServerStatus(ASender: TObject; const AStatus: TIdStatus;
      const AStatusText: string);
  private
    //
  public
    function isValidRemoteIP(aIP:string):Boolean;
  end;

var
  fmServer: TfmServer;

implementation

{$R *.dfm}

uses
  uDMServer;

const
  SSLPort = 443;
  ServiceName = 'obj';
  DTF='yyyy-mm-dd hh:hh:ss';

procedure TfmServer.btClearLogClick(Sender: TObject);
begin
  mmLogs.Lines.Clear;
end;

procedure TfmServer.FormCreate(Sender: TObject);
begin
  HTTPServer.Active:=True;
end;

procedure TfmServer.FormDestroy(Sender: TObject);
begin
  HTTPServer.Active:=False;
end;

//Обработка запроса
procedure TfmServer.HTTPServerCommandGet(AContext: TIdContext;
  ARequestInfo: TIdHTTPRequestInfo; AResponseInfo: TIdHTTPResponseInfo);
var
  sInfo:string;
  today : TDateTime;
  i:Integer;
  dateStart:string;
  dateEnd:string;
  dataFormat:string;
  FmtStngs: TFormatSettings;
begin
  today := Now;
  if isValidRemoteIP(ARequestInfo.RemoteIP) then
  begin
    if ARequestInfo.URI = '/'+ServiceName then
    begin
      if ARequestInfo.Params.Count <> 0 then
      begin
        dataFormat := '';
        dateStart := '';
        dateEnd := '';
        for i := 0 to ARequestInfo.Params.Count-1 do
        begin
          if ARequestInfo.Params.Names[i]='format' then
            dataFormat := ARequestInfo.Params.Values[ARequestInfo.Params.Names[i]];
          if ARequestInfo.Params.Names[i]='timeStart' then
            dateStart := StringReplace(ARequestInfo.Params.Values[ARequestInfo.Params.Names[i]],'T',' ',[]);
          if ARequestInfo.Params.Names[i]='timeEnd' then
            dateEnd := StringReplace(ARequestInfo.Params.Values[ARequestInfo.Params.Names[i]],'T',' ',[]);
        end;
        if dataFormat = '' then  dataFormat := 'csv';

        AResponseInfo.CustomHeaders.AddValue('Access-Control-Allow-Origin','*');

        FmtStngs.DateSeparator := '-';
        FmtStngs.ShortDateFormat := 'yyyy-mm-dd';
        FmtStngs.TimeSeparator := ':';
        FmtStngs.LongTimeFormat := 'hh:nn:ss';

        AResponseInfo.ContentType := 'text/plain';
        AResponseInfo.CharSet := 'utf-8';

        //OK
        AResponseInfo.ResponseNo := 200;

        try
          if dataFormat = 'csv' then
          begin
            AResponseInfo.ContentStream:=dmServer.SaveToCSV(StrToDateTime(dateStart,FmtStngs),StrToDateTime(dateEnd,FmtStngs));
          end;
          if dataFormat = 'json' then
          begin
            AResponseInfo.ContentStream:=dmServer.SaveToJSON(StrToDateTime(dateStart,FmtStngs),StrToDateTime(dateEnd,FmtStngs));
          end;
          if dataFormat = 'xml' then
          begin
            AResponseInfo.ContentStream:=dmServer.SaveToXML(StrToDateTime(dateStart,FmtStngs),StrToDateTime(dateEnd,FmtStngs));
          end;
        except
          //Ошибка с базой данных
          AResponseInfo.ResponseNo := 500;
        end;
      end
      else
        //Мало параметров
        AResponseInfo.ResponseNo := 411;
    end
    else
      //Неверный сервис
      AResponseInfo.ResponseNo := 503;
  end
  else
  begin
    //Запрещенный IP
    AResponseInfo.ResponseNo := 403;
  end;
  sInfo := TimeToStr(today) + ' > Remote IP=' + ARequestInfo.RemoteIP + '; Command=' + ARequestInfo.Command + '; URI=' + ARequestInfo.URI + '; Params: ' + ARequestInfo.Params.CommaText;
  mmLogs.Lines.Add(sInfo);
end;

procedure TfmServer.HTTPServerQuerySSLPort(APort: Word; var VUseSSL: Boolean);
begin
  if APort=SSLPort then VUseSSL := true;
end;

procedure TfmServer.HTTPServerStatus(ASender: TObject; const AStatus: TIdStatus;
  const AStatusText: string);
var
  today : TDateTime;
begin
  today := Now;
  mmLogs.Lines.Add(TimeToStr(today) + ' > ' +AStatusText);
end;

function TfmServer.isValidRemoteIP(aIP: string): Boolean;
begin
  Result := true;
end;

end.
