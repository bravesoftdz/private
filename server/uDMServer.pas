unit uDMServer;

interface

uses
  System.SysUtils,
  System.Classes,
  Data.DB,
  ZAbstractRODataset,
  ZAbstractDataset,
  ZDataset,
  ZAbstractConnection,
  ZConnection,
  Vcl.Dialogs,
  Vcl.Forms,
  Winapi.Windows,
  Winapi.ActiveX,
  Xml.XmlDoc,
  Xml.XMLIntf,
  ZSqlMonitor;

type
  TdmServer = class(TDataModule)
    mConnection: TZConnection;
    qrEvents: TZQuery;
    SQLMonitor: TZSQLMonitor;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    //
  public
    function SaveToCSV(startDateTime, endDateTime:TDateTime):TStringStream;
    function SaveToJSON(startDateTime, endDateTime:TDateTime):TStringStream;
    function SaveToXML(startDateTime, endDateTime:TDateTime):TStringStream;
  end;

var
  dmServer: TdmServer;

implementation

{%CLASSGROUP 'System.Classes.TPersistent'}

{$R *.dfm}

uses
  uLoginDlg;

const
  NS = #13#10;

procedure TdmServer.DataModuleCreate(Sender: TObject);
var
  suser:string;
  spassword:string;
begin
  mConnection.Database:=ExtractFilePath(Application.ExeName)+ 'database\PRIVATE.FDB';
  suser:='SYSDBA';
  spassword:='masterkey';
  if Login(Application, suser, spassword) then
  begin
    mConnection.User:=suser;
    mConnection.Password:=spassword;
  end
  else Application.Terminate;
  try
    mConnection.Connect;
    SQLMonitor.Active := True;
    SQLMonitor.AutoSave := True;
    SQLMonitor.FileName:=ExtractFilePath(Application.ExeName)+'sql.log';
  except
    ShowMessage('Ошибка соединения с Базой данных');
    Application.Terminate;
  end;
end;

procedure TdmServer.DataModuleDestroy(Sender: TObject);
begin
  SQLMonitor.Active := False;
  mConnection.Disconnect;
end;

function TdmServer.SaveToCSV(startDateTime, endDateTime:TDateTime):TStringStream;
var
  line:string;
  i:Integer;
begin
  Result := TStringStream.Create('',TEncoding.UTF8);
  try
    with qrEvents do
    begin
      ParamByName('startDate').AsDateTime := startDateTime;
      ParamByName('endDate').AsDateTime := endDateTime;
      Open;
      while not Eof do
      begin
        for i := 0 to Fields.Count-1 do
        begin
          if i=0 then
            line := '"' + Fields[i].AsString + '"'
          else
            line := line + ',"' + Fields[i].AsString + '"';
        end;
        Next;
        if not Eof then Result.WriteString(line + NS)
        else Result.WriteString(line);
      end;
      Close;
    end;
  except
    ShowMessage('Ошибка получения данных');
  end;
end;

function TdmServer.SaveToJSON(startDateTime, endDateTime:TDateTime):TStringStream;
var
  line:string;
  i:Integer;
begin
  Result := TStringStream.Create('',TEncoding.UTF8);
  try
    with qrEvents do
    begin
      ParamByName('startDate').AsDateTime := startDateTime;
      ParamByName('endDate').AsDateTime := endDateTime;
      Open;
      Result.WriteString('[' + NS);
      while not Eof do
      begin
        line := '  {' + NS;
        for i := 0 to Fields.Count-1 do
        begin
          if i=(Fields.Count-1) then
            line := line + '    "' + LowerCase(Fields[i].FieldName) + '":"' +  Fields[i].AsString + '"' + NS
          else
            line := line + '    "' + LowerCase(Fields[i].FieldName) + '":"' +  Fields[i].AsString + '",' + NS;
        end;
        Next;
        if not Eof then Result.WriteString(line + '  },' + NS)
        else Result.WriteString(line + '  }' + NS)
      end;
      Result.WriteString(']');
      Close;
    end;
  except
    ShowMessage('Ошибка получения данных');
  end;
end;

function TdmServer.SaveToXML(startDateTime, endDateTime:TDateTime):TStringStream;
var
  XMLNode,XMLNodeChild: IXMLNode;
  XMLDoc: IXMLDocument;
  i:Integer;
begin
  CoInitialize(nil);
  XMLDoc := NewXMLDocument;
  XMLDoc.Active := True;
  XMLDoc.Encoding := 'utf-8';
  XMLDoc.Options := [doNodeAutoIndent];
  XMLDoc.StandAlone :='no';
  XMLDoc.AddChild('data');
  Result := TStringStream.Create('',TEncoding.UTF8);
  try
    with qrEvents do
    begin
      ParamByName('startDate').AsDateTime := startDateTime;
      ParamByName('endDate').AsDateTime := endDateTime;
      Open;
      while not Eof do
      begin
        XMLNode := XMLDoc.DocumentElement.AddChild('row');
        for i := 0 to Fields.Count-1 do
        begin
          XMLNodeChild := XMLNode.AddChild('column');
          XMLNodeChild.Attributes['name'] := LowerCase(Fields[i].FieldName);
          XMLNodeChild.Text := Fields[i].AsString;
        end;
        Next;
      end;
      Result.WriteString(XMLDoc.XML.Text);
      Close;
    end;
  except
    ShowMessage('Ошибка получения данных');
  end;
end;

end.
