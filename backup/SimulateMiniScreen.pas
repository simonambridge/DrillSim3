Unit SimulateMiniScreen;

Interface

Uses DrillSimVariables;

Procedure MiniScreen(x : integer);

Implementation

Procedure MiniScreen(x : integer);
Begin
  With Data do
  Begin
    LastString:=PreviousString;
    PreviousString:=ThisString;
    Case x of
      1 : ThisString:='>Autodrill is ON';
      2 : ThisString:='>Autodrill is OFF';
      3 : ThisString:='>ERROR : not pumping';
      4 : ThisString:='>ERROR : not rotating';
      5 : ThisString:=CommandLine;
      6 : ThisString:='>Blind Rams are CLOSED';
      7 : ThisString:='>Blind Rams are OPEN';
      8 : ThisString:='>Pipe Rams are CLOSED';
      9 : ThisString:='>Pipe Rams are OPEN';
     10 : ThisString:='>Are you sure (Y/N)? ';
     11 : ThisString:='>Hydril is CLOSED';
     12 : ThisString:='>Hydril is OPEN';
     13 : ThisString:='>Unable to close RAMs';
     14 : ThisString:='>Circ. through Choke';
     15 : Begin
            Str(LagDS:6:Zero,ThisString);
            ThisString:='>Lag Down :' + ThisString + ' str';
          End;
     16 : Begin
            Str(LagDT:6:1,ThisString);
            ThisString:='>Lag Down :' + ThisString + ' min';
          End;
     17 : Begin
            Str(BitHP:6:2,ThisString);
            ThisString:='>HHP Bit : ' + ThisString;
          End;
     18 : Begin
            Str(Eff:6:2,ThisString);
            ThisString:='>Bit Eff : ' + ThisString + ' %';
          End;
     19 : Begin
            Str(TotHp:6:2,ThisString);
            ThisString:='>HHP Total : ' + ThisString;
          End;
     20 : Begin
            Str(MWIn / con[2]:5:2,ThisString);
            ThisString:='>MW in : ' + ThisString + Space + lab[2];
          End;
     21 : Begin
            Str(MudPv:3:Zero,ThisString);
            ThisString:='>PV in : ' + ThisString + ' cp';
          End;
     22 : Begin
            Str(MudYp:3:Zero,ThisString);
            ThisString:='>YP in : ' + ThisString + ' lb/100ft2';
          End;
     23 : Begin
            Str(MudGel:3:Zero,ThisString);
            ThisString:='>Gel in : ' + ThisString;
          End;
     24 : Begin
            Str(PlSurf / con[3]:5:2,ThisString);
            ThisString:='>Pl S.Eqpt : ' + ThisString + Space + lab[3];
          End;
     25 : Begin
            Str(PlPipe / con[3]:5:2,ThisString);
            ThisString:='>Pl Pipe : ' + ThisString + Space + lab[3];
          End;
     26 : Begin
            Str(PlBit / con[3]:5:2,ThisString);
            ThisString:='>Pl Bit : ' + ThisString  + Space + lab[3];
          End;
     27 : Begin
            Str(PlAnn / con[3]:5:2,ThisString);
            ThisString:='>Pl Ann. : ' + ThisString  + Space + lab[3];
          End;
     28 : Begin
            Str((PlSurf+PlAnn+PlBit+PlPipe+PlChoke+ChokeLinePl) / con[3]:5:2,ThisString);
            ThisString:='>Total : ' + ThisString  + Space + lab[3];
          End;
     29 : Begin
            Str(BHPAnn / con[3]:5:2,ThisString);
            ThisString:='>BHP Ann : ' + ThisString  + Space + lab[3];
          End;
     30 : Begin
            Str(AverageHhd / con[3]:5:2,ThisString);
            ThisString:='>Ave Hhd : ' + ThisString  + Space + lab[3];
          End;
     31 : ThisString:='>Mode = Bingham';
     32 : ThisString:='>Mode = Power Law';
     33 : ThisString:='>Pump # ? ';
     34 : Begin
            Str(Pump[1,4]:5:Zero,ThisString);
            ThisString:='>' + ThisString  + Space + '   SPM ?'
          End;
     35 : Begin
            Str(Pump[1,5] / con[3]:8:2,ThisString);
            ThisString:='>' + ThisString  + Space + lab[3] + ' ? ';
          End;
     36 : Begin
            Str(Pump[2,4]:5:Zero,ThisString);
            ThisString:='>' + ThisString  + Space + '   SPM ?';
          End;
     37 : Begin
            Str(Pump[2,5] / con[3]:8:2,ThisString);
            ThisString:='>' + ThisString  + Space + lab[3] + ' ? ';
          End;
     38 : Begin
            Str(WOH / con[7]:6:2,ThisString);
            ThisString:='>WOH : ' + ThisString + Space + lab[7];
          End;
     39 : Begin
            Str(StrWt / con[7]:6:2,ThisString);
            ThisString:='>Str. Wt : ' + ThisString  + Space + lab[7];
          End;
     40 : Begin
            Str(ECD / con[2]:6:3,ThisString);
            ThisString:='>ECD : ' + ThisString  + Space + lab[2];
          End;
     41 : Begin
            Str(MudWt / con[2]:6:3,ThisString);
            ThisString:='>Av. MW : ' + ThisString  + Space + lab[2];
          End;
     42 : Begin
            Str(AnnMW / con[2]:6:3,ThisString);
            ThisString:='>Ann. MW : ' + ThisString  + Space + lab[2];
          End;
     43 : Begin
            Str(PipeMW / con[2]:6:3,ThisString);
            ThisString:='>Pipe MW : ' + ThisString  + Space + lab[2];
          End;
     44 : Begin
            Str(Fn:6:2,ThisString);
            ThisString:='>Exp "n" : ' + ThisString;
          End;
     45 : Begin
            Str(Fk:6:2,ThisString);
            ThisString:='>Exp "k" : ' + ThisString  + Space + lab[3];
          End;
     46 : Begin
            Str(LagUS:8:Zero,ThisString);
            ThisString:='>Lag Up : ' + ThisString  + ' str';
          End;
     47 : Begin
            Str(LagUT:8:1,ThisString);
            ThisString:='>Lag Up : ' + ThisString  + ' min';
          End;
     48 : Begin
            Str(AnnVol/con[4]:6:2,ThisString);
            ThisString:='>Ann. Vol. : ' + ThisString  + Space + lab[4];
          End;
     49 : Begin
            Str(PipeCap/con[4]:6:2,ThisString);
            ThisString:='>Pipe Vol. : ' + ThisString  + Space + lab[4];
          End;
     50 : Begin
            Str(MudVol/con[4]:6:2,ThisString);
            ThisString:='>Mud Vol. : ' + ThisString  + Space + lab[4];
          End;
     51 : Begin
            Str(WellVol/con[4]:6:2,ThisString);
            ThisString:='>Well ' + ThisString  + Space + lab[4];
          End;
     52 : ThisString:='>Bushing not in table';
     53 : Begin
            Str((Rock[RockPointer].FP + MACP) / con[3]:5:2,ThisString);
            ThisString:='>MACP : ' + ThisString  + Space + lab[3];
          End;
     54 : ThisString:='>Losing to formation';
     55 : Begin
            Str((PlChoke+ChokeLinePl) / con[3]:5:2,ThisString);
            ThisString:='>Pl Choke: ' + ThisString + Space + lab[3];
          End;
     56 : Begin
            Str(WaterFraction * 100:5:2,ThisString);
            ThisString:='>Mud : ' + ThisString + ' % water';
          End;
     57 : Begin
            Str(OilFraction * 100:5:2,ThisString);
            ThisString:='>Mud : ' + ThisString + ' % oil';
          End;
     58 : Begin
            Str(SolidsFraction * 100:5:2,ThisString);
            ThisString:='>Mud : ' + ThisString + ' % sol.';
          End;
     59 : ThisString:='Version ' + VersionNumber + ' ' + VersionDate;
     60 : Begin
            Str(HoleVol / con[4]:6:2,ThisString);
            ThisString:='>Hole Vol. : ' + ThisString  + Space + lab[4];
          End;
     61 : Begin
            Str(AnnUnderbalance / con[3]:5:2,ThisString);
            ThisString:='>Ann U/b : ' + ThisString  + Space + lab[3];
          End;
     62 : Begin
            Str(PipeHhd / con[3]:5:2,ThisString);
            ThisString:='>P.Head : ' + ThisString  + Space + lab[3];
          End;
     63 : Begin
            Str(AnnHhd / con[3]:5:2,ThisString);
            ThisString:='>A.Head : ' + ThisString  + Space + lab[3];
          End;
     64 : ThisString:='>Chokeline is open';

     65 : ThisString:='>Chokeline is closed';

     66 : ThisString:='>Stroke counter zeroed';

     67 : ThisString:='';   { unused }

     68 : ThisString:='>Turn off pumps';

     69 : Begin
            Str(Data.Rock[RockPointer].FP / con[3]:5:2,ThisString);
            ThisString:='>Form Pr.: ' + ThisString + Space + lab[3];
          End;

     70 : ThisString:='>Casing Failure!!!!!!!';

     71 : ThisString:='PRESS ANY KEY...';

     72 : ThisString:='Pits empty - no mud';

     73 : Begin
            Str(DrillMult,ThisString);
            ThisString:='>Accelerator : ' + ThisString;
          End;

     74 : ThisString:='Twisted off!!!!!!!';

     75 : Begin
            Str(TwistOff / con[7]:5:2,ThisString);
            ThisString:='>Twist off @ ' + ThisString + Space + lab[7];
          End;
     76 : Begin
            Str((LastKD + 27) / con[1]:8:2,ThisString);
            ThisString:='>K. down :' + ThisString + Space + lab[1];
          End;
     77 : Begin
            Str((RetPitVol) / con[4]:8:2,ThisString);
            ThisString:='>Pit Vol :' + ThisString + Space + lab[4];
          End;
     78 : Begin
            ThisString:='>Saving '+ FullName;    { called by SaveData }
          End;

    End;
    While length(ThisString) < 22 do   ThisString:=ThisString + Space;
    if    length(ThisString) > 22 then ThisString:=copy(ThisString,1,22);
    //Disp(32,24,ThisString);
    //Disp(32,23,PreviousString);
    //Disp(32,22,LastString);
  End;
End;

Begin
End.

