inherited BaseLayoutFrm: TBaseLayoutFrm
  Caption = 'BaseLayoutFrm'
  ClientHeight = 481
  ClientWidth = 892
  ExplicitWidth = 908
  ExplicitHeight = 520
  PixelsPerInch = 96
  TextHeight = 13
  object layMain: TdxLayoutControl [0]
    Left = 0
    Top = 0
    Width = 796
    Height = 416
    TabOrder = 0
    LayoutLookAndFeel = lafCustomSkin
    object layMainGroup_Root: TdxLayoutGroup
      AlignHorz = ahClient
      AlignVert = avClient
      ButtonOptions.Buttons = <>
      Hidden = True
      ShowBorder = False
      Index = -1
    end
  end
  inherited styRepository: TcxStyleRepository
    Left = 460
    PixelsPerInch = 96
  end
  inherited styEditControllerReadOnly: TcxEditStyleController
    Left = 575
    PixelsPerInch = 96
  end
  inherited actList: TActionList
    Left = 375
  end
  inherited lafLayoutList: TdxLayoutLookAndFeelList
    inherited lafCustomSkin: TdxLayoutSkinLookAndFeel
      PixelsPerInch = 96
    end
  end
end
