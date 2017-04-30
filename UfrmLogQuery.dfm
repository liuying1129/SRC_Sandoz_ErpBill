object frmLogQuery: TfrmLogQuery
  Left = 192
  Top = 123
  Width = 928
  Height = 480
  Caption = 'frmLogQuery'
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  WindowState = wsMaximized
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 912
    Height = 35
    Align = alTop
    TabOrder = 0
    object BitBtn1: TBitBtn
      Left = 12
      Top = 5
      Width = 129
      Height = 25
      Caption = #36873#21462#26597#35810#26465#20214'(&Q)'
      TabOrder = 0
      OnClick = BitBtn1Click
    end
  end
  object DBGrid1: TDBGrid
    Left = 0
    Top = 35
    Width = 912
    Height = 406
    Align = alClient
    DataSource = DataSource1
    ReadOnly = True
    TabOrder = 1
    TitleFont.Charset = ANSI_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -13
    TitleFont.Name = #23435#20307
    TitleFont.Style = []
  end
  object lyquery1: TADOLYQuery
    DataBaseType = dbtMSSQL
    Left = 512
    Top = 64
  end
  object ADObasic: TADOQuery
    Connection = DM.ADOConnection1
    AfterOpen = ADObasicAfterOpen
    Parameters = <>
    Left = 512
    Top = 104
  end
  object DataSource1: TDataSource
    DataSet = ADObasic
    Left = 544
    Top = 104
  end
end
