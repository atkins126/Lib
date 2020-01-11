unit Skin;

interface

uses
  // SkinController
  dxSkinsCore, dxSkinsDefaultPainters, cxClasses, cxLookAndFeels, dxSkinsForm,
  // BarManager
  dxBar,
  // LookAndFellList
  dxLayoutLookAndFeels;

type
  TSkin = class
  private
    procedure UpdateApplicationSkin(SkinResourceFileName, SkinName);
  public
    SkinResourceFileName: string;
    SkinName: string;
    SkinController: TdxSkinController;
    BarManager: TdxBarManager;
  end;

implementation

procedure TSkin.UpdateApplicationSkin(SkinController: TdxSkinController; SkinResourceFileName, SkinName);
begin
  skinController.BeginUpdate;
  try
    skinController.NativeStyle := False;
    skinController.UseSkins := True;
    if dxSkinsUserSkinLoadFromFile(SkinResourceFileName, SkinName) then
    begin
      skinController.SkinName := 'UserSkin';
      RootLookAndFeel.SkinName := 'UserSkin';
      barManager.LookAndFeel.SkinName := 'UserSkin';
      lafCustomSkin.LookAndFeel.SkinName := 'UserSkin';
    end
    else
    begin
      skinController.SkinName := DEFAULT_SKIN_NAME;
      RootLookAndFeel.SkinName := DEFAULT_SKIN_NAME;
      barManager.LookAndFeel.SkinName := DEFAULT_SKIN_NAME;
      lafCustomSkin.LookAndFeel.SkinName := DEFAULT_SKIN_NAME;
    end;
  finally
    skinController.Refresh;
    skinController.EndUpdate;
  end;

//  skinController.BeginUpdate;
//  try
//    skinController.NativeStyle := False;
//    skinController.UseSkins := True;
//    if dxSkinsUserSkinLoadFromFile(SkinResourceFileName, SkinName) then
//    begin
//      skinController.SkinName := 'UserSkin';
//      RootLookAndFeel.SkinName := 'UserSkin';
//      barManager.LookAndFeel.SkinName := 'UserSkin';
//      lafCustomSkin.LookAndFeel.SkinName := 'UserSkin';
//    end
//    else
//    begin
//      skinController.SkinName := DEFAULT_SKIN_NAME;
//      RootLookAndFeel.SkinName := DEFAULT_SKIN_NAME;
//      barManager.LookAndFeel.SkinName := DEFAULT_SKIN_NAME;
//      lafCustomSkin.LookAndFeel.SkinName := DEFAULT_SKIN_NAME;
//    end;
//  finally
//    skinController.Refresh;
//    skinController.EndUpdate;
//  end;
end;


end.
