unit FormGeologyData;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls;

type

  { TGeologyDataForm }

  TGeologyDataForm = class(TForm)
      Horizon1DepthData: TEdit;
      Horizon2DepthData: TEdit;
      Horizon3DepthData: TEdit;
      Horizon4DepthData: TEdit;
      Horizon5DepthData: TEdit;
      Horizon6DepthData: TEdit;
      Horizon7DepthData: TEdit;
      Horizon8DepthData: TEdit;
      Horizon9DepthData: TEdit;
      Horizon10DepthData: TEdit;
      Horizon2HardnessData: TEdit;
      Horizon3HardnessData: TEdit;
      Horizon4HardnessData: TEdit;
      Horizon5HardnessData: TEdit;
      Horizon6HardnessData: TEdit;
      Horizon7HardnessData: TEdit;
      Horizon8HardnessData: TEdit;
      Horizon9HardnessData: TEdit;
      Horizon10HardnessData: TEdit;
      Horizon2Label: TLabel;
      Horizon3Label: TLabel;
      Horizon4Label: TLabel;
      Horizon5Label5: TLabel;
      Horizon6Label: TLabel;
      Horizon7Label: TLabel;
      Horizon8Label: TLabel;
      Horizon9Label: TLabel;
      Horizon10Label: TLabel;
      Horizon1ReservoirPressureData: TEdit;
      Horizon1HardnessData: TEdit;
      Horizon1Label: TLabel;
      Horizon2ReservoirPressureData: TEdit;
      Horizon3ReservoirPressureData: TEdit;
      Horizon4ReservoirPressureData: TEdit;
      Horizon5ReservoirPressureData: TEdit;
      Horizon6ReservoirPressureData: TEdit;
      Horizon7ReservoirPressureData: TEdit;
      Horizon8ReservoirPressureData: TEdit;
      Horizon9ReservoirPressureData: TEdit;
      Horizon10ReservoirPressureData: TEdit;
      HorizonColumnLabel: TLabel;
      HorizonTopDepthUoMLabel: TLabel;
      HardnessColumnLabel: TLabel;
      ReservoirPressureUoMLabel1: TLabel;
      ReservoirPressureColumnLabel: TLabel;
    QuitButton: TButton;
    SaveButton: TButton;
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
    procedure Horizon1ReservoirPressureDataChange(Sender: TObject);
    procedure Horizon1DepthDataChange(Sender: TObject);
    procedure Horizon1HardnessDataChange(Sender: TObject);
    procedure Horizon2DepthDataChange(Sender: TObject);
    procedure Horizon2HardnessDataChange(Sender: TObject);
    procedure Horizon2ReservoirPressureDataChange(Sender: TObject);
    procedure Horizon3DepthDataChange(Sender: TObject);
    procedure Horizon3HardnessDataChange(Sender: TObject);
    procedure Horizon3ReservoirPressureDataChange(Sender: TObject);
    procedure Horizon4DepthDataChange(Sender: TObject);
    procedure Horizon4HardnessDataChange(Sender: TObject);
    procedure Horizon4ReservoirPressureDataChange(Sender: TObject);
    procedure Horizon5DepthDataChange(Sender: TObject);
    procedure Horizon5HardnessDataChange(Sender: TObject);
    procedure Horizon5ReservoirPressureDataChange(Sender: TObject);
    procedure Horizon6DepthDataChange(Sender: TObject);
    procedure Horizon6HardnessDataChange(Sender: TObject);
    procedure Horizon6ReservoirPressureDataChange(Sender: TObject);
    procedure Horizon7DepthDataChange(Sender: TObject);
    procedure Horizon7HardnessDataChange(Sender: TObject);
    procedure Horizon7ReservoirPressureDataChange(Sender: TObject);
    procedure Horizon8DepthDataChange(Sender: TObject);
    procedure Horizon8HardnessDataChange(Sender: TObject);
    procedure Horizon8ReservoirPressureDataChange(Sender: TObject);
    procedure Horizon9DepthDataChange(Sender: TObject);
    procedure Horizon9HardnessDataChange(Sender: TObject);
    procedure Horizon9ReservoirPressureDataChange(Sender: TObject);
    procedure Horizon10DepthDataChange(Sender: TObject);
    procedure Horizon10HardnessDataChange(Sender: TObject);
    procedure Horizon10ReservoirPressureDataChange(Sender: TObject);
    procedure NumericOnlyKeyPress(Sender: TObject; var Key: Char);
    procedure QuitButtonClick(Sender: TObject);
    procedure SaveButtonClick(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  GeologyDataForm: TGeologyDataForm;

implementation

{$R *.lfm}

{ TGeologyDataForm }

{ ------------- Edit Procedures ------------ }

procedure TGeologyDataForm.NumericOnlyKeyPress(Sender: TObject; var Key: Char);
begin
  if not (Key in [#8, '0'..'9', '-', DefaultFormatSettings.DecimalSeparator]) then   { discard if not in approved list of chars }
  Begin
    Key := #0;  // discard it
  end
  else if ((Key = '-')) and  ((Sender as TEdit).SelStart <> 0) then             { discard if "-" and not first char in string }
  Begin
    Key := #0;  // discard it
  end
  else if ((Key = DefaultFormatSettings.DecimalSeparator) or (Key = '-')) and        { discard if "." or "-" already in string }
          (Pos(Key, (Sender as TEdit).Text) > 0) then
  Begin
    Key := #0;  // discard it
  end
  else if (Key = DefaultFormatSettings.DecimalSeparator) and                         { discard if "." is first charachter }
          ((Sender as TEdit).SelStart = 0) then
  Begin
    Key := #0;  // discard it
  end;
end;

procedure TGeologyDataForm.Horizon1DepthDataChange(Sender: TObject);
begin

end;

procedure TGeologyDataForm.Horizon1ReservoirPressureDataChange(Sender: TObject);
begin

end;

procedure TGeologyDataForm.Horizon1HardnessDataChange(Sender: TObject);
begin

end;


procedure TGeologyDataForm.Horizon2DepthDataChange(Sender: TObject);
begin

end;

procedure TGeologyDataForm.Horizon2HardnessDataChange(Sender: TObject);
begin

end;

procedure TGeologyDataForm.Horizon2ReservoirPressureDataChange(Sender: TObject);
begin

end;


procedure TGeologyDataForm.Horizon3DepthDataChange(Sender: TObject);
begin

end;

procedure TGeologyDataForm.Horizon3HardnessDataChange(Sender: TObject);
begin

end;

procedure TGeologyDataForm.Horizon3ReservoirPressureDataChange(Sender: TObject);
begin

end;


procedure TGeologyDataForm.Horizon4DepthDataChange(Sender: TObject);
begin

end;

procedure TGeologyDataForm.Horizon4HardnessDataChange(Sender: TObject);
begin

end;

procedure TGeologyDataForm.Horizon4ReservoirPressureDataChange(Sender: TObject);
begin

end;


procedure TGeologyDataForm.Horizon5DepthDataChange(Sender: TObject);
begin

end;

procedure TGeologyDataForm.Horizon5HardnessDataChange(Sender: TObject);
begin

end;

procedure TGeologyDataForm.Horizon5ReservoirPressureDataChange(Sender: TObject);
begin

end;


procedure TGeologyDataForm.Horizon6DepthDataChange(Sender: TObject);
begin

end;

procedure TGeologyDataForm.Horizon6HardnessDataChange(Sender: TObject);
begin

end;

procedure TGeologyDataForm.Horizon6ReservoirPressureDataChange(Sender: TObject);
begin

end;


procedure TGeologyDataForm.Horizon7DepthDataChange(Sender: TObject);
begin

end;

procedure TGeologyDataForm.Horizon7HardnessDataChange(Sender: TObject);
begin

end;

procedure TGeologyDataForm.Horizon7ReservoirPressureDataChange(Sender: TObject);
begin

end;


procedure TGeologyDataForm.Horizon8DepthDataChange(Sender: TObject);
begin

end;

procedure TGeologyDataForm.Horizon8HardnessDataChange(Sender: TObject);
begin

end;

procedure TGeologyDataForm.Horizon8ReservoirPressureDataChange(Sender: TObject);
begin

end;


procedure TGeologyDataForm.Horizon9DepthDataChange(Sender: TObject);
begin

end;

procedure TGeologyDataForm.Horizon9HardnessDataChange(Sender: TObject);
begin

end;

procedure TGeologyDataForm.Horizon9ReservoirPressureDataChange(Sender: TObject);
begin

end;


procedure TGeologyDataForm.Horizon10DepthDataChange(Sender: TObject);
begin

end;

procedure TGeologyDataForm.Horizon10HardnessDataChange(Sender: TObject);
begin

end;

procedure TGeologyDataForm.Horizon10ReservoirPressureDataChange(Sender: TObject
  );
begin

end;

{ ------------------ Form procedures ---------------------- }

procedure TGeologyDataForm.FormActivate(Sender: TObject);
begin

end;

procedure TGeologyDataForm.FormCreate(Sender: TObject);
begin

end;

procedure TGeologyDataForm.FormDeactivate(Sender: TObject);
begin

end;

procedure TGeologyDataForm.QuitButtonClick(Sender: TObject);
begin

end;

procedure TGeologyDataForm.SaveButtonClick(Sender: TObject);
begin

end;



end.

