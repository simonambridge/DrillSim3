program DrillSim2;

{$mode objfpc}{$H+}
{ To make a demo copy, delete procedure SaveData and replace with
  the file in NoSave.Pas which prints a message screen }

uses
  {$IFDEF UNIX}
  cthreads,
  {$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms, DrillSimGUI,
  { you can add units after this }
  DrillSimVariables,
  DrillSimStartup,
  DrillSimFile,
  DrillSimMenu,
  SimulateMessageToMemo;

{$R *.res}

begin

  RequireDerivedFormResource := True;
  Application.Initialize;
  Application.CreateForm(TDrillSim, DrillSim);

  writeln('Application.Run');
  Application.Run;


  if Edited then
  Begin
 //   if ExitCheck then SaveData;
    writeln('Edited');
  End;

  writeln('Exiting');
  ChDir(OriginDirectory);

end.
