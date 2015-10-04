Unit SimulateControl;

Interface

Uses Dialogs,
     DrillSimVariables,
     SimulateHydraulicCalcs,
     SimulateDrillingCalcs,
     SimulateControlChecks,
     SimulateUpdate,
     SimulateKick;

Procedure Control;

Implementation

Procedure Control;
Begin
  While not Quit do
  Begin
    //HyCalc;
    //TimeUpdate;

     if Quit then Exit;

    { check for hole deeper then next horizon          }
    { if yes, check if next horizon data is valid (>0) }
    { if yes, advance RockPointer and calculate new    }
    { formation pressure gradient                      }
    //ShowMessage('Got here');
    //ControlChecks;

    //DrillCalc;

    // InputScan;   now done in the GUI
    if Quit then Exit;

    //KickCalc;
    if Quit then Exit;

  End;
End;

Begin
End.