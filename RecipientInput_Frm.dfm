inherited RecipientInputFrm: TRecipientInputFrm
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = 'RecipientInputFrm'
  ClientHeight = 245
  ClientWidth = 490
  ExplicitWidth = 496
  ExplicitHeight = 274
  PixelsPerInch = 96
  TextHeight = 13
  inherited layMain: TdxLayoutControl
    Width = 400
    Height = 90
    ExplicitWidth = 400
    ExplicitHeight = 90
    object edtEmailAddress: TcxTextEdit [0]
      Left = 95
      Top = 11
      BeepOnEnter = False
      Properties.OnChange = edtEmailAddressPropertiesChange
      Style.HotTrack = False
      Style.TransparentBorder = False
      TabOrder = 0
      Width = 294
    end
    object btnOK: TcxButton [1]
      Left = 233
      Top = 48
      Width = 75
      Height = 25
      Caption = 'OK'
      Default = True
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      OnClick = btnOKClick
    end
    object btnCancel: TcxButton [2]
      Left = 314
      Top = 48
      Width = 75
      Height = 25
      Cancel = True
      Caption = 'Cancel'
      ModalResult = 2
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
    end
    inherited layMainGroup_Root: TdxLayoutGroup
      ItemIndex = 1
    end
    object grpControls: TdxLayoutGroup
      Parent = layMainGroup_Root
      CaptionOptions.Text = 'New Group'
      ButtonOptions.Buttons = <>
      LayoutDirection = ldHorizontal
      ShowBorder = False
      Index = 2
    end
    object litEmailAddress: TdxLayoutItem
      Parent = layMainGroup_Root
      CaptionOptions.Text = 'Add Recipient'
      Control = edtEmailAddress
      ControlOptions.OriginalHeight = 19
      ControlOptions.OriginalWidth = 121
      ControlOptions.ShowBorder = False
      Index = 0
    end
    object litOK: TdxLayoutItem
      Parent = grpControls
      AlignHorz = ahRight
      CaptionOptions.Text = 'New Item'
      CaptionOptions.Visible = False
      Control = btnOK
      ControlOptions.OriginalHeight = 25
      ControlOptions.OriginalWidth = 75
      ControlOptions.ShowBorder = False
      Index = 0
    end
    object litCancel: TdxLayoutItem
      Parent = grpControls
      AlignHorz = ahRight
      CaptionOptions.Text = 'New Item'
      CaptionOptions.Visible = False
      Control = btnCancel
      ControlOptions.OriginalHeight = 25
      ControlOptions.OriginalWidth = 75
      ControlOptions.ShowBorder = False
      Index = 1
    end
    object sep1: TdxLayoutSeparatorItem
      Parent = layMainGroup_Root
      CaptionOptions.Text = 'Separator'
      Index = 1
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
  end
end
