unit FormSurfaceEquipmentData;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls;

type

  { TSurfaceEquipmentDataForm }

  TSurfaceEquipmentDataForm = class(TForm)
    StandPipeIDUoMLabel: TLabel;
    KellyIDUoMLabel: TLabel;
    SwivelIDUoMLabel: TLabel;
    StandPipeIDData: TEdit;
    KellyIDData: TEdit;
    SwivelIDData: TEdit;
    StandPipeLengthData: TEdit;
    KellyLengthData: TEdit;
    HoseIDData: TEdit;
    HoseIDUoMLabel: TLabel;
    SwivelLengthData: TEdit;
    KellyLengthLabel: TLabel;
    KellyIDLabel: TLabel;
    HoseLengthData: TEdit;
    SwivelLengthLabel: TLabel;
    SwivelIDLabel: TLabel;
    HoseLengthLabel: TLabel;
    HoseIDLabel: TLabel;
    StandPipeLengthLabel: TLabel;
    StandPipeIDLabel: TLabel;
    QuitButton: TButton;
    SaveButton: TButton;
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
    procedure HoseIDDataChange(Sender: TObject);
    procedure HoseLengthDataChange(Sender: TObject);
    procedure KellyIDDataChange(Sender: TObject);
    procedure KellyLengthDataChange(Sender: TObject);
    procedure NumericOnlyKeyPress(Sender: TObject; var Key: Char);
    procedure QuitButtonClick(Sender: TObject);
    procedure SaveButtonClick(Sender: TObject);
    procedure StandPipeIDDataChange(Sender: TObject);
    procedure StandPipeLengthDataChange(Sender: TObject);
    procedure SwivelIDDataChange(Sender: TObject);
    procedure SwivelLengthDataChange(Sender: TObject);

  private
    { private declarations }
  public
    { public declarations }
  end;

var
  SurfaceEquipmentDataForm: TSurfaceEquipmentDataForm;

implementation

{$R *.lfm}

{ TSurfaceEquipmentDataForm }

{ ------------- Edit Procedures ------------ }

procedure TSurfaceEquipmentDataForm.NumericOnlyKeyPress(Sender: TObject; var Key: Char);
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

procedure TSurfaceEquipmentDataForm.KellyLengthDataChange(Sender: TObject);
begin

end;

procedure TSurfaceEquipmentDataForm.KellyIDDataChange(Sender: TObject);
begin

end;

procedure TSurfaceEquipmentDataForm.SwivelLengthDataChange(Sender: TObject);
begin

end;

procedure TSurfaceEquipmentDataForm.SwivelIDDataChange(Sender: TObject);
begin

end;

procedure TSurfaceEquipmentDataForm.HoseLengthDataChange(Sender: TObject);
begin

end;

procedure TSurfaceEquipmentDataForm.HoseIDDataChange(Sender: TObject);
begin

end;

procedure TSurfaceEquipmentDataForm.StandPipeIDDataChange(Sender: TObject);
begin

end;

procedure TSurfaceEquipmentDataForm.StandPipeLengthDataChange(Sender: TObject);
begin

end;



{ ------------------ Form procedures ---------------------- }

procedure TSurfaceEquipmentDataForm.FormActivate(Sender: TObject);
begin

end;

procedure TSurfaceEquipmentDataForm.FormCreate(Sender: TObject);
begin

end;

procedure TSurfaceEquipmentDataForm.FormDeactivate(Sender: TObject);
begin

end;
procedure TSurfaceEquipmentDataForm.QuitButtonClick(Sender: TObject);
begin

end;

procedure TSurfaceEquipmentDataForm.SaveButtonClick(Sender: TObject);
begin

end;



end.

