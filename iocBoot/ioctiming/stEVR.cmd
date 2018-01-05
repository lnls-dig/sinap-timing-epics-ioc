#!../../bin/linux-x86_64/timing

## You may have to change timing to something else
## everywhere it appears in this file

< envPaths
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

# < save_restore.cmd

## Run this to trace the stages of iocInit
#traceIocInit

iocInit

## Start any sequence programs

# Module initialization and network status state machine
seq sncEVRESetup, "P=${P}, R=${R}"

