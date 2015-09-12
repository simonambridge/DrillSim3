unit FormPumpData;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  DrillSimVariables,
  DrillSimUtilities,
  DrillSimMessageToMemo;


type

  { TPumpDataForm }

  TPumpDataForm = class(TForm)
    MaxPumpPressureUoMLabel: TLabel;
    Pump1EfficiencyData: TEdit;
    MaxPumpPressureData: TEdit;
    MaxPumpPressureLabel: TLabel;
    Pump1Label: TLabel;
    Pump1OutputData: TEdit;
    Pump1EfficiencySPMData: TEdit;
    Pump3EfficiencyData: TEdit;
    Pump3Label: TLabel;
    Pump3OutputData: TEdit;
    Pump3EfficiencySPMData: TEdit;
    Pump2EfficiencyData: TEdit;
    Pump2Label: TLabel;
    Pump2OutputData: TEdit;
    Pump2EfficiencySPMData: TEdit;
    EfficiencyColumnLabel: TLabel;
    OutputColumnLabel: TLabel;
    NumPumps: TLabel;
    NumPumpsComboBox: TComboBox;
    SPMColumnLabel: TLabel;
    OutputUoMLabel: TLabel;
    QuitButton: TButton;
    SaveButton: TButton;
    procedure MaxPumpPressureDataChange(Sender: TObject);
    procedure NumericOnlyKeyPress(Sender: TObject; var Key: Char);
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
    procedure NumPumpsComboBoxChange(Sender: TObject);
    procedure Pump1EfficiencyDataChange(Sender: TObject);
    procedure Pump1EfficiencySPMDataChange(Sender: TObject);
    procedure Pump1OutputDataChange(Sender: TObject);
    procedure Pump2EfficiencyDataChange(Sender: TObject);
    procedure Pump2EfficiencySPMDataChange(Sender: TObject);
    procedure Pump2OutputDataChange(Sender: TObject);
    procedure Pump3EfficiencyDataChange(Sender: TObject);
    procedure Pump3EfficiencySPMDataChange(Sender: TObject);
    procedure Pump3OutputDataChange(Sender: TObject);
    procedure QuitButtonClick(Sender: TObject);
    procedure SaveButtonClick(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  PumpDataForm: TPumpDataForm;
  _WellMaxPumps : Integer;
  _WellPump : array [1..3,1..3] of real;
  _WellMaxPumpPressure : real;

implementation

{$R *.lfm}

{ TPumpDataForm }

{ ------------- Edit Procedures ------------ }

procedure TPumpDataForm.NumericOnlyKeyPress(Sender: TObject; var Key: Char);
begin
  if not (Key in [#8, '0'..'9', '-', DefaultFormatSettings.DecimalSeparator]) then
  Begin
    Key := #0;  // discard it
  end
  else if ((Key = DefaultFormatSettings.DecimalSeparator) or (Key = '-')) and
          (Pos(Key, (Sender as TEdit).Text) > 0) then
  Begin
    Key := #0;  // discard it
  end
  else if (Key = '.') and
          ((Sender as TEdit).SelStart = 0) then
  Begin
    Key := #0;  // discard it
  end;
end;


procedure TPumpDataForm.NumPumpsComboBoxChange(Sender: TObject);
begin
  case NumPumpsComboBox.ItemIndex of
    0: Begin
         _WellMaxPumps:=1;
         Pump1OutPutData.Enabled:=True;
         Pump1EfficiencyData.Enabled:=True;
         Pump1EfficiencySPMData.Enabled:=True;

         Pump2OutPutData.Enabled:=False;
         Pump2EfficiencyData.Enabled:=False;
         Pump2EfficiencySPMData.Enabled:=False;

         Pump3OutPutData.Enabled:=False;
         Pump3EfficiencyData.Enabled:=False;
         Pump3EfficiencySPMData.Enabled:=False;
       end;

    1: Begin
         _WellMaxPumps:=2;
         Pump1OutPutData.Enabled:=True;
         Pump1EfficiencyData.Enabled:=True;
         Pump1EfficiencySPMData.Enabled:=True;

         Pump2OutPutData.Enabled:=True;
         Pump2EfficiencyData.Enabled:=True;
         Pump2EfficiencySPMData.Enabled:=True;

         Pump3OutPutData.Enabled:=False;
         Pump3EfficiencyData.Enabled:=False;
         Pump3EfficiencySPMData.Enabled:=False;
       end;

    2: Begin
         _WellMaxPumps:=3;
         Pump1OutPutData.Enabled:=True;
         Pump1EfficiencyData.Enabled:=True;
         Pump1EfficiencySPMData.Enabled:=True;

         Pump2OutPutData.Enabled:=True;
         Pump2EfficiencyData.Enabled:=True;
         Pump2EfficiencySPMData.Enabled:=True;

         Pump3OutPutData.Enabled:=True;
         Pump3EfficiencyData.Enabled:=True;
         Pump3EfficiencySPMData.Enabled:=True;
       end;
  end;
end;

procedure TPumpDataForm.Pump1OutputDataChange(Sender: TObject);
begin
  if not ((TEdit(Sender).Text = '-')
      or (TEdit(Sender).Text = DefaultFormatSettings.DecimalSeparator)
      or (TEdit(Sender).Text = ''))
          then _WellPump[1,1]:=Round2(StrToFloat(Pump1OutputData.Text)/UoMConverter[5],2); { User gals or litres ->API volume gals }
end;

procedure TPumpDataForm.Pump1EfficiencyDataChange(Sender: TObject);
begin
  if not ((TEdit(Sender).Text = '-')
      or (TEdit(Sender).Text = DefaultFormatSettings.DecimalSeparator)
      or (TEdit(Sender).Text = ''))
          then _WellPump[1,2]:=Round2(StrToFloat(Pump1EfficiencyData.Text),2); { % }
end;

procedure TPumpDataForm.Pump1EfficiencySPMDataChange(Sender: TObject);
begin
  if not ((TEdit(Sender).Text = '-')
      or (TEdit(Sender).Text = DefaultFormatSettings.DecimalSeparator)
      or (TEdit(Sender).Text = ''))
          then _WellPump[1,3]:=StrToInt(Pump1EfficiencyData.Text); { SPM }
end;

procedure TPumpDataForm.Pump2OutputDataChange(Sender: TObject);
begin
  if not ((TEdit(Sender).Text = '-')
      or (TEdit(Sender).Text = DefaultFormatSettings.DecimalSeparator)
      or (TEdit(Sender).Text = ''))
          then _WellPump[2,1]:=Round2(StrToFloat(Pump2OutputData.Text)/UoMConverter[5],2); { User gals or litres ->API volume gals }
end;

procedure TPumpDataForm.Pump2EfficiencyDataChange(Sender: TObject);
begin
  if not ((TEdit(Sender).Text = '-')
      or (TEdit(Sender).Text = DefaultFormatSettings.DecimalSeparator)
      or (TEdit(Sender).Text = ''))
          then _WellPump[2,2]:=Round2(StrToFloat(Pump2EfficiencyData.Text),2); { % }
end;

procedure TPumpDataForm.Pump2EfficiencySPMDataChange(Sender: TObject);
begin
  if not ((TEdit(Sender).Text = '-')
      or (TEdit(Sender).Text = DefaultFormatSettings.DecimalSeparator)
      or (TEdit(Sender).Text = ''))
          then _WellPump[2,3]:=StrToInt(Pump2EfficiencyData.Text); { SPM }
end;

procedure TPumpDataForm.Pump3OutputDataChange(Sender: TObject);
begin
  if not ((TEdit(Sender).Text = '-')
      or (TEdit(Sender).Text = DefaultFormatSettings.DecimalSeparator)
      or (TEdit(Sender).Text = ''))
          then _WellPump[3,1]:=Round2(StrToFloat(Pump3OutputData.Text)/UoMConverter[5],2); { User gals or litres ->API volume gals }
end;

procedure TPumpDataForm.Pump3EfficiencyDataChange(Sender: TObject);
begin
  if not ((TEdit(Sender).Text = '-')
      or (TEdit(Sender).Text = DefaultFormatSettings.DecimalSeparator)
      or (TEdit(Sender).Text = ''))
          then _WellPump[3,2]:=Round2(StrToFloat(Pump3EfficiencyData.Text),2); { % }
end;

procedure TPumpDataForm.Pump3EfficiencySPMDataChange(Sender: TObject);
begin
  if not ((TEdit(Sender).Text = '-')
      or (TEdit(Sender).Text = DefaultFormatSettings.DecimalSeparator)
      or (TEdit(Sender).Text = ''))
          then _WellPump[3,3]:=StrToInt(Pump3EfficiencyData.Text); { SPM }
end;


procedure TPumpDataForm.MaxPumpPressureDataChange(Sender: TObject);
begin
  if not ((TEdit(Sender).Text = '-')
      or (TEdit(Sender).Text = DefaultFormatSettings.DecimalSeparator)
      or (TEdit(Sender).Text = ''))
          then _WellMaxPumpPressure:=Round2(StrToFloat(MaxPumpPressureData.Text)/UoMConverter[3],2); { User psi or KPa ->API psi }
end;





{ ------------------ Form procedures ---------------------- }

procedure TPumpDataForm.FormActivate(Sender: TObject);
begin
  StringToMemo('Form Pump Data activated...........................');

  // units of measure labels



  // data


end;

procedure TPumpDataForm.FormCreate(Sender: TObject);
begin

end;

procedure TPumpDataForm.FormDeactivate(Sender: TObject);
begin     { Also called on QuitButton }
  StringToMemo('FormPumpData.Deactivate ........................................');
end;

procedure TPumpDataForm.QuitButtonClick(Sender: TObject);
begin
  StringToMemo('FormPumpData.Quit ..............................................');
  Close;
end;

procedure TPumpDataForm.SaveButtonClick(Sender: TObject);
var Error : boolean;
begin
  Edited:=True;
  Close;
end;

end.

