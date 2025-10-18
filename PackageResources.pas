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
{$OVERFLOWCHECKS OFF}

unit PackageResources;

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

  TCustomPackageResources = class
  public
    const
      DefaultLangID = Word(LANG_NEUTRAL shl 10) or SUBLANG_NEUTRAL;
      NeutralLangID = DefaultLangID;
  protected
    const
      INVALID_PLATFORM_TARGET = Int32(0);
    type
      TLangProc = function (dwFlags: DWORD; pulNumLanguages: PULONG;
        pwszLanguagesBuffer: PWideChar; pcchLanguagesBuffer: PULONG): BOOL; stdcall;
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
    FDefaultSystemLangID: Integer;

    procedure StreamFixup(const AStream: TStream); virtual;

    function GetDefaultSystemLangID: Word;

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
    /// <param name="Version"> The version to handle read/write, starts with Ord('0') </param>
    /// <param name="AReadHandler"> The read handler to handle the specified version  </param>
    /// <param name="AWriteHandler"> The write handler to handle the specified version </param>
    procedure RegisterDataHandlers(
      const Version: Byte;
      const AReadHandler: TVersionReadHandlerProc;
      const AWriteHandler: TVersionWriteHandlerProc
    );

    /// <summary>
    /// Updates the specified resource module with the value stored in FPlatformTargets
    /// </summary>
    /// <param name="AResHandle"> The resource module to update the new platform targets </param>
    /// <returns>True if updated successfully, false otherwise </returns>
    function UpdatePlatformTargets(AResHandle: THandle): BOOL;

    function GetPreferredUILanguages(const ALangProc: TLangProc): TArray<Word>;
    // See https://learn.microsoft.com/en-us/windows/win32/intl/language-identifiers

    function PrimaryLang(ALangID: Word): Word; inline;
    function SubLangID(ALangID: Word): Word; inline;
  public
    /// <summary>
    /// </summary>
    /// <param name="AFileName"> The name of the resource file to manipulate </param>
    constructor Create(const AFileName: string);

    procedure Clear;

    /// <summary>
    /// Clones the data in Src into Self. By default, this does nothing.
    /// </summary>
    /// <param name="Src"> The source to clone data from </param>
    procedure Clone(const Src: TCustomPackageResources); virtual;

    /// <summary>
    /// Deletes the following default package resources:
    /// package options,
    /// platform targets,
    /// description,
    /// package info,
    /// version info
    /// </summary>
    /// <returns> True if all resources deleted successfully, false if some
    /// resources failed to delete successfully </returns>
    function DeleteDefaultPackageResource: LongBool;

    /// <summary>
    /// To delete a resource, specify the resource type and its resource name, eg
    /// DeleteResource(LFileName, RT_VERSION, MakeIntResource(1));
    /// </summary>
    /// <param name="AResourceType"> The type of the resource to delete </param>
    /// <param name="AResourceName"> The name of the resource to delete </param>
    /// <returns> True if deleted, False otherwise </returns>
    function DeleteResource(AResourceType: PChar; const AResourceName: string): LongBool; overload; inline;

    /// <summary>
    /// To delete a resource, specify the resource type and its resource name, eg
    /// DeleteResource(LFileName, RT_VERSION, MakeIntResource(1));
    /// </summary>
    /// <param name="AResourceType"> The type of the resource to delete </param>
    /// <param name="AResourceName"> The name of the resource to delete </param>
    /// <returns> True if deleted, False otherwise </returns>
    function DeleteResource(AResourceType: PChar; const AResourceName: PChar): LongBool; overload;

    /// <summary>
    /// Duplicates the given resource specified with the given type, given name and given language id
    /// with a new language ID
    /// </summary>
    /// <param name="AResourceType">
    /// The type of the resource to copy
    /// </param>
    /// <param name="AResourceName">
    /// The name of the resource to copy
    /// </param>
    /// <param name="DestLangID">
    /// The target language id to copy to
    /// </param>
    /// <param name="SourceLangID">
    /// The language id of the resource to copy. Copies the 1st language ID (if using DefaultLangID)
    /// </param>
    /// <returns>
    /// True if resource has been duplicated successfully, false otherwise
    /// </returns>
    function DuplicateResource(AResourceType, AResourceName: PChar;
      DestLangID: Word; SourceLangID: Word = DefaultLangID): LongBool; overload;

    /// <summary>
    /// Duplicates the given resource specified with the given type, given name and given language id
    /// with a new language ID
    /// </summary>
    /// <param name="AResourceType">
    /// The type of the resource to copy
    /// </param>
    /// <param name="AResourceName">
    /// The name of the resource to copy
    /// </param>
    /// <param name="DestLangID">
    /// The target language id to copy to
    /// </param>
    /// <param name="SourceLangID">
    /// The language id of the resource to copy. Copies the 1st language ID (if using DefaultLangID)
    /// </param>
    /// <returns>
    /// True if resource has been duplicated successfully, false otherwise
    /// </returns>
    function DuplicateResource(const AResourceType: string; const AResourceName: string;
      DestLangID: Word; SourceLangID: Word = DefaultLangID): LongBool; overload;

    /// <summary>
    /// Checks if a resource exists with the specified resource type, name and LangID
    /// </summary>
    /// <param name="AResourceType"> The name of the resource to check </param>
    /// <param name="AResourceName"> The type of the resource to check </param>
    /// <param name="LangID"> The lang id of the resource to check </param>
    /// <returns>
    /// True if the resource exists
    /// </returns>
    function ExistsResource(AResourceType: PChar; const AResourceName: PChar; LangID: Word = DefaultLangID): LongBool;

    function GetSystemPreferredUILanguages: TArray<Word>;
    function GetThreadPreferredUILanguages: TArray<Word>;
    function GetUserPreferredUILanguages: TArray<Word>;

    /// <summary>
    /// Gets the LangID for the given resource
    /// </summary>
    /// <param name="AModuleHandle"> The module handle to get the LangID from </param>
    /// <param name="AResourceType"> The type of the resource to get the LangID from </param>
    /// <param name="AResourceName"> The name of the resource to get the LangID from </param>
    /// <param name="DefaultLangID"> If there is nothing found, return DefaultLangID as the result </param>
    /// <returns> array of LangID for the resource </returns>
    function GetResourceLangIDs(AModuleHandle: THandle;
      AResourceType: PChar; const AResourceName: string; DefaultLangID: Word = DefaultLangID): TArray<Word>; overload;

    /// <summary>
    /// Gets the LangID for the given resource
    /// </summary>
    /// <param name="AModuleHandle"> The module handle to get the LangID from </param>
    /// <param name="AResourceType"> The type of the resource to get the LangID from </param>
    /// <param name="AResourceName"> The name of the resource to get the LangID from </param>
    /// <param name="DefaultLangID"> If there is nothing found, return DefaultLangID as the result </param>
    /// <returns> array of LangID for the resource </returns>
    function GetResourceLangIDs(AModuleHandle: THandle;
      AResourceType: PChar; AResourceName: PChar; DefaultLangID: Word = DefaultLangID): TArray<Word>; overload;

    /// <summary>
    /// </summary>
    /// <param name="AFileName"> Optional parameter to get resource names from. If empty, uses the
    /// FileName provided during construction.
    /// </param>
    /// <returns>
    /// An array of resource names
    /// </returns>
    function GetResourceNames(const AFileName: string = ''): TArray<string>;

    /// <summary>
    /// Read package options from a .bpl file
    /// </summary>
    /// <param name="AFileName">
    /// </param>
    /// <returns>
    /// </returns>
    function ReadFromFile(const AFileName: string = ''): Boolean; virtual;

    /// <summary>
    /// Write package options to a .bpl file
    /// </summary>
    /// <param name="AFileName">
    /// </param>
    /// <returns>
    /// </returns>
    function WriteToFile(const AFileName: string = ''): Boolean; virtual;

    function WritePlatformTargetsToFile(const AFileName: string = ''): Boolean; virtual;

    procedure AddDefines(const ADefine: string);
    procedure ClearDefines;

    procedure AddUnitAlias(const AName, Alias: string);
    procedure ClearUnitAliases;

    /// <summary>
    /// Read a specific symbol by index
    /// </summary>
    /// <param name="Index">
    /// </param>
    /// <param name="SymbolType">
    /// </param>
    /// <param name="SymbolValue">
    /// </param>
    /// <returns>
    /// </returns>
    function ReadSymbol(Index: Integer; out SymbolType: string; out SymbolValue: string): Boolean;

    // Properties
    property Description: string read FDescription write SetDescription;
    property DefineCount: Integer read GetDefineCount;
    property Defines: TArray<string> read FDefines write SetDefines;
    property DebugInfo: Boolean read GetDebugInfo write SetDebugInfo;
    property DebugInfoValue: TDebugInfo read GetDebugInfoValue write SetDebugInfoValue;
    property DefaultSystemLangID: Word read GetDefaultSystemLangID;
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
  TV0PackageResources = class(TCustomPackageResources)
  protected
    /// <summary>
    /// This is the V0 handler that reads the necessary data from the given Data
    /// </summary>
    /// <param name="AStream"> The stream to read other data </param>
    /// <param name="Data"> The untyped var to read the data from </param>
    /// <returns> True if data has been read successfully, false otherwise
    /// </returns>
    /// <remarks>
    /// </remarks>
    function V0ReadDataHandler(const AStream: TStream; const Data): LongBool;

    /// <summary>
    /// This is the V0 handler that writes the necessary data to the given AStream
    /// </summary>
    /// <param name="AStream"> The stream to write the data to </param>
    /// <returns> True if data has been written successfully, false otherwise
    /// </returns>
    /// <remarks>
    /// </remarks>
    function V0WriteDataHandler(const AStream: TStream): LongBool;
  public
    /// <summary> Creates an instance of TV0PackageResources using the given AFileName
    /// </summary>
    /// <param name="AFileName">
    /// </param>
    /// <remarks>
    /// </remarks>
    constructor Create(const AFileName: string);

    /// <summary> Clones the data in Src into self </summary>
    /// <param name="Src"> The data to clone Src from </param>
    procedure Clone(const Src: TCustomPackageResources); override;
  end;


// V1 should probably look something like this...
//  /// <summary>
//  /// Handles '1' version for PACKAGEOPTIONS
//  /// </summary>
//  TV1PackageResources = class(TV0PackageResources)
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
//    procedure Clone(const Src: TCustomPackageResources); override;
//  end;
// constructor TV1PackageOptions.Create;
// begin
//   inherited Create;
//   ...
//   RegisterDataHandlers(Ord('1'), V1ReadDataHandler, V1WriteDataHandler);
// end;

const
  PACKAGEOPTIONS_NAME: string     = 'PACKAGEOPTIONS';
  PLATFORMTARGETS_NAME: string    = 'PLATFORMTARGETS';
  PACKAGEDESCRIPTION_NAME: string = 'DESCRIPTION';
  PACKAGEINFO_NAME: string        = 'PACKAGEINFO';

implementation

uses
  System.StrUtils, System.Types, System.Generics.Collections,
  System.Generics.Defaults;

const
  RESOURCE_ENUM_LN = $1 {1};
  {$EXTERNALSYM RESOURCE_ENUM_LN}
  RESOURCE_ENUM_MUI = $2 {2};
  {$EXTERNALSYM RESOURCE_ENUM_MUI}
  RESOURCE_ENUM_MUI_SYSTEM = $4 {4};
  {$EXTERNALSYM RESOURCE_ENUM_MUI_SYSTEM}
  RESOURCE_ENUM_VALIDATE = $8 {8};
  {$EXTERNALSYM RESOURCE_ENUM_VALIDATE}
  RESOURCE_ENUM_MODULE_EXACT = $10 {16};
  {$EXTERNALSYM RESOURCE_ENUM_MODULE_EXACT}

type
  PWSTR = PChar;

  ENUMRESNAMEPROCW = function (hModule: HMODULE; lpType: PWSTR; lpName: PWSTR; lParam: IntPtr): BOOL; stdcall;
  {$EXTERNALSYM ENUMRESNAMEPROCW}

function EnumResourceNamesEx(hModule: HMODULE;
  lpType: PWSTR; lpEnumFunc: ENUMRESNAMEPROCW; lParam: IntPtr;
  dwFlags: Cardinal; LangId: Word): BOOL; stdcall; external 'KERNEL32.dll' name 'EnumResourceNamesExW';

// Other RT_RC... types are in Winapi.Windows

{ TCustomPackageResources }

constructor TCustomPackageResources.Create(const AFileName: string);
begin
  inherited Create;
  Clear;
  FDefaultSystemLangID := -1;
  Assert(AFileName <> '');
  FFileName := AFileName;
end;

function TCustomPackageResources.GetDefaultSystemLangID: Word;
begin
  if FDefaultSystemLangID = -1 then
    FDefaultSystemLangID := GetSystemDefaultUILanguage;
  Result := FDefaultSystemLangID;
end;

function TCustomPackageResources.GetDefineCount: Integer;
begin
  Result := Length(FDefines);
end;

function TCustomPackageResources.GetUnitAliasCount: Integer;
begin
  Result := Length(FUnitAliases);
end;

function TCustomPackageResources.GetUserPreferredUILanguages: TArray<Word>;
begin
  Result := GetPreferredUILanguages(Winapi.Windows.GetUserPreferredUILanguages);
end;

function TCustomPackageResources.GetSymbolCount: Integer;
begin
  Result := GetDefineCount + GetUnitAliasCount;
end;

function TCustomPackageResources.GetSymbols: TArray<string>;
begin
  Result := FDefines + FUnitAliases;
end;

function TCustomPackageResources.GetSystemPreferredUILanguages: TArray<Word>;
begin
  Result := GetPreferredUILanguages(Winapi.Windows.GetSystemPreferredUILanguages);
end;

function TCustomPackageResources.GetPreferredUILanguages(const ALangProc: TLangProc): TArray<Word>;
begin
  var LNumLanguages: ULONG := 0; var SizeOfBuffer: ULONG := 0;
  ALangProc(
    MUI_LANGUAGE_ID or MUI_MACHINE_LANGUAGE_SETTINGS,
    @LNumLanguages, nil, @SizeOfBuffer
  );
  if LNumLanguages = 0 then
    Exit;
  var LangIDs: string; SetLength(LangIDs, LNumLanguages*4);
  ALangProc(
    MUI_LANGUAGE_ID or MUI_MACHINE_LANGUAGE_SETTINGS,
    @LNumLanguages, PChar(LangIDs), @SizeOfBuffer
  );
  for var I := 0 to LNumLanguages-1 do
    begin
      var LBase := (I*4)+Cardinal(Low(string)); var Value: string := '$xxxx';
      var P: PChar := @Value[Low(string)+1];
      for var J := LBase to LBase+3 do
        begin
          P^ := LangIDs[J];
          Inc(P);
        end;
      SetLength(Result, Length(Result) + 1);
      Result[High(Result)] := StrToInt(Value);
    end;
end;

function TCustomPackageResources.ReadFromFile(const AFileName: string = ''): Boolean;
type
  PInt32 = ^Int32;
var
  LStream: TMemoryStream;
  LModule: System.HModule;
  LResPackageDescription,
  LResPackageOptions, LResPlatformTargets: HRSRC;
  LGlobal: System.HGlobal;
  LData: PByte;
  LDataSize: Cardinal;
  LPackageOptionsRec: TPackageOptionsRec;
  LFileName: string;
begin
  Result := False;
  LFileName := if AFileName <> '' then AFileName else FFileName;
  LModule := LoadLibraryEx(PChar(LFileName), 0, LOAD_LIBRARY_AS_DATAFILE);
  if LModule = 0 then
    Exit;

  try
    LResPackageDescription := FindResource(LModule, PChar(PACKAGEDESCRIPTION_NAME), RT_RCDATA);
    LResPackageOptions := FindResource(LModule, PChar(PACKAGEOPTIONS_NAME), RT_RCDATA);
    LResPlatformTargets := FindResource(LModule, PChar(PLATFORMTARGETS_NAME), RT_RCDATA);

    if LResPackageDescription <> 0 then
      begin
        LGlobal := LoadResource(LModule, LResPackageDescription);
        if LGlobal <> 0 then
          begin
            LData := LockResource(LGlobal);
            LDataSize := if LData <> nil then SizeOfResource(LModule, LResPackageDescription) else 0;
            if LDataSize <> 0 then
              begin
                FPackageDescription := StrPas(PChar(LData));
                Include(FDirtyFlags, TDirtyFlag.lfPackageDescription);
              end;
          end;
      end;

    if LResPlatformTargets <> 0 then
      begin
        LGlobal := LoadResource(LModule, LResPlatformTargets);
        if LGlobal <> 0 then
          begin
            LData := LockResource(LGlobal);
            LDataSize := if LData <> nil then SizeofResource(LModule, LResPlatformTargets) else 0;
            if LDataSize = SizeOf(Int32) then
              begin
                FPlatformTargets := PInt32(LData)^;
                Exclude(FDirtyFlags, TDirtyFlag.dfPlatformTargets);
                Include(FDirtyFlags, TDirtyFlag.lfPlatformTargets);
              end;
          end;
      end;

    if LResPackageOptions = 0 then
      Exit;

    LGlobal := LoadResource(LModule, LResPackageOptions);
    if LGlobal = 0 then
      Exit;

    LData := LockResource(LGlobal);
    if LData = nil then
      Exit;

    LDataSize := SizeofResource(LModule, LResPackageOptions);
    if LDataSize = 0 then
      Exit;

    LStream := TMemoryStream.Create;
    try
      LStream.WriteBuffer(LData^, LDataSize);
      LStream.Position := 0;

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

      ReadData(LStream, LPackageOptionsRec, SizeOf(LPackageOptionsRec));
      FVersion := LPackageOptionsRec.Version;

      var LReadHandler := LookupVersionReadHandler();

      Result := LReadHandler(LStream, LPackageOptionsRec);
      Exclude(FDirtyFlags, TDirtyFlag.dfPackageOptions);
      Include(FDirtyFlags, TDirtyFlag.lfPackageOptions);
    finally
      LStream.Free;
    end;
  finally
    FreeLibrary(LModule);
  end;
end;

procedure TCustomPackageResources.AddDefines(const ADefine: string);
begin
  var LSeparator := if Length(FDefines) > 0 then ';' else '';
  FDefines := FDefines + [LSeparator + ADefine];
  Include(FDirtyFlags, dfPackageOptions);
end;

procedure TCustomPackageResources.Clear;
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

procedure TCustomPackageResources.ClearDefines;
begin
  FDefines := nil;
  Include(FDirtyFlags, dfPackageOptions);
end;

procedure TCustomPackageResources.AddUnitAlias(const AName, Alias: string);
begin
  var LSeparator := if Length(FUnitAliases) > 0 then ';' else '';
  FUnitAliases := FUnitAliases + [ AName + '=' + Alias];
  Include(FDirtyFlags, dfPackageOptions);
end;

procedure TCustomPackageResources.ClearUnitAliases;
begin
  FUnitAliases := nil;
  Include(FDirtyFlags, dfPackageOptions);
end;

procedure TCustomPackageResources.Clone(const Src: TCustomPackageResources);
begin
end;

function EnumResourceNamesProc(Module: HMODULE; lpszType, lpszName: PChar; Data: LPARAM): BOOL; stdcall;
type
  TResult = TArray<string>;
  PResult = ^TResult;
begin
  Result := True;
  SetLength(PResult(Data)^, Length(PResult(Data)^) + 1);
  PResult(Data)^[High(PResult(Data)^)] := StrPas(lpszName);
end;

function TCustomPackageResources.DeleteDefaultPackageResource: LongBool;
begin
  var LPackageDescriptionDeleted := DeleteResource(RT_RCDATA, PACKAGEOPTIONS_NAME);
  var LPackageInfoDeleted        := DeleteResource(RT_RCDATA, PACKAGEINFO_NAME);
  var LPackageOptionsDeleted     := DeleteResource(RT_RCDATA, PACKAGEOPTIONS_NAME);
  var LPlatformTargetsDeleted    := DeleteResource(RT_RCDATA, PLATFORMTARGETS_NAME);
  var LVersionResourceDeleted    := DeleteResource(RT_VERSION, MakeIntResource(1));
  Result := LPackageDescriptionDeleted and LPackageInfoDeleted and
    LPackageOptionsDeleted and LPlatformTargetsDeleted and LVersionResourceDeleted;
end;

function TCustomPackageResources.DeleteResource(
  AResourceType: PChar; const AResourceName: string): LongBool;
begin
  Result := DeleteResource(AResourceType, PChar(AResourceName));
end;

function TCustomPackageResources.DeleteResource(
  AResourceType: PChar; const AResourceName: PChar): LongBool;
var
  LFileName: string;
  LResHandle: THandle;
  LangID: Word;
begin
  Result := False;
  LangID := GetDefaultSystemLangID;
  LFileName := FFileName;
  LResHandle := BeginUpdateResource(PChar(LFileName), False);
  if LResHandle = 0 then
    Exit(False);
  var LDiscardUpdate: BOOL := False;
  try
    var hModule := LoadLibraryEx(PChar(LFileName), 0, LOAD_LIBRARY_AS_DATAFILE);
    var LangIDs: TArray<WORD>;
    try
      LangIDs := GetResourceLangIDs(hModule, AResourceType, AResourceName);
      if Length(LangIDs) > 0 then
        LangID := LangIDs[0];
    finally
      FreeLibrary(hModule);
    end;
    var LSuccess: LongBool := False;
    LSuccess := LSuccess or UpdateResource(LResHandle, AResourceType, AResourceName,
      LangID, nil, 0);
    if not LSuccess then
      begin
        LDiscardUpdate := True;
        Result := False;
        Exit;
      end;
    LDiscardUpdate := False;
  finally
    if not LDiscardUpdate then
      Result := EndUpdateResource(LResHandle, LDiscardUpdate);
  end;
end;

function EnumResourceLanguagesProc(hModule: HMODULE; lpType: PWSTR; lpName: PWSTR; wLanguage: Word; lParam: IntPtr): BOOL; stdcall;
type
  TResult = TArray<Word>;
  PResult = ^TResult;
begin
  Result := True;
  PResult(lParam)^ := PResult(lParam)^ + [wLanguage];
end;

function TCustomPackageResources.DuplicateResource(const AResourceType,
  AResourceName: string; DestLangID, SourceLangID: Word): LongBool;
begin
  Result := DuplicateResource(PChar(AResourceType), PChar(AResourceName), DestLangID, SourceLangID);
end;

function TCustomPackageResources.DuplicateResource(AResourceType,
  AResourceName: PChar; DestLangID, SourceLangID: Word): LongBool;
begin
  var hModule := LoadLibraryEx(PChar(FFileName), 0, LOAD_LIBRARY_AS_DATAFILE);
  if hModule = 0 then
    Exit(False);
  try
    var LLangIDs: TArray<Word>;
    EnumResourceLanguages(hModule, AResourceType, AResourceName, @EnumResourceLanguagesProc, IntPtr(@LLangIDs));
    var LIndex: NativeInt;
    if SourceLangID = DefaultLangID then
      begin
        LIndex := TArray.IndexOf<Word>(LLangIDs, DefaultSystemLangID);
      end else
      begin
        LIndex := TArray.IndexOf<Word>(LLangIDs, SourceLangID);
      end;
    Assert(LIndex >= 0);
    var LangID := LLangIDs[LIndex];
    var LFoundHandle := FindResourceEx(hModule, AResourceType, AResourceName, LangID);
    var LLoadedResource := LoadResource(hModule, LFoundHandle);
    var LData := LockResource(LLoadedResource);
    var LSize := SizeofResource(hModule, LFoundHandle);
    var LResHandle := BeginUpdateResource(PChar(FFileName), False);
    var LDiscardUpdate: LongBool := True;
    try
      var LUpdated := UpdateResource(LResHandle, AResourceType, AResourceName, DestLangID, LData, LSize);
      LDiscardUpdate := not LUpdated;
      Result := True;
    finally
      EndUpdateResource(LResHandle, LDiscardUpdate);
    end;
  finally
    FreeLibrary(hModule);
  end;
end;

function EnumResourceNamesExProc(hModule: HMODULE; lpType: PWSTR; lpName: PWSTR; lParam: IntPtr): BOOL; stdcall;
begin
  Result := False; // False: stop enumeration, true: continue
  PLongBool(lParam)^ := True;
end;

function TCustomPackageResources.ExistsResource(AResourceType: PChar; const AResourceName: PChar; LangID: Word): LongBool;
var
  LLangIDs: TArray<Word>;
begin
  var hModule := LoadLibraryEx(PChar(FFileName), 0, LOAD_LIBRARY_AS_DATAFILE);
  try
    LLangIDs := [];
    EnumResourceLanguages(hModule, AResourceType, AResourceName, @EnumResourceLanguagesProc, IntPtr(@LLangIDs));
    var LIndex: NativeInt;
    if LangID = DefaultLangID then
      begin
        LIndex := TArray.IndexOf<Word>(LLangIDs, DefaultSystemLangID);
      end else
      begin
        LIndex := TArray.IndexOf<Word>(LLangIDs, LangID);
      end;
    Result := LIndex <> -1;
  finally
    FreeLibrary(hModule);
  end;
end;

function EnumLangsProc(hModule: HMODULE; lpszType, lpszName: PWideChar; wLanguage: WORD; lParam: LPARAM): BOOL; stdcall;
type
  TResult = TArray<Word>;
  PResult = ^TResult;
begin
  // Save the language ID to the variable (assuming only one language desired)
  PResult(lParam)^ := PResult(lParam)^ + [wLanguage];
  // Return FALSE to stop enumeration after first match
  Result := True;
end;

function TCustomPackageResources.GetResourceLangIDs(AModuleHandle: THandle;
  AResourceType: PChar; const AResourceName: string; DefaultLangID: Word): TArray<Word>;
begin
  Result := GetResourceLangIDs(AModuleHandle, AResourceType, PChar(AResourceName), DefaultLangID);
end;

function TCustomPackageResources.GetResourceLangIDs(AModuleHandle: THandle;
  AResourceType: PChar; AResourceName: PChar; DefaultLangID: Word): TArray<Word>;
begin
  Result := [];
  if not EnumResourceLanguages(AModuleHandle, AResourceType, AResourceName, @EnumLangsProc, LPARAM(@Result)) then
    begin
      Result := [DefaultLangID];
    end;
end;

function TCustomPackageResources.GetResourceNames(const AFileName: string = ''): TArray<string>;
var
  LFileName: string;
  hModule: THandle;
begin
  Result := nil;
  LFileName := if AFileName <> '' then AFileName else FFileName;
  hModule := LoadLibraryEx(PChar(LFileName), 0, LOAD_LIBRARY_AS_DATAFILE);
  if hModule = 0 then
    Exit;
  try
    EnumResourceNames(hModule, RT_RCDATA, @EnumResourceNamesProc, LPARAM(@Result));
  finally
    FreeLibrary(hModule);
  end;
end;

function TCustomPackageResources.WriteToFile(const AFileName: string): Boolean;
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
          var LWriteHandler := LookupVersionWriteHandler();
          LDataWritten := LWriteHandler(LMS);
        end;

      if LDataWritten and (dfPackageOptions in FDirtyFlags) then
        begin
          StreamFixup(LMS);

          var LUpdated := UpdateResource(
            LResHandle, RT_RCDATA, PChar(PACKAGEOPTIONS_NAME),
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
            PChar(PACKAGEDESCRIPTION_NAME), MakeLangID(0, 0),
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

function TCustomPackageResources.WritePlatformTargetsToFile(const AFileName: string): Boolean;
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

function TCustomPackageResources.ReadSymbol(Index: Integer; out SymbolType, SymbolValue: string): Boolean;
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

function TCustomPackageResources.GetVersion: Byte;
begin
  Result := FVersion - Ord('0');
end;

procedure TCustomPackageResources.SetVersion(AVersion: Byte);
begin
  Assert(AVersion <= 1, 'Version cannot be higher than 1');
  FVersion := AVersion + Ord('0');
end;

procedure TCustomPackageResources.StreamFixup(const AStream: TStream);
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

function TCustomPackageResources.SubLangID(ALangID: Word): Word;
begin
  Result := Winapi.Windows.SubLangID(ALangID);
end;

function TCustomPackageResources.UpdatePlatformTargets(AResHandle: THandle): BOOL;
begin
  Result := UpdateResource(
    AResHandle, RT_RCDATA, PChar(PLATFORMTARGETS_NAME),
    MakeLangID(LANG_ENGLISH, SUBLANG_ENGLISH_US),  // English, United States
    @FPlatformTargets,
    SizeOf(FPlatformTargets)
  );
end;

function TCustomPackageResources.GetDebugInfo: Boolean;
begin
  Result := FDebugInfo.Value <> TDebugInfo.None;
end;

procedure TCustomPackageResources.SetDebugInfo(AEnableDebugInfo: Boolean);
begin
  FDebugInfo.Value := TDebugInfo.Unknown01;
end;

function TCustomPackageResources.GetDebugInfoValue: TDebugInfo;
begin
  Result := FDebugInfo.Value;
end;

procedure TCustomPackageResources.SetDebugInfoValue(AValue: TDebugInfo);
begin
  FDebugInfo.Value := AValue;
end;

function TCustomPackageResources.GetThreadPreferredUILanguages: TArray<Word>;
begin
  Result := GetPreferredUILanguages(Winapi.Windows.GetThreadPreferredUILanguages);
end;

function TCustomPackageResources.GetToggleValues: TToggleRec;
begin
  Result := FToggle;
end;

procedure TCustomPackageResources.SetToggleValues(const AValue: TToggleRec);
begin
  FToggle := AValue;
end;

procedure TCustomPackageResources.SetUnitAliases(const AValue: TArray<string>);
begin
  if FUnitAliases <> AValue then
    begin
      FUnitAliases := AValue;
      Include(FDirtyFlags, dfPackageOptions);
    end;
end;

function TCustomPackageResources.GetPlatformTargets: TPlatformTargets;
begin
  if TDirtyFlag.lfPackageOptions in FDirtyFlags then
    Result := FPlatformTargets else
    Result := 0;
end;

procedure TCustomPackageResources.SetPackageDescription(const AValue: string);
begin
  if FPackageDescription <> AValue then
    begin
      FPackageDescription := AValue;
      Include(FDirtyFlags, TDirtyFlag.dfPackageDescription);
    end;
end;

procedure TCustomPackageResources.SetPlatformTargets(const AValue: TPlatformTargets);
begin
  if FPlatformTargets <> AValue then
    begin
      FPlatformTargets := AValue;
      Include(FDirtyFlags, TDirtyFlag.dfPlatformTargets);
    end;
end;

function TCustomPackageResources.GetDecodedPlatformTargets: TDecodedPlatformTargets;
begin
  Result := TDecodedPlatformTargets(FPlatformTargets);
end;

procedure TCustomPackageResources.SetDecodedPlatformTargets(const AValue: TDecodedPlatformTargets);
begin
  if TDecodedPlatformTargets(FPlatformTargets) <> AValue then
    begin
      TDecodedPlatformTargets(FPlatformTargets) := AValue;
      Include(FDirtyFlags, dfPlatformTargets);
    end;
end;

procedure TCustomPackageResources.SetDefines(const AValue: TArray<string>);
begin
  if FDefines <> AValue then
    begin
      FDefines := AValue;
      Include(FDirtyFlags, dfPackageOptions);
    end;
end;

procedure TCustomPackageResources.SetDescription(const AValue: string);
begin
  if FDescription <> AValue then
    begin
      FDescription := AValue;
      Include(FDirtyFlags, dfPackageOptions);
    end;
end;

function TCustomPackageResources.ReadAnsiString(const AStream: TStream): AnsiString;
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

procedure TCustomPackageResources.WriteAnsiString(const AStream: TStream; const AStr: AnsiString);
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

function TCustomPackageResources.ReadData(const AStream: TStream; const Data; const Size: Cardinal): Cardinal;
begin
  Result := AStream.Read(PByte(@Data)^, Size);
end;

function TCustomPackageResources.LookupVersionReadHandler: TVersionReadHandlerProc;
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

function TCustomPackageResources.LookupVersionWriteHandler: TVersionWriteHandlerProc;
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

function TCustomPackageResources.PrimaryLang(ALangID: Word): Word;
begin
  Result := Winapi.Windows.PRIMARYLANGID(ALangID);
end;

procedure TCustomPackageResources.RegisterDataHandlers(
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

function TCustomPackageResources.DefaultReadDataHandler(const AStream: TStream; const Data): LongBool;
begin
  Result := False;
end;

function TCustomPackageResources.DefaultWriteDataHandler(const AStream: TStream): LongBool;
begin
  Result := False;
end;

{ TV0PackageResources }

procedure TV0PackageResources.Clone(const Src: TCustomPackageResources);
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
    var LReadHandler := LookupVersionReadHandler();
    LReadHandler(LStream, LStream.Memory^);
  finally
    LStream.Free;
  end;
end;

constructor TV0PackageResources.Create(const AFileName: string);
begin
  inherited;
  RegisterDataHandlers(Ord('0'), V0ReadDataHandler, V0WriteDataHandler);
end;

function TV0PackageResources.V0ReadDataHandler(const AStream: TStream; const Data): LongBool;
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

function TV0PackageResources.V0WriteDataHandler(const AStream: TStream): LongBool;
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
