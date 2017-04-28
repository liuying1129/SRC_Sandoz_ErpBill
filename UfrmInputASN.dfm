object frmInputASN: TfrmInputASN
  Left = 192
  Top = 122
  Width = 800
  Height = 600
  Caption = #20837#24211#21333#24405#20837
  Color = clBtnFace
  Font.Charset = GB2312_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = #23435#20307
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  WindowState = wsMaximized
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 37
    Width = 265
    Height = 525
    Align = alLeft
    TabOrder = 0
    object Label1: TLabel
      Left = 92
      Top = 13
      Width = 26
      Height = 13
      Caption = #36135#20027
    end
    object Label2: TLabel
      Left = 92
      Top = 86
      Width = 26
      Height = 13
      Caption = #36827#21475
    end
    object Label6: TLabel
      Left = 92
      Top = 110
      Width = 26
      Height = 13
      Caption = #20445#31246
    end
    object Label3: TLabel
      Left = 65
      Top = 62
      Width = 52
      Height = 13
      Caption = #19994#21153#31867#22411
    end
    object ComboBox1: TComboBox
      Left = 120
      Top = 9
      Width = 121
      Height = 21
      ItemHeight = 13
      TabOrder = 0
    end
    object LabeledEdit1: TLabeledEdit
      Left = 120
      Top = 34
      Width = 121
      Height = 21
      EditLabel.Width = 66
      EditLabel.Height = 13
      EditLabel.Caption = #35746#21333#24635#21333'ID'
      LabelPosition = lpLeft
      TabOrder = 1
    end
    object LabeledEdit4: TLabeledEdit
      Left = 120
      Top = 131
      Width = 121
      Height = 21
      EditLabel.Width = 65
      EditLabel.Height = 13
      EditLabel.Caption = #20379#24212#21830#20195#30721
      LabelPosition = lpLeft
      TabOrder = 5
      OnKeyDown = LabeledEdit4KeyDown
    end
    object LabeledEdit5: TLabeledEdit
      Left = 120
      Top = 179
      Width = 121
      Height = 21
      EditLabel.Width = 52
      EditLabel.Height = 13
      EditLabel.Caption = #24635#21333#22791#27880
      LabelPosition = lpLeft
      TabOrder = 6
    end
    object LabeledEdit6: TLabeledEdit
      Left = 120
      Top = 203
      Width = 121
      Height = 21
      EditLabel.Width = 66
      EditLabel.Height = 13
      EditLabel.Caption = #35746#21333#32454#21333'ID'
      LabelPosition = lpLeft
      TabOrder = 7
    end
    object LabeledEdit7: TLabeledEdit
      Left = 120
      Top = 227
      Width = 121
      Height = 21
      EditLabel.Width = 40
      EditLabel.Height = 13
      EditLabel.Caption = #36135#21697'ID'
      LabelPosition = lpLeft
      TabOrder = 8
      OnKeyDown = LabeledEdit7KeyDown
    end
    object LabeledEdit8: TLabeledEdit
      Left = 120
      Top = 275
      Width = 121
      Height = 21
      EditLabel.Width = 26
      EditLabel.Height = 13
      EditLabel.Caption = #25209#21495
      LabelPosition = lpLeft
      TabOrder = 9
    end
    object LabeledEdit9: TLabeledEdit
      Left = 120
      Top = 299
      Width = 121
      Height = 21
      EditLabel.Width = 52
      EditLabel.Height = 13
      EditLabel.Caption = #25209#20934#25991#21495
      LabelPosition = lpLeft
      TabOrder = 10
    end
    object LabeledEdit11: TLabeledEdit
      Left = 120
      Top = 324
      Width = 121
      Height = 21
      EditLabel.Width = 26
      EditLabel.Height = 13
      EditLabel.Caption = #25968#37327
      LabelPosition = lpLeft
      TabOrder = 11
    end
    object LabeledEdit12: TLabeledEdit
      Left = 120
      Top = 349
      Width = 121
      Height = 21
      EditLabel.Width = 52
      EditLabel.Height = 13
      EditLabel.Caption = #32454#21333#22791#27880
      LabelPosition = lpLeft
      TabOrder = 12
    end
    object BitBtn2: TBitBtn
      Left = 120
      Top = 376
      Width = 121
      Height = 25
      Caption = #20445#23384'ASN(F3)'
      TabOrder = 13
      OnClick = BitBtn2Click
    end
    object LabeledEdit2: TComboBox
      Left = 120
      Top = 82
      Width = 121
      Height = 21
      ItemHeight = 13
      TabOrder = 3
      Items.Strings = (
        #21542
        #26159)
    end
    object LabeledEdit3: TComboBox
      Left = 120
      Top = 106
      Width = 121
      Height = 21
      ItemHeight = 13
      TabOrder = 4
      Items.Strings = (
        #21542
        #26159)
    end
    object LabeledEdit15: TLabeledEdit
      Left = 120
      Top = 251
      Width = 121
      Height = 21
      EditLabel.Width = 52
      EditLabel.Height = 13
      EditLabel.Caption = #21697#21517#35268#26684
      Enabled = False
      LabelPosition = lpLeft
      TabOrder = 14
    end
    object LabeledEdit16: TLabeledEdit
      Left = 120
      Top = 155
      Width = 121
      Height = 21
      EditLabel.Width = 65
      EditLabel.Height = 13
      EditLabel.Caption = #20379#24212#21830#21517#31216
      Enabled = False
      LabelPosition = lpLeft
      TabOrder = 15
    end
    object ComboBox2: TComboBox
      Left = 120
      Top = 58
      Width = 121
      Height = 21
      ItemHeight = 13
      TabOrder = 2
      Items.Strings = (
        #27491#24120#37319#36141
        #38144#21806#36864#36135)
    end
  end
  object CoolBar1: TCoolBar
    Left = 0
    Top = 0
    Width = 784
    Height = 37
    Bands = <
      item
        Control = ToolBar1
        ImageIndex = -1
        MinHeight = 33
        Width = 780
      end>
    object ToolBar1: TToolBar
      Left = 9
      Top = 0
      Width = 767
      Height = 33
      Caption = 'ToolBar1'
      TabOrder = 0
      object SpeedButton1: TSpeedButton
        Left = 0
        Top = 2
        Width = 97
        Height = 22
        Caption = #26032#22686'(F2)'
        OnClick = SpeedButton1Click
      end
      object SpeedButton3: TSpeedButton
        Left = 97
        Top = 2
        Width = 120
        Height = 22
        Caption = #21024#38500'ASN(F4)'
        OnClick = SpeedButton3Click
      end
      object SpeedButton2: TSpeedButton
        Left = 217
        Top = 2
        Width = 120
        Height = 22
        Caption = #26597#35810
        OnClick = SpeedButton2Click
      end
    end
  end
  object DBGrid1: TDBGrid
    Left = 265
    Top = 37
    Width = 519
    Height = 525
    Align = alClient
    DataSource = DataSource1
    ParentShowHint = False
    PopupMenu = PopupMenu1
    ReadOnly = True
    ShowHint = True
    TabOrder = 2
    TitleFont.Charset = GB2312_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -13
    TitleFont.Name = #23435#20307
    TitleFont.Style = []
  end
  object DosMove1: TDosMove
    Active = True
    Left = 712
    Top = 8
  end
  object ADOQuery1: TADOQuery
    AfterOpen = ADOQuery1AfterOpen
    AfterScroll = ADOQuery1AfterScroll
    Parameters = <>
    Left = 673
    Top = 8
  end
  object DataSource1: TDataSource
    DataSet = ADOQuery1
    Left = 328
    Top = 104
  end
  object lyquery1: TADOLYQuery
    DataBaseType = dbtMSSQL
    Left = 641
    Top = 8
  end
  object PopupMenu1: TPopupMenu
    AutoHotkeys = maManual
    Left = 609
    Top = 8
    object N1: TMenuItem
      Caption = #37322#25918'ASN'
      OnClick = N1Click
    end
  end
  object ActionList1: TActionList
    Left = 577
    Top = 8
    object ActSave: TAction
      Caption = 'ActSave'
      ShortCut = 114
      OnExecute = BitBtn2Click
    end
    object ActDel: TAction
      Caption = 'ActDel'
      ShortCut = 115
      OnExecute = SpeedButton3Click
    end
    object ActAdd: TAction
      Caption = 'ActAdd'
      ShortCut = 113
      OnExecute = SpeedButton1Click
    end
  end
end
