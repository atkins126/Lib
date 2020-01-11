object BaseFrm: TBaseFrm
  Left = 0
  Top = 0
  Caption = 'BaseFrm'
  ClientHeight = 362
  ClientWidth = 684
  Color = clBtnFace
  DoubleBuffered = True
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Verdana'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object styRepository: TcxStyleRepository
    Left = 450
    Top = 10
    PixelsPerInch = 96
  end
  object styEditControllerReadOnly: TcxEditStyleController
    Style.Color = clWindow
    StyleDisabled.Color = clWindow
    Left = 570
    Top = 10
    PixelsPerInch = 96
  end
  object actList: TActionList
    Left = 365
    Top = 10
  end
  object lafLayoutList: TdxLayoutLookAndFeelList
    Left = 375
    Top = 65
    object lafCustomSkin: TdxLayoutSkinLookAndFeel
      PixelsPerInch = 96
    end
  end
  object img16: TcxImageList
    SourceDPI = 96
    FormatVersion = 1
    DesignInfo = 7995642
  end
  object img32: TcxImageList
    SourceDPI = 96
    FormatVersion = 1
    DesignInfo = 7995707
  end
end
