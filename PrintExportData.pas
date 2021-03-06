unit VBPrintExportData;

interface

uses
  System.SysUtils, System.Win.Registry, WinApi.Windows, System.IOUtils,
  Vcl.Dialogs, Vcl.Controls, WinApi.ShellApi,

  CommonValues,

  frxClass, frxDBSet,

  cxGrid, dxPrnDlg, cxGridExportLink,

{$IFDEF VB}
  VBProxyClass,
{$ENDIF}
  FireDAC.Comp.Client;

type
  TVBPrintExportData = class
  private
    FSourceDataSet: TFDMemTable;
    FTargetDataSet: TFDMemTable;
    FReport: TfrxReport;
    FReportDataSet: TfrxDBDataset;
    FReportTypeName: string;
    FReportFileName: string;
    FReportAction: TReportActions;
    FPrintDlg: TdxPrintDialog;
    FSaveDlg: TFileSaveDialog;
    FExportFileName: string;

    FMsgDlg: TTaskDialog;
    FGrid: TcxGrid;
    FOpenAfterExport: Boolean;
  public
//    constructor Create(SourceDataSet: TFDMemTable;
//      TargetDataSet: TFDMemTable;
//      Report: TfrxReport;
//      ReportDataSet: TfrxDBDataset;
//      ReportTypeName: string;
//      ReportFileName: string;
//      ReportAction: TReportActions);

    constructor Create;
    destructor Destroy; override;
    procedure PrintPreview;
    procedure ExportToExcel;
    procedure ExportToPDF;

    property SourceDataSet: TFDMemTable read FSourceDataSet write FSourceDataSet;
    property TargetDataSet: TFDMemTable read FTargetDataSet write FTargetDataSet;
    property Report: TfrxReport read FReport write FReport;
    property ReportDataSet: TfrxDBDataset read FReportDataSet write FReportDataSet;
    property ReportTypeName: string read FReportTypeName write FReportTypeName;
    property ReportFileName: string read FReportFileName write FReportFileName;
    property ReportAction: TReportActions read FReportAction write FReportAction;
    property ExportFileName: string read FExportFileName write FExportFileName;
    property Grid: TcxGrid read FGrid write FGrid;
    property OpenAfterExport: Boolean read FOpenAfterExport write FOpenAfterExport;
  end;

implementation

{ TVBPrintExportData }

{ TVBPrintExportData }

constructor TVBPrintExportData.Create;
begin
  FSourceDataSet := nil;
  FTargetDataSet := nil;
  FReport := nil;
  FReportDataSet := nil;
  FReportTypeName := '';
  FReportFileName := '';
  FReportAction := raPreview;
  FPrintDlg := TdxPrintDialog.Create(nil);
  FSaveDlg := TFileSaveDialog.Create(nil);

//  FSourceDataSet := SourceDataSet;
//  FTargetDataSet := TargetDataSet;
//  FReport := Report;
//  FReportDataSet := ReportDataSet;
//  FReportTypeName := ReportTypeName;
//  FReportFileName := ReportFileName;
//  FReportAction := ReportAction;
//  FPrintDlg := TdxPrintDialog.Create(nil);
end;

destructor TVBPrintExportData.Destroy;
begin
  FPrintDlg.Free;
  FSaveDlg.Free;
  inherited;
end;

procedure TVBPrintExportData.ExportToExcel;
var
  DestFolder: string;
  FileSaved: Boolean;
  RepFileName: string;
//  ProgressDialog: TExcelExportProgressFrm;
begin
  inherited;
  DestFolder := ExtractFilePath(FExportFileName);
  TDirectory.CreateDirectory(DestFolder);
  FSaveDlg.DefaultExtension := 'xlsx';
  FSaveDlg.DefaultFolder := DestFolder;
  FSaveDlg.FileName := ExtractFileName(FExportFilename);
  FileSaved := FSaveDlg.Execute;

  if not FileSaved then
    Exit;

//  UseLatestCommonDialogs := True;

  if TFile.Exists(FSaveDlg.FileName) then
    try
      FMsgDlg := TTaskDialog.Create(nil);
      FMsgDlg.Caption := 'VB Applications';
      FMsgDlg.Title := 'File Overwrite';
      FMsgDlg.Text :=
        'The file ' + FSaveDlg.FileName + ' already exists.' + CRLF +
        'Do you want to overwrite this file?';
      FMsgDlg.MainIcon := tdiInformation;
      FMsgDlg.DefaultButton := tcbYes;
      FMsgDlg.CommonButtons := [tcbYes, tcbNo];

      if FMsgDlg.Execute then
        if FMsgDlg.ModalResult = mrNo then
          Exit;
    finally
      FMsgDlg.Free;
    end;

  ExportFileName := FSaveDlg.FileName;
  ExportGridToXLSX(
    ExportFileName, // Filename to export
    FGrid, // Grid whose data must be exported
    True, // Expand groups
    True, // Save all records (Selected and un-selected ones)
    True, // Use native format
    'xlsx');

  if FOpenAfterExport then
    ShellExecute(0, 'open', PChar('Excel.exe'), PChar('"' + ExportFileName + '"'), nil, SW_SHOWNORMAL)
end;

procedure TVBPrintExportData.ExportToPDF;
begin
//
end;

procedure TVBPrintExportData.PrintPreview;
begin
  TargetDataSet.Close;
  TargetDataSet.Data := SourceDataSet.Data;
  FReportDataSet.DataSet := TargetDataSet;
  Report.DataSets.Clear;
  Report.DataSets.Add(FReportDataSet);
  Report.LoadFromFile(ReportFileName, False);
  TfrxMemoView(Report.FindObject('lblReportTypeName')).Text := ReportTypeName;

  case FReportAction of
    raPreview, raPrint: // Preview & Print
      begin
        if FReport.PrepareReport then
          if ReportAction = raPreview then
            FReport.ShowPreparedReport
          else
          begin
            if FPrintDlg.Execute then
            begin
              FReport.PrintOptions.Copies :=
                FPrintDlg.DialogData.Copies;

              FReport.Print;
            end;
          end;
      end;
  end;
end;

end.

