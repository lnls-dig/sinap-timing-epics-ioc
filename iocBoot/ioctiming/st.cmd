#!../../bin/linux-x86_64/timing

## You may have to change timing to something else
## everywhere it appears in this file

< envPaths

# ###### MACRO SUBSTITUTION ###### 

## Naming Convention
epicsEnvSet SEC AS
epicsEnvSet SUB Inj
epicsEnvSet DIS TI
epicsEnvSet GDEV EVG
epicsEnvSet RDEV EVR
epicsEnvSet EDEV EVE
epicsEnvSet FDEV FOUT

## Number of events recognized by the state machine
# Must NOT be modified
epicsEnvSet EVENT_NUM 16

# Enable/disable module lines
epicsEnvSet EVG1_line ""

epicsEnvSet EVR1_line "#"
epicsEnvSet EVR2_line "#"
epicsEnvSet EVR3_line "#"
epicsEnvSet EVR4_line "#"
epicsEnvSet EVR5_line "#"
epicsEnvSet EVR6_line "#"

epicsEnvSet EVE1_line "#"
epicsEnvSet EVE2_line "#"
epicsEnvSet EVE3_line "#"
epicsEnvSet EVE4_line "#"

epicsEnvSet FOUT1_line ""
epicsEnvSet FOUT2_line "#"
epicsEnvSet FOUT3_line "#"
epicsEnvSet FOUT4_line "#"
epicsEnvSet FOUT5_line "#"

# ################################

epicsEnvSet("STREAM_PROTOCOL_PATH", "$(TOP)/timingApp/Db")

## Register all support components
dbLoadDatabase("${TOP}/dbd/timing.dbd")
timing_registerRecordDeviceDriver pdbbase

asSetFilename("$(TOP)/timingApp/Db/accessSecurityFile.acf")

${EVG1_line}drvAsynIPPortConfigure ("EVG1", "10.0.18.32:50111:50111 udp",0,0,0)

${EVR1_line}drvAsynIPPortConfigure ("EVR1", "10.0.18.65:50111:50111 udp",0,0,0)
${EVR2_line}drvAsynIPPortConfigure ("EVR2", "10.0.18.112:50112:50112 udp",0,0,0)
${EVR3_line}drvAsynIPPortConfigure ("EVR3", "10.0.18.113:50113:50113 udp",0,0,0)
${EVR4_line}drvAsynIPPortConfigure ("EVR4", "10.0.18.114:50114:50114 udp",0,0,0)
${EVR5_line}drvAsynIPPortConfigure ("EVR5", "10.0.18.65:50115:50115 udp",0,0,0)
${EVR6_line}drvAsynIPPortConfigure ("EVR6", "10.0.18.43:50116:50116 udp",0,0,0)

${EVE1_line}drvAsynIPPortConfigure ("EVE1", "10.0.18.48:50121:50121 udp",0,0,0)
${EVE2_line}drvAsynIPPortConfigure ("EVE2", "10.0.18.32:50122:50122 udp",0,0,0)
${EVE3_line}drvAsynIPPortConfigure ("EVE3", "10.0.18.123:50123:50123 udp",0,0,0)
${EVE4_line}drvAsynIPPortConfigure ("EVE4", "10.0.18.124:50124:50124 udp",0,0,0)

${FOUT1_line}drvAsynIPPortConfigure ("FOUT1", "10.2.118.35:50116:50116 udp",0,0,0)
${FOUT2_line}drvAsynIPPortConfigure ("FOUT2", "10.0.18.43:50117:50117 udp",0,0,0)
${FOUT3_line}drvAsynIPPortConfigure ("FOUT3", "10.0.18.65:50118:50118 udp",0,0,0)
${FOUT4_line}drvAsynIPPortConfigure ("FOUT4", "10.0.18.65:50118:50118 udp",0,0,0)
${FOUT5_line}drvAsynIPPortConfigure ("FOUT5", "10.0.18.65:50118:50118 udp",0,0,0)

## Load record instances

# EVG
${EVG1_line}dbLoadRecords("${TOP}/db/evg.db", "Sec=${SEC}, Sub=${SUB}, Dis=${DIS}, Dev=${GDEV}, Idx=1, PORT=EVG1, ADDR=0, TIMEOUT=2")
${EVG1_line}dbLoadRecords "${TOP}/db/SeqRAM.db", "Sec=${SEC}, Sub=${SUB}, Dis=${DIS}, Dev=${GDEV}, Idx=1"

# Events
${EVG1_line}dbLoadRecords "${TOP}/db/Events.db", "Sec=${SEC}, Sub=${SUB}, Dis=${DIS}, Dev=${GDEV}, Idx=1, num=0, desc='Li Inj event', code=0x01, time=100, mode=0, transm=0"
${EVG1_line}dbLoadRecords "${TOP}/db/Events.db", "Sec=${SEC}, Sub=${SUB}, Dis=${DIS}, Dev=${GDEV}, Idx=1, num=1, desc='BO Inj event', code=0x02, time=150, mode=1, transm=0"
${EVG1_line}dbLoadRecords "${TOP}/db/Events.db", "Sec=${SEC}, Sub=${SUB}, Dis=${DIS}, Dev=${GDEV}, Idx=1, num=2, desc='BO ramp event', code=0x03, time=160, mode=1, transm=0"
${EVG1_line}dbLoadRecords "${TOP}/db/Events.db", "Sec=${SEC}, Sub=${SUB}, Dis=${DIS}, Dev=${GDEV}, Idx=1, num=3, desc='SI Inj event', code=0x04, time=170, mode=1, transm=0"

${EVG1_line}dbLoadRecords "${TOP}/db/Events.db", "Sec=${SEC}, Sub=${SUB}, Dis=${DIS}, Dev=${GDEV}, Idx=1, num=4, desc='Diagnostic', code=0x05, time=180, mode=1, transm=0"
${EVG1_line}dbLoadRecords "${TOP}/db/Events.db", "Sec=${SEC}, Sub=${SUB}, Dis=${DIS}, Dev=${GDEV}, Idx=1, num=5, desc='Undefined', code=0x06, time=190, mode=1, transm=0"
${EVG1_line}dbLoadRecords "${TOP}/db/Events.db", "Sec=${SEC}, Sub=${SUB}, Dis=${DIS}, Dev=${GDEV}, Idx=1, num=6, desc='Undefined', code=0x07, time=200, mode=1, transm=0"
${EVG1_line}dbLoadRecords "${TOP}/db/Events.db", "Sec=${SEC}, Sub=${SUB}, Dis=${DIS}, Dev=${GDEV}, Idx=1, num=7, desc='Undefined', code=0x08, time=210, mode=1, transm=0"

${EVG1_line}dbLoadRecords "${TOP}/db/Events.db", "Sec=${SEC}, Sub=${SUB}, Dis=${DIS}, Dev=${GDEV}, Idx=1, num=8, desc='Undefined', code=0x09, time=220, mode=1, transm=0"
${EVG1_line}dbLoadRecords "${TOP}/db/Events.db", "Sec=${SEC}, Sub=${SUB}, Dis=${DIS}, Dev=${GDEV}, Idx=1, num=9, desc='Undefined', code=0x0A, time=230, mode=1, transm=0"
${EVG1_line}dbLoadRecords "${TOP}/db/Events.db", "Sec=${SEC}, Sub=${SUB}, Dis=${DIS}, Dev=${GDEV}, Idx=1, num=10, desc='Undefined', code=0x0B, time=240, mode=1, transm=0"
${EVG1_line}dbLoadRecords "${TOP}/db/Events.db", "Sec=${SEC}, Sub=${SUB}, Dis=${DIS}, Dev=${GDEV}, Idx=1, num=11, desc='Undefined', code=0x0C, time=250, mode=1, transm=0"

${EVG1_line}dbLoadRecords "${TOP}/db/Events.db", "Sec=${SEC}, Sub=${SUB}, Dis=${DIS}, Dev=${GDEV}, Idx=1, num=12, desc='Undefined', code=0x0D, time=260, mode=1, transm=0"
${EVG1_line}dbLoadRecords "${TOP}/db/Events.db", "Sec=${SEC}, Sub=${SUB}, Dis=${DIS}, Dev=${GDEV}, Idx=1, num=13, desc='Undefined', code=0x0E, time=270, mode=1, transm=0"
${EVG1_line}dbLoadRecords "${TOP}/db/Events.db", "Sec=${SEC}, Sub=${SUB}, Dis=${DIS}, Dev=${GDEV}, Idx=1, num=14, desc='Undefined', code=0x0F, time=280, mode=1, transm=0"
${EVG1_line}dbLoadRecords "${TOP}/db/Events.db", "Sec=${SEC}, Sub=${SUB}, Dis=${DIS}, Dev=${GDEV}, Idx=1, num=15, desc='Undefined', code=0x10, time=290, mode=1, transm=0"

# EVR
${EVR1_line}dbLoadRecords("${TOP}/db/evr.db", "Sec=${SEC}, Sub=${SUB}, Dis=${DIS}, Dev=${RDEV}, Idx=1, PORT=EVR1, ADDR=0, TIMEOUT=2")
${EVR2_line}dbLoadRecords("${TOP}/db/evr.db", "Sec=${SEC}, Sub=${SUB}, Dis=${DIS}, Dev=${RDEV}, Idx=2, PORT=EVR2, ADDR=0, TIMEOUT=2")
${EVR3_line}dbLoadRecords("${TOP}/db/evr.db", "Sec=${SEC}, Sub=${SUB}, Dis=${DIS}, Dev=${RDEV}, Idx=3, PORT=EVR3, ADDR=0, TIMEOUT=2")
${EVR4_line}dbLoadRecords("${TOP}/db/evr.db", "Sec=${SEC}, Sub=${SUB}, Dis=${DIS}, Dev=${RDEV}, Idx=4, PORT=EVR4, ADDR=0, TIMEOUT=2")
${EVR5_line}dbLoadRecords("${TOP}/db/evr.db", "Sec=${SEC}, Sub=${SUB}, Dis=${DIS}, Dev=${RDEV}, Idx=5, PORT=EVR5, ADDR=0, TIMEOUT=2")
${EVR6_line}dbLoadRecords("${TOP}/db/evr.db", "Sec=${SEC}, Sub=${SUB}, Dis=${DIS}, Dev=${RDEV}, Idx=6, PORT=EVR6, ADDR=0, TIMEOUT=2")

# EVE
${EVE1_line}dbLoadRecords("${TOP}/db/eve.db", "Sec=${SEC}, Sub=${SUB}, Dis=${DIS}, Dev=${EDEV}, Idx=1, PORT=EVE1, ADDR=0, TIMEOUT=2")
${EVE2_line}dbLoadRecords("${TOP}/db/eve.db", "Sec=${SEC}, Sub=${SUB}, Dis=${DIS}, Dev=${EDEV}, Idx=2, PORT=EVE2, ADDR=0, TIMEOUT=2")
${EVE3_line}dbLoadRecords("${TOP}/db/eve.db", "Sec=${SEC}, Sub=${SUB}, Dis=${DIS}, Dev=${EDEV}, Idx=3, PORT=EVE3, ADDR=0, TIMEOUT=2")
${EVE4_line}dbLoadRecords("${TOP}/db/eve.db", "Sec=${SEC}, Sub=${SUB}, Dis=${DIS}, Dev=${EDEV}, Idx=4, PORT=EVE4, ADDR=0, TIMEOUT=2")

# FOUT
${FOUT1_line}dbLoadRecords("${TOP}/db/fout.db", "Sec=${SEC}, Sub=${SUB}, Dis=${DIS}, Dev=${FDEV}, Idx=1, PORT=FOUT1, ADDR=0, TIMEOUT=2")
${FOUT2_line}dbLoadRecords("${TOP}/db/fout.db", "Sec=${SEC}, Sub=${SUB}, Dis=${DIS}, Dev=${FDEV}, Idx=2, PORT=FOUT2, ADDR=0, TIMEOUT=2")
${FOUT3_line}dbLoadRecords("${TOP}/db/fout.db", "Sec=${SEC}, Sub=${SUB}, Dis=${DIS}, Dev=${FDEV}, Idx=3, PORT=FOUT3, ADDR=0, TIMEOUT=2")
${FOUT4_line}dbLoadRecords("${TOP}/db/fout.db", "Sec=${SEC}, Sub=${SUB}, Dis=${DIS}, Dev=${FDEV}, Idx=4, PORT=FOUT4, ADDR=0, TIMEOUT=2")
${FOUT5_line}dbLoadRecords("${TOP}/db/fout.db", "Sec=${SEC}, Sub=${SUB}, Dis=${DIS}, Dev=${FDEV}, Idx=5, PORT=FOUT5, ADDR=0, TIMEOUT=2")

# < save_restore.cmd

## Run this to trace the stages of iocInit
#traceIocInit

iocInit

## Start any sequence programs

# Module initialization and network status
${EVG1_line}seq sncEVGSetup, "Sec=${SEC}, Sub=${SUB}, Dis=${DIS}, Dev=${GDEV}, Idx=1"

# Injection System State Machine
${EVG1_line}seq sncSeqRAM, "Sec=${SEC}, Sub=${SUB}, Dis=${DIS}, Dev=${GDEV}, Idx=1, ev_num=${EVENT_NUM}"

${EVR1_line}seq sncEVRESetup, "Sec=${SEC}, Sub=${SUB}, Dis=${DIS}, Dev=${RDEV}, Idx=1"
${EVR2_line}seq sncEVRESetup, "Sec=${SEC}, Sub=${SUB}, Dis=${DIS}, Dev=${RDEV}, Idx=2"
${EVR3_line}seq sncEVRESetup, "Sec=${SEC}, Sub=${SUB}, Dis=${DIS}, Dev=${RDEV}, Idx=3"
${EVR4_line}seq sncEVRESetup, "Sec=${SEC}, Sub=${SUB}, Dis=${DIS}, Dev=${RDEV}, Idx=4"
${EVR5_line}seq sncEVRESetup, "Sec=${SEC}, Sub=${SUB}, Dis=${DIS}, Dev=${RDEV}, Idx=5"
${EVR6_line}seq sncEVRESetup, "Sec=${SEC}, Sub=${SUB}, Dis=${DIS}, Dev=${RDEV}, Idx=6"

${EVE1_line}seq sncEVRESetup, "Sec=${SEC}, Sub=${SUB}, Dis=${DIS}, Dev=${EDEV}, Idx=1"
${EVE2_line}seq sncEVRESetup, "Sec=${SEC}, Sub=${SUB}, Dis=${DIS}, Dev=${EDEV}, Idx=2"
${EVE3_line}seq sncEVRESetup, "Sec=${SEC}, Sub=${SUB}, Dis=${DIS}, Dev=${EDEV}, Idx=3"
${EVE4_line}seq sncEVRESetup, "Sec=${SEC}, Sub=${SUB}, Dis=${DIS}, Dev=${EDEV}, Idx=4"

${FOUT1_line}seq sncFOUTSetup, "Sec=${SEC}, Sub=${SUB}, Dis=${DIS}, Dev=${FDEV}, Idx=1"
${FOUT2_line}seq sncFOUTSetup, "Sec=${SEC}, Sub=${SUB}, Dis=${DIS}, Dev=${FDEV}, Idx=2"
${FOUT3_line}seq sncFOUTSetup, "Sec=${SEC}, Sub=${SUB}, Dis=${DIS}, Dev=${FDEV}, Idx=3"
${FOUT4_line}seq sncFOUTSetup, "Sec=${SEC}, Sub=${SUB}, Dis=${DIS}, Dev=${FDEV}, Idx=4"
${FOUT5_line}seq sncFOUTSetup, "Sec=${SEC}, Sub=${SUB}, Dis=${DIS}, Dev=${FDEV}, Idx=5"

# Create manual trigger for Autosave
#EVG
${EVG1_line}create_triggered_set("autosave_evg_NOPROC.req", "${SEC}-${SUB}:${DIS}-${GDEV}1:save_T", "Sec=${SEC}, Sub=${SUB}, Dis=${DIS}, Dev=${GDEV}, Idx=1")
${EVG1_line}create_triggered_set("autosave_ITBL_PROC.req", "${SEC}-${SUB}:${DIS}-${GDEV}1:save_T", "Sec=${SEC}, Sub=${SUB}, Dis=${DIS}, Dev=${GDEV}, Idx=1")
${EVG1_line}create_triggered_set("autosave_event0_PROC.req", "${SEC}-${SUB}:${DIS}-${GDEV}1:save_T", "Sec=${SEC}, Sub=${SUB}, Dis=${DIS}, Dev=${GDEV}, Idx=1, num=0")
${EVG1_line}create_triggered_set("autosave_event1_PROC.req", "${SEC}-${SUB}:${DIS}-${GDEV}1:save_T", "Sec=${SEC}, Sub=${SUB}, Dis=${DIS}, Dev=${GDEV}, Idx=1, num=1")
${EVG1_line}create_triggered_set("autosave_event2_PROC.req", "${SEC}-${SUB}:${DIS}-${GDEV}1:save_T", "Sec=${SEC}, Sub=${SUB}, Dis=${DIS}, Dev=${GDEV}, Idx=1, num=2")
${EVG1_line}create_triggered_set("autosave_event3_PROC.req", "${SEC}-${SUB}:${DIS}-${GDEV}1:save_T", "Sec=${SEC}, Sub=${SUB}, Dis=${DIS}, Dev=${GDEV}, Idx=1, num=3")
${EVG1_line}create_triggered_set("autosave_event4_PROC.req", "${SEC}-${SUB}:${DIS}-${GDEV}1:save_T", "Sec=${SEC}, Sub=${SUB}, Dis=${DIS}, Dev=${GDEV}, Idx=1, num=4")
${EVG1_line}create_triggered_set("autosave_event5_PROC.req", "${SEC}-${SUB}:${DIS}-${GDEV}1:save_T", "Sec=${SEC}, Sub=${SUB}, Dis=${DIS}, Dev=${GDEV}, Idx=1, num=5")
${EVG1_line}create_triggered_set("autosave_event6_PROC.req", "${SEC}-${SUB}:${DIS}-${GDEV}1:save_T", "Sec=${SEC}, Sub=${SUB}, Dis=${DIS}, Dev=${GDEV}, Idx=1, num=6")
${EVG1_line}create_triggered_set("autosave_event7_PROC.req", "${SEC}-${SUB}:${DIS}-${GDEV}1:save_T", "Sec=${SEC}, Sub=${SUB}, Dis=${DIS}, Dev=${GDEV}, Idx=1, num=7")
${EVG1_line}create_triggered_set("autosave_event8_PROC.req", "${SEC}-${SUB}:${DIS}-${GDEV}1:save_T", "Sec=${SEC}, Sub=${SUB}, Dis=${DIS}, Dev=${GDEV}, Idx=1, num=8")
${EVG1_line}create_triggered_set("autosave_event9_PROC.req", "${SEC}-${SUB}:${DIS}-${GDEV}1:save_T", "Sec=${SEC}, Sub=${SUB}, Dis=${DIS}, Dev=${GDEV}, Idx=1, num=9")
${EVG1_line}create_triggered_set("autosave_event10_PROC.req", "${SEC}-${SUB}:${DIS}-${GDEV}1:save_T", "Sec=${SEC}, Sub=${SUB}, Dis=${DIS}, Dev=${GDEV}, Idx=1, num=10")
${EVG1_line}create_triggered_set("autosave_event11_PROC.req", "${SEC}-${SUB}:${DIS}-${GDEV}1:save_T", "Sec=${SEC}, Sub=${SUB}, Dis=${DIS}, Dev=${GDEV}, Idx=1, num=11")
${EVG1_line}create_triggered_set("autosave_event12_PROC.req", "${SEC}-${SUB}:${DIS}-${GDEV}1:save_T", "Sec=${SEC}, Sub=${SUB}, Dis=${DIS}, Dev=${GDEV}, Idx=1, num=12")
${EVG1_line}create_triggered_set("autosave_event13_PROC.req", "${SEC}-${SUB}:${DIS}-${GDEV}1:save_T", "Sec=${SEC}, Sub=${SUB}, Dis=${DIS}, Dev=${GDEV}, Idx=1, num=13")
${EVG1_line}create_triggered_set("autosave_event14_PROC.req", "${SEC}-${SUB}:${DIS}-${GDEV}1:save_T", "Sec=${SEC}, Sub=${SUB}, Dis=${DIS}, Dev=${GDEV}, Idx=1, num=14")
${EVG1_line}create_triggered_set("autosave_event15_PROC.req", "${SEC}-${SUB}:${DIS}-${GDEV}1:save_T", "Sec=${SEC}, Sub=${SUB}, Dis=${DIS}, Dev=${GDEV}, Idx=1, num=15")

${EVR1_line}create_triggered_set("autosave_evr1_NOPROC.req", "${SEC}-${SUB}:${DIS}-${RDEV}1:save_T", "Sec=${SEC}, Sub=${SUB}, Dis=${DIS}, Dev=${RDEV}, Idx=1")
${EVR2_line}create_triggered_set("autosave_evr2_NOPROC.req", "${SEC}-${SUB}:${DIS}-${RDEV}2:save_T", "Sec=${SEC}, Sub=${SUB}, Dis=${DIS}, Dev=${RDEV}, Idx=2")
${EVR3_line}create_triggered_set("autosave_evr3_NOPROC.req", "${SEC}-${SUB}:${DIS}-${RDEV}3:save_T", "Sec=${SEC}, Sub=${SUB}, Dis=${DIS}, Dev=${RDEV}, Idx=3")
${EVR4_line}create_triggered_set("autosave_evr4_NOPROC.req", "${SEC}-${SUB}:${DIS}-${RDEV}4:save_T", "Sec=${SEC}, Sub=${SUB}, Dis=${DIS}, Dev=${RDEV}, Idx=4")
${EVR5_line}create_triggered_set("autosave_evr5_NOPROC.req", "${SEC}-${SUB}:${DIS}-${RDEV}5:save_T", "Sec=${SEC}, Sub=${SUB}, Dis=${DIS}, Dev=${RDEV}, Idx=5")
${EVR6_line}create_triggered_set("autosave_evr6_NOPROC.req", "${SEC}-${SUB}:${DIS}-${RDEV}6:save_T", "Sec=${SEC}, Sub=${SUB}, Dis=${DIS}, Dev=${RDEV}, Idx=6")

${EVE1_line}create_triggered_set("autosave_eve1_NOPROC.req", "${SEC}-${SUB}:${DIS}-${EDEV}1:save_T", "Sec=${SEC}, Sub=${SUB}, Dis=${DIS}, Dev=${EDEV}, Idx=1")
${EVE2_line}create_triggered_set("autosave_eve2_NOPROC.req", "${SEC}-${SUB}:${DIS}-${EDEV}2:save_T", "Sec=${SEC}, Sub=${SUB}, Dis=${DIS}, Dev=${EDEV}, Idx=2")
${EVE3_line}create_triggered_set("autosave_eve3_NOPROC.req", "${SEC}-${SUB}:${DIS}-${EDEV}3:save_T", "Sec=${SEC}, Sub=${SUB}, Dis=${DIS}, Dev=${EDEV}, Idx=3")
${EVE4_line}create_triggered_set("autosave_eve4_NOPROC.req", "${SEC}-${SUB}:${DIS}-${EDEV}4:save_T", "Sec=${SEC}, Sub=${SUB}, Dis=${DIS}, Dev=${EDEV}, Idx=4")

${FOUT1_line}create_triggered_set("autosave_fout1_NOPROC.req", "${SEC}-${SUB}:${DIS}-${FDEV}1:save_T", "Sec=${SEC}, Sub=${SUB}, Dis=${DIS}, Dev=${FDEV}, Idx=1")
${FOUT2_line}create_triggered_set("autosave_fout2_NOPROC.req", "${SEC}-${SUB}:${DIS}-${FDEV}2:save_T", "Sec=${SEC}, Sub=${SUB}, Dis=${DIS}, Dev=${FDEV}, Idx=2")
${FOUT3_line}create_triggered_set("autosave_fout3_NOPROC.req", "${SEC}-${SUB}:${DIS}-${FDEV}3:save_T", "Sec=${SEC}, Sub=${SUB}, Dis=${DIS}, Dev=${FDEV}, Idx=3")
${FOUT4_line}create_triggered_set("autosave_fout4_NOPROC.req", "${SEC}-${SUB}:${DIS}-${FDEV}4:save_T", "Sec=${SEC}, Sub=${SUB}, Dis=${DIS}, Dev=${FDEV}, Idx=4")
${FOUT5_line}create_triggered_set("autosave_fout5_NOPROC.req", "${SEC}-${SUB}:${DIS}-${FDEV}5:save_T", "Sec=${SEC}, Sub=${SUB}, Dis=${DIS}, Dev=${FDEV}, Idx=5")

