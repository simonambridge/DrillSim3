Unit SimulateScreen;

Interface

Uses Crt,
     DrillSimVariables;

Procedure DrillingWindow;
Procedure ShutInWindow;
Procedure FlowlineWindow;
Procedure PitBox;
Procedure FlowBox;
Procedure SPPBox;
Procedure MWBox;
Procedure DepthBox;           { this proc. calls BitBox, TotBox }
Procedure InitialiseKelly;   { clears box, draws scale and kelly }
Procedure Screen;

Implementation


{ -------------- Parameter Boxes -------------- }

Procedure BitBox;
Begin
  //Box(13,2,27,4);
  Str(Data.BitTD / con[1]:8:2,TempString);
  //Disp(15,3,TempString);
  //Disp(24,3,lab[1]);
End;

Procedure TotBox;
Begin
  //Box(13,5,27,7);
  Str(Data.TD / con[1]:8:2,TempString);
  //Disp(15,6,TempString);
  //Disp(24,6,lab[1]);
End;

Procedure RotaryBox(Ink, Paper : integer);
Begin
  TextColor(Ink); TextBackground(Paper); { set box colours }
  Window(13,8,27,13);   ClrScr;
  //DispColor(Ink,Paper);
  //Box(13,8,27,10);
  //Box(13,11,27,13);
  Str(Data.WOB / con[7]:8:2,TempString);
  //Disp(15,9,TempString);  //Disp(24,9,lab[7]);
  Str(Data.RPM:6:Zero,TempString);
  //Disp(16,12,TempString);
End;


Procedure PressureBox(Ink, Paper : integer);
Begin
  TextColor(Ink); TextBackground(Paper); { set box colours }
  Window(13,8,27,13);  ClrScr;
  //DispColor(Ink,Paper);
  //Box(13,8,27,10);
  //Box(13,11,27,13);
  Str(Data.BHPAnn / con[3]:8:2,TempString);
  //Disp(15,9,TempString);   //Disp(24,9,lab[3]);
  Str(Data.CasingPressure / con[3]:8:2,TempString);
  //Disp(15,12,TempString);  //Disp(24,12,lab[3]);
End;


Procedure ChokeBox(Ink, Paper : integer);
Begin
  TextColor(Ink); TextBackground(Paper);
  Window(65,9,78,11); ClrScr;
  //DispColor(Ink,Paper);
  //Box(65,9,78,11);
  Str(Data.Choke:4,TempString);
  //Disp(66,10,TempString);
  //Disp(70,10,' % open');
End;

{------------------ one-color boxes -------------}

Procedure PumpBox;
var i : integer;
Begin
  With Data do
  Begin
    //Box(13,15,27,21);
    for i:=1 to 3 do
    Begin
      Str(Data.Pump[i,3]:6:Zero,TempString);
      //Disp(16,16+((i-1)*2),TempString);
    End;
    TempString:='SPM';
    //Disp(24,16,TempString);
    //Disp(24,18,TempString);
    //Disp(24,20,TempString);
  End;
End;


Procedure CounterBox;
Begin
  //Box(13,22,27,24);
  Str(Data.StrokeCounter:8:Zero,TempString);
  //Disp(14,23,TempString);
  //Disp(24,23,'Str');
End;


Procedure MWBox;
Begin
  //Box(41,16,53,20);
  Str(Data.MwIn / con[2]:6:3,TempString);
  //Disp(43,17,TempString);
  //Disp(50,17,lab[2]);
  Str(Data.MwOut / con[2]:6:3,TempString);
  //Disp(43,19,TempString);
  //Disp(50,19,lab[2]);
End;


Procedure BOPBox;
Begin
  //Box(65,2,78,8);
  TempString:='Open';
  //Disp(70,3,TempString);
  //Disp(70,5,TempString);
  //Disp(70,7,TempString);
End;



Procedure FlowBox;
Begin
  //Box(65,12,78,16);
  Str(Data.FlowIn/con[5]:8:2,TempString);
  //Disp(66,13,TempString);
  //Disp(75,13,lab[6]);
  Str(Data.FlowOut/con[5]:8:2,TempString);
  //Disp(66,15,TempString);
  //Disp(75,15,lab[6]);
End;


Procedure SPPBox;
Begin
  //Box(65,17,78,19);
  Str(Data.PlCirc / con[3]:8:2,TempString);
  //Disp(66,18,TempString);
  //Disp(75,18,lab[3]);
End;


Procedure PitBox;
Begin
  With Data do
  Begin
    //Box(65,20,78,24);
    Str(Data.RetPitVol/con[4]:8:2,TempString);
    //Disp(66,21,TempString);
    //Disp(75,21,lab[4]);
    Str(Data.InfluxRate/con[4]:8:3,TempString);
    //Disp(66,23,TempString);
    //Disp(75,23,copy(lab[4],1,1) + 'pm');
  End;
End;

Procedure DepthBox;           { this proc. calls BitBox, TotBox }
Begin
  BitBox;
  TotBox;
End;

{ ------------------ Screen-build routines ------------------ }

Procedure ShutInWindow;
Begin
  TAttr:=AttrByte;
  PressureBox(LightRed,Black);
  TextColor(Cyan);                          { set text colour }
  Window(2,8,12,13); ClrScr;
  //DispColor(Cyan,Black);
  //Disp(3,9,'Ann. BHP');
  //Disp(3,12,'Csg. Pr.');
  Window(1,1,80,25);
  AttrByte:=TAttr;
End;


Procedure DrillingWindow;
Begin
  TAttr:=AttrByte;
  RotaryBox(Lightgray,Black);
  TextColor(Yellow);                        { set text colour }
  Window(2,8,12,13); ClrScr;
  //DispColor(Cyan,Black);
  //Disp(3,9,'W.O.B.');
  //Disp(3,12,'R.P.M.');
  Window(1,1,80,25);
  AttrByte:=TAttr;
End;

Procedure FlowlineWindow;
Begin
  TAttr:=AttrByte;
  if not Data.Flowline then
  Begin
    ChokeBox(Lightgray,Black);
    TextColor(Yellow);
    //DispColor(Yellow,Black);
  End else
  Begin
    ChokeBox(LightRed,Black);
    TextColor(Cyan);
    //DispColor(Cyan,Black);
  End;
  Window(57,9,61,11); ClrScr;
  //Disp(57,10,'CHOKE');
  Window(1,1,80,25);
  AttrByte:=TAttr;
End;



Procedure InitialiseKelly;   { clears box, draws scale and kelly }
Var i : integer;
    x, y : real;
Begin
  TAttr:=AttrByte;
  TextColor(White);
  TextBackground(Blue);
  Window(31,2,43,13);
  ClrScr;
  //SetColorSet(WhiteOnBlue);

  Col:=34; OutString:=chr($de);                      { Kelly Scale }
  //for Row:=2 to 13 do Disp(Col,Row,OutString);

  Row:=14; OutString:=chr($df);
  //for Col:=31 to 37 do Disp(Col,Row,OutString);
  //for Col:=41 to 43 do Disp(Col,Row,OutString);

  //Disp(38,14,chr($dd) + chr($db) + chr($de));

  if con[1] <> 1 then
  Begin
    x:=42/int(con[1]);
    y:=x/7;
  End;

  for i:=1 to 6 do
  Begin
    //Disp(35,i*2,chr($df));
    if con[1]=1 then Str(42-i*6:2,TempString) else Str(x-i*y:2:0,TempString);
    //Disp(32,i*2,TempString);
  End;

  //Disp(38,2,SolidUpper);
  Col:=39; OutString:=chr($db);
  for Row:=3 to 12 do //Disp(Col,Row,OutString);          { Kelly body }
  //Disp(37,13,UpBushing);
  Window(1,1,80,25);
  AttrByte:=TAttr;
End;


Procedure Screen;
Begin              { define kelly graphics }
  TAttr:=AttrByte;
  Bushing[1]:= chr($dc) + chr($c4) + chr($db) + chr($dc) + chr($bf);
  Bushing[2]:= chr($da) + chr($dc) + chr($db) + chr($c4) + chr($dc);
  Bushing[3]:= chr($dc) + chr($dc) + chr($df) + chr($dc) + chr($dc);

  UpBushing := chr($df) + chr($df) + chr($db) + chr($df) + chr($df);
  DnBushing := chr($dc) + chr($dc) + chr($db) + chr($dc) + chr($dc);

  SolidUpper:= chr($db) + chr($db) + chr($db);
  SplitUpper:= chr($dc) + chr($dc) + chr($dc);
  SplitLower:= chr($df) + chr($db) + chr($df);
  KellyPipe := chr($20) + chr($db) + chr($20);

  TextColor(Yellow);    TextBackground(Black); ClrScr; { set screen colours }
  TextColor(Lightgray); TextBackground(Black);         { set window colours }
  Window(13,15,27,24);  ClrScr;
  Window(41,16,53,20);  ClrScr;
  Window(65,2,78,24);   ClrScr;
  Window(31,22,54,24);  ClrScr;
  //SetColorSet(YellowOnBlack);
  //Disp(1,1,chr($c9));     //HLine(2,29,1);
  //Disp(30,1,chr($cb));    //HLine(31,43,1);
  //Disp(44,1,chr($cb));    //HLine(45,54,1);
  //Disp(55,1,chr($cb));    //HLine(56,79,1);
  //Disp(80,1,chr($bb));
  //VLine(2,24,1);          //VLine(2,13,30);        //VLine(2,14,44);
  //VLine(2,14,55);         //VLine(2,24,80);
  //Disp(1,14,chr($cc));    //HLine(2,29,14);
  //Disp(30,14,chr($b9));   //Disp(30,15,chr($cc));  //HLine(31,43,15);
  //Disp(44,15,chr($ca));   //HLine(45,54,15);
  //Disp(55,15,chr($b9));   //Disp(1,25,chr($c8));   //HLine(2,29,25);
  //Disp(30,25,chr($ca));   //VLine(16,20,30);
  //Disp(30,21,chr($cc));   //VLine(22,24,30);
  //HLine(31,54,21);
  //Disp(55,21,chr($b9));   //HLine(31,54,25);
  //Disp(55,25,chr($ca));   //VLine(16,20,55);
  //VLine(22,24,55);        //HLine(56,79,25);
  //Disp(80,25,chr($bc));

  //Disp(46,2,'Kelly Ht.'); //Disp(52,3,lab[1]);  { Boxes and parameter labels }
  //Disp(47,5,'STATUS');
  //Disp(47,9,'Time');
  //Disp(47,12,'R.O.P.');   //Disp(47,14,ROPLab);
  //Disp(57,21,'RET. PIT'); //Disp(57,23,'DIF.FLOW');
  //Disp(57,18,'S.P.P.');
  //Disp(57,13,'FLOW IN');  //Disp(57,15,'FLOW OUT');
  //Disp(3,23,'Counter');
  //Disp(3,16,'Pump #1');  //Disp(3,18,'Pump #2'); //Disp(3,20,'Pump #3');
  //Disp(57,3,'HYDRIL');   //Disp(57,5,'BLIND');   //Disp(57,7,'PIPE');
  //Disp(32,17,'MW In');   //Disp(32,19,'MW Out');
  //Disp(3,3,'Bit Depth');
  //Disp(3,6,'Tot.Depth');

  //SetColorSet(GrayOnBlack);
  DepthBox;
  PitBox;
  DrillingWindow;
  SPPBox;
  PumpBox;
  FlowBox;
  CounterBox;
  FlowlineWindow;
  MWBox;
  BOPBox;


{ --------- Draw Kelly & Scale ----------- }

  InitialiseKelly;

{ -------------------- Initial Screen Data  ------------------- }

  TextColor(LightGray); TextBackground(Black);
  gotoxy(46,13);    write(Data.ROP:6:2);
  gotoxy(46,10);    write(t.Hours:2,':',t.Minutes:2,':',t.Seconds:2);
  gotoxy(45,6);     write(' On Slips ');
  gotoxy(46,3);     write(Data.KelHt / con[1]:5:2);
  TextColor(White); TextBackground(Red);
  gotoxy(32,21);    write(' Press "/" to request ');
  AttrByte:=TAttr;
End;

Begin
End.