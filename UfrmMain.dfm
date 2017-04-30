object frmMain: TfrmMain
  Left = 192
  Top = 130
  Width = 870
  Height = 500
  Caption = #36135#20027#21046#21333
  Color = clBtnFace
  Font.Charset = GB2312_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = #23435#20307
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  Position = poScreenCenter
  WindowState = wsMaximized
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object CoolBar1: TCoolBar
    Left = 0
    Top = 0
    Width = 854
    Height = 37
    Bands = <
      item
        Control = ToolBar1
        ImageIndex = -1
        MinHeight = 33
        Width = 850
      end>
    object ToolBar1: TToolBar
      Left = 9
      Top = 0
      Width = 837
      Height = 33
      Caption = 'ToolBar1'
      TabOrder = 0
      object SpeedButton1: TSpeedButton
        Left = 0
        Top = 2
        Width = 89
        Height = 22
      end
    end
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 422
    Width = 854
    Height = 19
    Panels = <
      item
        Width = 50
      end
      item
        Text = #25805#20316#20154#21592#24037#21495':'
        Width = 90
      end
      item
        Width = 100
      end
      item
        Text = #25805#20316#20154#21592#22995#21517':'
        Width = 100
      end
      item
        Width = 70
      end
      item
        Text = #25480#26435#20351#29992#21333#20301':'
        Width = 100
      end
      item
        Width = 50
      end>
  end
  object MainMenu1: TMainMenu
    AutoHotkeys = maManual
    Left = 624
    Top = 8
    object N1: TMenuItem
      AutoHotkeys = maManual
      Caption = #25991#20214
      object N11: TMenuItem
        Caption = #37325#26032#30331#24405
        OnClick = N11Click
      end
      object N12: TMenuItem
        Caption = '-'
      end
      object N2: TMenuItem
        Caption = #36864#20986
        OnClick = N2Click
      end
    end
    object N3: TMenuItem
      Caption = #21333#25454#24405#20837
      object N4: TMenuItem
        AutoHotkeys = maManual
        Caption = #20837#24211#21333#24405#20837
        Enabled = False
        OnClick = N4Click
      end
      object N5: TMenuItem
        AutoHotkeys = maManual
        Caption = #20986#24211#21333#24405#20837
        OnClick = N5Click
      end
    end
    object N14: TMenuItem
      Caption = #26597#35810#32479#35745
      object N15: TMenuItem
        Caption = #26085#24535#26597#35810
        OnClick = N15Click
      end
    end
    object N6: TMenuItem
      Caption = #35774#32622
      object N7: TMenuItem
        Caption = #36890#29992#20195#30721
        OnClick = N7Click
      end
      object N10: TMenuItem
        Caption = #20154#21592#35774#32622
        OnClick = N10Click
      end
      object N9: TMenuItem
        Caption = '-'
      end
      object N13: TMenuItem
        Caption = #36873#39033
        OnClick = N13Click
      end
    end
    object N8: TMenuItem
      Caption = #24037#20855
    end
  end
end
