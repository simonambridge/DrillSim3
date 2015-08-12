unit FormGeneralData;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils,
  FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  DrillSimVariables,
  DrillSimMessageToMemo;

type

  { TGeneralDataForm }

  TGeneralDataForm = class(TForm)
    ElevationRKBData: TEdit;
    ElevationRKBUoMLabel: TLabel;
    OffshoreYNDataYes: TRadioButton;
    OffshoreYNDataNo: TRadioButton;
    Save: TButton;
    Quit: TButton;
    WellNameData: TEdit;
    WellOperatorData: TEdit;
    ElevationRKB: TStaticText;
    OffshoreYN: TStaticText;
    WellOperator: TStaticText;
    WellName: TStaticText;
    procedure ElevationRKBDataChange(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: char);
    procedure OffshoreYNDataYesChange(Sender: TObject);
    procedure QuitClick(Sender: TObject);
    procedure SaveClick(Sender: TObject);
    procedure WellNameDataChange(Sender: TObject);
    procedure WellOperatorDataChange(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;
var
  GeneralDataForm: TGeneralDataForm;


implementation

Uses DrillSimGUI;

{$R *.lfm}

{ TGeneralDataForm }

procedure TGeneralDataForm.FormKeyPress(Sender: TObject; var Key: char);
begin

end;

procedure TGeneralDataForm.QuitClick(Sender: TObject);
begin
  Close;
end;

procedure TGeneralDataForm.SaveClick(Sender: TObject);
begin

end;

{ ------------------------------- Edit ------------------------------}

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
  if Success then Data.WellOperator:=WellOperatorData.Text;
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
  if Success then Data.WellName:=WellNameData.Text;
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
if Success then Data.ElevationRKB:=StrToFloat(ElevationRKBData.Text);
end;

procedure TGeneralDataForm.FormActivate(Sender: TObject);
begin
  StringToMemo('Form General Well Data activated....');
end;

procedure TGeneralDataForm.OffshoreYNDataYesChange(Sender: TObject);
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
  if Success then Data.Offshore:=OffshoreYNDataYes.Checked;
end;


end.