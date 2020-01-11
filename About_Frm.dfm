inherited AboutFrm: TAboutFrm
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = 'AboutFrm'
  ClientHeight = 521
  ClientWidth = 844
  ExplicitWidth = 850
  ExplicitHeight = 550
  PixelsPerInch = 96
  TextHeight = 13
  inherited layMain: TdxLayoutControl
    Width = 840
    Height = 522
    ExplicitWidth = 840
    ExplicitHeight = 522
    object btnClose: TcxButton [0]
      Left = 754
      Top = 484
      Width = 75
      Height = 25
      Caption = 'Close'
      ModalResult = 8
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
    end
    object grdAppInfo: TcxGrid [1]
      Left = 11
      Top = 11
      Width = 818
      Height = 455
      TabOrder = 0
      object viewAppInfo: TcxGridBandedTableView
        Navigator.Buttons.CustomButtons = <>
        FindPanel.ApplyInputDelay = 500
        ScrollbarAnnotations.CustomAnnotations = <>
        OnCustomDrawCell = viewAppInfoCustomDrawCell
        DataController.Filter.Options = [fcoCaseInsensitive]
        DataController.Options = [dcoCaseInsensitive, dcoAssignGroupingValues, dcoAssignMasterDetailKeys, dcoSaveExpanding, dcoMultiSelectionSyncGroupWithChildren]
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        DataController.OnCompare = viewAppInfoDataControllerCompare
        OptionsBehavior.FocusCellOnTab = True
        OptionsBehavior.FocusFirstCellOnNewRecord = True
        OptionsBehavior.IncSearch = True
        OptionsBehavior.FocusCellOnCycle = True
        OptionsData.DeletingConfirmation = False
        OptionsView.NoDataToDisplayInfoText = '<No Version information to display>'
        OptionsView.GroupByBox = False
        Bands = <
          item
            Caption = 'RC Shell Application Version Information'
          end>
        object edtID: TcxGridBandedColumn
          Caption = 'ID'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.DisplayFormat = '#,##0'
          Properties.EditFormat = '#,##0'
          Properties.ReadOnly = True
          Visible = False
          MinWidth = 40
          Options.Editing = False
          Options.Filtering = False
          Options.IncSearch = False
          Options.Grouping = False
          Options.HorzSizing = False
          Options.Moving = False
          Width = 40
          Position.BandIndex = 0
          Position.ColIndex = 0
          Position.RowIndex = 0
        end
        object edtApplicationName: TcxGridBandedColumn
          Caption = 'Application'
          PropertiesClassName = 'TcxTextEditProperties'
          Properties.ReadOnly = True
          MinWidth = 245
          Options.Editing = False
          Options.Filtering = False
          Options.IncSearch = False
          Options.Grouping = False
          Options.HorzSizing = False
          Options.Moving = False
          Width = 245
          Position.BandIndex = 0
          Position.ColIndex = 1
          Position.RowIndex = 0
        end
        object edtFileName: TcxGridBandedColumn
          Caption = 'File Name'
          PropertiesClassName = 'TcxTextEditProperties'
          Properties.ReadOnly = True
          MinWidth = 245
          Options.Editing = False
          Options.Filtering = False
          Options.IncSearch = False
          Options.Grouping = False
          Options.HorzSizing = False
          Options.Moving = False
          Width = 245
          Position.BandIndex = 0
          Position.ColIndex = 2
          Position.RowIndex = 0
        end
        object edtVersion: TcxGridBandedColumn
          Caption = 'Version'
          PropertiesClassName = 'TcxTextEditProperties'
          Properties.ReadOnly = True
          MinWidth = 80
          Options.Editing = False
          Options.Filtering = False
          Options.IncSearch = False
          Options.Grouping = False
          Options.HorzSizing = False
          Options.Moving = False
          Width = 80
          Position.BandIndex = 0
          Position.ColIndex = 3
          Position.RowIndex = 0
        end
        object edtBuild: TcxGridBandedColumn
          Caption = 'Build'
          PropertiesClassName = 'TcxTextEditProperties'
          Properties.ReadOnly = True
          MinWidth = 64
          Options.Editing = False
          Options.Filtering = False
          Options.IncSearch = False
          Options.Grouping = False
          Options.HorzSizing = False
          Options.Moving = False
          Position.BandIndex = 0
          Position.ColIndex = 4
          Position.RowIndex = 0
        end
        object edtTimeStamp: TcxGridBandedColumn
          Caption = 'Timestamp'
          PropertiesClassName = 'TcxTextEditProperties'
          Properties.ReadOnly = True
          MinWidth = 160
          Options.Editing = False
          Options.Filtering = False
          Options.IncSearch = False
          Options.Grouping = False
          Options.HorzSizing = False
          Options.Moving = False
          Width = 160
          Position.BandIndex = 0
          Position.ColIndex = 5
          Position.RowIndex = 0
        end
      end
      object lvlAppInfo: TcxGridLevel
        GridView = viewAppInfo
      end
    end
    object grpGrid: TdxLayoutGroup
      Parent = layMainGroup_Root
      AlignHorz = ahClient
      CaptionOptions.Text = 'New Group'
      ButtonOptions.Buttons = <>
      ShowBorder = False
      Index = 0
    end
    object grpControls: TdxLayoutGroup
      Parent = layMainGroup_Root
      CaptionOptions.Text = 'New Group'
      ButtonOptions.Buttons = <>
      ShowBorder = False
      Index = 2
    end
    object litGrid: TdxLayoutItem
      Parent = grpGrid
      AlignHorz = ahClient
      AlignVert = avClient
      SizeOptions.AssignedValues = [sovSizableVert]
      SizeOptions.SizableVert = True
      SizeOptions.Height = 455
      Control = grdAppInfo
      ControlOptions.OriginalHeight = 400
      ControlOptions.OriginalWidth = 818
      ControlOptions.ShowBorder = False
      Index = 0
    end
    object litControls: TdxLayoutItem
      Parent = grpControls
      AlignHorz = ahRight
      CaptionOptions.Text = 'New Item'
      CaptionOptions.Visible = False
      Control = btnClose
      ControlOptions.OriginalHeight = 25
      ControlOptions.OriginalWidth = 75
      ControlOptions.ShowBorder = False
      Index = 0
    end
    object dxLayoutSeparatorItem1: TdxLayoutSeparatorItem
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
