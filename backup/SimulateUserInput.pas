Unit SimulateUserInput;

Interface

Uses Crt,
     DrillSimVariables,
     SimulateMessageToMemo,
     SimulateScreen,
     SimulateVolumes,
     DrillSimFileIO,
     SimulateFile,
     SimulateInit,
     SimulateUpdate,
     SimulateHoleCalcs,
     SimulateHydrostaticCalcs,
     SimulateHelp,
     SimulateSurfaceControls,
     SimulateClear,
     SimulateRAMs,
     DrillSimSound;

Procedure CommandProcessor;

Implementation

Uses DrillSimGUI;
{ -------------------- Extended Commands ------------------- }

Procedure BOPCommands;
Var x:integer;
Begin
  With Data do
  Begin
    if length(InputString)>1 then
    Begin
      Edited:=True;
      Input:=copy(InputString,2,1);
      if KelHt = 33 then
      Begin
        Case Input[1] of
        'H' : Begin
                Hydril:=not(Hydril);
                RamCheck;
              End;

        'B' : Begin
                x:=13;
                MessageToMemo(x);    { "unable..." - not possible to close }
              End;                   {               Blind Rams            }

        'P' : Begin
                PipeRam:=not(PipeRam);
                RamCheck;
              End;
        End;
      End else MessageToMemo(13);
    End;
  End;
End; { procedure BOPCommands; }


Procedure DCommands;
Var Temp,i : integer;
Begin
  if length(InputString)>1 then
  Begin
    Input:=copy(InputString,2,1);
    Case Input[1] of
      'D' : GetDirectory;
      'S' : MessageToMemo(15);  { Dn strokes }
      'T' : MessageToMemo(16);  { dn time }
      'A' : Begin
              if length(InputString)>2 then
              Begin
                Edited:=True;
                InputString:=copy(InputString,3,10);
                while copy(InputString,1,1)=Space do delete(InputString,1,1);
                Val(InputString,Temp,i);
                if i=Zero then Data.DrillMult:=Temp;
              End;
              MessageToMemo(73);
            End;
    End;
  End;
End;

{ ------------------------------------------------------- }

Procedure FCommands;
Begin
  With Data do
  Begin
    if length(InputString)>1 then
    Begin
      Input:=copy(InputString,2,1);
      Case Input[1] of
      'S' : Begin
              SaveFile;            { includes MessageToMemo(78) }
              gotoxy(39,12);
            End;
      'L' : Begin
              LoadFile;
              MessageToMemo(5);
              SimHoleCalc;         { do HoleCalc and initialise volumes }
              PitBox;              { Display correct parameters }
              SPPBox;
              FlowBox;
              DepthBox;
              MWBox;
              InitialiseKelly;   { clear box, draw scale and set up }
              SetKelly;          { move it to drilling position    }
              SetSurfControls;
              StackCalc;
            End;
      'P' : MessageToMemo(69);
      End;
    End;
  End;
End;


Procedure HCommands;
Begin
  if length(InputString)>1 then
  Begin
    if copy(InputString,1,4)='HELP' then
    Begin
      ShowHelp;
      Exit;
    End;
    Input:=copy(InputString,2,1);
    Case Input[1] of
      'B' : MessageToMemo(17);  { HHP bit }
      'E' : MessageToMemo(18);  { Bit Eff }
      'T' : MessageToMemo(19);  { Tot HHP }
      'P' : MessageToMemo(62);  { Hhd Pipe }
      'A' : MessageToMemo(63);  { Hhd Ann. }
      'W' : MessageToMemo(30);  { Ave Hhd }
    End;
  End;
End;

Procedure KCommands;
Begin
  if length(InputString)>1 then
  Begin
    Input:=copy(InputString,2,1);
    Case Input[1] of
      'D' : MessageToMemo(76);
    End;
  End;
End;


Procedure MudCommands;
Var i,x  : integer;
    Temp : real;
    P, Q : real;
Begin
  With Data do
  Begin
    x:=3;
    if length(InputString)>1 then
    Begin
           if length(InputString)>2 then  { count spaces to data for all 4 options }
              While (copy(InputString,x,1)=Space) and (x<=21) do x:=x+1;
      Case InputString[2] of
        'W' : Begin
                if length(InputString)>2 then
                Begin
                  Val(copy(InputString,x,10),Temp,i);
                  if i=Zero then
                  Begin
                    Edited:=True;
                    MWIn:=Temp * con[2];
                    if StackPointer < 200 then StackPointer:=StackPointer+1
                    else
                               { free stack space by merging last two entries }
                    Begin
                      P:=(CircStack[StackPointer].StartStrokes -
                                      CircStack[StackPointer-1].StartStrokes);
                      P:=P * CircStack[StackPointer-1].MW;
                      Q:=(StrokeCounter-CircStack[StackPointer].StartStrokes);
                      Q:=Q * CircStack[StackPointer].MW;
                      CircStack[StackPointer-1].MW:=(P + Q) / 2;
                    End;                             { Pv, Yp unchanged }

                    CircStack[StackPointer].MW          :=MWIn;
                    CircStack[StackPointer].StartStrokes:=StrokeCounter;
                    CircStack[StackPointer].PV          :=MudPV;
                    CircStack[StackPointer].YP          :=MudYP;
                  End;
                End;
                MessageToMemo(20);
              End;
        'P' : Begin
                if length(InputString)>2 then
                Begin
                  Val(copy(InputString,x,10),Temp,i);
                  if i=Zero then
                  Begin
                    Edited:=True;
                    MudPv:=Temp;
                  End;
                End;
                MessageToMemo(21);
              End;
        'Y' : Begin
                if length(InputString)>2 then
                Begin
                  Val(copy(InputString,x,10),Temp,i);
                  if i=Zero then
                  Begin
                    Edited:=True;
                    MudYp:=Temp;
                  End;
                End;
                MessageToMemo(22);
              End;
        'G' : Begin
                if length(InputString)>2 then
                Begin
                  Val(copy(InputString,x,10),Temp,i);
                  if i=Zero then
                  Begin
                    Edited:=True;
                    MudGel:=Temp;
                  End;
                End;
                MessageToMemo(23);
              End;
      End;
    End;
  End;
End; { procedure MudCommands; }


Procedure PCommands;
Var result : real;
    x, i   : integer;
Begin
  if length(InputString)>1 then
  Begin
    Input:=copy(InputString,2,1);
    Case Input[1] of
      'L' : MessageToMemo(24);  { PlSurf. Lines }
      'P' : MessageToMemo(25);  { PlPipe        }
      'N' : MessageToMemo(26);  { PlBit         }
      'A' : MessageToMemo(27);  { PlAnn         }
      'T' : MessageToMemo(28);  { Total         }
      'B' : MessageToMemo(29);  { Ann. BHP      }
      'M' : MessageToMemo(53);  { MACP          }
      'X' : MessageToMemo(55);  { PlChoke       }
      'U' : MessageToMemo(61);  { Ann. U.Bal    }
      'V' : Begin            { Pit Volume    }
              if length(InputString)>2 then
              Begin                     { count spaces to data }
                x:=3;
                While (copy(InputString,x,1)=Space) and (x<=21) do x:=x+1;
                Val(copy(InputString,x,10),result,i);
                if (i=Zero) and (x<999) then
                Begin
                  Edited:=True;
                  Data.RetPitVol:=result * con[4];
                End;
              End;
              MessageToMemo(77);
            End;
    End;
  End;
End;


Procedure RCommands;
Begin
  if length(InputString)>1 then
  Begin
    Input:=copy(InputString,2,1);
    Case Input[1] of
      'B' : Begin
              Data.Bingham:=True;
              MessageToMemo(31);
              Edited:=True;
            End;
      'P' : Begin
              Data.Bingham:=False;
              MessageToMemo(32);
              Edited:=True;
            End;
      'C' : Begin
              Data.StrokeCounter:=Zero;
              MessageToMemo(66);
              Edited:=True;
            End;
    End;
  End else
  Begin
    if Data.Bingham then MessageToMemo(31) else MessageToMemo(32);
  End;
  CalculatedSoFar:=Zero;             { to force a recalculation }
End;


Procedure SlowPumpCommands;
Var
  x    : integer;

Procedure GetPumpData(x,y,z : integer);             { 1st msg#, pump#, 2nd msg# }
Var i    : integer;
    Temp : real;
Begin
  With Data do
  Begin
    MessageToMemo(x);
    gotoxy(47,24);
    InputString:='';
    Read(InputString);
    if length(InputString)>Zero then
    Begin
      ThisString:=ThisString + InputString;
      Val(InputString,Temp,i);
      if i=Zero then Pump[y,4]:=Temp;
    End;
    MessageToMemo(z);
    gotoxy(47,24);
    InputString:='';
    Read(InputString);
    if length(InputString)>Zero then
    Begin
      ThisString:=ThisString + InputString;
      Val(InputString,Temp,i);
      if i=Zero then Pump[y,5]:=Temp * con[3];
    End;
  End;
End;

Begin
  x:=2;
  if length(InputString)<x then
  Begin
    MessageToMemo(33);
    gotoxy(43,24);
    Repeat
      Read(CharInput);
    Until CharInput in ['1','2'];
    PreviousString:=PreviousString + CharInput;
  End else
  Begin
    Input:=copy(InputString,x,1);
  End;
  Edited:=True;
  if Input[1] in ['1','2'] then ThisString:='>Slow rate, Pump #' + Input;
  Case Input[1] of
     '1' : GetPumpData(34,1,35);    { 1st msg#, pump#, 2nd msg# }

     '2' : GetPumpData(36,2,37);
  End;
End; { procedure SlowPumpCommands; }


Procedure TCommands;
Begin
  if length(InputString)>1 then
  Begin
    gotoxy(33,23);
    Input:=copy(InputString,2,1);
    Case Input[1] of
      'O' : MessageToMemo(75);  { twist-off point }
      'R' : Begin            { trace on - write parameters to printer }
              Trace:=not Trace; { toggle it }
              Edited:=True;
            End;
    End;
  End;
End;

Procedure UCommands;
Begin
  if length(InputString)>1 then
  Begin
    gotoxy(33,23);
    Input:=copy(InputString,2,1);
    Case Input[1] of
      'S' : MessageToMemo(46);  { Up strokes }
      'T' : MessageToMemo(47);  { Up time }
    End;
  End;
End;


Procedure VCommands;
Begin
  if length(InputString)>1 then
  Begin
    gotoxy(33,23);
    Input:=copy(InputString,2,1);
    Case Input[1] of
      'A' : MessageToMemo(48);     { Ann. volume    }
      'E' : MessageToMemo(59);     { version number }
      'P' : MessageToMemo(49);     { Pipe capacity  }
      'M' : MessageToMemo(50);     { Mud  volume    }
      'W' : MessageToMemo(51);     { Well capacity  }
      'H' : MessageToMemo(60);     { Hole capacity  }
      'L' : MessageToMemo(56);     { Water fraction }
      'O' : MessageToMemo(57);     { Oil   fraction }
      'S' : MessageToMemo(58);     { Solid fraction }
    End;
  End;
End;


Procedure WCommands;
Begin
  if length(InputString)>1 then
  Begin
    gotoxy(33,23);
    Input:=copy(InputString,2,1);
    Case Input[1] of
      'H' : MessageToMemo(38);  { WOH }
      'S' : MessageToMemo(39);  { Str. Wt }
      'E' : MessageToMemo(40);  { ECD }
      'W' : MessageToMemo(41);  { Ave MW }
      'A' : MessageToMemo(42);  { Ann MW }
      'P' : MessageToMemo(43);  { Pipe MW }
      'N' : MessageToMemo(44);  { Exp n }
      'K' : MessageToMemo(45);  { Exp k }
    End;
  End;
End;

{* ==================== Command Processor =================== *}
Procedure CommandProcessor;
Var
  i : integer;
Begin
  MessageToMemo(5);
  Quit:=False;
  writeln('CommandProcessor Started');

  if length(InputString) > Zero then
  Begin                            { convert to upper case }
    for i:=1 to length(InputString) do InputString[i]:=UpCase(InputString[i]);

    DrillSim.Memo1.Lines.Add('Running with ' + InputString);
    writeln('Running with ' + InputString);

    Input:=copy(InputString,1,1);
    Case Input[1] of
      'B' : BOPCommands;
      'C' : Clear;
      'D' : DCommands;
      'F' : FCommands;
      'H' : HCommands;
      'K' : KCommands;
      'M' : MudCommands;
      'P' : PCommands;
      'Q','X','E' : Quit:=True;  { appears like 'Quit', 'Exit' and 'X' all work }
      'R' : RCommands;
      'S' : SlowPumpCommands;
      'T' : TCommands;
      'U' : UCommands;
      'V' : VCommands;
      'W' : WCommands;
    End;
    Input:=Space;
  End else
  Begin                     // not a recognised command
    With DrillSim do
    Begin
      Memo1.Lines.Add(ThisString + ' ?');
      Memo1.SelStart:=Length(Memo1.Text);
    end;
  End;
End; { Procedure CommandProcessor; }


Begin
End.
