unit BaseGrid_Frm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, Vcl.Forms,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Dialogs, System.IOUtils,
  System.Win.Registry, WinApi.ShellApi,

  BaseLayout_Frm, CommonValues, VBCommonValues, CommonFunctions,

  FireDac.Comp.Client,

  frxClass, frxDBSet,

  cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, dxSkinsCore, dxSkinsDefaultPainters,
  System.ImageList, Vcl.ImgList, cxImageList, dxLayoutLookAndFeels,
  System.Actions, Vcl.ActnList, cxClasses, cxStyles, dxLayoutContainer,
  dxLayoutControl, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit,
  cxNavigator, dxDateRanges, Data.DB, cxDBData, cxDBNavigator, cxGridLevel,
  cxGridCustomView, cxGridCustomTableView, cxGridTableView, cxGridBandedTableView,
  cxGridDBBandedTableView, cxGrid, dxScrollbarAnnotations, dxPrnDev, dxPrnDlg,
  cxGridExportLink, dxLayoutcxEditAdapters, cxContainer, cxCheckBox;

type
  TBaseGridFrm = class(TBaseLayoutFrm)
    imgNav: TcxImageList;
    dlgFileSave: TSaveDialog;
    dlgPrint: TdxPrintDialog;
    grpToolbar: TdxLayoutGroup;
    litNavigator: TdxLayoutItem;
    litOpenAfterExport: TdxLayoutItem;
    litGrid: TdxLayoutItem;
    grdMaster: TcxGrid;
    viewMaster: TcxGridDBBandedTableView;
    lvlMaster: TcxGridLevel;
    navMaster: TcxDBNavigator;
    cbxOpenAfterExport: TcxCheckBox;
    procedure DrawCellBorder(var Msg: TMessage); message CM_DRAWBORDER;

    procedure FormCreate(Sender: TObject);
    procedure viewMasterCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;      var ADone: Boolean);
    procedure SetButtonVisibility(DataSet: TFDMemTable; MasterID: Integer);
    procedure SetPrintButtonStatus(DataSet: TFDMemTable);
    procedure FormShow(Sender: TObject);
    procedure navMasterButtonsButtonClick(Sender: TObject;
      AButtonIndex: Integer; var ADone: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  BaseGridFrm: TBaseGridFrm;

implementation

{$R *.dfm}

uses
  VBBase_DM,
  MT_DM,
  Report_DM;

procedure TBaseGridFrm.DrawCellBorder(var Msg: TMessage);
begin
  if (TObject(Msg.WParam) is TcxCanvas)
    and (TObject(Msg.LParam) is TcxGridTableDataCellViewInfo) then
    TcxCanvas(Msg.WParam).DrawComplexFrame(TcxGridTableDataCellViewInfo(Msg.LParam).ClientBounds, clRed, clRed, cxBordersAll, 1);
end;

procedure TBaseGridFrm.FormCreate(Sender: TObject);
var
  RegKey: TRegistry;
begin
  inherited;
  ReportDM.PrintExporting := False;
  RegKey := TRegistry.Create(KEY_ALL_ACCESS or KEY_WRITE or KEY_WOW64_64KEY);
  RegKey.RootKey := HKEY_CURRENT_USER;
  try
    RegKey.OpenKey(KEY_MASTER_TABLE_MANAGER, True);

    if not RegKey.ValueExists('Open Ducoment After Export') then
      RegKey.WriteBool('Open Ducoment After Export', True);

    cbxOpenAfterExport.Checked := RegKey.ReadBool('Open Ducoment After Export');
  finally
    RegKey.Free;
  end;
end;

procedure TBaseGridFrm.FormShow(Sender: TObject);
begin
  inherited;
  grdMaster.SetFocus;
  viewMaster.Focused := True;
end;

procedure TBaseGridFrm.navMasterButtonsButtonClick(Sender: TObject;
  AButtonIndex: Integer; var ADone: Boolean);
var
  ID, ScriptID: Integer;
  DataSet: TFDMemTable;
  Generatorname, UpdateTableName, FileName: string;
begin
  inherited;
//  // Don't allow printing or exporting data whilst editing data.
//  if (AButtonIndex in [16, 17, 18, 19]) and (navMaster.DataSet.State in [dsEdit, dsInsert]) then
//    raise EExecutionException.Create('Cannot use the print/export functions whilst editing data.' + CRLF +
//      'Please post or cancel the current transaction and try again.');
  case AbuttonIndex of
    16, 17, 18, 19:
      ReportDM.PrintExporting := True;
  end;

  DataSet :=  nil;
  ScriptID := 0;
  ID := 0;
  Screen.Cursor := crHourglass;
  try
    case AButtonIndex of
      NBDI_REFRESH, NBDI_DELETE:
        begin
//        ADone := True;
          case ReportDM.MasterFormType of
            ftActivityType:
              begin
                DataSet := MTDM.cdsActivityType;
                ScriptID := 39;
                FileName := 'C:\Data\Xml\Activity Type.xml';
              end;
            ftAgePeriod:
              begin
                DataSet := MTDM.cdsAgePeriod;
                ScriptID := 13;
                FileName := 'C:\Data\Xml\Age Period.xml';
              end;

            ftBank:
              begin
                DataSet := MTDM.cdsBank;
                ScriptID := 5;
                FileName := 'C:\Data\Xml\Bank.xml';
              end;

            ftBankAccountType:
              begin
                DataSet := MTDM.cdsBankAccountType;
                ScriptID := 39;
                FileName := 'C:\Data\Xml\Bank Account Type.xml';
              end;

            ftContactType:
              begin
                DataSet := MTDM.cdsContactType;
                ScriptID := 11;
                FileName := 'C:\Data\Xml\Contact Type.xml';
              end;

            ftCountry:
              begin
                DataSet := MTDM.cdsCountry;
                ScriptID := 12;
                FileName := 'C:\Data\Xml\Country.xml';
              end;

            ftCustomer:
              begin
                DataSet := MTDM.cdsCustomer;
                ScriptID := 3;
                FileName := 'C:\Data\Xml\Customer.xml';
              end;

            ftCustomerGroup:
              begin
                DataSet := MTDM.cdsCustomerGroup;
                ScriptID := 56;
                FileName := 'C:\Data\Xml\Customer Group.xml';
              end;

            ftCustomerStatus:
              begin
                DataSet := MTDM.cdsCustomerStatus;
                ScriptID := 14;
              end;

            ftCustomerType:
              begin
                DataSet := MTDM.cdsCustomerType;
                ScriptID := 15;
                FileName := 'C:\Data\Xml\Customer Type.xml';
              end;

            ftJobFunction:
              begin
                DataSet := MTDM.cdsJobFunction;
                ScriptID := 19;
                FileName := 'C:\Data\Xml\Job Function.xml';
              end;

            ftMonthOfYear:
              begin
                DataSet := MTDM.cdsMonthOfYear;
                ScriptID := 20;
                FileName := 'C:\Data\Xml\Month of Year.xml';
              end;

            ftPricelist:
              begin
                DataSet := MTDM.cdsPricelist;
                ScriptID := 22;
                FileName := 'C:\Data\Xml\Price List.xml';
              end;

            ftRateUnit:
              begin
                DataSet := MTDM.cdsRateUnit;
                ScriptID := 38;
                FileName := 'C:\Data\Xml\Rate Unit.xml';
              end;

            ftSalutation:
              begin
                DataSet := MTDM.cdsSalutation;
                ScriptID := 23;
                FileName := 'C:\Data\Xml\Salutation.xml';
              end;

            ftStdActivity:
              begin
                DataSet := MTDM.cdsStdActivity;
                ScriptID := 52;
                FileName := 'C:\Data\Xml\Standard Activity.xml';
              end;

            ftTaxoffice:
              begin
                DataSet := MTDM.cdsTaxOffice;
                ScriptID := 25;
                FileName := 'C:\Data\Xml\Tax Office.xml';
              end;

            ftVehicleMake:
              begin
                DataSet := MTDM.cdsVehicleMake;
                ScriptID := 48;
                FileName := 'C:\Data\Xml\Vehicle Make.xml';
              end;
          end;

          case AButtonIndex of
            NBDI_REFRESH:
              begin
                ADone := True;
                GeneratorName := DataSet.UpdateOptions.GeneratorName;
                UpdateTableName := DataSet.UpdateOptions.UpdateTableName;
                ID := DataSet.FieldByName('ID').AsInteger;

                VBBaseDM.GetData(ScriptID, DataSet, DataSet.Name, ONE_SPACE,
                  FileName, Generatorname, UpdateTableName);

                if not DataSet.Locate('ID', ID, []) then
                  DataSet.First;
              end;

            NBDI_DELETE:
              begin
                ADone := True;

                if VBBaseDM.GetUseCount(VBBaseDM.QueryRequest) > 0 then
                  raise EValidateException.Create('The selected: ''' + VBBaseDM.ItemToCount + ''' is already in use in one or more transaction table(s) and cannot be deleted.');

                Beep;
                if DisplayMsg(
                  Application.Title,
                  'Delete Confirmaiton',
                  'Are you sure you want to delete the selected ' + VBBaseDM.ItemToCount + '?' + CRLF + CRLF +
                  'This action cannot be undone!',
                  mtConfirmation,
                  [mbYes, mbNo]
                  ) = mrNo then
                  Exit;

                DataSet.Delete;
              end;
          end;
        end;

      16: ReportDM.ReportAction := raPreview;
      17: ReportDM.ReportAction := raPrint;
      18: ReportDM.ReportAction := raExcel;
      19: ReportDM.ReportAction := raPDF;
    end;

    SetPrintButtonStatus(TFDMemTable(navMaster.DataSet));
  finally
    Screen.Cursor := crDefault;
  end;
end;

procedure TBaseGridFrm.SetButtonVisibility(DataSet: TFDMemTable;  MasterID: Integer);
//var
//  ReadOnly: Boolean;
begin
//  if not DataSet.Locate('ID', MasterID, []) then
//    ReadOnly := False
//  else
//    ReadOnly := DataSet.FieldByName('READ_ONLY').AsInteger = 1;
//
//  navMaster.Buttons[6].Visible := not ReadOnly; // Insert
//  navMaster.Buttons[8].Visible := not ReadOnly; // Delete
//  navMaster.Buttons[10].Visible := not ReadOnly; // Post
//  navMaster.Buttons[11].Visible := not ReadOnly; //  Cancel
//  navMaster.Width := 40;
end;

procedure TBaseGridFrm.SetPrintButtonStatus(DataSet: TFDMemTable);
begin
  navMaster.Buttons[6].Enabled := not (DataSet.State in [dsEdit, dsInsert]);
  navMaster.Buttons[8].Enabled := not (DataSet.State in [dsEdit, dsInsert]);
  navMaster.Buttons[10].Enabled := not (DataSet.State in [dsEdit, dsInsert]);
  navMaster.Buttons[11].Enabled := not (DataSet.State in [dsEdit, dsInsert]);

  // Don't allow printing or exporting data whilst editing data.
  if DataSet.State in [dsEdit, dsInsert] then
    raise EExecutionException.Create('Cannot use the print/export functions whilst editing data.' + CRLF +
      'Please post or cancel the current transaction and try again.');
end;

procedure TBaseGridFrm.viewMasterCustomDrawCell(Sender: TcxCustomGridTableView;
  ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;
  if AViewInfo.GridRecord = nil then
    Exit;

  if AViewInfo.GridRecord.Focused then
  // This renders the background and font colours of the focused record
  begin
    if AViewInfo.Item <> nil then
      if AViewInfo.Item.Focused then
      begin
      // This renders the background and border colour of the focused cell
        ACanvas.Brush.Color := $B6EDFA;
        ACanvas.Font.Color := RootLookAndFeel.SkinPainter.DefaultSelectionColor;
        PostMessage(Handle, CM_DRAWBORDER, Integer(ACanvas), Integer(AViewInfo));
      end;
  end;
end;

end.

