#!../../bin/linux-x86_64/timing

< envPaths

epicsEnvSet("TOP", "../..")

< EVR.config

# ################################

epicsEnvSet("STREAM_PROTOCOL_PATH", "$(TOP)/timingApp/Db")

## Register all support components
dbLoadDatabase("${TOP}/dbd/timing.dbd")
timing_registerRecordDeviceDriver pdbbase

asSetFilename("$(TOP)/timingApp/Db/accessSecurityFile.acf")

drvAsynIPPortConfigure ("${PORT}", "${IPADDR}:${IPPORT}:${IPPORT} udp",0,0,0)

## Load record instances
dbLoadRecords("${TOP}/db/evr.db", "P=${P}, R=${R}, PORT=${PORT}, ADDR=0, TIMEOUT=2")

< save_restore.cmd

## Run this to trace the stages of iocInit
#traceIocInit

iocInit

## Start any sequence programs

# Module initialization and network status state machine
seq sncEVRESetup, "P=${P}, R=${R}"

# Create monitor for Autosave
create_monitor_set("autosave_evr.req", 60, "P=${P}, R=${R}")

# Create manual trigger for Autosave
create_triggered_set("autosave_evr.req", "${P}${R}Save-Cmd", "P=${P}, R=${R}")

set_savefile_name("autosave_evr.req", "auto_settings_${P}${R}.sav")
