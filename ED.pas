unit ED;

interface

uses
  System.SysUtils, System.Math, System.StrUtils;

const
  RANDOM_CHAR = '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz~!@#$%^&*()_+-={}[]<>,.?/|\';
//  CKEY1 = 537614;
//  CKEY2 = 326185;

type
  TED = class
  public
    constructor Create(Key1, Key2: Integer);
    destructor Destroy; override;
    function ECString(InputStr: string): string;
    function DCString(InputStr: string): string;
  private
//    Key1, Key2: Integer;
    FTheKey1, FTheKey2: Integer;
    function ECStr(InputStr: string): string;
    function DCStr(InputStr: string): string;
    function LPad(SourceString: string; aChar: Char; SLength: Integer): string;
    function AddRandomString(S: string): string;
    function RemoveRandomString(S: string): string;
    function OE(InputStr: string): string;
    function RS(InputStr: string): string;
  end;

implementation

{ TED }

constructor TED.Create(Key1, Key2: Integer);
begin
//  Self.Key1 := Key1;
//  Self.Key2 := Key2;
  FTheKey1 := Key1;
  FTheKey2 := Key2;
end;

destructor TED.Destroy;
begin
//
  inherited;
end;

function TED.ECString(InputStr: string): string;
var
  S: string;
begin
  S := InputStr;
  S := ECStr(S);
  S := AddRandomString(S);
  S := OE(S);
  S := RS(S);
  S := ECStr(S);
  Result := S;
end;

function TED.DCString(InputStr: string): string;
var
  S: string;
begin
  S := InputStr;
  S := DCStr(S);
  S := RS(S);
  S := OE(S);
  S := RemoveRandomString(S);
  S := DCStr(S);
  Result := S;
end;

function TED.ECStr(InputStr: string): string;
var
  I: Integer;
  RStr: RawByteString;
  RStrB: TBytes absolute RStr;
begin
  Result := '';
  RStr := UTF8Encode(InputStr);
  for I := 0 to Length(RStr) - 1 do
  begin
    RStrB[I] := RStrB[I] xor (FTheKey1 shr 8);
//    Key := (RStrB[I] + Key) * Key1 + Key2;
  end;
  for I := 0 to Length(RStr) - 1 do
  begin
    Result := Result + IntToHex(RStrB[I], 2);
  end;
end;

function TED.DCStr(InputStr: string): string;
var
  I{, tmpKey}: Integer;
  RStr: RawByteString;
  RStrB: TBytes absolute RStr;
  tmpStr: string;
begin
  tmpStr := UpperCase(InputStr);
  SetLength(RStr, Length(tmpStr) div 2);
  I := 1;
  try
    while (I < Length(tmpStr)) do
    begin
      RStrB[I div 2] := StrToInt('$' + tmpStr[I] + tmpStr[I + 1]);
      Inc(I, 2);
    end;
  except
    Result := '';
    Exit;
  end;
  for I := 0 to Length(RStr) - 1 do
  begin
    {tmpKey := RStrB[I];}
    RStrB[I] := RStrB[I] xor (FTheKey1 shr 8);
//    Key := (tmpKey + Key) * Self.Key1 + Self.Key2;
  end;
  Result := UTF8ToWideString(RStr);
end;

function TED.AddRandomString(S: string): string;
var
  I, {J,} N, P: Integer;
  RandNumbStr, OutputStr: string;
begin
  Randomize;
  N := RandomRange(6, 12);
  Result := '';

  for I := 0 to N - 1 do
  begin
    P := RandomRange(0, Length(RANDOM_CHAR) - 1);
    OutputStr := OutputStr + RANDOM_CHAR[P];
  end;

  OutputStr := S + OutputStr;
  RandNumbStr := LPad(N.ToString, '0', 2);
  Insert(RandNumbStr, OutputStr, 5);
  Result := OutputStr;
end;

function TED.RemoveRandomString(S: string): string;
var
  InputStr, RandStr: string;
  RandValue: Integer;
begin
  InputStr := S;
  RandStr := AnsiMidStr(InputStr, 5, 2);
  RandValue := StrToInt(RandStr);
  Delete(InputStr, 5, 2);
  RandStr := AnsiLeftStr(InputStr, Length(InputStr) - RandValue);
  Result := RandStr;
end;

function TED.LPad(SourceString: string; aChar: Char; SLength: Integer): string;
var
  I: Integer;
begin
  Result := SourceString;
  if Length(Result) >= SLength then
    Exit;

  for I := Length(SourceString) to SLength - 1 do
    Result := aChar + Result;
end;

function TED.OE(InputStr: string): string;
var
  I, L, NL: Integer;
  //NS: string;
  {TempStr, }LastChar: string;
begin
  L := Length(InputStr);
  NL := L;
  LastChar := InputStr[Length(InputStr)];
  if (L mod 2 <> 0) then
    NL := L - 1;
  Result := '';
  for I := 1 to NL do
  begin
    if ((I mod 2) <> 0) then
    begin
      Result := Result + InputStr[I + 1] + InputStr[I];
    end;
  end;
  if (L mod 2 <> 0) then
    Result := Result + LastChar;
end;

function TED.RS(InputStr: string): string;
var
  I, L: Integer;
begin
  L := Length(InputStr);
  Result := '';
  for I := 1 to L do
  begin
    Result := InputStr[I] + Result;
  end;
end;

end.

