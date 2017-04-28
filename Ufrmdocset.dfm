object frmdocset: Tfrmdocset
  Left = 182
  Top = 160
  Width = 544
  Height = 375
  Caption = #20154#21592#35774#32622
  Color = clSkyBlue
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = #23435#20307
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object DBGrid1: TDBGrid
    Left = 0
    Top = 98
    Width = 528
    Height = 239
    Align = alClient
    Color = 16767438
    DataSource = DataSourcedoclist
    ReadOnly = True
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -13
    TitleFont.Name = #23435#20307
    TitleFont.Style = []
    OnCellClick = DBGrid1CellClick
  end
  object Panel2: TPanel
    Left = 0
    Top = 41
    Width = 528
    Height = 57
    Align = alTop
    Color = clSkyBlue
    TabOrder = 1
    object Label1: TLabel
      Left = 8
      Top = 32
      Width = 138
      Height = 13
      Caption = #27880#65306#24102'[*]'#30340#24517#39035#36755#20837#12290
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -13
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object LabeledEdit1: TLabeledEdit
      Left = 80
      Top = 4
      Width = 85
      Height = 19
      Color = 16767438
      Ctl3D = False
      EditLabel.Width = 73
      EditLabel.Height = 13
      EditLabel.Caption = #29992#25143#20195#30721'[*]'
      LabelPosition = lpLeft
      ParentCtl3D = False
      TabOrder = 0
    end
    object LabeledEdit2: TLabeledEdit
      Left = 248
      Top = 4
      Width = 85
      Height = 19
      Color = 16767438
      Ctl3D = False
      EditLabel.Width = 52
      EditLabel.Height = 13
      EditLabel.Caption = #29992#25143#21517#31216
      ImeMode = imOpen
      LabelPosition = lpLeft
      ParentCtl3D = False
      TabOrder = 1
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 528
    Height = 41
    Align = alTop
    Color = clSkyBlue
    TabOrder = 2
    object suiButton1: TSpeedButton
      Left = 5
      Top = 8
      Width = 58
      Height = 27
      Caption = #26032#22686'F2'
      Transparent = False
      OnClick = suiButton1Click
    end
    object suiButton2: TSpeedButton
      Left = 69
      Top = 8
      Width = 58
      Height = 27
      Caption = #20445#23384'F3'
      Transparent = False
      OnClick = suiButton2Click
    end
    object suiButton3: TSpeedButton
      Left = 133
      Top = 8
      Width = 58
      Height = 27
      Caption = #21024#38500'F4'
      Transparent = False
      OnClick = suiButton3Click
    end
    object DBLookupComboBox1: TDBLookupComboBox
      Left = 354
      Top = 12
      Width = 145
      Height = 19
      Color = 16767438
      Ctl3D = False
      ListSource = DataSourcedeptlist
      ParentCtl3D = False
      TabOrder = 0
      OnClick = DBLookupComboBox1Click
    end
    object BitBtn1: TBitBtn
      Left = 200
      Top = 8
      Width = 113
      Height = 27
      Caption = #23548#20986#37096#38376#20154#21592
      TabOrder = 1
      OnClick = BitBtn1Click
    end
  end
  object DataSourcedeptlist: TDataSource
    DataSet = ADOdeptlist
    Left = 492
    Top = 16
  end
  object ADOdeptlist: TADOQuery
    Parameters = <>
    SQL.Strings = (
      'select id as '#31185#23460#20195#30721','
      
        'name as '#31185#23460#21517#31216',unid as '#21807#19968#32534#21495' from CommCode where TypeName='#39#37096#38376#39' orde' +
        'r by id'
      '')
    Left = 456
    Top = 16
  end
  object ADOdoclist: TADOQuery
    AfterScroll = ADOdoclistAfterScroll
    Parameters = <>
    Left = 444
    Top = 248
  end
  object DataSourcedoclist: TDataSource
    DataSet = ADOdoclist
    Left = 476
    Top = 248
  end
  object ActionList1: TActionList
    Left = 292
    Top = 16
    object Action1: TAction
      Caption = 'Action1'
      ShortCut = 113
    end
    object Action2: TAction
      Caption = 'Action2'
      ShortCut = 114
    end
    object Action3: TAction
      Caption = 'Action3'
      ShortCut = 115
    end
    object Action4: TAction
      Caption = 'Action4'
      ShortCut = 116
    end
    object Action5: TAction
      Caption = 'Action5'
      ShortCut = 117
    end
  end
  object DosMove1: TDosMove
    Active = True
    Left = 256
    Top = 16
  end
  object LYDataToExcel1: TLYDataToExcel
    Left = 300
    Top = 184
  end
end
