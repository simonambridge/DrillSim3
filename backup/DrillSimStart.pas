Unit DrillSimStart;

Interface

Uses Crt,
     DrillSimVariables,
     SimulateVariables,
     HyCalcVariables,
     DrillSimSound,
     DrillSimUnitsOfMeasure,
     DrillSimConversions,
     DrillSimInit,
     DrillSimUtilities,
     DrillSimFile,
     DrillSimFileIO;

Procedure StartUp;

Implementation

Procedure MainInit;
Begin
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
End;


Procedure GetDefault(DefaultString : AnyString);
Var i : integer;
Begin                                        { Extract path string }
  if copy(DefaultString,1,4)='PATH' then
  Begin
    DefaultDirectory:=copy(DefaultString,6,length(DefaultString));
    {$I-}
    ChDir(DefaultDirectory);                 { set path to user defined path }
    {$I+}
    if not OK then
    Begin
      SystemError(2);
      LowBeep;
      ExitPrompt;
    End else LoggedDirectory:=DefaultDirectory;
    Exit;
  End;
  if copy(DefaultString,1,4)='FILE' then
  Begin
    DefaultFile:=copy(DefaultString,6,length(DefaultString));
    FullName:=copy(DefaultFile,1,8) + Extension;
    for i:=1 to length(FullName) do FullName[i]:=UpCase(FullName[i]);
    if Exist(FullName) then
    Begin
      FileName:=DefaultFile;               { set file to user defined file }
      NewFile:=False;
      LoadData;
    End;
  End;
End;



Procedure StartUp;
Begin
  OriginalExitProc:=ExitProc;
{  ExitProc:=@Abort; }                  { Set Error trap vector  }

  Quit:=False;                          { Simulator Quit indicator }

{ 3 entry modes   : OS, Simulate and HyCalc.
    From DOS      : ExecuteFlag = ?
    From Simulate : ExecuteFlag = $FF - set in SimulateControl
    From HyCalc   : ExecuteFlag = $FF - obsolete

    ReturnFlag    : 3 = HyCalc        - obsolete
    ReturnFlag    : 5 = Simulate      - set in SimulateControl

   therefore ONLY DOS does the next section }

  if ExecuteFlag <> $FF then
  Begin
    MainInit;     { set system variables        }
    ReturnFlag:=Zero;
    APIUnits;     { Initial default unit type   }
    InitData;     { zero all main file variables }

    //Mode:='load configuration';
    //Window(1,1,80,25);
    //TextBackground(Blue);
    //TextColor(LightGray);
    //ClrScr;
    //SetColorSet(NormColors);
    //WriteTitle(False,False,False);

    //Box(15,6,65,12);
    //Box(20,14,60,21);

    //SetColorSet(WhiteOnBlue);
    //SetColorSet(NormColors);

    GetDir(0,Instring);
    OriginDirectory:=Instring;               { save original direc'y }
    LoggedDirectory:=Instring;               { default to original   }

    {* ------- get/set defaults if called from DOS or HyCalc ------- *}

    Assign(TextFile,'DrillSim.cfg');         { load drillsim.cfg }
    {$I-}
    Reset(TextFile);
    {$I+}
    if OK then                  { drillsim.CFG found }
    Begin
      SystemMessage(PleaseWait);
      While not EOF(TextFile) do
      Begin
        IResult:=IResult + 1;
        Case IResult of
          1 : Readln(TextFile,TextLine1);
          2 : Readln(TextFile,TextLine2);
        End;
      End;                          { IResult = 1 or 2 }
                                    { TextLine1 and 2 depending on IResult }
      Close(TextFile);

      if Iresult >= 1 then
      Begin
        for IntParam:=1 to length(TextLine1) do
          TextLine1[IntParam]:=UpCase(TextLine1[IntParam]);
        GetDefault(TextLine1);
      End;
      if IResult > 1 then
      Begin
        for IntParam:=1 to length(TextLine2) do
          TextLine2[IntParam]:=UpCase(TextLine2[IntParam]);
        GetDefault(TextLine2);
      End;
      SystemMessage('');
    End else
    Begin                  { defaults file not found }
      SystemError(1);
      LowBeep;
      ExitPrompt;
    End;
  End else                  { not called from O/S }
  Begin
    if ReturnFlag=5 then
    Begin                       { CALLED FROM SIMULATE }
      ConUser;                  { convert Simulate internal units (API) }
      ConUserKickData;          { if ReturnFlag=3 then from HyCalc      }
    End;
  End;

  ChDir(OriginDirectory);     { Change here after first-time intro above }

  {* --------- LOAD HELP --------- *}
  if (ReturnFlag=3) or (ExecuteFlag<>$FF) then      { if from HyCalc or OS }
  Begin
    Assign(HelpFile,'DrillSim.hlp');                   { load help messages }
    {$I-}
    Reset(HelpFile);
    {$I+}
    if OK then
    Begin
      HelpFileFound:=True;
      Read(HelpFile,Help);
      Close(HelpFile);
    End else
    Begin
      HelpFileFound:=False;
      SystemError(3);
      LowBeep;
      ExitPrompt;                   { exit from error message }
    End;
    if ReturnFlag=Zero then
    Begin
      //SetColorSet(TitleColors);     { only do this if from OS }
        //Disp(72,1,FileName);
      ExitPrompt;
    End;
  End;
  //SetColorSet(NormColors);     { set colors for system }
End;

Begin
End.
