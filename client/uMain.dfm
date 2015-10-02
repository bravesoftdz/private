object fmMain: TfmMain
  Left = 0
  Top = 0
  Caption = #1050#1083#1080#1077#1085#1090
  ClientHeight = 362
  ClientWidth = 916
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object pcMain: TPageControl
    Left = 0
    Top = 0
    Width = 916
    Height = 362
    ActivePage = tabMain
    Align = alClient
    TabOrder = 0
    object tabMain: TTabSheet
      Caption = #1044#1072#1085#1085#1099#1077
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object pnControl: TPanel
        Left = 0
        Top = 0
        Width = 908
        Height = 41
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 0
        DesignSize = (
          908
          41)
        object lbtimeStart: TLabel
          Left = 8
          Top = 12
          Width = 7
          Height = 13
          Caption = #1057
          FocusControl = dateStart
        end
        object lbtimeEnd: TLabel
          Left = 256
          Top = 12
          Width = 13
          Height = 13
          Caption = #1055#1086
          FocusControl = dateEnd
        end
        object lbFormat: TLabel
          Left = 510
          Top = 12
          Width = 38
          Height = 13
          Caption = #1060#1086#1088#1084#1072#1090
          FocusControl = cbFormat
        end
        object dateStart: TDateTimePicker
          Left = 21
          Top = 9
          Width = 150
          Height = 21
          Date = 42264.000000000000000000
          Time = 42264.000000000000000000
          TabOrder = 0
        end
        object dateEnd: TDateTimePicker
          Left = 275
          Top = 9
          Width = 150
          Height = 21
          Date = 42264.000000000000000000
          Time = 42264.000000000000000000
          TabOrder = 2
        end
        object cbFormat: TComboBox
          Left = 554
          Top = 9
          Width = 52
          Height = 21
          Style = csDropDownList
          ItemIndex = 0
          TabOrder = 4
          Text = 'CSV'
          Items.Strings = (
            'CSV'
            'JSON'
            'XML')
        end
        object btGetContent: TButton
          Left = 824
          Top = 9
          Width = 75
          Height = 21
          Anchors = [akTop, akRight]
          Caption = #1055#1086#1083#1091#1095#1080#1090#1100
          TabOrder = 5
          OnClick = btGetContentClick
        end
        object timeStart: TDateTimePicker
          Left = 177
          Top = 9
          Width = 73
          Height = 21
          Date = 42265.144121631940000000
          Time = 42265.144121631940000000
          DateMode = dmUpDown
          DragKind = dkDock
          Kind = dtkTime
          TabOrder = 1
        end
        object timeEnd: TDateTimePicker
          Left = 431
          Top = 9
          Width = 73
          Height = 21
          Date = 42265.144181099540000000
          Time = 42265.144181099540000000
          Kind = dtkTime
          TabOrder = 3
        end
      end
      object grdMain: TDBGrid
        Left = 0
        Top = 41
        Width = 908
        Height = 293
        Align = alClient
        DataSource = dsMain
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
        ReadOnly = True
        TabOrder = 1
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
        Columns = <
          item
            Expanded = False
            FieldName = 'edatetime'
            Title.Alignment = taCenter
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'pnumber'
            Title.Alignment = taCenter
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'address'
            Title.Alignment = taCenter
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'region'
            Title.Alignment = taCenter
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'etype'
            Title.Alignment = taCenter
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'isgroup'
            Title.Alignment = taCenter
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'description'
            Title.Alignment = taCenter
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'number'
            Title.Alignment = taCenter
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'dispatcher_msg'
            Title.Alignment = taCenter
            Visible = True
          end>
      end
    end
    object tabSettings: TTabSheet
      Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1072
      ImageIndex = 2
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object lbHost: TLabel
        Left = 34
        Top = 50
        Width = 23
        Height = 13
        Caption = #1061#1086#1089#1090
        FocusControl = edHost
      end
      object lbService: TLabel
        Left = 21
        Top = 77
        Width = 36
        Height = 13
        Caption = #1057#1077#1088#1074#1080#1089
        FocusControl = edService
      end
      object lbProtocol: TLabel
        Left = 8
        Top = 23
        Width = 49
        Height = 13
        Caption = #1055#1088#1086#1090#1086#1082#1086#1083
        FocusControl = cbProtocol
      end
      object edHost: TEdit
        Left = 63
        Top = 47
        Width = 241
        Height = 21
        TabOrder = 0
        Text = '127.0.0.1'
      end
      object edService: TEdit
        Left = 63
        Top = 74
        Width = 241
        Height = 21
        TabOrder = 1
        Text = 'obj'
      end
      object cbProtocol: TComboBox
        Left = 63
        Top = 20
        Width = 241
        Height = 21
        Style = csDropDownList
        ItemIndex = 1
        TabOrder = 2
        Text = 'https'
        Items.Strings = (
          'http'
          'https')
      end
    end
    object tabDebug: TTabSheet
      Caption = #1054#1090#1083#1072#1076#1082#1072
      ImageIndex = 1
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object spLog: TSplitter
        Left = 0
        Top = 242
        Width = 908
        Height = 3
        Cursor = crVSplit
        Align = alBottom
        ExplicitLeft = -8
        ExplicitTop = 257
        ExplicitWidth = 635
      end
      object pnTop: TPanel
        Left = 0
        Top = 0
        Width = 908
        Height = 41
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 0
        DesignSize = (
          908
          41)
        object lbAddress: TLabel
          Left = 8
          Top = 12
          Width = 31
          Height = 13
          Caption = #1040#1076#1088#1077#1089
          FocusControl = edAddress
        end
        object edAddress: TEdit
          Left = 45
          Top = 9
          Width = 773
          Height = 21
          Anchors = [akLeft, akTop, akRight]
          TabOrder = 0
          Text = 'https://127.0.0.1/obj'
        end
        object btGetContentDebug: TButton
          Left = 824
          Top = 9
          Width = 75
          Height = 21
          Anchors = [akTop, akRight]
          Caption = #1055#1086#1083#1091#1095#1080#1090#1100
          TabOrder = 1
          OnClick = btGetContentDebugClick
        end
      end
      object mmContent: TMemo
        Left = 0
        Top = 41
        Width = 908
        Height = 201
        Align = alClient
        Lines.Strings = (
          '')
        ReadOnly = True
        ScrollBars = ssVertical
        TabOrder = 1
      end
      object mmLog: TMemo
        Left = 0
        Top = 245
        Width = 908
        Height = 89
        Align = alBottom
        ReadOnly = True
        ScrollBars = ssVertical
        TabOrder = 2
      end
    end
  end
  object HTTPClient: TIdHTTP
    OnStatus = HTTPClientStatus
    IOHandler = SSLIOHandlerSocketOpenSSL
    AllowCookies = True
    ProtocolVersion = pv1_0
    ProxyParams.BasicAuthentication = False
    ProxyParams.ProxyPort = 0
    Request.CharSet = 'utf-8'
    Request.ContentEncoding = 'utf-8'
    Request.ContentLength = -1
    Request.ContentRangeEnd = -1
    Request.ContentRangeStart = -1
    Request.ContentRangeInstanceLength = -1
    Request.Accept = 'text/html, */*'
    Request.BasicAuthentication = False
    Request.UserAgent = 'Mozilla/3.0 (compatible; Indy Library)'
    Request.Ranges.Units = 'bytes'
    Request.Ranges = <>
    HTTPOptions = [hoForceEncodeParams]
    Left = 72
    Top = 176
  end
  object SSLIOHandlerSocketOpenSSL: TIdSSLIOHandlerSocketOpenSSL
    MaxLineAction = maException
    Port = 0
    DefaultPort = 0
    SSLOptions.RootCertFile = 'cert/cert.pem'
    SSLOptions.CertFile = 'cert/cert.pem'
    SSLOptions.KeyFile = 'cert/cert.pem'
    SSLOptions.Method = sslvSSLv23
    SSLOptions.SSLVersions = [sslvSSLv2, sslvSSLv3, sslvTLSv1]
    SSLOptions.Mode = sslmClient
    SSLOptions.VerifyMode = [sslvrfFailIfNoPeerCert, sslvrfClientOnce]
    SSLOptions.VerifyDepth = 0
    Left = 72
    Top = 240
  end
  object dsMain: TDataSource
    DataSet = MemoryData
    Left = 232
    Top = 248
  end
  object MemoryData: TJvMemoryData
    FieldDefs = <
      item
        Name = 'edatetime'
        DataType = ftDateTime
      end
      item
        Name = 'pnumber'
        DataType = ftString
        Size = 10
      end
      item
        Name = 'address'
        DataType = ftString
        Size = 80
      end
      item
        Name = 'region'
        DataType = ftString
        Size = 80
      end
      item
        Name = 'etype'
        DataType = ftString
        Size = 40
      end
      item
        Name = 'isgroup'
        DataType = ftInteger
      end
      item
        Name = 'description'
        DataType = ftString
        Size = 100
      end
      item
        Name = 'number'
        DataType = ftString
        Size = 10
      end
      item
        Name = 'msg_dispatch'
        DataType = ftString
        Size = 40
      end>
    Left = 232
    Top = 184
    object MemoryDataEdatetime: TDateTimeField
      DisplayLabel = #1044#1072#1090#1072'/'#1074#1088#1077#1084#1103' '#1089#1086#1073#1099#1090#1080#1103
      DisplayWidth = 22
      FieldName = 'edatetime'
    end
    object MemoryDataPnumber: TStringField
      DisplayLabel = #1085#1086#1084#1077#1088' '#1055#1062#1053
      DisplayWidth = 12
      FieldName = 'pnumber'
      Size = 10
    end
    object MemoryDataAddress: TStringField
      DisplayLabel = #1072#1076#1088#1077#1089
      DisplayWidth = 40
      FieldName = 'address'
      Size = 80
    end
    object MemoryDataRegion: TStringField
      DisplayLabel = #1088#1077#1075#1080#1086#1085
      DisplayWidth = 40
      FieldName = 'region'
      Size = 80
    end
    object MemoryDataEtype: TStringField
      DisplayLabel = #1090#1080#1087' '#1089#1086#1073#1099#1090#1080#1103
      DisplayWidth = 32
      FieldName = 'etype'
      Size = 40
    end
    object MemoryDataIsgroup: TIntegerField
      DisplayLabel = #1075#1088#1091#1087#1087#1072
      DisplayWidth = 8
      FieldName = 'isgroup'
    end
    object MemoryDataDescription: TStringField
      DisplayLabel = #1086#1087#1080#1089#1072#1085#1080#1077
      DisplayWidth = 69
      FieldName = 'description'
      Size = 100
    end
    object MemoryDataNumber: TStringField
      DisplayLabel = #1085#1086#1084#1077#1088
      DisplayWidth = 9
      FieldName = 'number'
      Size = 10
    end
    object MemoryDataDispatcherMsg: TStringField
      DisplayLabel = #1089#1086#1086#1073#1097#1077#1085#1080#1077' '#1076#1080#1089#1087#1077#1090#1095#1077#1088#1072
      DisplayWidth = 48
      FieldName = 'dispatcher_msg'
      Size = 40
    end
  end
end
