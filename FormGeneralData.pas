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
    ElevationRKBData: TEdit;
    ElevationRKBUoMLabel: TLabel;
    OffshoreYNRadioGroup: TRadioGroup;
    Save: TButton;
    Quit: TButton;
    WellNameData: TEdit;
    WellOperatorData: TEdit;
    ElevationRKB: TStaticText;
    WellOperator: TStaticText;
    WellName: TStaticText;

    procedure WellNameDataChange(Sender: TObject);
    procedure WellOperatorDataChange(Sender: TObject);
    procedure ElevationRKBDataChange(Sender: TObject);
    procedure OffshoreYNRadioGroupClick(Sender: TObject);

    procedure QuitClick(Sender: TObject);
    procedure SaveClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
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

implementation

Uses DrillSimGUI;

{$R *.lfm}

{ TGeneralDataForm }

{ ------------- Edit Procedures ------------ }

procedure TGeneralDataForm.OffshoreYNRadioGroupClick(Sender: TObject);
begin
  case OffshoreYNRadioGroup.ItemIndex of
    0: Begin
         _WellOffshore:= True;
       End;
    1: Begin
         _WellOffshore:= False;
       End;
    end;

end;

procedure TGeneralDataForm.WellOperatorDataChange(Sender: TObject);
var
  MyEdit: TEdit;
  Success: boolean;
begin
  Success:= true;
  if (Sender is TEdit) then begin
    MyEdit:= TEdit(Sender);
    MyEdit.Hint:= '';
    try
      if MyEdit.Text = '' then
      Begin
        MyEdit.Hint:= 'Cannot be blank';
        Success:= false;
      end else MyEdit.Color:= clWindow; //all is OK make edit standard white.
    except
      MyEdit.Color:= clRed;  //Let the user know the output is not valid.
      MyEdit.Hint:= MyEdit.Text + 'not valid';
      Success:= false;
    end;
  end;
  if Success then _WellOperator:=WellOperatorData.Text;
end;

procedure TGeneralDataForm.WellNameDataChange(Sender: TObject);
var
  MyEdit: TEdit;
  Success: boolean;
begin
  Success:= true;
  if (Sender is TEdit) then begin
    MyEdit:= TEdit(Sender);
    MyEdit.Hint:= '';
    try
      if MyEdit.Text = '' then
      Begin
        MyEdit.Hint:= 'Cannot be blank';
        Success:= false;
      end else MyEdit.Color:= clWindow; //all is OK make edit standard white.
    except
      MyEdit.Color:= clRed;  //Let the user know the output is not valid.
      MyEdit.Hint:= MyEdit.Text + 'not valid';
      Success:= false;
    end;
  end;
  if Success then _WellName:=WellNameData.Text;
end;

procedure TGeneralDataForm.ElevationRKBDataChange(Sender: TObject);
var
MyEdit: TEdit;
Success: boolean;
begin
Success:= true;
if (Sender is TEdit) then begin
  MyEdit:= TEdit(Sender);
  MyEdit.Hint:= '';
  try
    if MyEdit.Text = '' then
    Begin
      MyEdit.Hint:= 'Cannot be blank';
      Success:= false;
    end else MyEdit.Color:= clWindow; //all is OK make edit standard white.
  except
    MyEdit.Color:= clRed;  //Let the user know the output is not valid.
    MyEdit.Hint:= MyEdit.Text + 'not valid';
    Success:= false;
  end;
end;
if Success then _WellElevation:=StrToFloat(ElevationRKBData.Text);
end;


{ ------------------ Form procedures ---------------------- }

procedure TGeneralDataForm.FormActivate(Sender: TObject);
begin
  StringToMemo('Form General Well Data activated....');
  StringToMemo('Well name is ' + Data.WellName);
  WellOperatorData.Caption:=Data.WellOperator;
  WellNameData.Caption:=Data.WellName;
  ElevationRKBData.Caption:=FloatToStr(Data.ElevationRKB);
  if Data.Offshore= True
  then OffshoreYNRadioGroup.ItemIndex:=1
  else OffshoreYNRadioGroup.ItemIndex:=0;
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
  Close;
end;


end.
