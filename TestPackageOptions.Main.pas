unit TestPackageOptions.Main;

{$RANGECHECKS OFF}

interface

uses
  DUnitX.TestFramework, PackageResources;

type
  [TestFixture]
  TTestPackageOptionsObj = class
  protected
    FPackageOptionsReader: TV0PackageResources;
  public
    [Setup]
    procedure Setup;

    [TearDown]
    procedure TearDown;

    [Test]
    procedure TestClone;

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
    FPackageResourcesWriter: TV0PackageResources;
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
  var LFileName := 'C:\Users\Public\Documents\Embarcadero\Studio\37.0\Bpl\Package1.bpl';
  FPackageOptionsReader := TV0PackageResources.Create(LFileName);
  FPackageOptionsReader.ReadFromFile(LFileName);
end;

procedure TTestPackageOptionsObj.TearDown;
begin
  FreeAndNil(FPackageOptionsReader);
end;

procedure TTestPackageOptionsObj.TestVersion;
begin
  Assert.AreEqual<Byte>(FPackageOptionsReader.Version, 0);
end;

procedure TTestPackageOptionsObj.TestClone;
begin
  var LV0PackageResources := TV0PackageResources.Create('');
  Assert.AreEqual<string>(LV0PackageResources.Description, '');
  Assert.AreEqual<string>(LV0PackageResources.Defines, []);
  Assert.AreEqual<string>(LV0PackageResources.UnitAliases, []);

  var LDesc1 := 'Description1';
  LV0PackageResources.Description := LDesc1;
  LV0PackageResources.Defines := ['A=B', 'C=D'];
  LV0PackageResources.UnitAliases := ['Unit1=Unit2', 'Unit3=Unit4'];

  Assert.AreEqual<string>(LV0PackageResources.Description, LDesc1);
  Assert.AreEqual<string>(LV0PackageResources.Defines, ['A=B', 'C=D']);
  Assert.AreEqual<string>(LV0PackageResources.UnitAliases, ['Unit1=Unit2', 'Unit3=Unit4']);

  var LClonedDest := TV0PackageResources.Create('');
  Assert.AreEqual<string>(LClonedDest.Description, '');
  Assert.AreEqual<string>(LClonedDest.Defines, []);
  Assert.AreEqual<string>(LClonedDest.UnitAliases, []);

  LClonedDest.Clone(LV0PackageResources);
  Assert.AreEqual<string>(LClonedDest.Description, LDesc1);
  Assert.AreEqual<string>(LClonedDest.Defines, ['A=B', 'C=D']);
  Assert.AreEqual<string>(LClonedDest.UnitAliases, ['Unit1=Unit2', 'Unit3=Unit4']);

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
  var LFileName := 'C:\Users\Public\Documents\Embarcadero\Studio\37.0\Bpl\Package2.bpl';
  FPackageResourcesWriter := TV0PackageResources.Create(LFileName);
  ForceDirectories(ExtractFileDir(LFileName));
  if not FileExists(LFileName) then
    begin
      TFile.Copy(ParamStr(0), LFileName);
    end;
end;

procedure TTestPackageOptionsWriterObj.TearDown;
begin
  FreeAndNil(FPackageResourcesWriter);
end;

procedure TTestPackageOptionsWriterObj.TestWrite;
begin
  var LFileName := 'C:\Users\Public\Documents\Embarcadero\Studio\37.0\Bpl\Package2.bpl';
  var LPackageResourcesReader := TV0PackageResources.Create(LFileName);
  try
    LPackageResourcesReader.ReadFromFile(LFileName);

    FPackageResourcesWriter.Version := 1;
    FPackageResourcesWriter.ToggleValues := LPackageResourcesReader.ToggleValues;
    FPackageResourcesWriter.Defines := LPackageResourcesReader.Defines;
    FPackageResourcesWriter.AddUnitAlias('A', 'B');
    FPackageResourcesWriter.AddUnitAlias('C', 'D');
    FPackageResourcesWriter.DebugInfoValue := Succ(LPackageResourcesReader.DebugInfoValue);
    FPackageResourcesWriter.MinStackSize := $11112222;
    FPackageResourcesWriter.MaxStackSize := $33334444;
    FPackageResourcesWriter.ResourceReserve := Cardinal($444455555);
    FPackageResourcesWriter.ImageBase := $66667777;
    FPackageResourcesWriter.Description := 'Hello world';

    FreeAndNil(LPackageResourcesReader);
    FPackageResourcesWriter.WriteToFile(LFileName);

    LPackageResourcesReader := TV0PackageResources.Create(LFileName);
    LPackageResourcesReader.ReadFromFile(LFileName);

    Assert.AreEqual<Byte>(FPackageResourcesWriter.Version, LPackageResourcesReader.Version);
    Assert.AreEqual(FPackageResourcesWriter.ToggleValues, LPackageResourcesReader.ToggleValues);
    Assert.AreEqual<string>(FPackageResourcesWriter.Defines, LPackageResourcesReader.Defines);
    Assert.AreEqual(FPackageResourcesWriter.DebugInfoValue, LPackageResourcesReader.DebugInfoValue);
    Assert.AreEqual(FPackageResourcesWriter.MinStackSize, LPackageResourcesReader.MinStackSize);
    Assert.AreEqual(FPackageResourcesWriter.MaxStackSize, LPackageResourcesReader.MaxStackSize);
    Assert.AreEqual(FPackageResourcesWriter.ResourceReserve, LPackageResourcesReader.ResourceReserve);
    Assert.AreEqual(FPackageResourcesWriter.ImageBase, LPackageResourcesReader.ImageBase);
    Assert.AreEqual(FPackageResourcesWriter.Description, LPackageResourcesReader.Description);
  finally
    FreeAndNil(LPackageResourcesReader);
  end;
end;

initialization
  TDUnitX.RegisterTestFixture(TTestPackageOptionsObj);
//  TDUnitX.RegisterTestFixture(TTestPackageOptionsWriterObj);
end.




















































































































































































// chuacw,
// 5 Oct 2025,
// Singapore, Singapore

