Unit DrillSimUtilities;

Interface

Uses Crt,
     Dos,
     Math,
     DrillSimVariables,
     HyCalcVariables,
     Dialogs;

Procedure GetKey;
Procedure GetString(x, y, z : integer);
Procedure GetReal(x, y : integer; z : real);
Procedure GetInt(x, y, z : integer);
Procedure HelpWindow(Index : integer);
Procedure ConReal(Variable : real; Field,DPlaces : integer);
Procedure ConInt(Variable : integer; Field : integer);
Procedure GetCurrentDate (Var d : Date);
Procedure GetCurrentTime (Var t : Time);
Function Round2(const Number: extended; const Places: longint): extended;

Implementation

function Round2(const Number: extended; const Places: longint): extended;
var t: extended;
begin
   t := power(10, places);
   Round2 := round(Number*t)/t;
end;

Procedure GetCurrentDate (Var d : Date);
Begin
  GetDate(d.Year, d.Month, d.day, d.DayOfWeek);
End;

Procedure GetCurrentTime (Var t : Time);
Begin
  GetTime(t.Hours, t.Minutes, t.Seconds, t.Hundredths);
End;



Procedure GetKey;
Begin
  Repeat Until Keypressed;
  CharInput:=UpCase(ReadKey);
End;


Procedure GetString(x, y, z : integer);  { cursor is set on in calling routine }
Begin
  Edited:=True;
  Valid:=False;
  Esc:=False;
  Instring:='';
  Repeat
    gotoxy(x + length(Instring),y);
    CharInput:=ReadKey;
    if UpCase(CharInput) in [' '..'_',^[] then
    Begin
      if CharInput=^[ then
      Begin
        Esc:=True;
        Exit;
      End;
      if length(Instring) < z then Instring:=Instring + CharInput;
    End;
    if (CharInput=^H) and (length(Instring) > Zero) then
    Begin
        //Disp(x + length(Instring)-1,y,' ');
      Delete(Instring,length(Instring),1);
    End;
    //Disp(x,y,Instring);
  Until CharInput=^M;
  if length(Instring) > Zero then Valid:=True;
  //Disp(x,y,copy(BlankString,1,length(Instring)));
End;


Procedure GetReal(x, y : integer; z : real);
Var i : integer;
Begin
  Edited:=True;
  Valid:=False;
  Esc:=False;
  Repeat
    Instring:=''; i:=Zero; RealResult:=Zero;
    gotoxy(x,y);
    //Disp(x,y,copy(BlankString,1,9));
    Repeat
      CharInput:=ReadKey;
      if UpCase(CharInput) in ['-','.','0'..'9',^[] then
      Begin
        if CharInput=^[ then
        Begin
          Esc:=True;
          Exit;
        End;
        if length(Instring) < 9 then Instring:=Instring + CharInput; { ie 99999.999}
      End;
      if (CharInput=^H) and (length(Instring) > Zero) then
      Begin
        gotoxy(x + length(Instring)-1,y); write(' ');
        Delete(Instring,length(Instring),1);
      End;
      gotoxy(x,y); write(Instring);
    Until CharInput=^M;
    if length(Instring)>Zero then Val(Instring,RealResult,i);
  Until (i = Zero) and (RealResult <= z);
  if length(Instring) > Zero then Valid:=True;
  //Disp(x,y,copy(BlankString,1,length(Instring)));
End;


Procedure GetInt(x, y, z : integer);
Var i : integer;
Begin
  Edited:=True;
  Valid:=False;
  Esc:=False;
  Repeat
    Instring:=''; i:=Zero; IntResult:=Zero;
    gotoxy(x,y);
    //Disp(x,y,copy(BlankString,1,5));
    Repeat
      CharInput:=ReadKey;
      if UpCase(CharInput) in ['-','0'..'9',^[] then
      Begin
        if CharInput=^[ then
        Begin
          Esc:=True;
          Exit;
        End;
        if length(Instring) < 5 then Instring:=Instring + CharInput; { ie 32767 }
      End;
      if (CharInput=^H) and (length(Instring) > Zero) then
      Begin
        gotoxy(x + length(Instring)-1,y); write(' ');
        Delete(Instring,length(Instring),1);
      End;
      gotoxy(x,y); write(Instring);
    Until CharInput=^M;
    if length(Instring)>Zero then Val(Instring,IntResult,i);
  Until (i = Zero) and (IntResult <= z);
  if length(Instring) > Zero then Valid:=True;
  //Disp(x,y,copy(BlankString,1,length(Instring)));
End;


Procedure ConReal(Variable : real; Field,DPlaces : integer);
Begin
  Str(Variable:Field:DPlaces,TempString);
End;


Procedure ConInt(Variable : integer; Field : integer);
Begin
  Str(Variable:Field,TempString);
End;


Procedure HelpWindow(Index : integer);
Var i,j : integer;
Begin
//  TAttr:=AttrByte;
  j:=(Index-1)*10+1;  { ie 1=1-10, 2=11-20, etc }
  {MakeWindow (4,10,15,60,Blue+LightGrayBG,Blue+LightGrayBG,HdoubleBrdr,
               Window1); }
  Window(1,1,80,25);
  //SetColorSet(BlueOnGray);
  if HelpFileFound then
  Begin
    for i:= j to j+9 do //Disp(12,6+(i-j),Help.HelpText[i]);
  End else
  Begin
    //Disp(12,12,NoHelp1);  { "help not found" }
    //Disp(12,14,NoHelp2);  { "no help available" }
  End;
  {ModCursor(CursorOn);}
  //Disp(12,17,PressPrompt);
  gotoxy(28,17);
  Repeat Until KeyPressed;
  CharInput:=ReadKey;
  {ModCursor(CursorOff); }
  {RemoveWindow; }
//  AttrByte:=TAttr;
End;

Begin
End.