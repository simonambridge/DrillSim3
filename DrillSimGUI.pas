unit DrillSimGUI;

{$mode objfpc}{$H+}

interface

uses
  cthreads,
  crt,      // for Readkey
  SysUtils, // for FileExists
  Forms,
  Graphics,
  FileUtil,
  Controls,
  Dialogs,
  StdCtrls,
  Menus,
  ExtCtrls,
  LCLType,
  Classes,
  usplashabout,
  DrillSimVariables,
  DrillSimStartup,
  DrillSimFile,
  DrillSimDataResets,
  DrillSimUtilities,
  DrillSimHoleChecks,
  DrillSimMessageToMemo,
  DrillSimUnitsOfMeasure,

  FormConfigDefaults,
  FormUnitsOfMeasure,
  FormDisplayWellData,
  FormGeneralData,
  FormHoleData,
  FormPipeData,
  FormBitData,
  FormMudData,
  FormPumpData,
  FormSurfaceEquipmentData,
  FormWellTestData,
  FormGeologyData,

  SimulateCommandProcessor,
  SimulateUpdate,
  SimulateRAMs,
  SimulateHoleCalcs,
  SimulateHydraulicCalcs,
  SimulateDrillingCalcs,
  SimulateKick;

type

  { TDrillSim }

  TDrillSim = class(TForm)
    CasingPressureValue: TLabel;

    BitData: TGroupBox;
    BitDepthValue: TLabel;
    BitDepthUoMLabel: TStaticText;
    AutoDrillCheckBox: TCheckBox;
    HydrilValue: TLabel;
    BlindRAMsValue: TLabel;
    FlowInValue: TLabel;
    FlowOutValue: TLabel;
    DiffFlowValue: TLabel;
    BushingImage: TImage;
    KellyScale: TImage;
    KellyImage: TImage;
    AnnularPressureValue: TLabel;
    MenuItem2Geology: TMenuItem;
    MenuItem2Defaults: TMenuItem;
    MenuItem2Units: TMenuItem;
    MenuItem2DisplayWellData: TMenuItem;
    MenuItem2HoleProfile: TMenuItem;
    MenuItem2GeneralData: TMenuItem;
    MenuItem2Preferences: TMenuItem;
    MenuItem3Pause: TMenuItem;
    MenuItem3Stop: TMenuItem;
    MenuItem3Start: TMenuItem;
    MenuItem3Simulate: TMenuItem;
    MenuItem1CreateFile: TMenuItem;
    MenuItem2DrillString: TMenuItem;
    MenuItem2BitData: TMenuItem;
    MenuItem2SurfaceEquipment: TMenuItem;
    MenuItem2PumpData: TMenuItem;
    MenuItem2MudData: TMenuItem;
    MenuItem2WellTestData: TMenuItem;

    FileOpenDialog1: TOpenDialog;
    FileSaveDialog1: TSaveDialog;

    SelectDirectoryDialog1: TSelectDirectoryDialog;
    AnnularPressureText: TStaticText;
    CasingPressureText: TStaticText;
    AnnularPressureUoMLabel: TStaticText;
    CasingPressureUoMLabel: TStaticText;
    StandPipePressureValue: TLabel;
    ReturnPitValue: TLabel;
    PipeRAMsValue: TLabel;
    ChokeValue: TLabel;
    StandPipePressureUoMLabel: TStaticText;
    CommandLine: TEdit;
    Commands: TGroupBox;
    FlowOutUoMLabel: TStaticText;
    DiffFlowUoMLabel: TStaticText;
    ReturnPitUoMLabel: TStaticText;
    PipeMinus: TButton;
    PipePlus: TButton;
    ChokeMinus: TButton;
    ChokePlus: TButton;
    BOPBox1: TGroupBox;
    FlowBox: TGroupBox;
    KellyDown: TButton;
    KellyUp: TButton;
    KellyHeightText: TLabel;
    DrillingStatusText: TLabel;
    KellyHeightValue: TLabel;
    DrillingStatusValue: TLabel;
    ECDValue: TLabel;
    MainMenu1: TMainMenu;
    Memo1: TMemo;
    MenuItem1Quit: TMenuItem;
    MenuItem4ShowHelp: TMenuItem;
    MenuItem4About: TMenuItem;
    MenuItem4Help: TMenuItem;
    MenuItem1SaveAs: TMenuItem;
    MenuItem1SaveFile: TMenuItem;
    MenuItem2Edit: TMenuItem;
    MenuItem1OpenFile: TMenuItem;
    MenuItem2EditFile: TMenuItem;
    MenuItem1File: TMenuItem;
    MudWeightOutValue: TLabel;
    MudWeightInValue: TLabel;
    MudWeightInUoMLabel: TStaticText;
    MudWeightOutUoMLabel: TStaticText;
    MudWeightInText: TStaticText;
    MudWeightOutText: TStaticText;
    ECDText: TStaticText;
    ECDUoMLabel: TStaticText;
    PowerLawRadioButton: TRadioButton;
    BinghamRadioButton: TRadioButton;
    HydrilText: TStaticText;
    BlindRAMsText: TStaticText;
    PipeRAMsText: TStaticText;
    ChokeLineText: TStaticText;
    FlowInText: TStaticText;
    FlowOutText: TStaticText;
    ReturnPitText: TStaticText;
    DiffFlowText: TStaticText;
    StandPipePressureText: TStaticText;
    ROPUoMLabel: TStaticText;
    ChokeUoM: TStaticText;
    FlowInUoMLabel: TStaticText;
    TimeValue: TLabel;
    ROPValue: TLabel;
    ROPText: TLabel;
    PumpStrokesTotalText: TStaticText;
    KellyHeightUoMLabel: TStaticText;
    TimeText: TLabel;
    WOBUoMLabel: TStaticText;
    TotalDepthUoMLabel: TStaticText;
    WOBValue: TLabel;
    TotalDepthValue: TLabel;
    Pump3Plus: TButton;
    Pump3Minus: TButton;
    Pump2Plus: TButton;
    Pump2Minus: TButton;
    PumpStrokesValue: TLabel;
    Pump3Value: TLabel;
    Pump2Value: TLabel;
    Pump1Minus: TButton;
    Pump1Plus: TButton;
    DrillFloor: TGroupBox;
    Pump1Value: TLabel;
    PumpData: TGroupBox;
    DrillingFluids: TGroupBox;
    Messages: TGroupBox;
    BitDepthText: TStaticText;
    PumpStrokesText: TStaticText;
    Pump1Text: TStaticText;
    Pump2Text: TStaticText;
    Pump3Text: TStaticText;
    WeightOnBitText: TStaticText;
    TotalDepthText: TStaticText;
    RPMminus: TButton;
    RPMplus: TButton;
    RPMvalue: TLabel;
    RotaryRPMText: TStaticText;

    procedure AutoDrillCheckBoxChange(Sender: TObject);
    procedure ChokeMinusClick(Sender: TObject);
    procedure ChokePlusClick(Sender: TObject);
    procedure CommandLineClick(Sender: TObject);
    procedure CommandLineKeyPress(Sender: TObject; var Key: char);
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
    procedure MenuItem1OpenFileClick(Sender: TObject);
    procedure MenuItem1SaveAsClick(Sender: TObject);
    procedure MenuItem1SaveFileClick(Sender: TObject);
    procedure MenuItem2DefaultsClick(Sender: TObject);
    procedure MenuItem2DisplayWellDataClick(Sender: TObject);
    procedure MenuItem2GeneralDataClick(Sender: TObject);
    procedure MenuItem2GeologyClick(Sender: TObject);
    procedure MenuItem2HoleProfileClick(Sender: TObject);
    procedure MenuItem1CreateFileClick(Sender: TObject);
    procedure MenuItem1QuitClick(Sender: TObject);

    procedure KellyDownClick(Sender: TObject);
    procedure KellyUpClick(Sender: TObject);

    procedure BinghamRadioButtonChange(Sender: TObject);
    procedure MenuItem3PauseClick(Sender: TObject);
    procedure MenuItem3StartClick(Sender: TObject);
    procedure MenuItem2DrillStringClick(Sender: TObject);
    procedure MenuItem2BitDataClick(Sender: TObject);
    procedure MenuItem2MudDataClick(Sender: TObject);
    procedure MenuItem2PumpDataClick(Sender: TObject);
    procedure MenuItem2SurfaceEquipmentClick(Sender: TObject);
    procedure MenuItem2WellTestDataClick(Sender: TObject);
    procedure MenuItem2UnitsClick(Sender: TObject);
    procedure MenuItem3StopClick(Sender: TObject);
    procedure MenuItem4AboutClick(Sender: TObject);
    procedure PipeMinusClick(Sender: TObject);
    procedure PipePlusClick(Sender: TObject);
    procedure PowerLawRadioButtonChange(Sender: TObject);

    procedure Pump1MinusClick(Sender: TObject);
    procedure Pump1PlusClick(Sender: TObject);
    procedure Pump2MinusClick(Sender: TObject);
    procedure Pump2PlusClick(Sender: TObject);
    procedure Pump3MinusClick(Sender: TObject);
    procedure Pump3PlusClick(Sender: TObject);

    procedure RPMminusClick(Sender: TObject);
    procedure RPMplusClick(Sender: TObject);

    procedure FormCreate(Sender: TObject);
  private
    { private declarations }
    splash:TSplashAbout;
    procedure SetDefaultValues;

  public
    { public declarations }
  end;

  TMyThread = class(TThread)
    private
      ThreadStatus : string;
      procedure ShowStatus;
      procedure UpdateGUI;
    protected
      procedure Execute; override;
    public
      Constructor Create(CreateSuspended : boolean);
    end;
var
  DrillSim            : TDrillSim;
  MyThread            : TMyThread;
  DisplayWellDataForm : TDisplayWellDataForm;
  GeneralDataForm     : TGeneralDataForm;
  HoleDataForm        : THoleDataForm;
  UnitsOfMeasureForm  : TUnitsOfMeasureForm;
  SystemDefaultsForm  : TSystemDefaultsForm;

implementation

{$R *.lfm}

{ TDrillSim }

procedure TDrillSim.SetDefaultValues;
begin
  // The splashunit optional properties are normally set in the FormCreate method
  splash.DelaySeconds := 1;
  splash.Title := 'DrillSim3';
  splash.IconFilePath := 'ambersoft-icon.ico';
  splash.BackGroundImageFilePath := 'rig.jpg';
  splash.MaskImageFilePath := 'roundedrect.bmp';
  // Must be .bmp file to make a shaped window
  // Note: if MaskImageFilePath is specified as a .jpg file, the jpg will
  // be automatically converted to a bmp file on first run.
  // Use a graphics app to reduce the bmp's color depth and thus - its file size
  splash.BackGroundColor := clSkyBlue;
  splash.LicenseFilePath := 'dsl.txt';
  splash.LicenseType := 'Copyright';
  splash.CreditString := 'Do Not Distribute';
  splash.Author := 'Simon Ambridge';
  splash.SupportContact := 'simon@ntier-db.com';
end;

{* =========================== Input Controls ================================ *}

{ ------------------------------ checks -----------------------------------------}

Procedure CheckPumps;  { called by PipeMinus and PipePlus}
Begin                  {check to see if pumping when adding or subtracting pipe }
  if Data.Pumping then
  Begin
    MessageToMemo(68);

    PumpsOff:=False;      { !!! ERROR MESSAGE REQUIRED ? }
    ShowMessage('Oooops');
  End else PumpsOff:=True;
End;

{ ------------------------------ pumps -----------------------------------------}

Procedure TDrillSim.Pump1MinusClick(Sender: TObject);
begin
  if Simulating then With Data do              { - strokes per minute }
  Begin
    Pump[1,3]:=Pump[1,3]-1;
    if Pump[1,3]<Zero then Pump[1,3]:=Zero;
    Pump1Value.Caption:=FloatToStr(Pump[1,3]);
    StringToMemo('Pump 1 : ' + FloatToStr(Pump[1,3]));
  end;
end;

procedure TDrillSim.Pump1PlusClick(Sender: TObject);
begin
  if Simulating then With Data do              { + strokes per minute }
  Begin
    Pump[1,3]:=Pump[1,3]+1;
    Pump1Value.Caption:=FloatToStr(Pump[1,3]);
    StringToMemo('Pump 1 : ' + FloatToStr(Pump[1,3]));
  end;
 end;

Procedure TDrillSim.Pump2MinusClick(Sender: TObject);
Begin
  if Simulating then With Data do              { - strokes per minute }
  Begin
    Pump[2,3]:=Pump[2,3]-1;
    if Pump[2,3]<Zero then Pump[2,3]:=Zero;
    Pump2Value.Caption:=FloatToStr(Pump[2,3]);
    StringToMemo('Pump 2 : ' + FloatToStr(Pump[2,3]));
  end;
end;

procedure TDrillSim.Pump2PlusClick(Sender: TObject);
begin
  if Simulating then With Data do              { + strokes per minute }
  Begin
    Pump[2,3]:=Pump[2,3]+1;
    Pump2Value.Caption:=FloatToStr(Pump[2,3]);
    StringToMemo('Pump 2 : ' + FloatToStr(Pump[2,3]));
  end;
end;

procedure TDrillSim.Pump3MinusClick(Sender: TObject);
begin
  if Simulating then With Data do              { - strokes per minute }
  Begin
    Pump[3,3]:=Pump[3,3]-1;
    if Pump[3,3]<Zero then Pump[3,3]:=Zero;
    Pump3Value.Caption:=FloatToStr(Pump[3,3]);
    StringToMemo('Pump 3 : ' + FloatToStr(Pump[3,3]));
  end;
end;

procedure TDrillSim.Pump3PlusClick(Sender: TObject);
begin
  if Simulating then With Data do              { + strokes per minute }
  Begin
    Pump[3,3]:=Pump[3,3]+1;
    Pump3Value.Caption:=FloatToStr(Pump[3,3]);
    StringToMemo('Pump 3 : ' + FloatToStr(Pump[3,3]));
  end;
end;

{ ------------------------------ RPM -----------------------------------------}

procedure TDrillSim.RPMminusClick(Sender: TObject);
begin
  if Simulating then With Data do              { - revolutions per minute }
  Begin
    RPM:=RPM-1;
    if RPM<Zero then RPM:=Zero;
    RPMValue.Caption:=FloatToStr(RPM);
    StringToMemo('RPM : ' + FloatToStr(RPM));
  end;
end;

procedure TDrillSim.RPMplusClick(Sender: TObject);
begin
  if Simulating then With Data do              { + revolutions per minute }
  Begin
    if (KellyHeight < 33) then
    Begin
      RPM:=RPM+1;
      if RPM>160 then RPM:=160;
      RPMValue.Caption:=FloatToStr(RPM);
      StringToMemo('RPM : ' + FloatToStr(RPM));
    End else
    Begin
      MessageToMemo(52);
    End;
  end;
end;

{ ------------------------------ kelly -----------------------------------------}

procedure TDrillSim.KellyDownClick(Sender: TObject);
begin
  if Simulating then With Data do              { lower Kelly }
  Begin
    if not ShutIn then  { cannot move kelly if shut in }
    Begin
      if abs(Hole[MaxHoles,1]-BitTD) >= 1
        then KellyHeight:=KellyHeight - 0.5
        else KellyHeight:=KellyHeight - 0.05;    { max decrement when less than 1 foot off bottom }

      if KellyHeight<3 then KellyHeight:=3;      { kelly cannot go below 3 ft }

      DrawKelly;                     { display it in SimulateUpdate }
    End;
    KellyHeightValue.Caption:=FloatToStr(Round2(KellyHeight/UoMConverter[1],2));   { API -> displayed }
  end;
end;

procedure TDrillSim.KellyUpClick(Sender: TObject);
begin
  if Simulating then With Data do              { raise Kelly }
  Begin
    if not ShutIn then  { cannot move kelly if shut in }
    Begin
      if abs(Hole[MaxHoles,1]-BitTD) >= 1
        then KellyHeight:=KellyHeight + 0.5
        else KellyHeight:=KellyHeight + 0.05;    { max increment when less than 1 foot off bottom }

      if KellyHeight>33 then KellyHeight:=33;    { kelly cannot go above 33 ft }

      DrawKelly;                     { display it in SimulateUpdate }
    End;
    KellyHeightValue.Caption:=FloatToStr(Round2(KellyHeight/UoMConverter[1],2));  { API -> displayed }
  End;
end;

{ ------------------------------ pipe ------------------------------------------}

procedure TDrillSim.PipeMinusClick(Sender: TObject);
begin
  if Simulating then With Data do              { only allowed when on slips }
  Begin
    if (KellyHeight=33) and (Pipe[MaxPipes,1] >27) then
    Begin
      CheckPumps;
      if PumpsOff then Pipe[MaxPipes,1]:=Pipe[MaxPipes,1] - 27;
      StringWtCalc;
    End;
  End;
end;

procedure TDrillSim.PipePlusClick(Sender: TObject);
begin
  if Simulating then With Data do              { only allowed when on slips }
  Begin
    if (KellyHeight=33) and (Hole[MaxHoles,1] - BitTD >=27) then
    Begin
      CheckPumps;
      if PumpsOff then
      Begin
        Pipe[MaxPipes,1]:=Pipe[MaxPipes,1] + 27;
        LastKD:=Hole[MaxHoles,1];
        StringWtCalc;
      End;
    End;
  End;
end;

{ ------------------------------ choke -----------------------------------------}

procedure TDrillSim.ChokeMinusClick(Sender: TObject);
begin
  if Simulating then With Data do              { - choke aperture }
  Begin
    Choke:=Choke - 1;
    if Choke < 5 then
    Begin
      if Choke=4 then CloseChoke;
      MessageToMemo(65);
      Choke:=Zero;
      DeltaCsgPr:=DeltaCsgPr + PlChoke;
      PlChoke:=Zero;
    End;
    ChokeValue.Caption:=FloatToStr(Choke);
    StringToMemo('Choke : ' + FloatToStr(Choke));
  end;
End;

procedure TDrillSim.ChokePlusClick(Sender: TObject);
begin
  if Simulating then With Data do              { - choke aperture }
  Begin
    Choke:=Choke + 1;
    if Choke < 5 then
    Begin
      MessageToMemo(64);
      Choke:=5;
      OpenChoke;
    end;
    if Choke>100 then Choke:=100;
    ChokeValue.Caption:=FloatToStr(Choke);
    StringToMemo('Choke : ' + FloatToStr(Choke));
  End;
End;

{ ------------------------------ Mud Mode---------------------------------------}

procedure TDrillSim.PowerLawRadioButtonChange(Sender: TObject);
begin

end;

procedure TDrillSim.BinghamRadioButtonChange(Sender: TObject);
begin
  With Data do
  Begin
  Bingham:=not Bingham;
  if Bingham then MessageToMemo(31) else MessageToMemo(32);
  End;

end;

{ ------------------------------ Autodrill -------------------------------------}

procedure TDrillSim.AutoDrillCheckBoxChange(Sender: TObject);
begin
  With Data do
  Begin
  AutoDrill:=not AutoDrill;
  if AutoDrill then MessageToMemo(1) else MessageToMemo(2);
  End;
end;



{* ======================= Memo Input ======================================= *}

procedure TDrillSim.CommandLineKeyPress(Sender: TObject; var Key: char);
begin
  if Key=^M then      // if ENTER
  Begin
    if length(InputString) > Zero then   // display it
    Begin
      //Memo1.Lines.Add('>' + InputString);
      //Memo1.SelStart:=Length(Memo1.Text);
      CommandProcessor;        { Command - process it          }
      InputString:='';
    End;
  End else
  if Key=#8 then                // if BACKSPACE
  Begin
    InputString:=copy(InputString,1,length(InputString)-1);
  end else
  Begin                         // else add to InputString
    InputString:=InputString + Key;
  End;

  CommandLine.Text := InputString;    // update text entry
  CommandLine.SelStart:=Length(CommandLine.Text);
  Key:=#0;
end;

procedure TDrillSim.CommandLineClick(Sender: TObject);
begin
  InputString:='';
  CommandLine.Text := InputString;
  CommandLine.SelStart:=Length(CommandLine.Text);
//  writeln('Clicked in TEdit');

end;

{* ======================== Form Controls =========================== *}

procedure TDrillSim.FormActivate(Sender: TObject);
begin
  StringToMemo('Running DrillSimGUI FormActivate................................'); // please wait....
  Edited:=False;  { start clean }
  Simulating:=False;
  SimulateMessageCode:=0;
  Paused:=False;

  { DrillSim start up sequence }
  StringToMemo('DrillSimGUI.FormaActivate: Running DrillSim start up sequence');
  { ***************************************** }
  StartUp;     { call DrillSim StartUp }
  { ***************************************** }

  DrillingStatusValue.Caption:='Checking...';

  KellyScale.Picture.LoadFromFile('kellyscale.png');  { draw kelly starting position }
  KellyImage.Picture.LoadFromFile('kellyup-0.png');
  BushingImage.Picture.LoadFromFile('kellybushingup.png');

  KellyHeightValue.Caption:=FloatToStr(Round2(Data.KellyHeight/UoMConverter[1],2)); { API -> displayed }
  StringToMemo('Initial kelly height = ' + FloatToStr(Data.KellyHeight));

  BitDepthValue.Caption:=FloatToStr(Round2(Data.BitTD/UoMConverter[1],2)); { API -> displayed }
  TotalDepthValue.Caption:=FloatToStr(Round2(Data.TD/UoMConverter[1],2)); { API -> displayed }
  WOBValue.Caption:=FloatToStr(Round2(Data.WOB/UoMConverter[7],2)); { API -> displayed }
  RPMValue.Caption:=FloatToStr(Round2(Data.RPM,2));
  ROPValue.Caption:=FloatToStr(Round2(Data.ROP/UoMConverter[1],2)); { API -> displayed }

  MudWeightInValue.Caption:=FloatToStr(Round2(Data.MwIn/UoMConverter[2],2)); { API -> displayed }
  MudWeightOutValue.Caption:=FloatToStr(Round2(Data.MwOut/UoMConverter[2],2)); { API -> displayed }

  Pump1Value.Caption:=FloatToStr(Round2(Data.Pump[1,3],0));
  Pump2Value.Caption:=FloatToStr(Round2(Data.Pump[2,3],0));
  Pump3Value.Caption:=FloatToStr(Round2(Data.Pump[3,3],0));
  PumpStrokesValue.Caption:=FloatToStr(Round2(Data.StrokeCounter,0));

  FlowInValue.Caption:=FloatToStr(Round2(Data.FlowIn/UoMConverter[5],2)); { API -> displayed }
  FlowOutValue.Caption:=FloatToStr(Round2(Data.FlowOut/UoMConverter[5],2)); { API -> displayed }
  StandPipePressureValue.Caption:=FloatToStr(Round2(Data.PlCirc/UoMConverter[3],2)); { API -> displayed }
  ReturnPitValue.Caption:=FloatToStr(Round2(Data.RetPitVol/UoMConverter[4],2)); { API -> displayed }
  DiffFlowValue.Caption:=FloatToStr(Round2(PitGain/UoMConverter[4],2)); { API -> displayed }

  ChokeValue.Caption:=FloatToStr(Data.Choke);


  AnnularPressureValue.Caption:=FloatToStr(Round2(Data.BHPAnn/UoMConverter[3],2)); { API -> displayed }
  CasingPressureValue.Caption:=FloatToStr(Round2(Data.CasingPressure/UoMConverter[3],2)); { API -> displayed }
  if Data.ShutIn then
  Begin
    HydrilValue.Caption:='Closed';
    PipeRAMsValue.Caption:='Closed';
    BlindRAMsValue.Caption:='Closed';
  End else
  Begin
    HydrilValue.Caption:='Open';
    PipeRAMsValue.Caption:='Open';
    BlindRAMsValue.Caption:='Open';
  End;
end;

procedure TDrillSim.FormCreate(Sender: TObject);
begin
  Memo1.SelStart:=Length(Memo1.Text);
  StringToMemo('DrillSimGUI.FormCreate:Running DrillSimGUI FormCreate...');

  splash := TSplashAbout.Create(nil);
  SetDefaultValues; // splash - optional
  splash.ShowSplash;

end;

Procedure CheckExit;
var Reply, BoxStyle: Integer;
Begin
  if Edited then StringToMemo('Edited') else StringToMemo('Not Edited');
  BoxStyle := MB_ICONQUESTION + MB_YESNO;
  Reply := Application.MessageBox('Are you sure?', 'Exit Check', BoxStyle);
  if Reply = IDYES then
  Begin
    if Edited then
    Begin
      BoxStyle := MB_ICONQUESTION + MB_YESNO;
      Reply := Application.MessageBox('File has been edited. Do you want to save?', 'Save Check', BoxStyle);
      if Reply = IDYES then
      Begin
        SaveData;
        StringToMemo('DrillSimGUI.OnClose: File ' + CurrentFQFileName + ' saved');
      end;
    end;
    Application.Terminate;
  end
  else
    Exit;
End;

Procedure TDrillSim.FormDeActivate(Sender: TObject);
Begin { Also called on Quit Button }
  StringToMemo('DrillSimGUI.Deactivate ........................................');
  CheckExit;
End;

procedure TDrillSim.FormClose(Sender: TObject);
begin { Kill the app using window controls }
  StringToMemo('DrillSimGUI.Close .............................................');
  CheckExit;
end;

Procedure TDrillSim.MenuItem1QuitClick(Sender: TObject);
Begin { Kill the app from the menu }
  StringToMemo('DrillSimGUI:Menu 1: Quit ......................................');
  CheckExit;
End;


{* ======================== Menus =========================== *}

{ ---------------- File Menu Operations ------------------------ }

procedure TDrillSim.MenuItem1OpenFileClick(Sender: TObject);
var
  openDialog : TOpenDialog;    // Open dialog variable
  Reply: Integer;
  BoxStyle: Integer;
begin
  if Edited then
  Begin
    BoxStyle := MB_ICONQUESTION + MB_YESNO;
    Reply := Application.MessageBox('File has been edited. Do you want to save?', 'Save Check', BoxStyle);
    if Reply = IDYES then
    Begin
      SaveData;
      StringToMemo('DrillSimGUI.MenuItem1OpenFileClick: File ' + CurrentFQFileName + ' saved');
    end;
  end;
  CreateNewFile:=False;    { we dont know what sort of file we'll load... }

    // Create the open dialog object - assign to our open dialog variable
  openDialog := TOpenDialog.Create(self);

    // Set up the starting directory to be the current one
  openDialog.InitialDir := GetCurrentDir;

    // Only allow existing files to be selected
  openDialog.Options := [ofFileMustExist];

    // Allow only .dpr and .pas files to be selected
  openDialog.Filter :=
      'DrillSim Well files|*.wdf';

    // Select pascal files as the starting filter type
  openDialog.FilterIndex := 2;

    // Display the open file dialog
  if openDialog.Execute then
  Begin
    CurrentFQFileName:=openDialog.FileName;  // set global active file name variable
    if FileExists(CurrentFQFileName) then
    Begin
        LoadData;
        if not NoFileDefined
          then ShowMessage('File loaded: '+ CurrentFQFileName)
          else ShowMessage('File '+ CurrentFQFileName + ' failed to load successfully!');
    end
    else ShowMessage('File not found!');
      // Free up the dialog
      openDialog.Free;
  end;
end;


procedure TDrillSim.MenuItem1CreateFileClick(Sender: TObject);
begin
  CreateNewFile:=True;
  InitData;                             { Set NeverSimulated }
  APIUnits;                             { Default to API units    }
//  UpdateGen;
  CheckHoleData;         { get hole data and redo pipe/hole screens if error }
  CheckPipeData;         { get pipe data and redo hole/pipe screens if error }
//  UpdateBit;
//  UpdateMud;
//  UpdatePump;
//  UpdateSurf;
//  UpDateWellTests;
  SaveData;
  CreateNewFile:=False;
end;


procedure TDrillSim.MenuItem1SaveFileClick(Sender: TObject);
begin
  SaveData;
  ShowMessage('File saved: '+CurrentFQFileName);

end;

procedure TDrillSim.MenuItem1SaveAsClick(Sender: TObject);
var
  saveDialog : TSaveDialog;    // Save dialog variable
  Reply, BoxStyle: Integer;
begin
  // Create the save dialog object - assign to our save dialog variable
  saveDialog := TSaveDialog.Create(self);

  // Give the dialog a title
  saveDialog.Title := 'Save Well Data File';

  // Set up the starting directory to be the current one
  saveDialog.InitialDir := GetCurrentDir;

  // Allow only filtered file types to be saved
  saveDialog.Filter := 'DrillSim file|*.wdf|All Files|*.*';

  // Set the default extension
  saveDialog.DefaultExt := 'wdf';

  // Select text files as the starting filter type
  saveDialog.FilterIndex := 1;

  // Display the open file dialog
  if saveDialog.Execute then
  Begin
    CurrentFQFileName:=saveDialog.FileName;  // set global active file name variable
    if FileExists(CurrentFQFileName) then
    Begin
      BoxStyle := MB_ICONQUESTION + MB_YESNO;
      Reply := Application.MessageBox(pchar('Overwrite '+CurrentFQFileName + '?'), 'File Exists!', BoxStyle);
      if Reply = IDYES then
      Begin
        CreateNewFile:=False;
        SaveData;
      end else
      Begin
        StringToMemo('DrillSimGUI.MenuItem1SaveAsClick: File exists, save cancelled');
        ShowMessage('File exists, save cancelled');
      end;
    end else
    Begin
      CreateNewFile:=True;
      SaveData;
    end;
  end else
  Begin
    StringToMemo('DrillSimGUI.MenuItem1SaveAsClick: Save cancelled');
    ShowMessage('Save cancelled');
  end;
  saveDialog.Free; // Free up the dialog
end;


{ --------------- Edit Well Menu Options ------------------------ }

procedure TDrillSim.MenuItem2DisplayWellDataClick(Sender: TObject);
begin
  try
    DisplayWellDataForm:=TDisplayWellDataForm.Create(Nil);  //DisplayWellData is created
    DisplayWellDataForm.ShowModal;
  finally
    DisplayWellDataForm.Free;
end;

end;

procedure TDrillSim.MenuItem2GeneralDataClick(Sender: TObject);
begin
  try
    GeneralDataForm:=TGeneralDataForm.Create(Nil);  //General Data Input is created
    GeneralDataForm.ShowModal;
  finally
    GeneralDataForm.Free;
  end;

end;

procedure TDrillSim.MenuItem2HoleProfileClick(Sender: TObject);
begin
  try
    HoleDataForm:=THoleDataForm.Create(Nil);  //Hole Data Input is created
    HoleDataForm.ShowModal;
  finally
    HoleDataForm.Free;
  end;
  { call DrillSimHoleChecks:CheckHoleData - calls DSHoleCalc - check hole and pipe data }
  CheckHoleData;
  if HoleError then StringToMemo('DrillSimFile.LoadData: Hole Error !!!! ');

end;

procedure TDrillSim.MenuItem2DrillStringClick(Sender: TObject);
begin
  try
    PipeDataForm:=TPipeDataForm.Create(Nil);  //Pipe Data Input is created
    PipeDataForm.ShowModal;
  finally
    PipeDataForm.Free;
  end;
    { call DrillSimHoleChecks:CheckHoleData - calls DSHoleCalc - check hole and pipe data }
    CheckHoleData;
    if HoleError then StringToMemo('DrillSimFile.LoadData: Hole Error !!!! ');

end;

procedure TDrillSim.MenuItem2BitDataClick(Sender: TObject);
begin
  try
    BitDataForm:=TBitDataForm.Create(Nil);  //Bit Data Input is created
    BitDataForm.ShowModal;
  finally
    BitDataForm.Free;
  end;
end;

procedure TDrillSim.MenuItem2MudDataClick(Sender: TObject);
begin
  try
    MudDataForm:=TMudDataForm.Create(Nil);  //Mud Data Input is created
    MudDataForm.ShowModal;
  finally
    MudDataForm.Free;
  end;
end;

procedure TDrillSim.MenuItem2PumpDataClick(Sender: TObject);
begin
  try
    PumpDataForm:=TPumpDataForm.Create(Nil);  //Pump Data Input is created
    PumpDataForm.ShowModal;
  finally
    PumpDataForm.Free;
  end;
end;

procedure TDrillSim.MenuItem2SurfaceEquipmentClick(Sender: TObject);
begin
  try
    SurfaceEquipmentDataForm:=TSurfaceEquipmentDataForm.Create(Nil);  //Pump Data Input is created
    SurfaceEquipmentDataForm.ShowModal;
  finally
    SurfaceEquipmentDataForm.Free;
  end;
end;

procedure TDrillSim.MenuItem2WellTestDataClick(Sender: TObject);
begin
  try
    WellTestDataForm:=TWellTestDataForm.Create(Nil);  //Pump Data Input is created
    WellTestDataForm.ShowModal;
  finally
    WellTestDataForm.Free;
  end;
end;

procedure TDrillSim.MenuItem2GeologyClick(Sender: TObject);
begin
  try
    GeologyDataForm:=TGeologyDataForm.Create(Nil);  //Pump Data Input is created
    GeologyDataForm.ShowModal;
  finally
    GeologyDataForm.Free;
  end;
end;

{ ---------- Preferences Menu Options -------------------------- }

procedure TDrillSim.MenuItem2DefaultsClick(Sender: TObject);
begin
  try
    SystemDefaultsForm:=TSystemDefaultsForm.Create(Nil);  //Hole Data Input is created
    SystemDefaultsForm.ShowModal;
  finally
    SystemDefaultsForm.Free;
  end;
end;

procedure TDrillSim.MenuItem2UnitsClick(Sender: TObject);  // UoM
begin
  try
    UnitsOfMeasureForm:=TUnitsOfMeasureForm.Create(Nil);
    UnitsOfMeasureForm.ShowModal;
  finally
    UnitsOfMeasureForm.Free;
  end;

end;


{ ----------- Help, About Menu Options ---------------------------- }

procedure TDrillSim.MenuItem4AboutClick(Sender: TObject);
begin
    splash.ShowAbout;
end;

{ ----------- Simulate Menu Options ---------------------------- }

procedure TDrillSim.MenuItem3StopClick(Sender: TObject);
begin
  Simulating:=False;
end;

procedure TDrillSim.MenuItem3PauseClick(Sender: TObject);
begin
  if (not Simulating) and (not Paused) then
  Begin
    ShowMessage('Cannot pause a non-running simulation');
    Exit;
  end;

  Paused:=not Paused;
  if Paused=True then
  Begin
    StringToMemo('Menu3: Simulation Paused');
    Simulating:=False;
  end
  else
  Begin
    StringToMemo('Menu3: Simulation Un-paused');
    Simulating:=True;
  end;
end;

procedure TDrillSim.MenuItem3StartClick(Sender: TObject);
begin
  StringToMemo('Menu3: Starting Simulation');
  MessageToMemo(100);               { Please wait...  }
  if not Simulating then
  Begin
    if NoFileDefined=True then
    Begin
      CurrentFQFileName:='no file';          { set file name for load window          }
      MenuItem1OpenFileClick(nil);           { and go prompt for one                  }
    End else
    Begin                           { call inits in DrillSimDataResets }
      InitMud;                      { set the system OriginalMudWt etc.      }

      InitDepth;                    { depths used for reset are the current  }
                                   { depths at the start of this session    }
                                   { which may not be the original depths   }
      InitKick;                     { Set up and initialise if NeverSimulated }

      InitGeology;                  { find current position within geological}
                                    { table. Also done on Load and Clear     }
      GetCurrentTime (t);
      Data.t2:=t.Seconds;             { initialize time                    }



      SimHoleCalc;                    { SimulateHoleCalcs - calculate volumes }

      MudUpdate;                      { SimulateUpdate - set up mud, display it  }

      FlowUpdate;                     { SimulateUpdate - set up flow, display it }

      SetKelly;                       { SimulateUpdate - move kelly to drilling position    }

      SetSurfControls;                { set RAMs and choke line            }

      SimulateMessageCode:=0;
      Paused:=False;
      Simulating:=True;               { ACTIVATE THE THREAD !!!            }

      TimeUpdate;                     { SimulateHydraulicCalcs:HyCalc }
    End;
  end;
End;



{* ============================ Threads ================================= *}

constructor TMyThread.Create(CreateSuspended : boolean);
begin
  FreeOnTerminate := True;
  inherited Create(CreateSuspended);
end;

procedure TMyThread.ShowStatus;
// this method is executed by the mainthread and can therefore access all GUI elements.
begin
  StringToMemo('Simulation Thread Status Change - '+ ThreadStatus);
end;

procedure TMyThread.UpdateGUI;
// this method is executed by the mainthread and can therefore access all GUI elements.
begin
  if SimulateMessageCode<>0 then MessageToMemo(SimulateMessageCode);

  ScreenService;
end;

procedure TMyThread.Execute;
var
  NewStatus : string;
begin
  ThreadStatus := 'TMyThread Starting...';
  Synchronize(@Showstatus);
  ThreadStatus := 'TMyThread Running...';

  Synchronize(@UpdateGUI);

  while (not Terminated) do
    begin
       if Simulating then
       Begin
         NewStatus:=('Simulating');  { can be either 'Simulating' or 'Not Simulating' }

         //writeln('FlowCalc');
         FlowRateCalc;      { SimulateHydraulicCalcs:FlowRateCalc }

         //writeln('HydraulicCalc');
         HydraulicCalc;     { SimulateHydraulicCalcs:HyCalc }

         { check for hole deeper then next horizon          }
         { if yes, check if next horizon data is valid (>0) }
         { if yes, advance RockPointer and calculate new    }
         { formation pressure gradient                      }

         //writeln('FormationPressureCalc');
         FormationPressureCalc;

         //writeln('TwistOffCalc');
         TwistOffCalc;

         //writeln('DrillCalc');
         DrillCalc;

         //writeln('KickCalc');
         KickCalc;

         Synchronize(@UpdateGUI);

       end else
       Begin
         NewStatus:=('Not Simulating');
       end;

      if NewStatus <> ThreadStatus then
        begin
          ThreadStatus := NewStatus;
          Synchronize(@Showstatus);
        end;
    end;
end;


Initialization
 writeln('DrillSimGUI : Initialization - creating Thread before FormCreate is run');

 MyThread := TMyThread.Create(True); // set True = it doesn't start automatically

 {* Here initialise anything required before the threads starts executing *}

 MyThread.Start;

end.

