unit About_Frm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, Vcl.Forms, System.Classes,
  Vcl.Graphics, Vcl.Controls, System.Actions, Vcl.Menus, Vcl.StdCtrls,
  Vcl.ActnList,

  BaseLayout_Frm, VersionInformation,

  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, dxSkinsCore,
  dxSkinsDefaultPainters, cxContainer, cxEdit, cxClasses, cxStyles, cxNavigator,
  dxLayoutContainer, dxLayoutControl, cxCustomData, cxFilter, cxData, cxTextEdit,
  cxDataStorage, cxDataControllerConditionalFormattingRulesManagerDialog, dxCore,
  cxGridCustomTableView, cxGridTableView, cxGridBandedTableView, cxGridLevel,
  cxGridCustomView, cxGrid, dxLayoutLookAndFeels, cxGridDBDataDefinitions,
  cxCurrencyEdit, dxLayoutControlAdapters, cxButtons, dxDateRanges,
  dxSkinTheBezier, System.ImageList, Vcl.ImgList, cxImageList,
  dxScrollbarAnnotations;

type
  TAboutFrm = class(TBaseLayoutFrm)
    grdAppInfo: TcxGrid;
    viewAppInfo: TcxGridBandedTableView;
    lvlAppInfo: TcxGridLevel;
    edtFileName: TcxGridBandedColumn;
    edtApplicationName: TcxGridBandedColumn;
    edtVersion: TcxGridBandedColumn;
    edtTimeStamp: TcxGridBandedColumn;
    edtBuild: TcxGridBandedColumn;
    edtID: TcxGridBandedColumn;
    btnClose: TcxButton;
    grpGrid: TdxLayoutGroup;
    grpControls: TdxLayoutGroup;
    litGrid: TdxLayoutItem;
    litControls: TdxLayoutItem;
    dxLayoutSeparatorItem1: TdxLayoutSeparatorItem;
    procedure FormCreate(Sender: TObject);
    procedure viewAppInfoCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);

    procedure viewAppInfoDataControllerCompare(
      ADataController: TcxCustomDataController; ARecordIndex1, ARecordIndex2,
      AItemIndex: Integer; const V1, V2: Variant; var Compare: Integer);
  private
    { Private declarations }
    procedure DrawCellBorder(var Msg: TMessage);
    procedure GetApplicationList(Folder, Mask: string);
  public
    { Public declarations }
  end;

var
  AboutFrm: TAboutFrm;

implementation

{$R *.dfm}

uses
  RUtils, VBCommonValues;

procedure TAboutFrm.DrawCellBorder(var Msg: TMessage);
begin
  if (TObject(Msg.WParam) is TcxCanvas) and (TObject(Msg.LParam) is
    TcxGridTableDataCellViewInfo) then
    TcxCanvas(Msg.WParam).DrawComplexFrame(TcxGridTableDataCellViewInfo(
      Msg.LParam).ClientBounds, clRed, clRed, cxBordersAll, 1);
end;

procedure TAboutFrm.FormCreate(Sender: TObject);
begin
  inherited;
  Caption := 'RC Shell Application Version Information';
  GetApplicationList('C:\RC Apps\', '*.exe');
end;

procedure TAboutFrm.GetApplicationList(Folder, Mask: string);
var
  {Index, }ID: Integer;
  SearchRec: TSearchRec;
  SL: TStringList;
  DC: TcxGridDataController;
  FileName: string;
  AppFileTimestamp: TDateTime;
  verInfo: TVersionInformation;
begin
  Folder := AddChar(Folder, '\', rpEnd);
  SL := RUtils.CreateStringList(COMMA);
  DC := viewAppInfo.DataController;
  DC.BeginUpdate;

  try
    try
      {Index := }findfirst(Folder + Mask, faAnyFile + faDirectory, SearchRec);
      repeat
        if SearchRec.Attr = faAnyFile {+ faAnyFile} then
        begin
          if (SearchRec.Name <> '')
            and (SearchRec.Name <> '.')
            and (SearchRec.Name <> '..') then
          begin
          // Only process executable files
            if ExtractFileExt(SearchRec.Name) = '.exe' then
            begin
              FileName := Folder + '\' + SearchRec.Name;
              verInfo := TVersionInformation.Create(Self);
              try
                verInfo.FileName := FileName;
                if (verInfo.HaveInfo) and (Length(verInfo.StringFileInfo['ProductName']) > 0) then
                begin
                  ID := DC.AppendRecord;
                  DC.Values[ID, edtID.Index] := ID + 1;
                  DC.Values[ID, edtApplicationName.Index] := verInfo.StringFileInfo['ProductName'];
                  DC.Values[ID, edtFileName.Index] := SearchRec.Name;
                  DC.Values[ID, edtVersion.Index] := RUtils.GetBuildInfo(FileName, rbShortVersion);
                  DC.Values[ID, edtBuild.Index] := RUtils.GetBuildInfo(FileName, rbBuildNoOnly);
                  FileAge(FileName, AppFileTimestamp);
                  DC.Values[ID, edtTimeStamp.Index] := FormatDateTime('dd/MM/yyyy hh:mm:ss', AppFileTimestamp);
                  DC.Post(True);
                end;
              finally
                verInfo.Free;
              end;

//            if verInfo.HaveInfo then
//            begin
//              RUtils.GetBuildInfo(Application.ExeName, rbBuildNoOnly) + ' - ' +
//                verInfo.StringFileInfo['CompilerName'];
//            end;
            end;
            GetApplicationList(Folder + SearchRec.Name, Mask);
          end;
        end;
//        Index := FindNext(SearchRec);
//      until Index <> 0;
      until FindNext(SearchRec) <> 0
    finally
      FindClose(SearchRec);
      SL.Free;
    end;
  finally
    DC.EndUpdate;
    // soAscending used in dxCore unit
    edtApplicationName.SortOrder := soAscending;
  end;
end;

procedure TAboutFrm.viewAppInfoCustomDrawCell(Sender: TcxCustomGridTableView;
  ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;
  if AViewInfo.GridRecord = nil then
    Exit;

  if AViewInfo.GridRecord.Focused then
  begin
    if AViewInfo.Item.Focused then
    begin
      // This renders the background and border colour of the focused cell
      ACanvas.Brush.Color := $B6EDFA;
      ACanvas.Font.Color := RootLookAndFeel.SkinPainter.DefaultSelectionColor;
      PostMessage(Handle, DRAW_CELL_BORDER, Integer(ACanvas), Integer(AViewInfo));
    end;
  end;

  if AViewInfo.GridRecord.Values[edtFileName.Index] = ExtractFileName(Application.ExeName) then
  begin
    ACanvas.Brush.Color := $C6FFC6;
    ACanvas.Font.Color := RootLookAndFeel.SkinPainter.DefaultSelectionColor; //clBlack;
    ACanvas.Font.Style := [fsBold];
//    styEditControllerReadOnly.Style.Color := RootLookAndFeel.SkinPainter.DefaultContentColor;
//    styReadOnlyControl.Style.Color := RootLookAndFeel.SkinPainter.DefaultContentColor;
  end;

//  if (AViewInfo.Item = edtPStartDate) then
//    if AViewInfo.GridRecord.Values[edtPStartDate.Index] < Date then
//      ACanvas.Brush.Color := styLateStartDate.Color;
//
//  if (TcxGridBandedTableView(Sender).Controller.FocusedRow <> nil)
//    and (AViewInfo.GridRecord <> nil) then
//    if not TcxGridBandedTableView(Sender).Controller.FocusedRow.IsFilterRow then
//      if AViewInfo.GridRecord.Focused then
//      begin
//        // Don't paint this cell with default values.
//        if (AViewInfo.Item = edtPriorityProcess) then
//        begin
//          if AViewInfo.GridRecord.Values[cbxPriorityProcess.Index] = 1 then
//            ACanvas.Brush.Color := styPriority.Color
//          else
//          begin
//            if AViewInfo.GridRecord.Values[edtPWeekNo.Index] = FWeekNo then
//              ACanvas.Brush.Color := styOnTime.Color
//
//            else if FWeekNo - AViewInfo.GridRecord.Values[edtPWeekNo.Index] = 1 then
//              ACanvas.Brush.Color := styLate.Color
//
//            else if FWeekNo - AViewInfo.GridRecord.Values[edtPWeekNo.Index] > 1 then
//              ACanvas.Brush.Color := styVeryLate.Color;
//          end;
//        end;
//
//        // This renders the background and font colours of the focused record
//        if (AViewInfo.Item.Focused) then
//        begin
//            // This renders the background and border colour of the focused cell
//          ACanvas.Brush.Color := $B6EDFA;
//          ACanvas.Font.Color := clBlack;
//          PostMessage(Handle, CM_DRAWBORDER, Integer(ACanvas), Integer(AViewInfo));
//        end;
//      end
//end;

//  if AViewInfo.GridRecord.Focused then
//  // This renders the background and font colours of the focused record
//  begin
//    if AViewInfo.Item.Focused then
//    begin
//      // This renders the background and border colour of the focused cell
//      ACanvas.Brush.Color := $B6EDFA;
//      ACanvas.Font.Color := RootLookAndFeel.SkinPainter.DefaultSelectionColor;
//      PostMessage(Handle, CM_DRAWBORDER, Integer(ACanvas), Integer(AViewInfo));
//    end;
//  end;
end;

procedure TAboutFrm.viewAppInfoDataControllerCompare(
  ADataController: TcxCustomDataController; ARecordIndex1, ARecordIndex2,
  AItemIndex: Integer; const V1, V2: Variant; var Compare: Integer);
var
  ASortColumnIndex: Integer;
  AValue1, AValue2: Variant;
begin
  inherited;
  if AItemIndex = edtApplicationName.Index then
  begin
    ASortColumnIndex := edtApplicationName.Index;
    AValue1 := UpperCase(ADataController.Values[ARecordIndex1, ASortColumnIndex]);
    AValue2 := UpperCase(ADataController.Values[ARecordIndex2, ASortColumnIndex]);
    Compare := AnsiCompareStr(V1, V2);
  end;
end;

end.

