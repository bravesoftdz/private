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
  Vcl.StdCtrls,
  Vcl.ExtCtrls,
  IdBaseComponent,
  IdComponent,
  IdTCPConnection,
  IdTCPClient,
  IdStack,
  IdURI,
  IdHTTP,
  IdIOHandler,
  IdIOHandlerSocket,
  IdIOHandlerStack,
  IdSSL,
  IdSSLOpenSSL,
  Vcl.ComCtrls,
  Vcl.Grids,
  Vcl.DBGrids,
  Data.DB,
  JvMemoryDataset,
  Winapi.ActiveX,
  Xml.XmlDoc,
  Xml.XMLIntf;

type
  TfmMain = class(TForm)
    pnTop: TPanel;
    mmContent: TMemo;
    edAddress: TEdit;
    btGetContentDebug: TButton;
    HTTPClient: TIdHTTP;
    SSLIOHandlerSocketOpenSSL: TIdSSLIOHandlerSocketOpenSSL;
    pcMain: TPageControl;
    tabMain: TTabSheet;
    tabDebug: TTabSheet;
    mmLog: TMemo;
    spLog: TSplitter;
    pnControl: TPanel;
    grdMain: TDBGrid;
    dateStart: TDateTimePicker;
    timeStart: TDateTimePicker;
    dateEnd: TDateTimePicker;
    timeEnd: TDateTimePicker;
    lbtimeStart: TLabel;
    lbtimeEnd: TLabel;
    lbFormat: TLabel;
    cbFormat: TComboBox;
    btGetContent: TButton;
    lbAddress: TLabel;
    dsMain: TDataSource;
    MemoryData: TJvMemoryData;
    tabSettings: TTabSheet;
    lbHost: TLabel;
    lbService: TLabel;
    edHost: TEdit;
    edService: TEdit;
    MemoryDataEdatetime: TDateTimeField;
    MemoryDataPnumber: TStringField;
    MemoryDataAddress: TStringField;
    MemoryDataRegion: TStringField;
    MemoryDataEtype: TStringField;
    MemoryDataIsgroup: TIntegerField;
    MemoryDataDescription: TStringField;
    MemoryDataNumber: TStringField;
    MemoryDataDispatcherMsg: TStringField;
    lbProtocol: TLabel;
    cbProtocol: TComboBox;
    procedure btGetContentDebugClick(Sender: TObject);
    procedure HTTPClientStatus(ASender: TObject; const AStatus: TIdStatus;
      const AStatusText: string);
    procedure btGetContentClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    //
  public
    function getContent(httpQuery: string; ResponseContent:TStringStream; Debug: boolean):Integer;
    function gethttpQuery:string;
    procedure SetCSVContentToTable(ResponseContent:TStringStream);
    procedure SetJSONContentToTable(ResponseContent:TStringStream);
    procedure SetXMLContentToTable(ResponseContent:TStringStream);
  end;

var
  fmMain: TfmMain;

implementation

{$R *.dfm}

uses
  superobject;

const
  DF='yyyy-mm-dd';
  TF='hh:nn:ss';

function GetTimeZone: string;
var
  TimeZone: TTimeZoneInformation;
  bias:Integer;
begin
  GetTimeZoneInformation(TimeZone);
  bias := TimeZone.Bias div -60;
  if bias>0 then
   Result := '%2B'+Format('%.2d:00', [bias])
  else
    Result := Format('%.2d:00', [bias]);
end;

function GetEMsg(Code:Integer):string;
begin
  case Code of
  -1:Result := 'Сервер не найден';
  403:Result := 'Доступ для Вашего IP запрещен';
  411:Result := 'Мало параметров для получения данных';
  500:Result := 'Ошибка сервера';
  503:Result := 'Данный сервис не доступен';
  else
    Result := 'Неизвестная ошибка';
  end;
end;

procedure TfmMain.btGetContentDebugClick(Sender: TObject);
var
  ResponseContent: TStringStream;
begin
  ResponseContent := TStringStream.Create('',TEncoding.UTF8);
  try
    getContent(edAddress.Text,ResponseContent,true)
  finally
    ResponseContent.Free;
  end;
end;

procedure TfmMain.FormCreate(Sender: TObject);
begin
  dateStart.DateTime := Now;
  timeStart.DateTime := Now;
  dateEnd.DateTime := Now;
  timeEnd.DateTime := Now;
end;

procedure TfmMain.btGetContentClick(Sender: TObject);
var
  Code:Integer;
  ResponseContent: TStringStream;
begin
  ResponseContent := TStringStream.Create('',TEncoding.UTF8);
  try
    Code := getContent(gethttpQuery,ResponseContent,true);
    if Code = 200 then
    begin
      case cbFormat.ItemIndex of
      0:SetCSVContentToTable(ResponseContent);
      1:SetJSONContentToTable(ResponseContent);
      2:SetXMLContentToTable(ResponseContent);
      end;
      if not MemoryData.IsEmpty then
        MemoryData.First;
    end;
  finally
    ResponseContent.Free;
  end;
end;

function TfmMain.getContent(httpQuery: string; ResponseContent:TStringStream; Debug: boolean): Integer;
var
  Code:Integer;
  today : TDateTime;
begin
  today := Now;
  Code := 200;
  try
    mmlog.Lines.Add(TimeToStr(today) + ' > ' + 'ResponseCode='+IntToStr(Code));
    HTTPClient.Get(httpQuery,ResponseContent);
    Code := HTTPClient.ResponseCode;
    if Debug then
    begin
      mmlog.Lines.Add(TimeToStr(today) + ' > ' + 'url=' + httpQuery);
      if Code=200 then
      begin
        ResponseContent.Position:=0;
        mmContent.Clear;
        mmContent.Lines.LoadFromStream(ResponseContent,TEncoding.UTF8);
      end;
    end;
    Result := Code;
  except
    on E: EIdSocketError do
    begin
       ShowMessage('Ошибка : '+ GetEMsg(HTTPClient.ResponseCode));
       if Debug then mmlog.Lines.Add(TimeToStr(today) + ' > ' + 'ResponseCode='+IntToStr(HTTPClient.ResponseCode));
       Result := HTTPClient.ResponseCode;
    end ;
    on E: EIdHTTPProtocolException do
    begin
        ShowMessage('Ошибка : '+ GetEMsg(HTTPClient.ResponseCode));
        if Debug then mmlog.Lines.Add(TimeToStr(today) + ' > ' + 'ResponseCode='+IntToStr(HTTPClient.ResponseCode));
        Result := HTTPClient.ResponseCode;
    end;
  end;
end;

function TfmMain.gethttpQuery: string;
var
  format, dtStart, dtEnd:string;
begin
  Result := cbProtocol.Items[cbProtocol.ItemIndex] + '://' + edHost.Text + '/' + edService.Text;
  dtStart := 'timeStart=' +  FormatDateTime(DF, dateStart.DateTime) + 'T' + FormatDateTime(TF, timeStart.DateTime);
  dtEnd := 'timeEnd=' + FormatDateTime(DF, dateEnd.DateTime) + 'T' + FormatDateTime(TF, timeEnd.Time);
  Result := Result + '?' + dtStart + '&' + dtEnd;
  if cbFormat.ItemIndex <>0 then
  begin
    format := 'format=' + LowerCase(cbFormat.Items[cbFormat.ItemIndex]);
    Result := Result + '&' + format;
  end;
end;

procedure TfmMain.HTTPClientStatus(ASender: TObject; const AStatus: TIdStatus;
  const AStatusText: string);
var
  today : TDateTime;
begin
  today := Now;
  mmlog.Lines.Add(TimeToStr(today) + ' > ' + AStatusText);
end;

procedure TfmMain.SetCSVContentToTable(ResponseContent:TStringStream);
var
  RowList:TStringList;
  ColList:TStringList;
  line:string;
  i,j:Integer;
begin
  RowList := TStringList.Create;
  try
    ResponseContent.Position:=0;
    RowList.LoadFromStream(ResponseContent,TEncoding.UTF8);
    with MemoryData do
    begin
      Close;
      Open;
      for i := 0 to RowList.Count-1 do
      begin
        line := RowList.Strings[i];
        ColList:=TStringList.Create;
        ColList.Delimiter := ',';
        ColList.DelimitedText:=line;
        try
          Append;
          for j:=0 to Fields.Count-1 do
             Fields[j].AsString := StringReplace(ColList.Strings[j],'"','',[]);
          Post;
        finally
          ColList.Free;
        end;
      end;
    end;
  finally
    RowList.Free;
  end;
end;

procedure TfmMain.SetJSONContentToTable(ResponseContent: TStringStream);
var
  JsObject: ISuperObject;
  JsonArray: TSuperArray;
  i,j : Integer;
begin
  with MemoryData do
  begin
    ResponseContent.Position := 0;
    JsObject := SO(ResponseContent.DataString);
    JsonArray := JsObject.AsArray;
    Close;
    Open;
    for i := 0 to JsonArray.Length-1 do
    begin
      Append;
      for j:=0 to Fields.Count-1 do
        Fields[j].AsString := JsonArray.O[i].S[Fields[j].FullName];
      Post;
    end;
  end;
end;

procedure TfmMain.SetXMLContentToTable(ResponseContent: TStringStream);
var
  XMLNode,XMLNodeChild: IXMLNode;
  XMLDoc: IXMLDocument;
  i, j : Integer;
begin
  CoInitialize(nil);
  XMLDoc := NewXMLDocument;
  ResponseContent.Position := 0;
  XMLDoc.LoadFromStream(ResponseContent,xetUTF_8);
  XMLDoc.Active := True;
  with MemoryData do
  begin
    Close;
    Open;
    if Assigned(XMLDoc.DocumentElement) and XMLDoc.DocumentElement.HasChildNodes then
    begin
      for i := 0 to XMLDoc.DocumentElement.ChildNodes.Count-1 do
      begin
        Append;
        XMLNodeChild := XMLDoc.DocumentElement.ChildNodes[i];
        if Assigned(XMLNodeChild) and XMLNodeChild.HasChildNodes then
          for j := 0 to XMLNodeChild.ChildNodes.Count-1 do
            FieldByName(XMLNodeChild.ChildNodes[j].Attributes['name']).AsString := XMLNodeChild.ChildNodes[j].Text;
        Post;
      end;
    end;
  end;
end;

end.
