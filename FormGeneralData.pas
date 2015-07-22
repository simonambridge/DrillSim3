unit FormGeneralData;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils,
  FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls, DrillSimVariables;

type

  { TGeneralData }

  TGeneralData = class(TForm)
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
  GeneralData: TGeneralData;


implementation

Uses DrillSimGUI;

{$R *.lfm}

{ TGeneralData }

procedure TGeneralData.FormKeyPress(Sender: TObject; var Key: char);
begin

end;

procedure TGeneralData.QuitClick(Sender: TObject);
begin
  Close;
end;

procedure TGeneralData.SaveClick(Sender: TObject);
begin

end;

{ ------------------------------- Edit ------------------------------}

procedure TGeneralData.WellOperatorDataChange(Sender: TObject);
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

procedure TGeneralData.WellNameDataChange(Sender: TObject);
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

procedure TGeneralData.ElevationRKBDataChange(Sender: TObject);
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

procedure TGeneralData.OffshoreYNDataYesChange(Sender: TObject);
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
