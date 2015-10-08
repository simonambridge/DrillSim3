Unit SimulateRAMs;

Interface

Uses DrillSimVariables,
     DrillSimMessageToMemo,
     SimulateVolumes;

Procedure RamCheck;  { called from BOPCommands and SetSurfControls }

Implementation

Procedure RamCheck;  { called from BOPCommands and SetSurfControls }
Begin
  With Data do
  Begin
    if Hydril then MessageToMemo(11)  { message# }
              else MessageToMemo(12);  { message# }
    if PipeRam then MessageToMemo(8)  { message# }
               else MessageToMemo(9);  { message# }

    if not (Hydril or BlindRam or PipeRam) then
    Begin
      StringToMemo('Blow Out Preventers are OPEN');
      if ShutIn then        { change status to open if not already open }
      Begin
        ShutIn:=False;      { change to shut-in                   }
        VolCalc;            { calculate volumes and include riser }

      { add the circulating volume in the riser to MudVol.
        If well had been pressured up then MainCalc will calculate
        net flow as normal. Setting ExcessMud to 0 keeps it in one of
        2 states (valid or zero) depending upon whether the well is
        shut-in or not. }

        MudVol:=MudVol + ExcessMud;
        ExcessMud:=Zero;              { clear it for next time }
      End;
    End else
    Begin
      StringToMemo('Blow Out Preventers are CLOSED');
      if not ShutIn then   { change status to shut in if not already shut in }
      Begin                { ie only do this if rams have just been closed   }
        ShutIn:=True;
        VolCalc;            { calculate volumes and exclude riser }

      { HoleVol is now reduced if sub-sea wellhead in use. MudVol
        minus holevol = riser circulating volume, so store it in
        ExcessMud for when well is opened up again. This assumes that
        MudVol cannot be less than hole minus riser circ. volume. }

        ExcessMud:=MudVol - HoleVol;
        MudVol:=HoleVol;
      End;
    End;
  End;
End;

Begin
End.