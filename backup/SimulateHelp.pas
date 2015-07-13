Unit SimulateHelp;

Interface

Uses Crt,
     DrillSimVariables,
     SimulateVariables;

Procedure ShowHelp;

Implementation


Procedure ShowHelp;
Label Adios;

Procedure DisplayHelp(Index : integer);
Var i, j : integer;
Begin
  j:=(Index-1)*10+1;                          { ie 1=1-10, 2=11-20, etc }
  for i:= j to j+9 do //Disp(12,6+(i-j),Help.HelpText[i]);
  //Disp(12,17,HelpPrompt);
  Repeat
    CharInput:=ReadKey;
  Until CharInput in [^[,^M];
End;

Procedure ClearHelp;
Var i: integer;
Begin
  For i:=5 to 17 do //Disp(12,i,copy(BlankString,1,57));
End;

Begin
  {MakeWindow (4,10, 15,61,Blue+LightGrayBG,Blue+LightGrayBG,HdoubleBrdr,
               Window1); }
  if not HelpFileFound then
  Begin
    //Disp(12,12,NoHelp1);
    //Disp(12,14,NoHelp2);
    //Disp(12,17,PressPrompt);
    gotoxy(28,17);
    Repeat Until KeyPressed;
    Input:=ReadKey;                 { clear kbd buffer }
  End else
  Begin
    DisplayHelp(11);
    if CharInput=^[ then goto Adios;
    ClearHelp;
    DisplayHelp(12);
    if CharInput=^[ then goto Adios;
    ClearHelp;
    DisplayHelp(13);
    if CharInput=^[ then goto Adios;
    ClearHelp;
    DisplayHelp(14);
  End;
 { Adios : RemoveWindow;  }
 Adios : Exit;
End;


Begin
End.
