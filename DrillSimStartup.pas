Unit DrillSimStartup;

Interface

Uses Crt,
     sysutils,
     DrillSimVariables,
     SimulateVariables,
     HyCalcVariables,
     DrillSimUnitsOfMeasure,
     DrillSimConversions,
     DrillSimUtilities,
     DrillSimFile,
     SimulateMessageToMemo;

Procedure StartUp;
Procedure InitData;

Implementation

{ ----------------- Initialize Data --------------------- }

Procedure InitData;              { Start-up status }
Var i : integer;
    x : real;
Begin
  With Data do
  Begin
    NewIf0:=Zero;       { set NewIf0 - this will be a new file }
    Bingham:=False;
    WellOperator:='';
    Well    :='';
    Offshore:=False;
    Riser   :=False;
    Casing  :=False;
    Liner   :=False;
    CsgTD:=Zero; CsgID:=Zero;
    RsrTD:=Zero; RsrID:=Zero;
    LinerTop:=Zero; LinerTD:=Zero; LinerID:=Zero; Dev:=Zero;
    WaterDepth:=Zero;
    Rkb       :=Zero;

    Maxholes:=1;
    For i:=1 to 2 do
    Begin
      Hole[i,1]:=Zero;
      Hole[i,2]:=Zero;
    End;

    Maxpipes:=1;
    For i:=1 to 4 do
    Begin
      Pipe[i,1]:=Zero;
      Pipe[i,2]:=Zero;
      Pipe[i,3]:=Zero;
      Pipe[i,4]:=Zero;          { pipe wt. unassigned in HyCalc }
    End;

    For i:=1 to 4 do
    Begin
      Surf[i,1]:=Zero;
      Surf[i,2]:=Zero;
    End;

    MaxPumps:=1;
    For i:=1 to 3 do
    Begin
      Pump[i,1]:=Zero;
      Pump[i,2]:=Zero;
      Pump[i,3]:=Zero;
      Pump[i,4]:=Zero;
      Pump[i,5]:=Zero;
    End;
    MaxPress  :=Zero;

    MaxJets :=4;
    For i:=1 to MaxJets do Jet[i]:=Zero;
    Bit    :=Zero;
    BitType :='';

    MudYp  :=Zero;
    MudWt  :=Zero;
    MudPv  :=Zero;
    MudGel :=Zero;

    ChokeLineID:=Zero;
    KillLineID:=Zero;

    LotTD :=Zero;             { these simulator variables are here because }
    LotMW :=Zero;             { they are edited in Proc. UpdateKick and    }
    LotEMW:=Zero;             { must be set to 0 for a new file            }
    LotPressure:=Zero;
    BurstPressure:=Zero;
    RetPitVol:=100;

    Rock[1].Depth:=Hole[MaxHoles,1];   { define default formation }
    Rock[1].Hardness:=1;
    if Offshore then x:=0.442 else x:=0.4332; { x = norm. gradient * 0.052 }
    Rock[1].FP:=((Hole[MaxHoles,1] * con[1]) * x) / con[3];
    For i:=2 to 10 do                  { and zero the rest        }
    Begin
      Rock[i].Depth:=Zero;
      Rock[i].Hardness:=Zero;
      Rock[i].FP:=Zero;
    End;

    For i:=1 to 5 do
    Begin
      UserCon[i]:=Zero;
      UserLab[i]:='   ';
      UserType:='Undefined';
    End;
  End;
End;


Procedure LoadDefaultWellDataFile(S : AnyString);
Var i : integer;
Begin                                        { Extract path string }
  for i:=1 to length(S) do S[i]:=UpCase(S[i]);
  if FileExists(S) then
  Begin
    FileName:=S;               { set file to user defined file }
    NewFile:=False;
    NoFileDefined:=False;
    LoadData;
    StringToMemo('Default well data file ' + FileName + 'loaded');
  End;
End;



Procedure StartUp;
Begin
  writeln('Running StartUp');
  OriginalExitProc:=ExitProc;
{  ExitProc:=@Abort; }                  { Set Error trap vector  }

  Quit:=False;                          { Initialise Simulator Quit indicator }
  Enter := chr($11) + chr($cd) + chr($bc);
  NoFileDefined:=True;
  NoData:=True;
  NewFile:=True;
  Error:=False;                              { Hydraulic calculation }
  HoleError:=False;
  Create:=False;
  PosCounter:=1;
  TempString:='';
  Instring:='';
  FileName:='';
  DefaultFile:='';
  DefaultDirectory:='';
  LstString:='';
  BlankString:='';
  For IResult:=1 to 80 do
  Begin
    LstString:=LstString+Space;
    BlankString:=BlankString+Space;
  End;

    APIUnits;     { Initial default unit type   }
    InitData;     { zero all main file variables }

    { ------- get default directory ------- }

    GetDir(0,Instring);                 { get current directory spec}
    StringToMemo('Current directory is ' + Instring);
    OriginDirectory:=Instring;               { save original direc'y }
    LoggedDirectory:=Instring;               { default to original   }

    { ------- get defaults file ------- }

    Assign(TextFile,'DrillSim.cfg');         { load drillsim.cfg }

    StringToMemo('Loading ' + OriginDirectory + '/' + 'DrillSim.cfg');
    MessageToMemo(102); // 'Loading application configuration file'

    {$I-}
    Reset(TextFile);
    {$I+}
    IResult:=0;
    if OK then                  { drillsim.CFG found }
    Begin
      While not EOF(TextFile) do
      Begin
        Readln(TextFile,TextFileLine);
      End;
      Close(TextFile);
      LoadDefaultWellDataFile(TextFileLine);
    End else
    Begin                  { defaults file not found }
      SystemError(1);      // pop up error message
      ExitPrompt;
    End;

  ChDir(OriginDirectory);     { Change here after first-time intro above }

  {* --------- Load Help File --------- *}
  MessageToMemo(103); // 'Loading application help file'

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
      SystemError(3);
      ExitPrompt;                   { exit from error message }
    End;
End;

Begin
End.

