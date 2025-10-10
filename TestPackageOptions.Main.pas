unit TestPackageOptions.Main;

{$RANGECHECKS OFF}

interface

uses
  DUnitX.TestFramework, uPackageOptions;

type
  [TestFixture]
  TTestPackageOptionsObj = class
  protected
    FPackageOptionsReader: TV0PackageOptions;
  public
    [Setup]
    procedure Setup;

    [TearDown]
    procedure TearDown;

    [Test]
    procedure TestDefineCount;

    [Test]
    procedure TestDefines;

    [Test]
    procedure TestDescription;

    [Test]
    procedure TestUnitAliasCount;

    [Test]
    procedure TestUnitAliases;

    [Test]
    procedure TestVersion;

    [Test]
    procedure TestDebugInfo;

    [Test]
    procedure TestPlatformTargets;

//    property Description: string
//    property DefineCount: Integer
//    property UnitAliasCount: Integer
//    property SymbolCount: Integer
//    property Defines: TArray<string>
//    property UnitAliases: TArray<string>
//    property DebugInfo: Boolean
//    property MinStackSize: Cardinal
//    property MaxStackSize: Cardinal
//    property ImageBase: Cardinal
//    property ResourceReserve: Cardinal

  end;

  [TestFixture]
  TTestPackageOptionsWriterObj = class
  protected
    FPackageOptionsWriter: TV0PackageOptions;
  public
    [Setup]
    procedure Setup;
    [TearDown]
    procedure TearDown;

    [Test]
    procedure TestWrite;
  end;

implementation

uses
  System.SysUtils, System.IOUtils, System.Classes;

procedure TTestPackageOptionsObj.Setup;
begin
  FPackageOptionsReader := TV0PackageOptions.Create;
  FPackageOptionsReader.ReadFromFile('C:\Users\Public\Documents\Embarcadero\Studio\37.0\Bpl\Package1.bpl');
end;

procedure TTestPackageOptionsObj.TearDown;
begin
  FreeAndNil(FPackageOptionsReader);
end;

procedure TTestPackageOptionsObj.TestVersion;
begin
  Assert.AreEqual<Byte>(FPackageOptionsReader.Version, 0);
end;

//procedure TTestPackageOptionsObj.Test2(const AValue1: Integer; const AValue2 : Integer);
//begin
//end;

procedure TTestPackageOptionsObj.TestDebugInfo;
begin
  Assert.AreEqual(True, FPackageOptionsReader.DebugInfo);
end;

procedure TTestPackageOptionsObj.TestDefineCount;
begin
  Assert.AreEqual<Integer>(FPackageOptionsReader.DefineCount, 3);
end;

procedure TTestPackageOptionsObj.TestDefines;
begin
  var LDefines := FPackageOptionsReader.Defines;
  var LExpDefines: TArray<string> := ['TEST', 'LAST', 'DEBUG'];
  Assert.AreEqual<string>(LExpDefines, LDefines);
end;

procedure TTestPackageOptionsObj.TestDescription;
begin
  Assert.AreEqual<string>('This is the package description', FPackageOptionsReader.Description);
end;

procedure TTestPackageOptionsObj.TestPlatformTargets;
begin
  FPackageOptionsReader.PlatformTargets := pidWin32;
  Assert.AreEqual(FPackageOptionsReader.DecodedPlatformTargets = [TDecodedPlatformTarget.dpfWin32], True);
  FPackageOptionsReader.PlatformTargets := pidWin32 or pidWin64 or pidWin64x;
  Assert.AreEqual(FPackageOptionsReader.DecodedPlatformTargets =
    [TDecodedPlatformTarget.dpfWin32, TDecodedPlatformTarget.dpfWin64,
     TDecodedPlatformTarget.dpfWin64x
    ], True
  );

  FPackageOptionsReader.PlatformTargets := pidAllPlatforms;
  Assert.AreEqual(FPackageOptionsReader.DecodedPlatformTargets =
   [dpfWin32, dpfWin64, dpfOSX32, dpfiOSSimulator32,
    dpfAndroidArm32, dpfiOSDevice32, dpfLinux64, dpfiOSDevice64, dpfOSX64,
    dpfLinuxArm64, dpfAndroidArm64, dpfiOSSimulator64, dpfOSXArm64, dpfWinArm64,
    dpfiOSSimulatorArm64, dpfWin64x
   ], True
  );
end;

procedure TTestPackageOptionsObj.TestUnitAliasCount;
begin
  Assert.AreEqual<Integer>(3, FPackageOptionsReader.UnitAliasCount);
end;

procedure TTestPackageOptionsObj.TestUnitAliases;
begin
  var LUnitAliases := FPackageOptionsReader.UnitAliases;
  var LExpUnitAliases: TArray<string> := ['E=F', 'C=D', 'A=B'];
  Assert.AreEqual<string>(LExpUnitAliases, LUnitAliases);
{
  Check that CodeGear.Common.Targets is fixed to the below content
    <!-- UnitAliases>Generics.Collections=System.Generics.Collections;Generics.Defaults=System.Generics.Defaults</UnitAliases -->
    <UnitAliases Condition="'$(Platform)'=='$(cWin32Platform)' Or
      '$(Platform)'=='$(cWin64Platform)' Or
      '$(Platform)'=='$(cWin64xPlatform)' Or
      '$(Platform)'=='$(cWinNX32Platform)' Or
      '$(Platform)'=='$(cWinIoT32Platform)' Or
      '$(Platform)'=='$(cWinArm32Platform)'">$(UnitAliases)
      <!-- WinTypes=Winapi.Windows;WinProcs=Winapi.Windows;DbiTypes=BDE;DbiProcs=BDE;DbiErrs=BDE -->
      </UnitAliases>
    <UnitAliases Condition="'$(DCC_UnitAlias)'!=''">$(DCC_UnitAlias)$(UnitAliases)</UnitAliases>
}
end;

{ TTestPackageOptionsWriterObj }

procedure TTestPackageOptionsWriterObj.Setup;
begin
  FPackageOptionsWriter := TV0PackageOptions.Create;
  var LFileName := 'C:\Users\Public\Documents\Embarcadero\Studio\37.0\Bpl\Package2.bpl';
  ForceDirectories(ExtractFileDir(LFileName));
  if not FileExists(LFileName) then
    begin
      TFile.Copy(ParamStr(0), LFileName);
    end;
end;

procedure TTestPackageOptionsWriterObj.TearDown;
begin
  FreeAndNil(FPackageOptionsWriter);
end;

procedure TTestPackageOptionsWriterObj.TestWrite;
begin
  var LPackageOptionsReader := TV0PackageOptions.Create;
  try
    LPackageOptionsReader.ReadFromFile('C:\Users\Public\Documents\Embarcadero\Studio\37.0\Bpl\Package2.bpl');

    FPackageOptionsWriter.Version := 1;
    FPackageOptionsWriter.ToggleValues := LPackageOptionsReader.ToggleValues;
    FPackageOptionsWriter.Defines := LPackageOptionsReader.Defines;
    FPackageOptionsWriter.AddUnitAlias('A', 'B');
    FPackageOptionsWriter.AddUnitAlias('C', 'D');
    FPackageOptionsWriter.DebugInfoValue := Succ(LPackageOptionsReader.DebugInfoValue);
    FPackageOptionsWriter.MinStackSize := $11112222;
    FPackageOptionsWriter.MaxStackSize := $33334444;
    FPackageOptionsWriter.ResourceReserve := Cardinal($444455555);
    FPackageOptionsWriter.ImageBase := $66667777;
    FPackageOptionsWriter.Description := 'Hello world';

    FreeAndNil(LPackageOptionsReader);
    FPackageOptionsWriter.WriteToFile('C:\Users\Public\Documents\Embarcadero\Studio\37.0\Bpl\Package2.bpl');

    LPackageOptionsReader := TV0PackageOptions.Create;
    LPackageOptionsReader.ReadFromFile('C:\Users\Public\Documents\Embarcadero\Studio\37.0\Bpl\Package2.bpl');

    Assert.AreEqual<Byte>(FPackageOptionsWriter.Version, LPackageOptionsReader.Version);
    Assert.AreEqual(FPackageOptionsWriter.ToggleValues, LPackageOptionsReader.ToggleValues);
    Assert.AreEqual<string>(FPackageOptionsWriter.Defines, LPackageOptionsReader.Defines);
    Assert.AreEqual(FPackageOptionsWriter.DebugInfoValue, LPackageOptionsReader.DebugInfoValue);
    Assert.AreEqual(FPackageOptionsWriter.MinStackSize, LPackageOptionsReader.MinStackSize);
    Assert.AreEqual(FPackageOptionsWriter.MaxStackSize, LPackageOptionsReader.MaxStackSize);
    Assert.AreEqual(FPackageOptionsWriter.ResourceReserve, LPackageOptionsReader.ResourceReserve);
    Assert.AreEqual(FPackageOptionsWriter.ImageBase, LPackageOptionsReader.ImageBase);
    Assert.AreEqual(FPackageOptionsWriter.Description, LPackageOptionsReader.Description);
  finally
    FreeAndNil(LPackageOptionsReader);
  end;
end;

initialization
  TDUnitX.RegisterTestFixture(TTestPackageOptionsObj);
//  TDUnitX.RegisterTestFixture(TTestPackageOptionsWriterObj);
end.




















































































































































































// chuacw,
// 5 Oct 2025,
// Singapore, Singapore

