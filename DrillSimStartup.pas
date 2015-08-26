Unit DrillSimStartup;

Interface

Uses Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs,
  ExtCtrls,
     DrillSimVariables,
     DrillSimUnitsOfMeasure,
     DrillSimUtilities,
     DrillSimFile,
     DrillSimMessageToMemo,
     DrillSimDataResets;

Procedure StartUp;

Implementation

{ ----------------- Initialize Data --------------------- }

Procedure LoadDefaultWellDataFile(S : String120);
Begin                                        { Extract path string }
  if FileExists(S) then
  Begin
    CurrentFQFileName:=S;      { set file to user defined file }
    CreateNewFile:=False;      { its an existing file }

    LoadData;  { sets NoFileDefined=True if error during read }

    if NoFileDefined=True then // on return, is a valid file loaded?
    Begin                      // then notify the error
      StringToMemo('DrillSimStartup.LoadDefaultWellDataFile: Error loading ' + CurrentFQFileName);
      ShowMessage('Error loading well data file ' + CurrentFQFileName);
    end else
    Begin                      // otherwise confirm well name loaded
      StringToMemo('DrillSimStartup.LoadDefaultWellDataFile: ' + CurrentFQFileName + ' loaded');
      StringToMemo('DrillSimStartup.LoadDefaultWellDataFile: Simulating Well ' + Data.WellName);
    End;
  End else
  Begin
    StringToMemo('DrillSimStartup.LoadDefaultWellDataFile: Error - missing well data file ' + CurrentFQFileName);
    NoFileDefined:=True;
  end;
End;



Procedure StartUp;
Begin
  StringToMemo('DrillSimStartup.StartUp: Running DrillSim StartUp.................');
  OriginalExitProc:=ExitProc;
{  ExitProc:=@Abort; }                  { Set Error trap vector  }

  Quit:=False;                          { Initialise Simulator Quit indicator }
  NoFileDefined:=True;  // we are a blank
  CreateNewFile:=True;                  { new file until we know otherwise... }

  HoleError:=False;

  PosCounter:=1;
  TempString:='';
  Instring:='';
  CurrentFQFileName:='';
  DefaultWellDataFile:='';
  DefaultDirectory:='';

  APIUnits;     { Initial default unit type   }
                {* set UoMLabel, UoMCOnverter and UoMDescriptor *}

  InitData;     { zero all main file variables }

    { ------- get default directory ------- }

  GetDir(0,OriginDirectory);               { get current directory spec}
  StringToMemo('DrillSimStartup.StartUp: Current directory is ' + OriginDirectory);
  SystemPropertiesFile:=OriginDirectory + '/' + 'DrillSim.cfg';
  StringToMemo('DrillSimStartup.StartUp: Configuration file is ' + SystemPropertiesFile);
  StringToMemo('Loading system onfiguration');

    { ------- get defaults file ------- }

  AssignFile(Textfile,SystemPropertiesFile);         { /path/drillsim.cfg }
  {$I-}
  Reset(TextFile);
  {$I+}
  if OK then                  { drillsim.CFG found }
  Begin
    While not EOF(TextFile) do
    Begin
      Readln(TextFile,DefaultWellDataFile); { read FQFN of default well file into DefaultWellDataFile }
    End;
    CloseFile(TextFile);

    if DefaultWellDataFile=''
    then
      StringToMemo('DrillSimStartup.StartUp: Default well not defined ')
    else
    Begin
      StringToMemo('DrillSimStartup.StartUp: Default well data file is ' + DefaultWellDataFile);
      LoadDefaultWellDataFile(DefaultWellDataFile);     // Load the default data file !!!
    end;
  End else
  Begin
    ShowMessage('Error loading ' + DefaultWellDataFile); { defaults file not found }
  End;

  {* --------- Load Help File --------- *}

  MessageToMemo(103); // 'Loading application help file...'

  Assign(HelpFile,'DrillSim.hlp');                   { load help messages }
  {$I-}
  Reset(HelpFile);
  {$I+}
  if OK then
  Begin
    HelpFileFound:=True;
    //Read(HelpFile,Help);
    Close(HelpFile);
  End else
  Begin
    HelpFileFound:=False;
    ShowMessage('Error loading DrillSim help file');
  End;
  StringToMemo('DrillSimStartup.StartUp: DrillSim Startup complete');
  ThisString:=Data.WellName;
    writeln(ThisString);

  StringToMemo('DrillSimStartup.StartUp: Using Well ' + ThisString + '');
  StringToMemo('DrillSimStartup.StartUp: Units selected: '+ UoMDescriptor);

End;

Begin
End.

