Unit DrillSimUnitsOfMeasure;

Interface

Uses SysUtils,
  DrillSimVariables,
  DrillSimMessageToMemo;

Procedure MetricUnits;
Procedure APIUnits;

Implementation

Procedure MetricUnits;
Begin
  Data.API:=False;
  Data.UoMLabel:='Metric';          { divide by these numbers to get API }
  ROPLab:='min/met';
  con[1]:=3.28084;
  con[2]:=8.345;
  con[3]:=1.45033;
  con[4]:=6.291;
  con[5]:=0.264;
  con[6]:=0.264;
  con[7]:=2.2046;
  lab[1]:='met';
  lab[2]:='sg ';
  lab[3]:='KPa';
  lab[4]:='m3 ';
  lab[5]:='ltr';
  lab[6]:='lpm';
  lab[7]:='ton';
  StringToMemo('Metric Units selected. Depth units are '+lab[1]);
End;


Procedure APIUnits;      {* Assign values to con[] and lab[] arrays *}
Begin
  Data.API:=True;
  Data.UoMLabel:='API';
  ROPLab:='min/ft';
  con[1]:=1;
  con[2]:=1;
  con[3]:=1;
  con[4]:=1;
  con[5]:=1;
  con[6]:=1;
  con[7]:=1;
  lab[1]:='ft.';
  lab[2]:='ppg';
  lab[3]:='psi';
  lab[4]:='bbl';
  lab[5]:='gal';
  lab[6]:='gpm';
  lab[7]:='Klb';
  StringToMemo('API Units selected. Depth units are '+lab[1]);
End;

Begin
End.