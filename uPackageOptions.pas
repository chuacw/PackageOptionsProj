{$WARN SYMBOL_DEPRECATED ON}
{$WARN SYMBOL_LIBRARY ON}
{$WARN SYMBOL_PLATFORM ON}
{$WARN SYMBOL_EXPERIMENTAL ON}
{$WARN UNIT_LIBRARY ON}
{$WARN UNIT_PLATFORM ON}
{$WARN UNIT_DEPRECATED ON}
{$WARN UNIT_EXPERIMENTAL ON}
{$WARN HRESULT_COMPAT ON}
{$WARN HIDING_MEMBER ON}
{$WARN HIDDEN_VIRTUAL ON}
{$WARN GARBAGE OFF}
{$WARN BOUNDS_ERROR ON}
{$WARN ZERO_NIL_COMPAT ON}
{$WARN STRING_CONST_TRUNCED ON}
{$WARN FOR_LOOP_VAR_VARPAR ON}
{$WARN TYPED_CONST_VARPAR ON}
{$WARN ASG_TO_TYPED_CONST ON}
{$WARN CASE_LABEL_RANGE ON}
{$WARN FOR_VARIABLE ON}
{$WARN CONSTRUCTING_ABSTRACT ON}
{$WARN COMPARISON_FALSE ON}
{$WARN COMPARISON_TRUE ON}
{$WARN COMPARING_SIGNED_UNSIGNED ON}
{$WARN COMBINING_SIGNED_UNSIGNED ON}
{$WARN UNSUPPORTED_CONSTRUCT ON}
{$WARN FILE_OPEN ON}
{$WARN FILE_OPEN_UNITSRC ON}
{$WARN BAD_GLOBAL_SYMBOL ON}
{$WARN DUPLICATE_CTOR_DTOR ON}
{$WARN INVALID_DIRECTIVE ON}
{$WARN PACKAGE_NO_LINK ON}
{$WARN PACKAGED_THREADVAR ON}
{$WARN IMPLICIT_IMPORT ON}
{$WARN HPPEMIT_IGNORED ON}
{$WARN NO_RETVAL ON}
{$WARN USE_BEFORE_DEF ON}
{$WARN FOR_LOOP_VAR_UNDEF ON}
{$WARN UNIT_NAME_MISMATCH ON}
{$WARN NO_CFG_FILE_FOUND ON}
{$WARN IMPLICIT_VARIANTS ON}
{$WARN UNICODE_TO_LOCALE ON}
{$WARN LOCALE_TO_UNICODE ON}
{$WARN IMAGEBASE_MULTIPLE ON}
{$WARN SUSPICIOUS_TYPECAST ON}
{$WARN PRIVATE_PROPACCESSOR ON}
{$WARN UNSAFE_TYPE OFF}
{$WARN UNSAFE_CODE OFF}
{$WARN UNSAFE_CAST OFF}
{$WARN OPTION_TRUNCATED ON}
{$WARN WIDECHAR_REDUCED ON}
{$WARN DUPLICATES_IGNORED ON}
{$WARN UNIT_INIT_SEQ ON}
{$WARN LOCAL_PINVOKE ON}
{$WARN MESSAGE_DIRECTIVE ON}
{$WARN TYPEINFO_IMPLICITLY_ADDED ON}
{$WARN RLINK_WARNING ON}
{$WARN IMPLICIT_STRING_CAST ON}
{$WARN IMPLICIT_STRING_CAST_LOSS ON}
{$WARN EXPLICIT_STRING_CAST OFF}
{$WARN EXPLICIT_STRING_CAST_LOSS OFF}
{$WARN CVT_WCHAR_TO_ACHAR ON}
{$WARN CVT_NARROWING_STRING_LOST ON}
{$WARN CVT_ACHAR_TO_WCHAR ON}
{$WARN CVT_WIDENING_STRING_LOST ON}
{$WARN NON_PORTABLE_TYPECAST ON}
{$WARN XML_WHITESPACE_NOT_ALLOWED ON}
{$WARN XML_UNKNOWN_ENTITY ON}
{$WARN XML_INVALID_NAME_START ON}
{$WARN XML_INVALID_NAME ON}
{$WARN XML_EXPECTED_CHARACTER ON}
{$WARN XML_CREF_NO_RESOLVE ON}
{$WARN XML_NO_PARM ON}
{$WARN XML_NO_MATCHING_PARM ON}
{$WARN IMMUTABLE_STRINGS OFF}
{$RANGECHECKS OFF}

unit uPackageOptions;

interface

uses
  System.SysUtils, System.Classes, Winapi.Windows;

type

  TCompilerDirectives = (
    AlignFields,     // A
    BoolEval,        // B
    Assertions,      // C
    DebugInfo,       // D
    OldObjWarn,      // E
    PlaceHolder01,   // F
    ImportedData,    // G
    LongStrings,     // H
    IOChecks,        // I
    WritableConst,   // J
    PlaceHolder02,   // K
    LocalSymbols,    // L
    TypeInfo,        // M
    PlaceHolder03,   // N
    Optimization,    // O
    OpenStrings,     // P
    OverflowChecks,  // Q
    RangeChecks,     // R
    StackChecks,     // S
    TypedAddress,    // T
    SafeDivide,      // U
    VarStringChecks, // V
    StackFrames,     // W
    ExtendedSyntax,  // X
    ReferenceInfo,   // Y  // DefinitionInfo also here?
    MinEnumSize      // Z
  );
  TDebugInfo = (
    None,
    Unknown01,
    Unknown02,
    Unknown03,
    Unknown04
  );

  TToggleRec = record
      case Byte of
        0: (Value: array[0..Ord('Z')-Ord('A')] of Byte);
        1: (Directives: array[TCompilerDirectives] of Byte);
  end;

  TDebugInfoRec = record
      case Byte of
        0: (Value: TDebugInfo);
//        1: (Raw: Int32);
  end;

  TPackageOptionsRec = record
    Version: Byte; // '0' observed all the time
    Toggle: TToggleRec;
    DebugInfo: TDebugInfoRec;
    MinStackSize: Int32;
    MaxStackSize: Int32;
    ResourceReserve: Int32;
    ImageBase: Int32;
  end;

  TPlatformTargets = Int32;

  TPackageOptionsFile = file of TPackageOptionsRec;

  TDirtyFlag = (
    dfNone, dfPackageDescription, dfPackageOptions, dfPlatformTargets,
    lfPackageDescription, lfPackageOptions, lfPlatformTargets
  );
  TDirtyFlags = set of TDirtyFlag;

  TDecodedPlatformTarget = (
    dpfWin32, dpfWin64, dpfOSX32, dpfiOSSimulator32,
    dpfAndroidArm32, dpfLinux32, dpfiOSDevice32, dpfLinux64,
    dpfWinNX32, dpfWinIoT32, dpfiOSDevice64, dpfWinARM32,
    dpfOSX64, dpfLinuxArm32, dpfLinuxArm64, dpfAndroidArm64,
    dpfiOSSimulator64, dpfOSXArm64, dpfWinArm64,
    dpfiOSSimulatorArm64, dpfWin64x
  );
  TDecodedPlatformTargets = set of TDecodedPlatformTarget;

const

  dpfWindows = [dpfWin32, dpfWin64, dpfWinArm64, dpfWin64x];
  dpfOSX = [dpfOSX32, dpfOSX64, dpfOSXArm64];
  dpfiOS = [dpfiOSDevice32, dpfiOSDevice64,
    dpfiOSSimulator32, dpfiOSSimulator64, dpfiOSSimulatorArm64
  ];
  dpfAndroid = [dpfAndroidArm32, dpfAndroidArm64];
  dpfLinux = [dpfLinux64, dpfLinuxArm64];

{$SCOPEDENUMS ON}

type

  TCustomPackageOptions = class
  protected
    const
      INVALID_PLATFORM_TARGET = Int32(0);
    type
      TVersionReadHandlerProc = function (const AStream: TStream; const Data): LongBool of object;
      TVersionWriteHandlerProc = function (const AStream: TStream): LongBool of object;
      TVersionHandlerRec = record
        Version: Byte;
        ReadProc: TVersionReadHandlerProc;
        WriteProc: TVersionWriteHandlerProc;
      end;
  var
    FVersionHandlers: TArray<TVersionHandlerRec>;

    FVersion: Byte;
    FToggle: TToggleRec;
    FDefines, FUnitAliases: TArray<string>;
    FDebugInfo: TDebugInfoRec;
    FMinStackSize, FMaxStackSize, FImageBase, FResourceReserve: Cardinal;
    FDescription, FFileName, FPackageDescription: string;

    FDirtyFlags: TDirtyFlags;
    FPlatformTargets: TPlatformTargets;

    procedure StreamFixup(const AStream: TStream); virtual;

    function GetDefineCount: Integer;
    function GetUnitAliasCount: Integer;
    function GetSymbolCount: Integer;
    function GetSymbols: TArray<string>;

    function GetVersion: Byte; virtual;
    procedure SetVersion(AVersion: Byte); virtual;

    function GetDebugInfo: Boolean;
    procedure SetDebugInfo(AEnableDebugInfo: Boolean);

    function GetDebugInfoValue: TDebugInfo;
    procedure SetDebugInfoValue(AValue: TDebugInfo);

    procedure SetDefines(const AValue: TArray<string>);
    procedure SetDescription(const AValue: string);
    procedure SetPackageDescription(const AValue: string);
    procedure SetUnitAliases(const AValue: TArray<string>);

    function GetToggleValues: TToggleRec;
    procedure SetToggleValues(const AValue: TToggleRec);

    function GetPlatformTargets: TPlatformTargets;
    procedure SetPlatformTargets(const AValue: TPlatformTargets);
    function GetDecodedPlatformTargets: TDecodedPlatformTargets;
    procedure SetDecodedPlatformTargets(const AValue: TDecodedPlatformTargets);

    function ReadAnsiString(const AStream: TStream): AnsiString;
    procedure WriteAnsiString(const AStream: TStream; const AStr: AnsiString);

    function ReadData(const AStream: TStream; const Data; const Size: Cardinal): Cardinal; virtual;
    function LookupVersionReadHandler: TVersionReadHandlerProc; virtual;
    function LookupVersionWriteHandler: TVersionWriteHandlerProc; virtual;

    function DefaultReadDataHandler(const AStream: TStream; const Data): LongBool;
    function DefaultWriteDataHandler(const AStream: TStream): LongBool;

    /// <summary>
    /// Registers a read and write handler, matching a version
    /// If Version matches an existing version, then the handlers are replaced
    /// </summary>
    procedure RegisterDataHandlers(
      const Version: Byte;
      const AReadHandler: TVersionReadHandlerProc;
      const AWriteHandler: TVersionWriteHandlerProc
    );

    function UpdatePlatformTargets(AResHandle: THandle): BOOL;
  public
    constructor Create(const AFileName: string = '');

    procedure Clear;
    procedure Clone(const Src: TCustomPackageOptions); virtual;

    // Read package options from a .bpl file
    function ReadFromFile(const AFileName: string = ''): Boolean; virtual;

    // Write package options to a .bpl file
    function WriteToFile(const AFileName: string = ''): Boolean; virtual;

    function WritePlatformTargetsToFile(const AFileName: string = ''): Boolean; virtual;

    procedure AddDefines(const ADefine: string);
    procedure ClearDefines;

    procedure AddUnitAlias(const AName, Alias: string);
    procedure ClearUnitAliases;

    // Read a specific symbol by index
    function ReadSymbol(Index: Integer; out SymbolType: string; out SymbolValue: string): Boolean;

    // Properties
    property Description: string read FDescription write SetDescription;
    property DefineCount: Integer read GetDefineCount;
    property Defines: TArray<string> read FDefines write SetDefines;
    property DebugInfo: Boolean read GetDebugInfo write SetDebugInfo;
    property DebugInfoValue: TDebugInfo read GetDebugInfoValue write SetDebugInfoValue;
    property ImageBase: Cardinal read FImageBase write FImageBase;
    property MinStackSize: Cardinal read FMinStackSize write FMinStackSize;
    property MaxStackSize: Cardinal read FMaxStackSize write FMaxStackSize;

    property PackageDescription: string read FPackageDescription write
      SetPackageDescription;

    property ResourceReserve: Cardinal read FResourceReserve write FResourceReserve;
    property SymbolCount: Integer read GetSymbolCount;
    property Symbols: TArray<string> read GetSymbols;
    property ToggleValues: TToggleRec read GetToggleValues write SetToggleValues;
    property UnitAliases: TArray<string> read FUnitAliases write SetUnitAliases;
    property UnitAliasCount: Integer read GetUnitAliasCount;
    property Version: Byte read GetVersion write SetVersion;

    property DecodedPlatformTargets: TDecodedPlatformTargets
      read GetDecodedPlatformTargets write SetDecodedPlatformTargets;
    /// <summary>
    /// 32-bit value of various pidXXXX platforms in System.Classes
    /// eg,
    /// The value 0x100003 corresponds to pidWin32 or pidWin64 or pidWin64x.
    /// PLATFORMTARGETS RCDATA {0x1AB793L} corresponds to
    /// Win32+Win64+AndroidArm32+Linux64+WinNX32+WinIoT32+iOSDevice64+OSX64+LinuxArm32+AndroidArm64+OSXArm64+iOSSimulatorArm64+Win64x
    /// </summary>
    property PlatformTargets: TPlatformTargets read GetPlatformTargets write SetPlatformTargets;
  end;

  /// <summary>
  /// Handles '0' version for PACKAGEOPTIONS
  /// </summary>
  TV0PackageOptions = class(TCustomPackageOptions)
  protected
    /// <summary>
    /// This is the V0 handler that reads the necessary data from the given Data
    /// <param name="Data"> The untyped var to read the data from </param>
    /// <param name="AStream"> The stream to read other data </param>
    /// </summary>
    function V0ReadDataHandler(const AStream: TStream; const Data): LongBool;

    /// <summary>
    /// This is the V0 handler that writes the necessary data to the given AStream
    /// <param name="AStream"> The stream to write the data to </param>
    /// </summary>
    function V0WriteDataHandler(const AStream: TStream): LongBool;
  public
    constructor Create;
    procedure Clone(const Src: TCustomPackageOptions); override;
  end;


// V1 should probably look something like this...
//  /// <summary>
//  /// Handles '1' version for PACKAGEOPTIONS
//  /// </summary>
//  TV1PackageOptions = class(TV0PackageOptions)
//  protected
//    /// <summary>
//    /// This is the V1 handler that reads the necessary data from the given Data
//    /// <param name="Data"> The untyped var to read the data from </param>
//    /// <param name="AStream"> The stream to read other data </param>
//    /// </summary>
//    function V1ReadDataHandler(const AStream: TStream; const Data): LongBool;
//
//    /// <summary>
//    /// This is the V1 handler that writes the necessary data to the given AStream
//    /// <param name="AStream"> The stream to write the data to </param>
//    /// </summary>
//    function V1WriteDataHandler(const AStream: TStream): LongBool;
//  public
//    constructor Create;
//    /// customize how Clone reads data differently from the inherited Clone
//    procedure Clone(const Src: TCustomPackageOptions); override;
//  end;
// constructor TV1PackageOptions.Create;
// begin
//   inherited Create;
//   ...
//   RegisterDataHandlers(Ord('1'), V1ReadDataHandler, V1WriteDataHandler);
// end;
implementation

uses
  System.StrUtils, System.Types;

const
  PACKAGEOPTIONS_NAME = 'PACKAGEOPTIONS';
  PLATFORMTARGETS_NAME = 'PLATFORMTARGETS';
  PACKAGEDESCRIPTION_NAME = 'DESCRIPTION';

// Other RT_RC... types are in Winapi.Windows

{ TCustomPackageOptions }

constructor TCustomPackageOptions.Create(const AFileName: string = '');
begin
  inherited Create;
  Clear;
  FFileName := AFileName;
end;

function TCustomPackageOptions.GetDefineCount: Integer;
begin
  Result := Length(FDefines);
end;

function TCustomPackageOptions.GetUnitAliasCount: Integer;
begin
  Result := Length(FUnitAliases);
end;

function TCustomPackageOptions.GetSymbolCount: Integer;
begin
  Result := GetDefineCount + GetUnitAliasCount;
end;

function TCustomPackageOptions.GetSymbols: TArray<string>;
begin
  Result := FDefines + FUnitAliases;
end;

function TCustomPackageOptions.ReadFromFile(const AFileName: string = ''): Boolean;
type
  PInt32 = ^Int32;
var
  Stream: TMemoryStream;
  hModule: System.HMODULE;
  hResPackageDescription,
  hResPackageOptions, hResPlatformTargets: HRSRC;
  hGlobal: System.HGLOBAL;
  pData: PByte;
  DataSize: Cardinal;
  PackageOptionsRec: TPackageOptionsRec;
  LFileName: string;
begin
  Result := False;
  LFileName := if AFileName <> '' then AFileName else FFileName;
  hModule := LoadLibraryEx(PChar(LFileName), 0, LOAD_LIBRARY_AS_DATAFILE);
  if hModule = 0 then
    Exit;

  try
    hResPackageDescription := FindResource(hModule, PACKAGEDESCRIPTION_NAME, RT_RCDATA);
    hResPackageOptions := FindResource(hModule, PACKAGEOPTIONS_NAME, RT_RCDATA);
    hResPlatformTargets := FindResource(hModule, PLATFORMTARGETS_NAME, RT_RCDATA);

    if hResPackageDescription <> 0 then
      begin
        hGlobal := LoadResource(hModule, hResPackageDescription);
        if hGlobal <> 0 then
          begin
            pData := LockResource(hGlobal);
            DataSize := if pData <> nil then SizeOfResource(hModule, hResPackageDescription) else 0;
            if DataSize <> 0 then
              begin
                FPackageDescription := StrPas(PChar(pData));
                Include(FDirtyFlags, TDirtyFlag.lfPackageDescription);
              end;
          end;
      end;

    if hresPlatformTargets <> 0 then
      begin
        hGlobal := LoadResource(hModule, hResPlatformTargets);
        if hGlobal <> 0 then
          begin
            pData := LockResource(hGlobal);
            DataSize := if pData <> nil then SizeofResource(hModule, hResPlatformTargets) else 0;
            if DataSize = SizeOf(Int32) then
              begin
                FPlatformTargets := PInt32(pData)^;
                Exclude(FDirtyFlags, TDirtyFlag.dfPlatformTargets);
                Include(FDirtyFlags, TDirtyFlag.lfPlatformTargets);
              end;
          end;
      end;

    if hResPackageOptions = 0 then
      Exit;

    hGlobal := LoadResource(hModule, hResPackageOptions);
    if hGlobal = 0 then
      Exit;

    pData := LockResource(hGlobal);
    if pData = nil then
      Exit;

    DataSize := SizeofResource(hModule, hResPackageOptions);
    if DataSize = 0 then
      Exit;

    Stream := TMemoryStream.Create;
    try
      Stream.WriteBuffer(pData^, DataSize);
      Stream.Position := 0;

      // Read format:
      // Byte: Version
      // 26 bytes: compiler options
      // DWord: Debug info flag
      // DWord: Min stack size
      // DWord: Max stack size
      // DWord: Image base
      // DWord: Resource reserve
      // DWord: Define count
      // For each define: DWord length + string data
      // DWord: Alias count
      // For each alias: DWord length + string data

      ReadData(Stream, PackageOptionsRec, SizeOf(PackageOptionsRec));
      FVersion := PackageOptionsRec.Version;

      var LReadHandler := LookupVersionReadHandler;

      Result := LReadHandler(Stream, PackageOptionsRec);
      Exclude(FDirtyFlags, TDirtyFlag.dfPackageOptions);
      Include(FDirtyFlags, TDirtyFlag.lfPackageOptions);
    finally
      Stream.Free;
    end;
  finally
    FreeLibrary(hModule);
  end;
end;

procedure TCustomPackageOptions.AddDefines(const ADefine: string);
begin
  var LSeparator := if Length(FDefines) > 0 then ';' else '';
  FDefines := FDefines + [LSeparator + ADefine];
  Include(FDirtyFlags, dfPackageOptions);
end;

procedure TCustomPackageOptions.Clear;
begin
  FFileName := '';
  FDirtyFlags := [];
  FDefines := nil;
  FUnitAliases := nil;
  FMinStackSize := $4000;
  FMaxStackSize := $100000;
  FImageBase := $400000;
  FResourceReserve := 0;
  FPlatformTargets := INVALID_PLATFORM_TARGET;
end;

procedure TCustomPackageOptions.ClearDefines;
begin
  FDefines := nil;
  Include(FDirtyFlags, dfPackageOptions);
end;

procedure TCustomPackageOptions.AddUnitAlias(const AName, Alias: string);
begin
  var LSeparator := if Length(FUnitAliases) > 0 then ';' else '';
  FUnitAliases := FUnitAliases + [ AName + '=' + Alias];
  Include(FDirtyFlags, dfPackageOptions);
end;

procedure TCustomPackageOptions.ClearUnitAliases;
begin
  FUnitAliases := nil;
  Include(FDirtyFlags, dfPackageOptions);
end;

procedure TCustomPackageOptions.Clone(const Src: TCustomPackageOptions);
begin
end;

function TCustomPackageOptions.WriteToFile(const AFileName: string): Boolean;
var
  LMS: TMemoryStream;
  LResHandle: THandle;
  LDiscardUpdate: LongBool;
  LFileName: string;
begin
  // True = remove existing
  LFileName := if AFileName <> '' then AFileName else FFileName;
  LResHandle := BeginUpdateResource(PChar(LFileName), False);
  if LResHandle = 0 then
    Exit(False);
  LDiscardUpdate := True;
  try
    if (dfPackageOptions in FDirtyFlags) then
      LMS := TMemoryStream.Create else
      LMS := nil;
    try
      var LDataWritten: LongBool := False;
      if (dfPackageOptions in FDirtyFlags) then
        begin
          LMS.Size := 4096; // Set initial size of 4K
          var LWriteHandler := LookupVersionWriteHandler;
          LDataWritten := LWriteHandler(LMS);
        end;

      if LDataWritten and (dfPackageOptions in FDirtyFlags) then
        begin
          StreamFixup(LMS);

          var LUpdated := UpdateResource(
            LResHandle, RT_RCDATA, PACKAGEOPTIONS_NAME,
            MakeLangID(0, 0),
            LMS.Memory,
            LMS.Size
          );
          if LUpdated then
            begin
              LDiscardUpdate := False;
              Exclude(FDirtyFlags, TDirtyFlag.dfPackageOptions);
              Include(FDirtyFlags, TDirtyFlag.lfPackageOptions);
            end;
        end;
      if dfPackageDescription in FDirtyFlags then
        begin
          var LUpdated := UpdateResource(LResHandle, RT_RCDATA,
            PACKAGEDESCRIPTION_NAME, MakeLangID(0, 0),
            PChar(FPackageDescription),
            Length(FPackageDescription) * SizeOf(Char)
          );
          if LUpdated then
            begin
              LDiscardUpdate := False;
              Exclude(FDirtyFlags, TDirtyFlag.dfPackageDescription);
              Include(FDirtyFlags, TDirtyFlag.lfPackageDescription);
            end;
        end;
      if dfPlatformTargets in FDirtyFlags then
        begin
          var LUpdated := UpdatePlatformTargets(LResHandle);
          if LUpdated then
            begin
              LDiscardUpdate := False;
              Exclude(FDirtyFlags, TDirtyFlag.dfPlatformTargets);
              Include(FDirtyFlags, TDirtyFlag.lfPlatformTargets);
            end;
        end;
    finally
      LMS.Free;
    end;
  finally
    Result := EndUpdateResource(LResHandle, LDiscardUpdate); // False = Update file
  end;
end;

function TCustomPackageOptions.WritePlatformTargetsToFile(const AFileName: string): Boolean;
var
  LResHandle: THandle;
  LFileName: string;
begin
  LFileName := if AFileName <> '' then AFileName else FFileName;
  LResHandle := BeginUpdateResource(PChar(LFileName), False);
  if LResHandle = 0 then
    Exit(False);
  try
    var LUpdated := UpdatePlatformTargets(LResHandle);
    if LUpdated then
      begin
        Exclude(FDirtyFlags, TDirtyFlag.dfPlatformTargets);
        Include(FDirtyFlags, TDirtyFlag.lfPlatformTargets);
      end;
  finally
    Result := EndUpdateResource(LResHandle, False); // False = Update file
  end;
end;

function TCustomPackageOptions.ReadSymbol(Index: Integer; out SymbolType, SymbolValue: string): Boolean;
begin
  Result := False;

  if Index < 0 then
    Exit;

  if Index < Length(FDefines) then
  begin
    SymbolType := 'DEFINE';
    SymbolValue := FDefines[Index];
    Result := True;
  end else
  if Index < Length(FDefines) + Length(FUnitAliases) then
  begin
    SymbolType := 'UNITALIAS';
    SymbolValue := FUnitAliases[Index - Length(FDefines)];
    Result := True;
  end;
end;

function TCustomPackageOptions.GetVersion: Byte;
begin
  Result := FVersion - Ord('0');
end;

procedure TCustomPackageOptions.SetVersion(AVersion: Byte);
begin
  Assert(AVersion <= 1, 'Version cannot be higher than 1');
  FVersion := AVersion + Ord('0');
end;

procedure TCustomPackageOptions.StreamFixup(const AStream: TStream);
var
  Zeros: array[0..3] of Byte;
  LPadCount: Cardinal;
begin
  // Pad to multiples of 4 bytes... weird things happen
  // in UpdateResource if the memory stream is not a multiple of 4.
  AStream.Size := AStream.Position;
  LPadCount := (-AStream.Size) and 3;
  FillChar(Zeros, LPadCount, 0);
  AStream.Write(Zeros[0], LPadCount);
end;

function TCustomPackageOptions.UpdatePlatformTargets(AResHandle: THandle): BOOL;
begin
  Result := UpdateResource(
    AResHandle, RT_RCDATA, PLATFORMTARGETS_NAME,
    MakeLangID(LANG_ENGLISH, SUBLANG_ENGLISH_US),  // English, United States
    @FPlatformTargets,
    SizeOf(FPlatformTargets)
  );
end;

function TCustomPackageOptions.GetDebugInfo: Boolean;
begin
  Result := FDebugInfo.Value <> TDebugInfo.None;
end;

procedure TCustomPackageOptions.SetDebugInfo(AEnableDebugInfo: Boolean);
begin
  FDebugInfo.Value := TDebugInfo.Unknown01;
end;

function TCustomPackageOptions.GetDebugInfoValue: TDebugInfo;
begin
  Result := FDebugInfo.Value;
end;

procedure TCustomPackageOptions.SetDebugInfoValue(AValue: TDebugInfo);
begin
  FDebugInfo.Value := AValue;
end;

function TCustomPackageOptions.GetToggleValues: TToggleRec;
begin
  Result := FToggle;
end;

procedure TCustomPackageOptions.SetToggleValues(const AValue: TToggleRec);
begin
  FToggle := AValue;
end;

procedure TCustomPackageOptions.SetUnitAliases(const AValue: TArray<string>);
begin
  if FUnitAliases <> AValue then
    begin
      FUnitAliases := AValue;
      Include(FDirtyFlags, dfPackageOptions);
    end;
end;

function TCustomPackageOptions.GetPlatformTargets: TPlatformTargets;
begin
  if TDirtyFlag.lfPackageOptions in FDirtyFlags then
    Result := FPlatformTargets else
    Result := 0;
end;

procedure TCustomPackageOptions.SetPackageDescription(const AValue: string);
begin
  if FPackageDescription <> AValue then
    begin
      FPackageDescription := AValue;
      Include(FDirtyFlags, TDirtyFlag.dfPackageDescription);
    end;
end;

procedure TCustomPackageOptions.SetPlatformTargets(const AValue: TPlatformTargets);
begin
  if FPlatformTargets <> AValue then
    begin
      FPlatformTargets := AValue;
      Include(FDirtyFlags, TDirtyFlag.dfPlatformTargets);
    end;
end;

function TCustomPackageOptions.GetDecodedPlatformTargets: TDecodedPlatformTargets;
begin
  Result := TDecodedPlatformTargets(FPlatformTargets);
end;

procedure TCustomPackageOptions.SetDecodedPlatformTargets(const AValue: TDecodedPlatformTargets);
begin
  if TDecodedPlatformTargets(FPlatformTargets) <> AValue then
    begin
      TDecodedPlatformTargets(FPlatformTargets) := AValue;
      Include(FDirtyFlags, dfPlatformTargets);
    end;
end;

procedure TCustomPackageOptions.SetDefines(const AValue: TArray<string>);
begin
  if FDefines <> AValue then
    begin
      FDefines := AValue;
      Include(FDirtyFlags, dfPackageOptions);
    end;
end;

procedure TCustomPackageOptions.SetDescription(const AValue: string);
begin
  if FDescription <> AValue then
    begin
      FDescription := AValue;
      Include(FDirtyFlags, dfPackageOptions);
    end;
end;

function TCustomPackageOptions.ReadAnsiString(const AStream: TStream): AnsiString;
var
  B: Byte;
begin
  AStream.Read(B, SizeOf(Byte));
  if B > 0 then
    begin
      SetLength(Result, B);
      AStream.Read(Result[Low(Result)], B);
    end else
    begin
      Result := '';
    end;
end;

procedure TCustomPackageOptions.WriteAnsiString(const AStream: TStream; const AStr: AnsiString);
var
  Len: Cardinal;
  B: Byte;
begin
  Len := Length(AStr);
  Assert(Len <= High(Byte));
  B := Len;
  AStream.Write(B, SizeOf(B));
  AStream.Write(AStr[Low(AStr)], B);
end;

function TCustomPackageOptions.ReadData(const AStream: TStream; const Data; const Size: Cardinal): Cardinal;
begin
  Result := AStream.Read(PByte(@Data)^, Size);
end;

function TCustomPackageOptions.LookupVersionReadHandler: TVersionReadHandlerProc;
begin
  for var I := Low(FVersionHandlers) to High(FVersionHandlers) do
    if FVersionHandlers[I].Version = FVersion then
      begin
        Result := FVersionHandlers[I].ReadProc;
        Exit;
      end;
  if Length(FVersionHandlers) > 0 then
    Result := FVersionHandlers[0].ReadProc else
    Result := DefaultReadDataHandler;
end;

function TCustomPackageOptions.LookupVersionWriteHandler: TVersionWriteHandlerProc;
begin
  for var I := Low(FVersionHandlers) to High(FVersionHandlers) do
    if FVersionHandlers[I].Version = FVersion then
      begin
        Result := FVersionHandlers[I].WriteProc;
        Exit;
      end;
  if Length(FVersionHandlers) > 0 then
    Result := FVersionHandlers[0].WriteProc else
    Result := DefaultWriteDataHandler;
end;

procedure TCustomPackageOptions.RegisterDataHandlers(
  const Version: Byte;
  const AReadHandler: TVersionReadHandlerProc;
  const AWriteHandler: TVersionWriteHandlerProc
);
label ReplaceHandler;
var
  Index: Integer;
begin
  for var I := Low(FVersionHandlers) to High(FVersionHandlers) do
    if FVersionHandlers[I].Version = Version then
       begin
         Index := I;
         goto ReplaceHandler;
       end;
  SetLength(FVersionHandlers, Length(FVersionHandlers) + 1);
  Index := High(FVersionHandlers);
  FVersionHandlers[Index].Version := Version;
ReplaceHandler:
  FVersionHandlers[Index].ReadProc := AReadHandler;
  FVersionHandlers[Index].WriteProc := AWriteHandler;
// For matching against a Clone, if ReadFromFile wasn't called
  FVersion := Version;
end;

function TCustomPackageOptions.DefaultReadDataHandler(const AStream: TStream; const Data): LongBool;
begin
  Result := False;
end;

function TCustomPackageOptions.DefaultWriteDataHandler(const AStream: TStream): LongBool;
begin
  Result := False;
end;

{ TV0PackageOptions }

procedure TV0PackageOptions.Clone(const Src: TCustomPackageOptions);
var
  PackageOptionsRec: TPackageOptionsRec;
begin
  var LWriteHandler: TVersionWriteHandlerProc := Src.LookupVersionWriteHandler();
  var LStream := TMemoryStream.Create;
  try
    LWriteHandler(LStream);
    LStream.Position := 0;

    ReadData(LStream, PackageOptionsRec, SizeOf(PackageOptionsRec));
    FVersion := PackageOptionsRec.Version;
    var LReadHandler := LookupVersionReadHandler;
    LReadHandler(LStream, LStream.Memory^);
  finally
    LStream.Free;
  end;
end;

constructor TV0PackageOptions.Create;
begin
  inherited Create;
  RegisterDataHandlers(Ord('0'), V0ReadDataHandler, V0WriteDataHandler);
end;

function TV0PackageOptions.V0ReadDataHandler(const AStream: TStream; const Data): LongBool;
var
  LDefines, LUnitAliases: AnsiString;
begin
  try
    FToggle := TPackageOptionsRec(Data).Toggle;
    FDebugInfo := TPackageOptionsRec(Data).DebugInfo;
    FMinStackSize := TPackageOptionsRec(Data).MinStackSize;
    FMaxStackSize := TPackageOptionsRec(Data).MaxStackSize;
    FResourceReserve := TPackageOptionsRec(Data).ResourceReserve;
    FImageBase := TPackageOptionsRec(Data).ImageBase;

    LDefines := ReadAnsiString(AStream);
    FDefines := SplitString(string(LDefines), ';');
    while (Length(FDefines) > 0) and (FDefines[High(FDefines)] = '') do
      Delete(FDefines, High(FDefines), 1);

    LUnitAliases := ReadAnsiString(AStream);
    if Length(LUnitAliases) > 0 then
      begin
        FUnitAliases := SplitString(string(LUnitAliases), ';');
        while (Length(FUnitAliases) > 0) and (FUnitAliases[High(FUnitAliases)] = '') do
          Delete(FUnitAliases, High(FUnitAliases), 1);
      end;

    FDescription := string(ReadAnsiString(AStream));
    Result := True;
  except
    Result := False;
  end;
end;

function TV0PackageOptions.V0WriteDataHandler(const AStream: TStream): LongBool;
var
  LW: string;
  LDefines, LUnitAliases, LDescription: AnsiString;
begin
  try
    AStream.Write(FVersion, SizeOf(FVersion));
    AStream.Write(FToggle, SizeOf(FToggle));
    AStream.Write(FDebugInfo, SizeOf(FDebugInfo));
    AStream.Write(FMinStackSize, SizeOf(FMinStackSize));
    AStream.Write(FMaxStackSize, SizeOf(FMaxStackSize));
    AStream.Write(FResourceReserve, SizeOf(FResourceReserve));
    AStream.Write(FImageBase, SizeOf(FImageBase));

    if Length(FDefines) > 0 then
      begin
        LW := String.Join(';', FDefines);
        LDefines := AnsiString(LW);
      end;
    WriteAnsiString(AStream, LDefines);

    if Length(FUnitAliases) > 0 then
      begin
        LW := String.Join(';', FUnitAliases);
        LUnitAliases := AnsiString(LW);
      end;
    WriteAnsiString(AStream, LUnitAliases);

    LDescription := AnsiString(FDescription);
    WriteAnsiString(AStream, LDescription);
    Result := True;
  except
    Result := False;
  end;
end;

end.




















































































































































































// chuacw,
// 5 Oct 2025,
// Singapore, Singapore
