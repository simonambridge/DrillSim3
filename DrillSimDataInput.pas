Unit DrillSimDataInput;

Interface

Uses Crt,
     DrillSimVariables,
     DrillSimUtilities,
     DrillSimMessageToMemo;

Procedure UpdateWellTests;

Implementation

Procedure GetState(Item : boolean);
Begin
  if Item then YesNo:=Yes else YesNo:=No;
End;

{*********************** Input Procedures ******************}

Procedure UpdateWellTests;
Var i,j : integer;
    ZeroFound : boolean;
    EscPressed: boolean;

Function CheckForZero : boolean;
Begin
  if (Data.Rock[i].Depth = Zero)
    or (Data.Rock[i].Hardness = Zero)
    or (Data.Rock[i].FP = Zero) then CheckForZero:=True
                                else CheckForZero:=False;
End;

Begin
  With Data do
  Begin
    gotoxy(10,6);
    write('Last Leak-off depth      : ',LotTD:9:3,' ',UoMLabel[1]);
    gotoxy(10,8);
    write('Last Leak-off Mud Weight : ',LotMW:9:3,' ',UoMLabel[2]);
    gotoxy(10,10);
    write('Last Leak-off EMW        : ',LotEMW:9:3,' ',UoMLabel[2]);
    gotoxy(10,12);
    write('Last Leak-off Pressure   : ',LotPressure:9:3,' ',UoMLabel[3]);
    gotoxy(10,14);
    write('Casing Burst Pressure    : ',CasingBurstPressure:9:3,' ',UoMLabel[3]);
    For i:=1 to MaxPipes do
    Begin
      gotoxy(10,16+(i-1));
      write('Pipe #',i,' Weight           : ',Pipe[i,4]:9:3,' lb/ft');
    End;

    GetReal(55,6,25000/UoMConverter[1]);
    if Valid then LotTD:=RealResult;
    gotoxy(55,6); write(LotTD:9:3);

    GetReal(55,8,25/UoMConverter[2]);
    if Valid then LotMW:=RealResult;
    gotoxy(55,8); write(LotMW:9:3);

    GetReal(55,10,25/UoMConverter[2]);
    if Valid then LotEMW:=RealResult;
    gotoxy(55,10); write(LotEMW:9:3);

    GetReal(55,12,5000/UoMConverter[3]);
    if Valid then LotPressure:=RealResult;
    gotoxy(55,12); write(LotPressure:9:3);

    GetReal(55,14,15000/UoMConverter[3]);
    if Valid then CasingBurstPressure:=RealResult;
    gotoxy(55,14); write(CasingBurstPressure:9:3);

    For i:=1 to MaxPipes do
    Begin
      GetReal(55,16+(i-1),250);
      if Valid then Pipe[i,4]:=RealResult;
      gotoxy(55,16+(i-1)); write(Pipe[i,4]:9:3);
    End;

    StrWt:=Zero;       { set up strwt in case pipe weights changed }
    For i:=1 to MaxPipes do StrWt:=StrWt + (Pipe[i,1] * Pipe[i,4]) / 1000;


{ ===================== Formation Parameter Table ==========================}

    //Disp(14,4,'Horizon Top');
    //Disp(16,5,'('+UoMLabel[1]+')');

    //Disp(36,4, 'Hardness');
    //Disp(35,5,'(0.1 - 1.0)');

    //Disp(50,4,'Formation Pressure');
    //Disp(57,5,'('+UoMLabel[3]+')');

    //Box(10,6,70,17);
    //DrawSingleLine(10,70,6);

    For i:=1 to 10 do         { display current data table }
    Begin
      j:=7+(i-1);                              { calculate screen line number }

      Str(i:2,TempString);                     { display horizon number }
      //Disp(8,j,TempString);

      Str(Rock[i].Depth:9:3,TempString);       { display horizon top }
      //Disp(11,j,TempString);

      Str(Rock[i].Hardness:5:2,TempString);    { display horizon hardness }
      //Disp(33,j,TempString);

      Str(Rock[i].FP:9:3,TempString);          { display horizon form. pr. }
      //Disp(50,j,TempString);
    End;

    EscPressed:=False;
    i:=1;                                { start at first entry }

    Repeat
      j:=7+(i-1);
      TextColor(White);                             { select input text color }

      GetReal(22,j,25000/UoMConverter[1]);                   { get depth }
      if Esc then EscPressed:=True;                 { ESC ?     }
      if Valid then Rock[i].Depth:=RealResult;         { valid ? if yes, use it  }
      gotoxy(22,j); write(Rock[i].Depth:9:3);       { display current value   }
      if not EscPressed then                        { not if exit requested }
      Begin
        GetReal(42,j,1);                            { get hardness }
        if Esc then EscPressed:=True;
        if Valid then Rock[i].Hardness:=RealResult;
        gotoxy(42,j); write(Rock[i].Hardness:5:2);

        if not EscPressed then                      { not if exit requested }
        Begin
          GetReal(60,j,20000/UoMConverter[1]);               { get formation pressure }
          if Esc then EscPressed:=True;
          if Valid then Rock[i].FP:=RealResult;
          gotoxy(60,j); write(Rock[i].FP:9:3);
        End;
      End;

      if (i=1) and CheckForZero then
      Begin
        StringToMemo('First entries cannot be zero');
        EscPressed:=False;      { don't permit exit if bad data }
        i:=Zero;                { reset to start at first entry }
      End;
      i:=i+1;
    Until (i>10) or EscPressed;

    ZeroFound:=False;
    i:=1;               { start at second entry - first entry checked above }

    Repeat
      i:=i+1;
      if CheckForZero then
      Begin
        ZeroFound:=True;
        StringToMemo('Warning : some entries contain zero');
      End;
    Until (i=10) or ZeroFound;

    RockPointer:=1;          { set up for drilling - gets set up in Simulate }
                             { anyway but needs initialisation               }
    FormationPressureGradient:=
             ((Rock[1].FP * UoMConverter[3]) / (Rock[1].Depth * UoMConverter[1])) / Presscon;
  End;
 End;





Begin
End.

