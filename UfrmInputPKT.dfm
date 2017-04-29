object frmInputPKT: TfrmInputPKT
  Left = 301
  Top = 41
  Width = 800
  Height = 686
  Caption = #20986#24211#21333#24405#20837
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
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 0
    Top = 0
    Width = 784
    Height = 329
    Align = alClient
    Caption = #24635#21333
    TabOrder = 0
    object Panel1: TPanel
      Left = 2
      Top = 15
      Width = 265
      Height = 312
      Align = alLeft
      TabOrder = 0
      object Label1: TLabel
        Left = 92
        Top = 8
        Width = 26
        Height = 13
        Caption = #36135#20027
      end
      object Label2: TLabel
        Left = 79
        Top = 195
        Width = 39
        Height = 13
        Caption = #21516#25209#21495
      end
      object Label6: TLabel
        Left = 92
        Top = 219
        Width = 26
        Height = 13
        Caption = #20445#31246
      end
      object Label5: TLabel
        Left = 79
        Top = 171
        Width = 39
        Height = 13
        Caption = #38468#21457#31080
      end
      object SpeedButton1: TSpeedButton
        Left = 21
        Top = 263
        Width = 110
        Height = 22
        Caption = #26032#22686'(F2)'
        OnClick = SpeedButton1Click
      end
      object SpeedButton3: TSpeedButton
        Left = 21
        Top = 286
        Width = 110
        Height = 22
        Caption = #21024#38500'PKT'#20027#21333'(F4)'
        OnClick = SpeedButton3Click
      end
      object SpeedButton2: TSpeedButton
        Left = 187
        Top = 286
        Width = 55
        Height = 22
        Caption = #26597#35810
        OnClick = SpeedButton2Click
      end
      object SpeedButton6: TSpeedButton
        Left = 132
        Top = 286
        Width = 55
        Height = 22
        Caption = #23548#20837
        OnClick = SpeedButton6Click
      end
      object ComboBox1: TComboBox
        Left = 120
        Top = 4
        Width = 121
        Height = 21
        ItemHeight = 13
        TabOrder = 0
      end
      object LabeledEdit1: TLabeledEdit
        Left = 120
        Top = 27
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
        Top = 50
        Width = 121
        Height = 21
        EditLabel.Width = 52
        EditLabel.Height = 13
        EditLabel.Caption = #23458#25143#20195#30721
        LabelPosition = lpLeft
        TabOrder = 2
        OnKeyDown = LabeledEdit4KeyDown
      end
      object LabeledEdit5: TLabeledEdit
        Left = 120
        Top = 239
        Width = 121
        Height = 21
        EditLabel.Width = 52
        EditLabel.Height = 13
        EditLabel.Caption = #24635#21333#22791#27880
        LabelPosition = lpLeft
        TabOrder = 9
      end
      object BitBtn2: TBitBtn
        Left = 132
        Top = 263
        Width = 110
        Height = 22
        Caption = #20445#23384'PKT'#20027#21333'(F3)'
        TabOrder = 10
        OnClick = BitBtn2Click
      end
      object LabeledEdit2: TComboBox
        Left = 120
        Top = 191
        Width = 121
        Height = 21
        ItemHeight = 13
        TabOrder = 7
        Items.Strings = (
          #21542
          #26159)
      end
      object LabeledEdit3: TComboBox
        Left = 120
        Top = 215
        Width = 121
        Height = 21
        ItemHeight = 13
        TabOrder = 8
        Items.Strings = (
          #21542
          #26159)
      end
      object LabeledEdit16: TLabeledEdit
        Left = 120
        Top = 73
        Width = 121
        Height = 21
        EditLabel.Width = 52
        EditLabel.Height = 13
        EditLabel.Caption = #23458#25143#21517#31216
        Enabled = False
        LabelPosition = lpLeft
        TabOrder = 11
      end
      object LabeledEdit13: TLabeledEdit
        Left = 120
        Top = 143
        Width = 121
        Height = 21
        EditLabel.Width = 52
        EditLabel.Height = 13
        EditLabel.Caption = #36816#36755#26041#24335
        LabelPosition = lpLeft
        TabOrder = 5
        OnKeyDown = LabeledEdit13KeyDown
      end
      object ComboBox3: TComboBox
        Left = 120
        Top = 167
        Width = 121
        Height = 21
        ItemHeight = 13
        TabOrder = 6
        Items.Strings = (
          #21542
          #26159)
      end
      object LabeledEdit10: TLabeledEdit
        Left = 120
        Top = 96
        Width = 121
        Height = 21
        EditLabel.Width = 40
        EditLabel.Height = 13
        EditLabel.Caption = #22320#22336'ID'
        LabelPosition = lpLeft
        TabOrder = 3
        OnKeyDown = LabeledEdit10KeyDown
      end
      object ComboBox2: TLabeledEdit
        Left = 120
        Top = 119
        Width = 121
        Height = 21
        EditLabel.Width = 52
        EditLabel.Height = 13
        EditLabel.Caption = #36865#36135#22320#22336
        LabelPosition = lpLeft
        TabOrder = 4
      end
    end
    object DBGrid1: TDBGrid
      Left = 267
      Top = 15
      Width = 515
      Height = 312
      Align = alClient
      DataSource = DataSource1
      ParentShowHint = False
      PopupMenu = PopupMenu1
      ReadOnly = True
      ShowHint = True
      TabOrder = 1
      TitleFont.Charset = GB2312_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -13
      TitleFont.Name = #23435#20307
      TitleFont.Style = []
    end
  end
  object GroupBox2: TGroupBox
    Left = 0
    Top = 329
    Width = 784
    Height = 318
    Align = alBottom
    Caption = #32454#21333
    TabOrder = 1
    object Panel2: TPanel
      Left = 2
      Top = 15
      Width = 265
      Height = 301
      Align = alLeft
      TabOrder = 0
      object Label7: TLabel
        Left = 66
        Top = 254
        Width = 52
        Height = 13
        Caption = #21457#31080#31867#22411
      end
      object SpeedButton4: TSpeedButton
        Left = 0
        Top = 274
        Width = 53
        Height = 22
        Caption = #26032#22686'(F6)'
        OnClick = SpeedButton4Click
      end
      object SpeedButton5: TSpeedButton
        Left = 158
        Top = 274
        Width = 105
        Height = 22
        Caption = #21024#38500'PKT'#26126#32454'(F8)'
        OnClick = SpeedButton5Click
      end
      object LabeledEdit7: TLabeledEdit
        Left = 120
        Top = 26
        Width = 121
        Height = 21
        EditLabel.Width = 40
        EditLabel.Height = 13
        EditLabel.Caption = #36135#21697'ID'
        LabelPosition = lpLeft
        TabOrder = 1
        OnKeyDown = LabeledEdit7KeyDown
      end
      object LabeledEdit15: TLabeledEdit
        Left = 120
        Top = 48
        Width = 121
        Height = 21
        EditLabel.Width = 52
        EditLabel.Height = 13
        EditLabel.Caption = #21697#21517#35268#26684
        Enabled = False
        LabelPosition = lpLeft
        TabOrder = 9
      end
      object LabeledEdit6: TLabeledEdit
        Left = 120
        Top = 4
        Width = 121
        Height = 21
        EditLabel.Width = 66
        EditLabel.Height = 13
        EditLabel.Caption = #35746#21333#32454#21333'ID'
        LabelPosition = lpLeft
        TabOrder = 0
      end
      object LabeledEdit8: TLabeledEdit
        Left = 120
        Top = 70
        Width = 121
        Height = 21
        EditLabel.Width = 26
        EditLabel.Height = 13
        EditLabel.Caption = #25209#21495
        LabelPosition = lpLeft
        TabOrder = 2
      end
      object LabeledEdit9: TLabeledEdit
        Left = 120
        Top = 92
        Width = 121
        Height = 21
        EditLabel.Width = 39
        EditLabel.Height = 13
        EditLabel.Caption = #38145#20195#30721
        LabelPosition = lpLeft
        TabOrder = 3
        OnKeyDown = LabeledEdit9KeyDown
      end
      object LabeledEdit11: TLabeledEdit
        Left = 120
        Top = 114
        Width = 121
        Height = 21
        EditLabel.Width = 39
        EditLabel.Height = 13
        EditLabel.Caption = #38145#21517#31216
        Enabled = False
        LabelPosition = lpLeft
        TabOrder = 10
      end
      object LabeledEdit12: TLabeledEdit
        Left = 120
        Top = 136
        Width = 121
        Height = 21
        EditLabel.Width = 26
        EditLabel.Height = 13
        EditLabel.Caption = #25968#37327
        LabelPosition = lpLeft
        TabOrder = 4
      end
      object LabeledEdit14: TLabeledEdit
        Left = 120
        Top = 227
        Width = 121
        Height = 21
        EditLabel.Width = 52
        EditLabel.Height = 13
        EditLabel.Caption = #32454#21333#22791#27880
        LabelPosition = lpLeft
        TabOrder = 7
      end
      object LabeledEdit17: TLabeledEdit
        Left = 120
        Top = 203
        Width = 121
        Height = 21
        EditLabel.Width = 52
        EditLabel.Height = 13
        EditLabel.Caption = #33647#26816#20221#25968
        LabelPosition = lpLeft
        TabOrder = 6
      end
      object LabeledEdit18: TLabeledEdit
        Left = 120
        Top = 158
        Width = 121
        Height = 21
        EditLabel.Width = 65
        EditLabel.Height = 13
        EditLabel.Caption = #20379#24212#21830#20195#30721
        LabelPosition = lpLeft
        TabOrder = 5
        OnKeyDown = LabeledEdit18KeyDown
      end
      object LabeledEdit19: TLabeledEdit
        Left = 120
        Top = 181
        Width = 121
        Height = 21
        EditLabel.Width = 65
        EditLabel.Height = 13
        EditLabel.Caption = #20379#24212#21830#21517#31216
        Enabled = False
        LabelPosition = lpLeft
        TabOrder = 11
      end
      object ComboBox4: TComboBox
        Left = 120
        Top = 250
        Width = 121
        Height = 21
        ItemHeight = 13
        TabOrder = 8
        Items.Strings = (
          #26222#36890
          #22686#20540)
      end
      object BitBtn1: TBitBtn
        Left = 53
        Top = 274
        Width = 105
        Height = 22
        Caption = #20445#23384'PKT'#26126#32454'(F7)'
        TabOrder = 12
        OnClick = BitBtn1Click
      end
    end
    object DBGrid2: TDBGrid
      Left = 267
      Top = 15
      Width = 515
      Height = 301
      Align = alClient
      DataSource = DataSource2
      ReadOnly = True
      TabOrder = 1
      TitleFont.Charset = GB2312_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -13
      TitleFont.Name = #23435#20307
      TitleFont.Style = []
    end
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
      Caption = #37322#25918'PKT'
      OnClick = N1Click
    end
  end
  object DataSource2: TDataSource
    DataSet = ADOQuery2
    Left = 328
    Top = 456
  end
  object ADOQuery2: TADOQuery
    AfterOpen = ADOQuery2AfterOpen
    AfterScroll = ADOQuery2AfterScroll
    Parameters = <>
    Left = 577
    Top = 8
  end
  object ActionList1: TActionList
    Left = 544
    Top = 8
    object ActAdd_Z: TAction
      Caption = 'ActAdd_Z'
      ShortCut = 113
      OnExecute = SpeedButton1Click
    end
    object ActSave_Z: TAction
      Caption = 'ActSave_Z'
      ShortCut = 114
      OnExecute = BitBtn2Click
    end
    object ActDel_Z: TAction
      Caption = 'ActDel_Z'
      ShortCut = 115
      OnExecute = SpeedButton3Click
    end
    object ActAdd_C: TAction
      Caption = 'ActAdd_C'
      ShortCut = 117
      OnExecute = SpeedButton4Click
    end
    object ActSave_C: TAction
      Caption = 'ActSave_C'
      ShortCut = 118
      OnExecute = BitBtn1Click
    end
    object ActDel_C: TAction
      Caption = 'ActDel_C'
      ShortCut = 119
      OnExecute = SpeedButton5Click
    end
  end
  object OpenDialog1: TOpenDialog
    Left = 512
    Top = 8
  end
end
