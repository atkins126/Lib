inherited BaseLayoutToolbarFrm: TBaseLayoutToolbarFrm
  Caption = 'BaseLayoutToolbarFrm'
  PixelsPerInch = 96
  TextHeight = 13
  inherited layMain: TdxLayoutControl
    object docToolbar: TdxBarDockControl [0]
      Left = 11
      Top = 11
      Width = 578
      Height = 26
      Align = dalNone
      BarManager = barManager
    end
    object grpToolbar: TdxLayoutGroup
      Parent = layMainGroup_Root
      CaptionOptions.Text = 'New Group'
      ButtonOptions.Buttons = <>
      ShowBorder = False
      Index = 0
    end
    object litToolbar: TdxLayoutItem
      Parent = grpToolbar
      Control = docToolbar
      ControlOptions.AutoColor = True
      ControlOptions.OriginalHeight = 26
      ControlOptions.OriginalWidth = 500
      ControlOptions.ShowBorder = False
      Index = 0
    end
  end
  inherited styRepository: TcxStyleRepository
    PixelsPerInch = 96
  end
  inherited styEditControllerReadOnly: TcxEditStyleController
    PixelsPerInch = 96
  end
  inherited lafLayoutList: TdxLayoutLookAndFeelList
    inherited lafCustomSkin: TdxLayoutSkinLookAndFeel
      PixelsPerInch = 96
    end
  end
  inherited lafItemTitle: TdxLayoutLookAndFeelList
    inherited lafItemCaptionInfoHighlight: TdxLayoutSkinLookAndFeel
      PixelsPerInch = 96
    end
    inherited lafHalfDayCaptureInfo: TdxLayoutSkinLookAndFeel
      PixelsPerInch = 96
    end
    inherited lafLayoutTitle: TdxLayoutSkinLookAndFeel
      PixelsPerInch = 96
    end
  end
  inherited lafGroup: TdxLayoutLookAndFeelList
    inherited lafGroupCaption: TdxLayoutCxLookAndFeel
      PixelsPerInch = 96
    end
  end
  object barManager: TdxBarManager [7]
    AlwaysSaveText = True
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    Categories.Strings = (
      'Default')
    Categories.ItemsVisibles = (
      2)
    Categories.Visibles = (
      True)
    PopupMenuLinks = <>
    Style = bmsUseLookAndFeel
    UseBarHintWindow = False
    UseSystemFont = False
    Left = 576
    Top = 185
    PixelsPerInch = 96
    object barToolbar: TdxBar
      AllowClose = False
      AllowCustomizing = False
      AllowQuickCustomizing = False
      Caption = 'Toolbar'
      CaptionButtons = <>
      DockControl = docToolbar
      DockedDockControl = docToolbar
      DockedLeft = 0
      DockedTop = 0
      FloatLeft = 768
      FloatTop = 8
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <>
      NotDocking = [dsNone, dsLeft, dsTop, dsRight, dsBottom]
      OneOnRow = True
      Row = 0
      UseOwnFont = False
      Visible = True
      WholeRow = True
    end
  end
  inherited repScreenTip: TdxScreenTipRepository
    PixelsPerInch = 96
  end
  inherited imgNav: TcxImageList
    FormatVersion = 1
  end
  inherited img32: TcxImageList
    FormatVersion = 1
  end
end
