object fmLoginDlg: TfmLoginDlg
  Left = 245
  Top = 108
  BorderStyle = bsDialog
  Caption = #1041#1072#1079#1072' '#1076#1072#1085#1085#1099#1093' - '#1051#1086#1075#1080#1085
  ClientHeight = 94
  ClientWidth = 309
  Color = clBtnFace
  ParentFont = True
  OldCreateOrder = True
  Position = poOwnerFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object lbPassword: TLabel
    Left = 43
    Top = 38
    Width = 37
    Height = 13
    Caption = #1055#1072#1088#1086#1083#1100
    FocusControl = edPassword
  end
  object lbUser: TLabel
    Left = 8
    Top = 11
    Width = 72
    Height = 13
    Caption = #1055#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1100
    FocusControl = edUser
  end
  object edPassword: TEdit
    Left = 86
    Top = 35
    Width = 211
    Height = 21
    PasswordChar = '*'
    TabOrder = 1
  end
  object OKBtn: TButton
    Left = 141
    Top = 62
    Width = 75
    Height = 25
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 2
  end
  object CancelBtn: TButton
    Left = 222
    Top = 62
    Width = 75
    Height = 25
    Cancel = True
    Caption = #1054#1090#1084#1077#1085#1072
    ModalResult = 2
    TabOrder = 3
  end
  object edUser: TEdit
    Left = 86
    Top = 8
    Width = 211
    Height = 21
    TabOrder = 0
  end
end
