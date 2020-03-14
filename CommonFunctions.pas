unit CommonFunctions;

interface

uses
  System.UItypes, System.SysUtils, Vcl.Forms, Winapi.Windows, Vcl.Dialogs,
  WinApi.Messages,

  MsgDialog_Frm;

function DisplayMsg(FormCaption, MainCaption, Msg: string;
  DlgType: TMsgDlgType; Buttons: TMsgDlgButtons): Integer;

procedure SendTheMessage(Msg, Param1: Cardinal; param2: Integer);
function SendMessageToApp(AppTitle, Msg: string): Boolean;

implementation

function DisplayMsg(FormCaption, MainCaption, Msg: string;
  DlgType: TMsgDlgType; Buttons: TMsgDlgButtons): Integer;
begin
  try
    Screen.Cursor := crHourglass;

    if MsgDialogFrm = nil then
      MsgDialogFrm := TMsgDialogFrm.Create(nil);

    MsgDialogFrm.FFormCaption := FormCaption;
    MsgDialogFrm.FMainCaption := MainCaption;
    MsgDialogFrm.FMsg := Msg;
    MsgDialogFrm.FButtons := Buttons;
    MsgDialogFrm.FMsgType := DlgType;
    Result := MsgDialogFrm.ShowModal;
  finally
//    FreeAndNil(MsgDialogFrm);
  end;
end;

procedure SendTheMessage(Msg, Param1: Cardinal; param2: Integer);
var
  AppHandle: HWND;
begin
//  AppHandle := FindWindow(nil, PChar(Application.Title));
  AppHandle := FindWindow(nil, PChar('VB Shell'));
//  ShowMessage(PChar(Application.Title));
  SendMessage(AppHandle, Msg, Param1, param2);
end;

function SendMessageToApp(AppTitle, Msg: string): Boolean;
var
  DataStructure: TCopyDataStruct;
  RecipientHandle: THandle;
begin
  DataStructure.dwData := 0;
  // Integer(cdtString); //use it to identify the message contents
  DataStructure.cbData := (1 + Length(Msg)) * SizeOf(Char);
  DataStructure.lpData := PChar(Msg);
//  SendWinMsg(DataStructure);
  RecipientHandle := FindWindow(nil, PChar(AppTitle));
//  RecipientHandle := FindWindow(nil, PChar('VB Shell'));
  Result := RecipientHandle <> 0;
  if Result then
//    SendMessage(RecipientHandle, WM_COPYDATA, Integer(Application.Handle), Integer(@DataStructure));
    SendMessage(RecipientHandle, WM_COPYDATA, Integer(Application.MainForm.Handle), Integer(@DataStructure));
end;

end.

