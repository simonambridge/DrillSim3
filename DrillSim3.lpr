program DrillSim3;

{$mode objfpc}{$H+}
{ To make a demo copy, delete procedure SaveData and replace with
  the file in NoSave.Pas which prints a message screen }

uses
  {$IFDEF UNIX} //{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF} //{$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms,
  { you can add units after this }
  DrillSimVariables,
  DrillSimStartup,
  DrillSimFile,
  DrillSimMessageToMemo,
  DrillSimGUI,
  FormGeneralData,
  FormDisplayWellData,
  FormHoleData,
  FormUnitsOfMeasure, FormConfigDefaults;

{$R *.res}

begin

  RequireDerivedFormResource := True;

  writeln('DrillSim3.lpr : Application.Initialize');
  Application.Initialize;

  // Build GUI, run DrillSim StartUp
  writeln('DrillSim3.lpr : Application.CreateForm');
  Application.CreateForm(TDrillSim, DrillSim);
  StringToMemo('Initialise Form: DrillSim');
  Application.CreateForm(TGeneralDataForm, GeneralDataForm);
  StringToMemo('Initialise Form: General Well Data');
  Application.CreateForm(TDisplayWellDataForm, DisplayWellDataForm);
  StringToMemo('Initialise Form: Summary Well Data');
  Application.CreateForm(TUnitsOfMeasureForm, UnitsOfMeasureForm);
  StringToMemo('Initialise Form: Units Of Measure');
  Application.CreateForm(TSystemDefaultsForm, SystemDefaultsForm);
  StringToMemo('Initialise Form: System Defaults');
  Application.CreateForm(THoleDataForm, HoleDataForm);
  StringToMemo('Initialise Form: Well Hole Profile');

  StringToMemo('===============================');
  StringToMemo('Form Initialisation complete.');
  StringToMemo('DrillSim3.lpr : Application.Run');
  StringToMemo('===============================');
  Application.Run;


  // if ExitCheck then SaveData;       <- where's this set?
  if Edited then
  Begin
    writeln('Edited');
    // do some exit file save check
  End;

  writeln('Exiting');
  ChDir(OriginDirectory);

end.
