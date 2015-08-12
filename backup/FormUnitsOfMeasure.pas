unit FormUnitsOfMeasure;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
    DrillSimVariables, DrillSimMessageToMemo;

type

  { TUnitsOfMeasureForm }

  TUnitsOfMeasureForm = class(TForm)
    APIRadioButton: TRadioButton;
    CancelButton: TButton;
    SaveButton: TButton;
    DensityMultiplierData: TEdit;
    FlowRateLabelData: TEdit;
    FlowRateMultiplierData: TEdit;
    FlowMultiplierLabelData: TEdit;
    LengthMultiplierData: TEdit;
    PressureMultiplierData: TEdit;
    UoMUnitLabel: TStaticText;
    UoMMultiplierLabel: TStaticText;
    VolumeMultiplierData: TEdit;
    WeightLabelData: TEdit;
    PressureLabelData: TEdit;
    LengthLabelData: TEdit;
    DensityLabelData: TEdit;
    MetricRadioButton: TRadioButton;
    VolumeLabelData: TEdit;
    UoMFormTitle: TStaticText;
    LengthText: TStaticText;
    DensityText: TStaticText;
    PressureText: TStaticText;
    FlowVolumeLabelData: TEdit;
    VolumeText: TStaticText;
    FlowVolumeText: TStaticText;
    FlowRateText: TStaticText;
    WeightMultiplierData: TEdit;
    WeightText: TStaticText;
    procedure CancelButtonClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure OnClose(Sender: TObject);
    procedure SaveButtonClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormCreateActions;
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  UnitsOfMeasureForm: TUnitsOfMeasureForm;

implementation

{ TUnitsOfMeasureForm }

{$R *.lfm}

Procedure TUnitsOfMeasureForm.FormCreateActions;
Begin
end;

{ ------------- Form Procedures ------------ }

procedure TUnitsOfMeasureForm.FormCreate(Sender: TObject);
begin
  FormCreateActions;
end;

procedure TUnitsOfMeasureForm.SaveButtonClick(Sender: TObject);
begin
  Close
end;

procedure TUnitsOfMeasureForm.CancelButtonClick(Sender: TObject);
begin
  Close
end;

procedure TUnitsOfMeasureForm.FormActivate(Sender: TObject);
begin
 StringToMemo('Form Units Of Measure activated....');
 StringToMemo('=>Units selected: '+ Data.UoMLabel);
 If Data.API=True then
 StringToMemo('=>API=true') else StringToMemo('=>API=false');
 stringtomemo('length = ' + lab[1]);
 stringtomemo('conv = ' + con[1]);

  if Data.API=true then
  Begin
    APIRadioButton.checked:=True;
    MetricRadioButton.checked:=False;
    With Data do
    Begin
     LengthLabelData.Text:=Data.lab[1];     {*  "ft." or "met" *}
     LengthMultiplierData.Text:=FloatToStr(con[1]);

     DensityLabelData.Text:=Data.lab[2];    {* "ppg" or "sg" *}
     DensityMultiplierData.Text:=FloatToStr(con[2]);

     PressureLabelData.Text:=Data.lab[3];    {* "psi" or "KPa" *}
     PressureMultiplierData.Text:=FloatToStr(con[3]);

    end;
  end else
  Begin
    APIRadioButton.checked:=False;
    MetricRadioButton.checked:=True;

    LengthLabelData.Text:=lab[1];     {*  "ft." or "met" *}
    LengthMultiplierData.Text:=FloatToStr(con[1]);

    DensityLabelData.Text:=lab[2];    {* "ppg" or "sg" *}
    DensityMultiplierData.Text:=FloatToStr(con[2]);

    PressureLabelData.Text:=lab[3];    {* "psi" or "KPa" *}
    PressureMultiplierData.Text:=FloatToStr(con[3]);

  End;
end;

Procedure TUnitsOfMeasureForm.OnClose(Sender: TObject);
begin
 Close;
end;

end.
