Unit DrillSimHoleCalc;

Interface

Uses DrillSimVariables,
     DrillSimDataInput;

Procedure DSHoleCalc;                  { Procedure To Determine Hole Profile }
Procedure CheckHoleData;
Procedure CheckPipeData;


Implementation

Procedure ErrorScreen;
Begin

  //Box(13,5,67,19);
  //Box(30,6,49,8);
  //Disp(32,7,'INPUT DATA ERROR');
  //Disp(16,9,Help.HelpText[191]);   { There is an error in the... }
  //Disp(16,10,Help.HelpText[192]);
  //Disp(16,11,Help.HelpText[193]);
  //Disp(16,12,Help.HelpText[194]);
  //Disp(16,13,Help.HelpText[195]);
  //Disp(16,14,Help.HelpText[196]);
  //Disp(16,15,Help.HelpText[197]);
  //Disp(16,16,Help.HelpText[198]);
  //Disp(16,17,Help.HelpText[199]);
  //Disp(16,18,Help.HelpText[200]);
End;

Procedure CheckHoleData; // called when a file is loaded
Begin
  Repeat
    //UpdateHole;                  { call hole data entry form }
    Begin
      DSHoleCalc;                { Check hole for errors and initialise volumes  }
                                 { mud volume reset when hole profile changed }
      if HoleError then
      Begin
        ErrorScreen;
        //UpdatePipe;
      End;
    End;
  Until not HoleError;
End;

Procedure CheckPipeData;  // called when a file is loaded
Begin
  Repeat
    //UpdatePipe;                { call pipe data entry form }
    DSHoleCalc;                { Check hole for errors and initialise volumes }
                               { mud volume reset when pipe profile changed }
    if HoleError then
    Begin
      ErrorScreen;
      //UpdateHole;
    End;
  Until not HoleError;
End;

Procedure ErrorCheck(SectionNumber : integer);
Begin
  With Data do
  Begin
    HoleError:=False;
    if HoleSection[SectionNumber,3] >= HoleSection[SectionNumber,2] then
                                      HoleError:=True;    { Pipe OD > Hole ID }
    if HoleSection[SectionNumber,4] >= HoleSection[SectionNumber,3] then
                                      HoleError:=True;    { Pipe ID > Pipe OD }
  End;
End;


Procedure DSHoleCalc;                  { Procedure To Determine Hole Profile }
Var X, Y : real;
    J, i, K    : integer;
    Temp       : array[1..5,1..2] of real;  { Also calculates PipeTD for    }
    TempCount  : integer;                   { Simulate and Optimise         }
    ExtraHole  : array[1..2] of real;

Function BblPerFoot(x : real) : real;
Begin
  BBlPerFoot:=sqr(x) / VolCon;
End;

Begin
//  ConAPI;
//  ConAPIKickData;
  With Data do
  Begin
    TempCount:=Zero;                   { Create and Edit set NeverSimulated }

    if Riser then                      { Assign Hole Sections To Temp[*] }
    Begin
     TempCount:=TempCount+1;
     Temp[TempCount,1]:=RiserTD; Temp[TempCount,2]:=RiserID;
    End;

    if Casing then
    Begin
      TempCount:=TempCount+1;
      Temp[TempCount,1]:=CasingTD; Temp[TempCount,2]:=CasingID;
      if Riser then Temp[TempCount,1]:=Temp[TempCount,1]-RiserTD;
      if Liner then Temp[TempCount,1]:=Temp[TempCount,1]-(CasingTD-LinerTopTD);
    End;

    if Liner then
    Begin
      TempCount:=TempCount+1;
      Temp[TempCount,1]:=LinerBottomTD-LinerTopTD;
      Temp[TempCount,2]:=LinerID;
    End;

    if MaxHoles>Zero then
    Begin
      For i:=1 to MaxHoles do
      Begin
        TempCount:=TempCount+1;
        Temp[TempCount,1]:=Hole[i,1]; Temp[TempCount,2]:=Hole[i,2];
        if Casing then
        Begin
          if Liner then Temp[TempCount,1]:=Temp[TempCount,1]-LinerBottomTD else
                                Temp[TempCount,1]:=Temp[TempCount,1]-CasingTD;
        End;
        if i>1 then Temp[TempCount,1]:=Temp[TempCount,1]-Temp[TempCount-1,1];
      End;                                     { Deduct OH#1 }
    End;

    TD:=Zero;                              { Calculate TD, TVD from Temp[i,1] }
    For i:=1 to TempCount do TD:=TD+Temp[i,1];

    PipeTD:=Zero;
    For i:=1 to MaxPipes do PipeTD:=PipeTD + Pipe[i,1];

                        { Check hole and pipe TD's }
    if TD < PipeTD then                      { check for excess pipe length  }
    Begin
      x:=PipeTD - TD;
      if x >= Pipe[MaxPipes,1] then          { if it can't be accomodated in   }
      Begin                                  { Drill Pipe, then error and Exit }
        HoleError:=True;
        Exit;
      End else
      Begin                                  { otherwise subtract from Drill }
        Pipe[MaxPipes,1]:=Pipe[MaxPipes,1]-x;{ Pipe to put bit on bottom     }
        PipeTD:=PipeTD-x;                    { and subtract from PipeTD      }
        KellyHeight:=33;                     { and then reset kelly on slips }
        LastKellyHeight:=33;
        LastKD:=PipeTD;                      { and set up for new kelly down }
      End;
    End;
    Tvd:=TD * Cos(DeviationDegrees * Pi / 180);

    J:=1; K:=MaxPipes;                   { Calculate Hole Profile }
    i:=1;
    X:=Temp[J,1];
    Y:=Pipe[K,1];                        { From bottom to surface }
    ExtraVolume:=Zero;                   { initialise off-bottom volume }
    While K>Zero do
    Begin
      if X > Y then                      { Hole > Pipe }
      Begin
        HoleSection[i,1]:=Y;                 { section length }
        HoleSection[i,2]:=Temp[J,2];         { section hole ID }
        HoleSection[i,3]:=Pipe[K,3];         { section Pipe OD }
        HoleSection[i,4]:=Pipe[K,2];         { section Pipe ID }
        ErrorCheck(i);
        if HoleError then Exit;
        X:=X-Y;
        K:=K-1;
        if K > Zero then
        Begin
          i:=i+1;
          Y:=Pipe[K,1];
        End;
      End else
      if X < Y then
      Begin
        HoleSection[i,1]:=X;                  { Pipe < Hole }
        HoleSection[i,2]:=Temp[J,2];
        HoleSection[i,3]:=Pipe[K,3];
        HoleSection[i,4]:=Pipe[K,2];
        ErrorCheck(i);
        if HoleError then Exit;
        Y:=Y-X;
        J:=J+1;
        if J <= TempCount then
        Begin
          i:=i+1;
          X:=Temp[J,1];
        End;
      End else
      if X = Y then
      Begin
        HoleSection[i,1]:=X;                  { Pipe = Hole }
        HoleSection[i,2]:=Temp[J,2];          { section length = hole length }
        HoleSection[i,3]:=Pipe[K,3];
        HoleSection[i,4]:=Pipe[K,2];
        ErrorCheck(i);
        if HoleError then Exit;
        K:=K-1;
        J:=J+1;
        if (K > Zero) and (J <= TempCount) then
        Begin
          i:=i+1;
          X:=Temp[J,1];
          Y:=Pipe[K,1];
        End;
      End;
{  not to be confused with previous block if Pipe=Hole and on
   last hole section, because it does this first before looping
   back. K is here set to zero which exits the algorithm }

{ first check to see if pipe is off bottom (no more pipe after this).
  If yes, last hole section is equal to remaining pipe length and
  extra (non circulating) volume must be calculated in ExtraVol }

      if (K = 1) and (J=TempCount) then    { if on last section of pipe + hole }
      Begin
        HoleSection[i,1]:=Y;       { section for analysis must be pipe length }
        if X>Y then                { if off bottom...}
        Begin
          ExtraHole[1]:=X-Y;       { off-bottom distance }
          ExtraHole[2]:=Temp[J,2]; { hole ID }
          ExtraVolume:=ExtraHole[1] * BblPerFoot(ExtraHole[2]); { extra volume }
        End;

        HoleSection[i,2]:=Temp[J,2];
        HoleSection[i,3]:=Pipe[K,3];
        HoleSection[i,4]:=Pipe[K,2];
        ErrorCheck(i);
        if HoleError then Exit;
        K:=Zero;                      { ...To Exit }
      End;
    End;


    TotHoleSections:=i;
 { Set up well volume below before calculating from HoleSection[i].
   Initially set to zero, ExtraVolume is only non-zero if off-bottom
   Well Volume is still correct because it includes the ExtraVolume.
   Annular volume is compensated for non-circulating volume. }

    WellVol:=ExtraVolume;
    PipeCap:=Zero;
    PipeDis:=Zero;
    For i:=1 to TotHoleSections do
          WellVol:=WellVol + HoleSection[i,1] * BblPerFoot(HoleSection[i,2]);

    For i:=1 to MaxPipes do
    Begin
      PipeCap:=PipeCap + Pipe[i,1] * BblPerFoot(Pipe[i,2]);
      PipeDis:=PipeDis + Pipe[i,1] * BblPerFoot(Pipe[i,3]);
      FillCE[i]:=BblPerFoot(Pipe[i,3]) * StandLen;
      FillOE[i]:=(sqr(Pipe[i,3])-Sqr(Pipe[i,2])) / VolCon * StandLen;
    End;

    AnnVol:=(WellVol - ExtraVolume) - PipeDis; { don't include extra hole vol }
    HoleVol:=AnnVol + PipeCap + ExtraVolume;
    MudVol:=HoleVol;             { set to correct hole volume }
  End;
//  ConUser;
//  ConUserKickData;
End;

Begin
End.
