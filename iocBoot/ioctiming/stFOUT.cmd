#!../../bin/linux-x86_64/timing

< envPaths

epicsEnvSet("TOP", "../..")

< FOUT.config

# ################################

epicsEnvSet("STREAM_PROTOCOL_PATH", "$(TOP)/timingApp/Db")

## Register all support components
dbLoadDatabase("${TOP}/dbd/timing.dbd")
timing_registerRecordDeviceDriver pdbbase

asSetFilename("$(TOP)/timingApp/Db/accessSecurityFile.acf")
asSetSubstitutions("P=$(P_EVG=AS-RaMO:),R=$(R_EVG=TI-EVG:)")

drvAsynIPPortConfigure ("${PORT}", "${IPADDR}:${IPPORT} tcp",0,0,0)

dbLoadRecords("${TOP}/db/asynRecord.db", "P=$(P)$(R), R=asyn, PORT=$(PORT), ADDR=0, OMAX=80, IMAX=80")

## Load record instances
dbLoadRecords("${TOP}/db/fout.db", "P=${P}, R=${R}, IPADDR=${IPADDR}, IPPORT=${IPPORT}, PORT=${PORT}, ADDR=0, TIMEOUT=2")

dbLoadRecords("${TOP}/db/fw_version.db", "P=${P}, R=${R}, PORT=${PORT}, ADDR=0, TIMEOUT=2")

dbLoadRecords("${TOP}/db/rx_locked.db", "P=${P}, R=${R}, PORT=${PORT}, ADDR=0, TIMEOUT=2, DEVICE=fout")

dbLoadRecords("${TOP}/db/evgfout_rxenbl.db", "P=${P}, R=${R}")

dbLoadRecords("${TOP}/db/evgfout_out.db", "P=${P}, R=${R}, num=0, PORT=${PORT}, ADDR=0, TIMEOUT=2")
dbLoadRecords("${TOP}/db/evgfout_out.db", "P=${P}, R=${R}, num=1, PORT=${PORT}, ADDR=0, TIMEOUT=2")
dbLoadRecords("${TOP}/db/evgfout_out.db", "P=${P}, R=${R}, num=2, PORT=${PORT}, ADDR=0, TIMEOUT=2")
dbLoadRecords("${TOP}/db/evgfout_out.db", "P=${P}, R=${R}, num=3, PORT=${PORT}, ADDR=0, TIMEOUT=2")
dbLoadRecords("${TOP}/db/evgfout_out.db", "P=${P}, R=${R}, num=4, PORT=${PORT}, ADDR=0, TIMEOUT=2")
dbLoadRecords("${TOP}/db/evgfout_out.db", "P=${P}, R=${R}, num=5, PORT=${PORT}, ADDR=0, TIMEOUT=2")
dbLoadRecords("${TOP}/db/evgfout_out.db", "P=${P}, R=${R}, num=6, PORT=${PORT}, ADDR=0, TIMEOUT=2")
dbLoadRecords("${TOP}/db/evgfout_out.db", "P=${P}, R=${R}, num=7, PORT=${PORT}, ADDR=0, TIMEOUT=2")

< save_restore.cmd

## Run this to trace the stages of iocInit
#traceIocInit

iocInit

## Start any sequence programs

# Module initialization and network status state machine
seq sncFOUTSetup, "P=${P}, R=${R}"

# Create monitor for Autosave
create_monitor_set("autosave_fout.req", 60, "P=${P}, R=${R}")

# Create manual trigger for Autosave
create_triggered_set("autosave_fout.req", "${P}${R}Save-Cmd", "P=${P}, R=${R}")

set_savefile_name("autosave_fout.req", "auto_settings_${P}${R}.sav")
