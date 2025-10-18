program PackageOptionsReaderProj;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  Winapi.Windows,
  PackageResources in 'PackageResources.pas';

begin
  var LFileName := 'C:\Users\Public\Documents\Embarcadero\Studio\37.0\Bpl\Package3.bpl';
  var POR := TV0PackageResources.Create(LFileName);
  try
    var POW := TV0PackageResources.Create(LFileName);
    try
      try
        POR.GetResourceNames;
//        POR.DuplicateResource(RT_RCDATA, PChar('PLATFORMTARGETS'),
//          MakeLangID(LANG_ENGLISH, SUBLANG_ENGLISH_AUS));
//        POR.DuplicateResource(RT_RCDATA, PChar('PLATFORMTARGETS'),
//          MakeLangID(LANG_ENGLISH, SUBLANG_ENGLISH_CAN));
//        POR.DuplicateResource(RT_RCDATA, PChar('PLATFORMTARGETS'),
//          MakeLangID(LANG_ENGLISH, SUBLANG_ENGLISH_NZ));
//        POR.DuplicateResource(RT_RCDATA, PChar('PLATFORMTARGETS'),
//          MakeLangID(LANG_ENGLISH, SUBLANG_ENGLISH_UK));
        POR.ExistsResource(RT_RCDATA, 'PLATFORMTARGETS', MAKELANGID(LANG_ENGLISH, SUBLANG_SYS_DEFAULT));
        POR.ExistsResource(RT_RCDATA, 'PLATFORMTARGETS', TCustomPackageResources.NeutralLangID);
        POR.DeleteResource(RT_RCDATA, 'DESCRIPTION');
        POR.DeleteResource(RT_RCDATA, 'PACKAGEINFO');
        POR.DeleteResource(RT_RCDATA, 'PACKAGEOPTIONS');
        POR.DeleteResource(RT_RCDATA, 'PLATFORMTARGETS');
        POR.DeleteResource(RT_VERSION, MakeIntResource(1));
        POR.GetResourceNames(LFileName);
        POR.ReadFromFile(LFileName);
        POW.Clone(POR);
        POW.WriteToFile(LFileName);
      except
        on E: Exception do
          Writeln(E.ClassName, ': ', E.Message);
      end;
    finally
      POW.Free;
    end;
  finally
    POR.Free;
  end;
end.




















































































































































































// chuacw,
// 5 Oct 2025,
// Singapore, Singapore
