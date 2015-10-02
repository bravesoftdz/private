object fmServer: TfmServer
  Left = 0
  Top = 0
  Align = alBottom
  Caption = #1057#1077#1088#1074#1077#1088
  ClientHeight = 147
  ClientWidth = 1107
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object pnButtons: TPanel
    Left = 0
    Top = 106
    Width = 1107
    Height = 41
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    object btClearLog: TButton
      Left = 8
      Top = 6
      Width = 75
      Height = 25
      Caption = #1054#1095#1080#1089#1090#1080#1090#1100
      TabOrder = 0
      OnClick = btClearLogClick
    end
  end
  object mmLogs: TMemo
    Left = 0
    Top = 0
    Width = 1107
    Height = 106
    Align = alClient
    ReadOnly = True
    ScrollBars = ssVertical
    TabOrder = 1
  end
  object HTTPServer: TIdHTTPServer
    OnStatus = HTTPServerStatus
    Bindings = <
      item
        IP = '0.0.0.0'
        Port = 80
      end
      item
        IP = '0.0.0.0'
        Port = 443
      end>
    IOHandler = ServerIOHandlerSSLOpenSS
    AutoStartSession = True
    OnQuerySSLPort = HTTPServerQuerySSLPort
    OnCommandGet = HTTPServerCommandGet
    Left = 16
    Top = 16
  end
  object ServerIOHandlerSSLOpenSS: TIdServerIOHandlerSSLOpenSSL
    SSLOptions.RootCertFile = 'cert/cert.pem'
    SSLOptions.CertFile = 'cert/cert.pem'
    SSLOptions.KeyFile = 'cert/cert.pem'
    SSLOptions.Method = sslvSSLv23
    SSLOptions.SSLVersions = [sslvSSLv2, sslvSSLv3, sslvTLSv1]
    SSLOptions.Mode = sslmServer
    SSLOptions.VerifyMode = [sslvrfFailIfNoPeerCert, sslvrfClientOnce]
    SSLOptions.VerifyDepth = 0
    Left = 128
    Top = 16
  end
end
