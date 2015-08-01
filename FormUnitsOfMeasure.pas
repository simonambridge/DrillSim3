unit FormUnitsOfMeasure;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls;

type

  { TUnitsOfMeasureForm }

  TUnitsOfMeasureForm = class(TForm)
    APIRadioButton: TRadioButton;
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
    UserRadioButton: TRadioButton;
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
    procedure FormCreateActions;
    procedure FormCreate(Sender: TObject);
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


end.
