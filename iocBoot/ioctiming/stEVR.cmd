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
asSetSubstitutions("P=$(P),R=$(R)")

drvAsynIPPortConfigure ("${PORT}", "${IPADDR}:${IPPORT} tcp",0,0,0)

dbLoadRecords("${TOP}/db/asynRecord.db", "P=$(P)$(R), R=asyn, PORT=$(PORT), ADDR=0, OMAX=80, IMAX=80")

## Load record instances
dbLoadRecords("${TOP}/db/evr.db", "P=${P}, R=${R}, IPADDR=${IPADDR}, IPPORT=${IPPORT}, PORT=${PORT}, ADDR=0, TIMEOUT=2")

dbLoadRecords("${TOP}/db/fw_version.db", "P=${P}, R=${R}, PORT=${PORT}, ADDR=0, TIMEOUT=2")
dbLoadRecords("${TOP}/db/event_log.db", "P=${P}, R=${R}, PORT=${PORT}, ADDR=0, TIMEOUT=2")

dbLoadRecords("${TOP}/db/digital_input.db", "P=${P}, R=${R}, PORT=${PORT}, ADDR=0, TIMEOUT=2, IN_N=0")
dbLoadRecords("${TOP}/db/digital_input.db", "P=${P}, R=${R}, PORT=${PORT}, ADDR=0, TIMEOUT=2, IN_N=1")
dbLoadRecords("${TOP}/db/digital_input.db", "P=${P}, R=${R}, PORT=${PORT}, ADDR=0, TIMEOUT=2, IN_N=2")

dbLoadRecords("${TOP}/db/evre_otp.db", "P=${P}, R=${R}, num=00, PORT=${PORT}, ADDR=0, TIMEOUT=2")
dbLoadRecords("${TOP}/db/evre_otp.db", "P=${P}, R=${R}, num=01, PORT=${PORT}, ADDR=0, TIMEOUT=2")
dbLoadRecords("${TOP}/db/evre_otp.db", "P=${P}, R=${R}, num=02, PORT=${PORT}, ADDR=0, TIMEOUT=2")
dbLoadRecords("${TOP}/db/evre_otp.db", "P=${P}, R=${R}, num=03, PORT=${PORT}, ADDR=0, TIMEOUT=2")
dbLoadRecords("${TOP}/db/evre_otp.db", "P=${P}, R=${R}, num=04, PORT=${PORT}, ADDR=0, TIMEOUT=2")
dbLoadRecords("${TOP}/db/evre_otp.db", "P=${P}, R=${R}, num=05, PORT=${PORT}, ADDR=0, TIMEOUT=2")
dbLoadRecords("${TOP}/db/evre_otp.db", "P=${P}, R=${R}, num=06, PORT=${PORT}, ADDR=0, TIMEOUT=2")
dbLoadRecords("${TOP}/db/evre_otp.db", "P=${P}, R=${R}, num=07, PORT=${PORT}, ADDR=0, TIMEOUT=2")
dbLoadRecords("${TOP}/db/evre_otp.db", "P=${P}, R=${R}, num=08, PORT=${PORT}, ADDR=0, TIMEOUT=2")
dbLoadRecords("${TOP}/db/evre_otp.db", "P=${P}, R=${R}, num=09, PORT=${PORT}, ADDR=0, TIMEOUT=2")
dbLoadRecords("${TOP}/db/evre_otp.db", "P=${P}, R=${R}, num=10, PORT=${PORT}, ADDR=0, TIMEOUT=2")
dbLoadRecords("${TOP}/db/evre_otp.db", "P=${P}, R=${R}, num=11, PORT=${PORT}, ADDR=0, TIMEOUT=2")
dbLoadRecords("${TOP}/db/evre_otp.db", "P=${P}, R=${R}, num=12, PORT=${PORT}, ADDR=0, TIMEOUT=2")
dbLoadRecords("${TOP}/db/evre_otp.db", "P=${P}, R=${R}, num=13, PORT=${PORT}, ADDR=0, TIMEOUT=2")
dbLoadRecords("${TOP}/db/evre_otp.db", "P=${P}, R=${R}, num=14, PORT=${PORT}, ADDR=0, TIMEOUT=2")
dbLoadRecords("${TOP}/db/evre_otp.db", "P=${P}, R=${R}, num=15, PORT=${PORT}, ADDR=0, TIMEOUT=2")
dbLoadRecords("${TOP}/db/evre_otp.db", "P=${P}, R=${R}, num=16, PORT=${PORT}, ADDR=0, TIMEOUT=2")
dbLoadRecords("${TOP}/db/evre_otp.db", "P=${P}, R=${R}, num=17, PORT=${PORT}, ADDR=0, TIMEOUT=2")
dbLoadRecords("${TOP}/db/evre_otp.db", "P=${P}, R=${R}, num=18, PORT=${PORT}, ADDR=0, TIMEOUT=2")
dbLoadRecords("${TOP}/db/evre_otp.db", "P=${P}, R=${R}, num=19, PORT=${PORT}, ADDR=0, TIMEOUT=2")
dbLoadRecords("${TOP}/db/evre_otp.db", "P=${P}, R=${R}, num=20, PORT=${PORT}, ADDR=0, TIMEOUT=2")
dbLoadRecords("${TOP}/db/evre_otp.db", "P=${P}, R=${R}, num=21, PORT=${PORT}, ADDR=0, TIMEOUT=2")
dbLoadRecords("${TOP}/db/evre_otp.db", "P=${P}, R=${R}, num=22, PORT=${PORT}, ADDR=0, TIMEOUT=2")
dbLoadRecords("${TOP}/db/evre_otp.db", "P=${P}, R=${R}, num=23, PORT=${PORT}, ADDR=0, TIMEOUT=2")

dbLoadRecords("${TOP}/db/evre_otp_scan.db", "P=${P}, R=${R}, PORT=${PORT}, ADDR=0, TIMEOUT=2")

dbLoadRecords("${TOP}/db/evre_out.db", "P=${P}, R=${R}, num=0, PORT=${PORT}, ADDR=0, TIMEOUT=2")
dbLoadRecords("${TOP}/db/evre_out.db", "P=${P}, R=${R}, num=1, PORT=${PORT}, ADDR=0, TIMEOUT=2")
dbLoadRecords("${TOP}/db/evre_out.db", "P=${P}, R=${R}, num=2, PORT=${PORT}, ADDR=0, TIMEOUT=2")
dbLoadRecords("${TOP}/db/evre_out.db", "P=${P}, R=${R}, num=3, PORT=${PORT}, ADDR=0, TIMEOUT=2")
dbLoadRecords("${TOP}/db/evre_out.db", "P=${P}, R=${R}, num=4, PORT=${PORT}, ADDR=0, TIMEOUT=2")
dbLoadRecords("${TOP}/db/evre_out.db", "P=${P}, R=${R}, num=5, PORT=${PORT}, ADDR=0, TIMEOUT=2")
dbLoadRecords("${TOP}/db/evre_out.db", "P=${P}, R=${R}, num=6, PORT=${PORT}, ADDR=0, TIMEOUT=2")
dbLoadRecords("${TOP}/db/evre_out.db", "P=${P}, R=${R}, num=7, PORT=${PORT}, ADDR=0, TIMEOUT=2")

< save_restore.cmd

## Run this to trace the stages of iocInit
#traceIocInit

iocInit

## Start any sequence programs

# Module initialization and network status state machine
seq sncEVRESetup, "P=${P}, R=${R}"

# Create monitor for Autosave
create_monitor_set("autosave_evr.req", 60, "P=${P}, R=${R}")

set_savefile_name("autosave_evr.req", "auto_settings_${P}${R}.sav")
