#!/bin/bash

COMMANDINFO="/dev/shm/runcommand.info"
 
if [ -f "$COMMANDINFO" ];
then
   echo "Found Command File: $COMMANDINFO"
   
   EMULATOR=$(head -1 $COMMANDINFO)
   echo "Found Emulator: $EMULATOR"
   
   COMMAND=$(tail -1 $COMMANDINFO)
   echo "Found Command: $COMMAND"
   
   PROGRAM=${COMMAND%% *}
   echo "Found Program: $PROGRAM"
   
   if [ "$PROGRAM" = "bash" ];
   then
     echo "WARNING! bash found. Changing to emulator specific program"
     PROGRAM=
     if [ "$EMULATOR" = "scummvm" ];
     then 
      PROGRAM=$EMULATOR
     fi
     echo "Changed Program to $PROGRAM"
   fi
   
   if [[ "$PROGRAM" != "" ]];
   then
     PID=$(pgrep -n -f "$PROGRAM")
     if [[ $PID -gt 0 ]];
     then
        echo "Found PID: $PID"
        kill -9 $PID
        echo "Killed Emulator $EMULATOR"
     else
        echo "No emulator running. Aborting!"
     fi
   else
      echo "No program defined. Aborting!"
   fi
else
   echo "Unable to find $COMMANDINFO. Aborting!"
fi