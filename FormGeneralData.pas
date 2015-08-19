unit FormGeneralData;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils,
  FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls,
  DrillSimVariables,
  DrillSimMessageToMemo;

type

  { TGeneralDataForm }

  TGeneralDataForm = class(TForm)
    ChokeLineIDData: TEdit;
    ChokeLineIDUoMLabel: TLabel;
    WaterDepthUoMLabel: TLabel;
    RiserTDUoMLabel: TLabel;
    RiserIDUoMLabel: TLabel;
    WaterDepthData: TEdit;
    RiserTDData: TEdit;
    RiserIDData: TEdit;
    WaterDepth: TStaticText;
    ElevationRKBData: TEdit;
    ElevationRKBUoMLabel: TLabel;
    OffshoreYNRadioGroup: TRadioGroup;
    ChokeLineID: TStaticText;
    RiserTD: TStaticText;
    RiserID: TStaticText;
    SubSeaWellHeadYNRadioGroup: TRadioGroup;
    Save: TButton;
    Quit: TButton;
    WellNameData: TEdit;
    WellOperatorData: TEdit;
    ElevationRKB: TStaticText;
    WellOperator: TStaticText;
    WellName: TStaticText;

    procedure ChokeLineIDDataChange(Sender: TObject);
    procedure RiserIDDataChange(Sender: TObject);
    procedure RiserTDDataChange(Sender: TObject);
    procedure WaterDepthDataChange(Sender: TObject);
    procedure WellNameDataChange(Sender: TObject);
    procedure WellOperatorDataChange(Sender: TObject);
    procedure ElevationRKBDataChange(Sender: TObject);
    procedure OffshoreYNRadioGroupClick(Sender: TObject);
    procedure SubSeaWellHeadYNRadioGroupClick(Sender: TObject);
    procedure NumericOnlyKeyPress(Sender: TObject; var Key: Char);

    procedure QuitClick(Sender: TObject);
    procedure SaveClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;
var
  GeneralDataForm           : TGeneralDataForm;

  _WellOperator     : String120;
  _WellName         : String120;
  _WellElevation    : real;
  _WellOffshore     : boolean;
  _WellSubSeaWellHead   : boolean;
  _WellRiserTD      : real;
  _WellRiserID      : real;
  _WellChokeLineID  : real;
  _WellWaterDepth   : real;

implementation

Uses DrillSimGUI;

{$R *.lfm}

{ TGeneralDataForm }

{ ------------- Edit Procedures ------------ }

procedure TGeneralDataForm.NumericOnlyKeyPress(Sender: TObject; var Key: Char);
begin
  if not (Key in [#8, '0'..'9', '-', DecimalSeparator]) then
  Begin
    Key := #0;
  end
  else if ((Key = DecimalSeparator) or (Key = '-')) and
          (Pos(Key, (Sender as TEdit).Text) > 0) then
  Begin
    Key := #0;
  end
  else if (Key = '-') and
          ((Sender as TEdit).SelStart <> 0) then
  Begin
    Key := #0;
  end;
end;

procedure TGeneralDataForm.WellOperatorDataChange(Sender: TObject);
begin
  if TEdit(Sender).Text <> '' then _WellOperator:=WellOperatorData.Text;
end;

procedure TGeneralDataForm.WellNameDataChange(Sender: TObject);
begin
  if TEdit(Sender).Text <> '' then _WellName:=WellNameData.Text;
end;

procedure TGeneralDataForm.ElevationRKBDataChange(Sender: TObject);
begin
  if TEdit(Sender).Text <> '' then _WellElevation:=StrToFloat(ElevationRKBData.Text);
end;

procedure TGeneralDataForm.OffshoreYNRadioGroupClick(Sender: TObject);
begin
  case OffshoreYNRadioGroup.ItemIndex of
    0: Begin
         _WellOffshore:= False;
         SubSeaWellHeadYNRadioGroup.Enabled:=False;
         RiserTDData.Enabled:=False;
         RiserIDData.Enabled:=False;
         ChokeLineIDData.Enabled:=False;
         WaterDepthData.Enabled:=False;

         SubSeaWellHeadYNRadioGroup.ItemIndex:=0;
         RiserTDData.Caption:=FloatToStr(0);
         RiserIDData.Caption:=FloatToStr(0);
         ChokeLineIDData.Caption:=FloatToStr(0);
         WaterDepthData.Caption:=FloatToStr(0);
       End;
    1: Begin
         _WellOffshore:= True;
         SubSeaWellHeadYNRadioGroup.Enabled:=True;

         if Data.SubSeaWellHead=True then
         Begin
           SubSeaWellHeadYNRadioGroup.ItemIndex:=1;
           ChokeLineIDData.Enabled:=True;
         end else
         Begin
           SubSeaWellHeadYNRadioGroup.ItemIndex:=0;
           RiserTDData.Enabled:=True;
           RiserIDData.Enabled:=True;
         end;
         WaterDepthData.Enabled:=True;
       End;
    end;
end;

procedure TGeneralDataForm.SubSeaWellHeadYNRadioGroupClick(Sender: TObject);
begin
  case SubSeaWellHeadYNRadioGroup.ItemIndex of
    0: Begin
         _WellSUbSeaWellHead:=False;
         RiserTDData.Enabled:=True;
         RiserIDData.Enabled:=True;
         ChokeLineIDData.Enabled:=False;
         WaterDepthData.Enabled:=True;

         SubSeaWellHeadYNRadioGroup.ItemIndex:=0;
//         RiserTDData.Caption:=FloatToStr(0);  { leave data - no need to zero }
//         RiserIDData.Caption:=FloatToStr(0);
       End;
    1: Begin
         _WellSubSeaWellHead:=True;
         RiserTDData.Enabled:=False;
         RiserIDData.Enabled:=False;
         ChokeLineIDData.Enabled:=True;
         WaterDepthData.Enabled:=True;

//         ChokeLineIDData.Caption:=FloatToStr(0);
       End;
    end;
end;

procedure TGeneralDataForm.RiserTDDataChange(Sender: TObject);
begin
  if TEdit(Sender).Text <> '' then _WellRiserTD:=StrToFloat(RiserTDData.Text);
end;

procedure TGeneralDataForm.RiserIDDataChange(Sender: TObject);
begin
  if TEdit(Sender).Text <> '' then _WellRiserID:=StrToFloat(RiserIDData.Text);
end;

procedure TGeneralDataForm.ChokeLineIDDataChange(Sender: TObject);
begin
  if TEdit(Sender).Text <> '' then _WellChokeLineID:=StrToFloat(ChokeLineIDData.Text);
end;

procedure TGeneralDataForm.WaterDepthDataChange(Sender: TObject);
begin
  if TEdit(Sender).Text <> '' then _WellWaterDepth:=StrToFloat(WaterDepthData.Text);
end;


{ ------------------ Form procedures ---------------------- }

procedure TGeneralDataForm.FormActivate(Sender: TObject);
begin
  StringToMemo('Form General Well Data activated....');
//  StringToMemo('Well name is ' + Data.WellName);

  WellOperatorData.Caption:=Data.WellOperator;
  WellNameData.Caption:=Data.WellName;
  ElevationRKBData.Caption:=FloatToStr(Data.ElevationRKB);

  if Data.Offshore=True then
  Begin
    OffshoreYNRadioGroup.ItemIndex:=1;
    SubSeaWellHeadYNRadioGroup.Enabled:=True;
    if Data.SubSeaWellHead=True then
    Begin
      SubSeaWellHeadYNRadioGroup.ItemIndex:=1;
      ChokeLineIDData.Enabled:=True;
      ChokeLineIDData.Caption:=FloatToStr(Data.ChokeLineID);
    end else
    Begin
      SubSeaWellHeadYNRadioGroup.ItemIndex:=0;
      RiserTDData.Enabled:=True;
      RiserTDData.Caption:=FloatToStr(Data.RiserTD);
      RiserIDData.Enabled:=True;
      RiserIDData.Caption:=FloatToStr(Data.RiserID);
    end;
    WaterDepthData.Enabled:=True;
    WaterDepthData.Caption:=FloatToStr(Data.WaterDepth);
  end
  else
  Begin
    OffshoreYNRadioGroup.ItemIndex:=0;
    SubSeaWellHeadYNRadioGroup.ItemIndex:=0;
    SubSeaWellHeadYNRadioGroup.Enabled:=False;
    RiserTDData.Enabled:=False;
    RiserIDData.Enabled:=False;
    ChokeLineIDData.Enabled:=False;
    WaterDepthData.Enabled:=False;
  end;
  ElevationRKBUoMLabel.Caption:=UoMLabel[1]; { depth }
  RiserTDUoMLabel.Caption:=UoMLabel[1];              { depth }
  RiserIDUoMLabel.Caption:=UoMLabel[8];              { inches }
  ChokeLineIDUoMLabel.Caption:=UoMLabel[8];          { inches }
  WaterDepthUoMLabel.Caption:=UoMLabel[1];           { depth }
end;

procedure TGeneralDataForm.FormCreate(Sender: TObject);
begin

end;

procedure TGeneralDataForm.QuitClick(Sender: TObject);
begin
  Close;
end;

procedure TGeneralDataForm.SaveClick(Sender: TObject);
begin
  Data.WellOperator   :=_WellOperator;
  Data.WellName       :=_WellName;
  Data.ElevationRKB   :=_WellElevation;
  Data.Offshore       :=_WellOffshore;
  Data.SubSeaWellHead :=_WellSubSeaWellHead;
  Data.RiserTD        :=_WellRiserTD;
  Data.RiserID        :=_WellRiserID;
  Data.ChokeLineID    :=_WellChokeLineID;
  Data.WaterDepth     :=_WellWaterDepth;
  Edited              :=True;
  Close;
end;


end.
