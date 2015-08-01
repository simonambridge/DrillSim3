Unit SimulateMain;
{ !!!!! Simulate does not use ConAPI or ConUser because it converts all
  !!!!! parameters for display purposes - all data is maintained
  !!!!! internally in API units to speed up calculations }


Interface

Uses
  DrillSimVariables,
  DrillSimUnitsOfMeasure,
  DrillSimStartup,
  SimulateFile,
  SimulateHoleCalcs,
  SimulateControl,
  SimulateInit,
  DrillSimDateTime,
  SimulateScreen,
  SimulateUpdate,
  SimulateSurfaceControls;

Procedure Simulator;

Implementation

{ --------------- Program Code Starts Here ----------------- }

Procedure Abort(ErrorType,ErrorAddr : integer);
Var
  ErrorCat, ErrorNum : integer;
  Msg1 : string[60];

Begin
  ErrorCat:=hi(ErrorType);
  ErrorNum:=lo(ErrorType);
  Case ErrorCat of
    1 : Begin
          Msg1:='I/O error - ';
          Case ErrorNum of
            $01 : Msg1:=Msg1 + 'File not found';
            $04 : Msg1:=Msg1 + 'File not prepared with reset or rewrite';
            $91 : Msg1:=Msg1 + 'disk data area full';
            $F0 : Msg1:=Msg1 + 'disk directory full';
            $F1 : Msg1:=Msg1 + 'Too many files open';
            $FF : Msg1:=Msg1 + 'file no longer in directory';
             else Msg1:=Msg1 + 'unknown I/O error';
          End;
        End;
    2 : Begin
          Msg1:='Run-time error - ';
          Case ErrorNum of
            $01 : Msg1:=Msg1 + 'floating point overflow';
            $02 : Msg1:=Msg1 + 'division by zero';
            $03 : Msg1:=Msg1 + 'negative sqrt argument';
            $04 : Msg1:=Msg1 + 'zero or negative argument';
            $10 : Msg1:=Msg1 + 'illegal string length';
            $11 : Msg1:=Msg1 + 'string index not within 1..255';
            $90 : Msg1:=Msg1 + 'index not within range for an array';
            $91 : Msg1:=Msg1 + 'scalar or subrange out of range';
            $92 : Msg1:=Msg1 + 'real value out of integer range';
             else Msg1:=Msg1 + 'unknown error type';
          End;
        End;
   else Msg1:='Unknown error';
  End;

{  Str(hi(ErrorAddr):4,Msg2);
  Str(lo(ErrorAddr):4,Msg3);
  Str(ErrorAddr:6,Msg4);
  if ErrorCat in [1,2] then Msg1:=Msg1 + ' at' + Msg2 + ':' + Msg3;
  ClrScr;

  //Disp(1,1,'System halted');
  //Disp(1,2,Msg1);

  if ErrorCat=1 then
  //Disp(1,3,'Please check your system for possible faults (ie disk full etc.)')
                else
  //Disp(1,3,'Please inform Ambersoft with full details immediately');

  //Disp(1,4,Msg4);
 }
 { errors $F0 and $FF not needed - no overlays, heap/stack }
 ExitProc:=OriginalExitProc;
  Halt;
End;

{***********************  main program block  *************************}

Procedure Simulator;
Begin
  { ExitProc:=@Abort;    }       { set error trap vector                  }
  ChDir(LoggedDirectory);         { set to Logged directory first          }

                                  { if Quit=T  resets to Origin directory  }
                                  { All file and Path functions use the    }
                                  { Logged directory                       }

  if NoFileDefined then           { check for no file in use               }
  Begin
    FileName:='no file';          { set file name for load window          }
    SimulateLoadFile;                     { and go prompt for one                  }
  End;

  if not NoFileDefined then       { if file defined, continue into Simulator }
  Begin
    InitMud;                      { set the system OriginalMudWt etc.      }

    InitDepth;                    { depths used for reset are the current  }
                                  { depths at the start of this session    }
                                  { which may not be the original depths   }

    InitKick;                     { Set up and initialise if NeverSimulated }

    InitGeology;                  { find current position within geological}
                                  { table. Also done on Load and Clear     }
    GetCurrentTime (t);
    Data.t2:=t.Seconds;             { initialize time                    }
    Screen;                         { display screen and kelly.          }
                                    { do HoleCalc in DrillSim/HyCalc     }
                                    { so that Screen can be done first   }
                                    { to reduce the delay for the user.  }

    SimHoleCalc;                    { calculate volumes                  }



    FlowUpdate;                     { set up flow in                     }
    InitialiseKelly;                { draw it at the top                 }
    SetKelly;                       { move kelly to drilling position    }
    SetSurfControls;                { set RAMs and choke line            }
    Control;                        { Call simulater controller, fall    }
                                    { through to SelectMenu when Quit=T  }

  End;                              { still no file, then return to DrillSim }
End;

                                  { Edited set to FALSE when a file is     }
                                  { loaded. Therefore the start up file    }
                                  { and any subsequently loaded will be    }
                                  { able to detect if the data is altered  }
                                  { even when going in and out of DrillSim }


Begin
End.
