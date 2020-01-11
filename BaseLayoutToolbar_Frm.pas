unit BaseLayoutToolbar_Frm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, BaseLayout_Frm, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, dxSkinsCore, dxSkinsDefaultPainters,
  dxLayoutContainer, dxBar, dxLayoutLookAndFeels, System.Actions, Vcl.ActnList,
  cxContainer, cxEdit, cxClasses, cxStyles, dxLayoutControl, dxPrnDev,
  dxScreenTip, VersionInformation, System.ImageList, Vcl.ImgList, cxImageList,
  dxCustomHint, cxHint, dxPrnDlg;

type
  TBaseLayoutToolbarFrm = class(TBaseLayoutFrm)
    grpToolbar: TdxLayoutGroup;
    docToolbar: TdxBarDockControl;
    litToolbar: TdxLayoutItem;
    barManager: TdxBarManager;
    barToolbar: TdxBar;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  BaseLayoutToolbarFrm: TBaseLayoutToolbarFrm;

implementation

{$R *.dfm}

end.
