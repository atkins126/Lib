unit Base_Frm;

interface

uses
  Winapi.Windows, Vcl.Forms, Winapi.Messages, System.SysUtils, System.Variants,
  System.IOUtils, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Dialogs,
  Vcl.ImgList, Vcl.ActnList, System.Actions, System.Win.Registry, System.IniFiles,
  Vcl.ExtCtrls, Vcl.AppEvnts, Winapi.ShlObj, Data.DB, DataSnap.DBClient,
  Vcl.Clipbrd, Vcl.ComCtrls, System.ImageList, Vcl.Menus,

  VBCommonValues,

  // DevExpress
  dxRibbonForm, cxContainer, cxEdit, cxClasses, cxStyles, cxCalendar, cxFormats,
  cxGraphics, cxControls, cxLabel, cxCheckBox, cxDBEdit, dxSkinsDefaultPainters,
  cxGridTableView, cxGridCustomView, cxGridCustomTableView, cxListView,
  cxImageList, dxLayoutLookAndFeels, cxLookAndFeels;

type
//  TBaseFrm = class(TdxRibbonForm)
  TBaseFrm = class(TForm)
    styRepository: TcxStyleRepository;
    actList: TActionList;
    lafLayoutList: TdxLayoutLookAndFeelList;
    lafCustomSkin: TdxLayoutSkinLookAndFeel;
    img16: TcxImageList;
    img32: TcxImageList;
    procedure SetComponentProperties;

    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
//    FCopyContentOnly: Boolean;
    { Private declarations }
  public
    { Public declarations }
    FMainCaption: string;
//    FSLGen: TStringList;
//    FQueryIniFile: TIniFile;
//    FServerError: Boolean;
//    FBeepFreq: Integer;
//    FBeepDuration: Integer;
//    FRootDataFolder: string;
//    FAppDataFolder: string;
    FSwitchPrefix: TSysCharSet;
    FAppTitle: string;
    FSLRight: TStringList;
//    FUserRight: TUserRightSet;
    FCallingFromShell: Boolean;
    FUserData: TUserData;

//    property CopyContentOnly: Boolean read FCopyContentOnly write FCopyContentOnly;

    procedure CopyRecordData(AView: TcxCustomGridView; CopyCellContentOnly: Boolean);
  end;

var
  BaseFrm: TBaseFrm;

implementation

{$R *.dfm}

procedure TBaseFrm.CopyRecordData(AView: TcxCustomGridView; CopyCellContentOnly: Boolean);
var
  C: TcxCustomGridTableController;
begin
  C := TcxGridTableView(AView).Controller;
  Clipboard.Clear;
  if CopyCellContentOnly then
    Clipboard.AsText := C.FocusedRecord.DisplayTexts[C.FocusedItem.Index]
  else
    TcxGridTableView(AView).CopyToClipboard(False);
// This line of code copies the EditValue of an item. This yields undesirable
// results whhen the control is a LookupComboBox as the EditValue is typically
// the ID of the data being looked up
//  Clipboard.AsText := C.FocusedRecord.Values[C.FocusedItem.Index];
end;

procedure TBaseFrm.FormCreate(Sender: TObject);
begin
// Note to developer
// It is absolutely imperative that this event is invoked!! Even if there is
// no code.

  Self.Scaled := False;
  Self.ScaleBy(Screen.PixelsPerInch, 96);

  // Setup system date parameters
  System.SysUtils.FormatSettings.DateSeparator := '/';
  System.SysUtils.FormatSettings.ShortDateFormat := 'dd/MM/yyyy';
  System.SysUtils.FormatSettings.LongDateFormat := 'dd MMMM yyyy';
  cxFormatController.BeginUpdate;
  cxFormatController.UseDelphiDateTimeFormats := True;
  cxFormatController.EndUpdate;
  cxFormatController.GetFormats;
  cxFormatController.NotifyListeners;
//  FCaptionTextColour := RootLookAndFeel.SkinPainter.DefaultSelectionColor;
end;

procedure TBaseFrm.FormShow(Sender: TObject);
begin
//  styEditControllerReadOnly.Style.TextColor := RootLookAndFeel.SkinPainter.DefaultSelectionColor;
end;

procedure TBaseFrm.SetComponentProperties;
var
  I: Integer;
begin
  for I := 0 to ComponentCount - 1 do
  begin
    // Minimise flickering of DX controls
    if Components[I] is TcxControl then
      (Components[I] as TcxControl).DoubleBuffered := True;

    if (Components[I] is TcxLabel) then
    begin
      (Components[I] as TcxLabel).Properties.Transparent := True;
      (Components[I] as TcxLabel).Style.TransparentBorder := False;
    end;

    if (Components[I] is TcxCheckBox) then
      (Components[I] as TcxCheckBox).Transparent := True;

    if (Components[I] is TcxDBCheckBox) then
      (Components[I] as TcxDBCheckBox).Transparent := True;

    // Set navigator width to look proportional
    // if (Components[I] is TcxNavigator) then
    // (Components[I] as TcxNavigator).Width :=
    // (Components[I] as TcxNavigator).Height *
    // (Components[I] as TcxNavigator).Buttons.ButtonCount;
    //
    // if (Components[I] is TcxDBNavigator) then
    // (Components[I] as TcxDBNavigator).Width :=
    // (Components[I] as TcxDBNavigator).Height *
    // (Components[I] as TcxDBNavigator).Buttons.ButtonCount;
  end;
end;

end.

