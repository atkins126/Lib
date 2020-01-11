inherited BaseLayoutFrm: TBaseLayoutFrm
  Caption = 'BaseLayoutFrm'
  PixelsPerInch = 96
  TextHeight = 13
  object layMain: TdxLayoutControl [0]
    Left = 10
    Top = 10
    Width = 526
    Height = 376
    TabOrder = 0
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
    PixelsPerInch = 96
  end
  inherited lafLayoutList: TdxLayoutLookAndFeelList
    inherited lafCustomSkin: TdxLayoutSkinLookAndFeel
      PixelsPerInch = 96
    end
  end
  inherited img16: TcxImageList
    FormatVersion = 1
  end
  inherited img32: TcxImageList
    FormatVersion = 1
    ImageInfo = <>
  end
end
