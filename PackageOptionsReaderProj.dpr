program PackageOptionsReaderProj;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  uPackageOptions in 'uPackageOptions.pas';

begin
  var POR := TV0PackageOptions.Create;
  try
    var POW := TV0PackageOptions.Create;
    try
      try
        // POR.ReadFromFile('C:\Users\Public\Documents\Embarcadero\Studio\37.0\Bpl\Package3.bpl');
        POR.ReadFromFile('C:\Users\Public\Documents\Embarcadero\Studio\37.0\Bpl\Win64\Package3.bpl');
        POW.Clone(POR);
        POW.WriteToFile('C:\Users\Public\Documents\Embarcadero\Studio\37.0\Bpl\Win64\Package3.bpl');
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
