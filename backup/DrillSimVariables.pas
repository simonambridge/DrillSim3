Unit DrillSimVariables;

Interface

uses
Forms, Controls, Graphics, Dialogs, Menus, StdCtrls, ExtCtrls,
  usplashabout;

Type


    ROPString     =  string[7];
    AnyString     =  string[80];
    BitString     =  string[10];
    StringLength  =  string[20];
    FileString    =  string[12];
    HelpString    =  string[60];
    LabelString   =  string[3];
    DisplayString =  string[120];
    AttrType      =  byte;

  ColorSet        = (NormColors, { grey on blue }
                     BlueonGray,
                     WhiteOnBlue,
                     YellowOnBlack,
                     GrayOnBlack,
                     DataColors,   { high cyan on blue }
                     TitleColors,  { yellow on blue }
                     RedOnGray,
                     RedOnBlue,
                     FlashColors,  { red on blue }
                     BlackOnGreen,
                     WhiteOnGreen,
                     WhiteOnRed);

    Date       =  Record
                    DayOfWeek, Year, Month, Day               : word;
                  End;

    Time       =  Record
                    Hours, Minutes, Seconds, Hundredths       : word;
                  End;

    MudRec     =  Record
                    StartStrokes : real;  { StrokeCounter @ start circ' }
                    MW           : real;  { New MW }
                    PV           : real;  {     PV }
                    YP           : real;  {     YP }
                  End;

    GasRec     =  Record
                    Spare1 : real;
                    Spare2 : real;
                    Spare3 : real;
                    Spare4 : real;
                  End;

    RockRec    = Record
                   Depth             : real;
                   Hardness          : real;
                   FP                : real;
                   Porosity          : real;
                 End;

    HelpSet    = Record
                   HelpText : array[1..200] of HelpString;
                 End;

    WellData   = Record
                   TD, BitTD           : real;
                   API                 : boolean;
                   SpareBoolean1       : boolean; { * }
                   Pumping             : boolean;
                   Drilling            : boolean;
                   AutoDrill           : boolean;
                   ShutIn              : boolean;
                   BlindRam            : boolean;
                   PipeRam             : boolean;
                   Hydril              : boolean;
                   FlowLine            : boolean;

                   SpareBoolean2       : boolean; { * }

                   Bingham             : boolean;
                   UpdateFlow          : boolean;

                   SpareBoolean3       : boolean; { * }
                   SpareBoolean4       : boolean; { * }

                   PmpOp               : array[1..3] of real;
                   FillCE              : array[1..4] of real;
                   FillOE              : array[1..4] of real;
                   LagDT, LagDS        : real;
                   LagUT,   LagUS      : real;
                   WellVol, HoleVol    : real;
                   AnnVol,  MudVol     : real;
                   PipeCap, PipeDis    : real;
                   TotHoleSections     : integer;
                   HoleSection         : array[1..9,1..4] of real;
                   Vel                 : array[1..9,1..3] of real;

                   StackPointer        : integer;
                   CircStack           : array[1..200] of MudRec;
                   MudOut              : MudRec;
                   StrokeCounter       : real;
                   TotStrks            : real;
                   TotCircStrks        : real;

                   PipeMW              : real;
                   AnnMW               : real;
                   MwIn                : real;
                   MwOut               : real;
                   AnnPV               : real;
                   AnnYP               : real;
                   PipePV              : real;
                   PipeYP              : real;

                   FlowIn, FlowOut     : real;
                   ElapsedTime         : real;
                   ElapsedFlow         : real;
                   PlSurf, PlPipe      : real;
                   PlBit, PlAnn        : real;
                   PlCirc              : real;
                   MACP                : real;
                   SpareReal1          : real; { * }           { = spare }
                   AnnUnderbalance     : real;
                   CasingPressure      : real;
                   DeltaCsgPr          : real;
                   PlChoke             : real;
                   Choke               : integer;

                   JetVel, ImpForce    : real;
                   BitHp, Eff, TotHP   : real;
                   AverageHhd          : real;
                   PipeHhd, AnnHhd     : real;
                   BHPAnn              : real;
                   SpareReal2          : real; { * }
                   Ecd                 : real;
                   Ff, Rn              : real;
                   Fn, Fk              : real;
                   WaterFraction       : real;
                   OilFraction         : real;
                   SolidsFraction      : real;

                   PipeTD              : real;
                   StringTD            : real;
                   KelHt               : real;
                   LastKD              : real;
                   WOB                 : real;
                   WOH                 : real;
                   StrWt               : real;
                   ROP                 : real;
                   RPM                 : real;
                   OverDrill           : real;
                   t1,t2               : integer;
                   ROPt1,ROPt2         : integer;
                   RPMt1,RPMt2         : integer;

                   Influx              : real;
                   InfluxRate          : real;
                   BleedOffRate        : real;
                   BleedOff            : real;

                   WellOperator            : StringLength;
                   Well                : StringLength;
                   MaxPumps : integer;        MaxHoles : integer;
                   MaxPipes : integer;        MaxJets  : integer;
                   Offshore : boolean;        Riser    : boolean;
                   Casing   : boolean;        Liner    : boolean;
                   Surf     : array[1..4,1..2] of real;
                   Hole     : array[1..2,1..2] of real;
                   Pipe     : array[1..4,1..4] of real;
                   RsrTD, CsgTD, Tvd            : real;
                   RsrID, CsgID, Dev            : real;
                   LinerTop, LinerTD, LinerID   : real;
                   Rkb, WaterDepth              : real;
                   LotTD                        : real;
                   LotEMW                       : real;
                   LotMW                        : real;
                   LOTPressure                  : real;
                   RockPointer                  : integer;
                   Rock                         : array[1..10] of RockRec;

                   Gas       : array[1..200] of GasRec;

                   ChokeLineID : real;
                   KillLineID  : real;

                   DrillMult   : integer;
                   NewIf0      : integer;  { has this file been 'simulated'? }

                   FormationPressureGradient    : real;
                   BurstPressure                : real;
                   SpareReal3                   : real; { * }
                   SpareReal4                   : real; { * }
                   SpareReal5                   : real; { * }
                   SpareReal6                   : real; { * }
                   SpareReal7                   : real; { * }
                   InfluxDensity                : real;
                   PipeRAMRating                : real;
                   HydrilRating                 : real;
                   Jet      : array[1..4] of integer;
                   Bit      : integer;
                   BitType  : BitString;
                   Pump     : array[1..3,1..5] of real;
                   MaxPress : real;
                   ExcessMud: real;
                   MudWt, MudPv        : real;
                   MudYp               : real;
                   MudGel              : real;
                   RetPitVol           : real;
                   SpareReal8 : real; { * }

                   UserCon    : array[1..7] of real;
                   UserLab    : array[1..7] of LabelString;
                   UserType   : StringLength;

                   SpareInt1 : integer; { * }
                   SpareInt2 : integer; { * }
                 End;

Const
    VolCon    = 1029;               HHPcon    = 1714;
    StandLen  = 90;                 Bbl2Gal   = 42;
    Presscon  = 0.052;              Zero      = 0;
    Rheocon1  = 24.51;              Rheocon2  = 64.57;
    Rheocon3  = 9.899999;           Rheocon4  = 0.079;
    Rheocon5  = 49.56;              Rheocon6  = 0.25;
    Rheocon7  = 93000.0;            Rheocon8  = 282;
    Rheocon9  = 90000.0;            Rheocon10 = 1024;
    Rheocon11 = 0.32068;            Rheocon12 = 10858;
    Rheocon13 = 0.2;                Rheocon14 = 1.86;
    Rheocon15 = 0.00015;            Rheocon16 = 38780.0;
    Rheocon17 = 0.000001;           Rheocon18 = 2.8;
    VersionNumber = '1.10';
    VersionDate   = '(12/87)';
    Title         = 'DRILLSIM';

    PressPrompt = 'Press any key...';
    CommandLine = '>                     ';
    Extension   : String[4]  = '.WDF';
    Space       :   char     = ' ';
    CurrentMode = 'Mode : ';
    UnitMode    = 'Select User Units';
    SelectMode  = 'Main Menu';
    FileMode    = 'File Utilities';
    SetUpMode   = 'Setup';
    CreateMode  = 'Create Data File';
    UpdateMode  = 'Update Data File';
    GenMode     = 'General Data';
    HoleMode    = 'Hole Profile';
    PipeMode    = 'Drill String';
    BitMode     = 'Bit Data';
    MudMode     = 'Mud Data';
    PumpMode    = 'Pump Data';
    SurfMode    = 'Surface Equipment';
    OptMode     = 'Optimise';
    HyPrMode    = 'Hydraulic Print';
    ErrorMode   = 'Data Error';
    NoHelp1     = 'Help file was not found in start-up directory';
    NoHelp2     = 'No help messages available';
    Yes         = 'Yes';
    No          = ' No';

{ hydvar constants }
    LaminarText   = 'Laminar  ';
    TurbulentText = 'Turbulent';
    Blank4      = '    ';
    Blank5      = '     ';
    Blank6      = '      ';
    Blank7      = '       ';
    Blank9      = '         ';
    Blank11     = '           ';
    Dollar4      = '$$$$';
    Dollar5      = '$$$$$';
    Dollar6      = '$$$$$$';
    Dollar7      = '$$$$$$$';
    Dollar9      = '$$$$$$$$$';

{ Simvar constants }
   KickMode = 'DrillSim Data';   { used by DrillSim for UpdateKick }
   HelpPrompt = 'Press ENTER to continue or ESC to exit';
   Slash      : char = '/';
Var
   DataFile            : File of WellData;
   Data                : WellData;
   TextFile            : Text;
   SubProgram          : File;
   HelpFile            : File of HelpSet;
   Help                : HelpSet;

   d                   : Date;
   t                   : Time;

   FileName            : string[8];
   FileSpec            : AnyString;
   //FullName            : FileString;
   NewFile             : boolean;
   Quit                : boolean;
   Error               : boolean;
   NoFileDefined       : boolean;
   HelpFileFound       : boolean;
   con                 : array[1..7] of real;
   lab                 : array[1..7] of LabelString;
   ROPLab              : ROPString;
   TurbFlag            : boolean;
   FlowMode            : StringLength;
   Model               : StringLength;
   InString            : AnyString;          { Utility input string }
   BlankString         : AnyString;
   LstString           : AnyString;           { spacer print string }
   InputString         : DisplayString;
   OutputString        : DisplayString;
   LastString          : DisplayString;
   PreviousString      : DisplayString;
   ThisString          : DisplayString;
   Enter               : String[3];
   YesNo               : string[4];
   Input               : String[1]; { was char; }  { Utility input char' }
   CharInput           : char;                     {   ----- " -----     }
   Util                : char;                { Box building  char' }

   OutString           : AnyString;    { FastDisp variables }
   TempString          : AnyString;    { utility diplsy string }
   Row, Col            : integer;
   AttrByte            : byte;         { current Disp colour }
   TAttr               : byte;         { store current Disp Colour }

   Code                : integer;           { used by Proc. }
   Name                : FileString;        { GetDirectory  }

   DefaultFile         : FileString;        { used for .CFG file }
   DefaultDirectory    : AnyString;
   TextFileLine        : AnyString;
   PathString          : AnyString;         { Used for DOS Path }
   OriginDirectory     : AnyString;
   LoggedDirectory     : AnyString;
   OriginalExitProc    : Pointer;

   RResult             : real;          { used by Proc. GetReal, GetInt }
   IResult             : integer;
   IntParam            : integer;
   RealParam           : real;

   NoData              : boolean;
   HoleError           : boolean;
   Create              : boolean;
   Edited              : boolean;
   Valid               : boolean;
   Esc                 : boolean;

   MinChoice           : integer;
   MaxChoice           : integer;
   OldChoice           : integer;
   NewChoice           : integer;
   Choice              : integer;
   Menu                : array [1..10] of AnyString;

{ Hydvar vars }
   Bhcp                             : real;
   Mode                             : string[20];
   PosCounter                       : integer;
   LineCnt                          : integer;
   ColorCount                       : integer;
{ Simvar vars }
   LastTD, LastBitTD   : real;
   LastCasingPressure  : real;
   LastBHPAnn          : real;
   LastPitGain         : real;
   LastPlBit           : real;
   LastPlAnn           : real;
   LastPlSurf          : real;
   LastPlPipe          : real;
   LastPlCirc          : real;
   LastPlChoke         : real;

   LastFlowOut         : real;
   LastFlowIn          : real;
   LastElapsedFlow     : real;
   LastCalculatedFlow  : real;

   LastRetPitVol       : real;

   LastJetVel          : real;
   LastImpForce        : real;
   LastBitHp           : real;
   LastEff             : real;
   LastTotHp           : real;
   LastFf, LastRn      : real;
   LastFn, LastFk      : real;

   LastKelHt           : real;
   LastWOB             : real;
   LastWOH             : real;
   LastStrWt           : real;
   LastROP             : real;
   LastRPM             : real;
   Status              : integer;

   LastSeconds         : integer;
   LastHundredths      : integer;

   LastInflux          : real;
   LastInfluxRate      : real;
   LastEcd             : real;
   LastChoke           : integer;

   OriginalMudWt       : real;
   OriginalMudPV       : real;
   OriginalMudYP       : real;
   OriginalHoleDepth   : real;
   OriginalPipeDepth   : real; { not used yet }
   OriginalPitVolume   : real;
   LastMwOut           : real;
   LastMwIn            : real;
   LastMudPv           : real;
   LastMudYp           : real;
   LastMudGel          : real;
   LastCalculatedMudWt : real;

   LastTotStrks        : real;
   LastStrokeCounter   : real;
   LastSPM             : array[1..3] of real;
   DrilledHoleVol      : real;
   ExtraVolume         : real;
   ChokeLinePl         : real;
   Twistoff            : real;
   PitGain             : real;
   Trace               : boolean;
   PumpsOff            : boolean;

   HoleCalcCounter     : real;         { depth of last HoleCalc }
   HyCalcCounter       : integer;
   ROPCalcCounter      : integer;
   CalculatedSoFar     : integer;
   StatusCounter       : integer;
   SolidUpper          : String[3];
   SplitUpper          : String[3];
   SplitLower          : String[3];
   KellyPipe           : String[3];
   UpBushing           : String[5];
   DnBushing           : String[5];
   Bushing             : array[1..3] of String[5];
   CurrentBushing      : integer;
   CurrentTurn         : real;
Implementation

Begin
End.

