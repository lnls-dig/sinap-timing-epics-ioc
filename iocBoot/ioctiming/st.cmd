#!../../bin/linux-x86_64/timing

## You may have to change timing to something else
## everywhere it appears in this file

< envPaths

cd ${TOP}

# ###### MACRO SUBSTITUTION ###### 
epicsEnvSet SEC AS
epicsEnvSet SUB Inj
epicsEnvSet DIS TI
epicsEnvSet EVGDEV EVG
epicsEnvSet EVRDEV EVR
epicsEnvSet EVEDEV EVE
epicsEnvSet EVENT_NUM 4
# ################################

epicsEnvSet("STREAM_PROTOCOL_PATH", "$(TOP)/timingApp/Db")

## Register all support components
dbLoadDatabase "dbd/timing.dbd"
timing_registerRecordDeviceDriver pdbbase

asSetFilename("$(TOP)/accessSecurityFile.acf")

#drvAsynIPPortConfigure ("EVG1", "10.0.18.65:50118:50118 udp",0,0,0)

#drvAsynIPPortConfigure ("EVR1", "10.0.18.55:50116:50116 udp",0,0,0)
#drvAsynIPPortConfigure ("EVR2", "10.0.18.112:50112:50112 udp",0,0,0)
#drvAsynIPPortConfigure ("EVR3", "10.0.18.113:50113:50113 udp",0,0,0)
#drvAsynIPPortConfigure ("EVR4", "10.0.18.114:50114:50114 udp",0,0,0)
#drvAsynIPPortConfigure ("EVR5", "10.0.18.63:50115:50115 udp",0,0,0)
#drvAsynIPPortConfigure ("EVR6", "10.0.18.117:50117:50117 udp",0,0,0)

#drvAsynIPPortConfigure ("EVE1", "10.0.18.58:50121:50121 udp",0,0,0)
drvAsynIPPortConfigure ("EVE2", "10.0.18.32:50122:50122 udp",0,0,0)
#drvAsynIPPortConfigure ("EVE3", "10.0.18.123:50123:50123 udp",0,0,0)
#drvAsynIPPortConfigure ("EVE4", "10.0.18.124:50124:50124 udp",0,0,0)

## Load record instances

# EVG
#dbLoadRecords("${TOP}/db/evg.db", "Sec=${SEC}, Sub=${SUB}, Dis=${DIS}, Dev=${EVGDEV}, Idx=1, ITBL_LEN=2000, PORT=EVG1, ADDR=0, TIMEOUT=2")
#dbLoadRecords "${TOP}/db/SeqRAM.db", "Sec=${SEC}, Sub=${SUB}, Dis=${DIS}, Dev=${EVGDEV}, Idx=1"

# Events
#dbLoadRecords "${TOP}/db/Events.db", "Sec=${SEC}, Sub=${SUB}, Dis=${DIS}, Dev=${EVGDEV}, Idx=1, num=0, desc='Diagnostic', code=0x02, time=100, mode=0, transm=0"
#dbLoadRecords "${TOP}/db/Events.db", "Sec=${SEC}, Sub=${SUB}, Dis=${DIS}, Dev=${EVGDEV}, Idx=1, num=1, desc='Septa LTB', code=0x03, time=150, mode=1, transm=0"
#dbLoadRecords "${TOP}/db/Events.db", "Sec=${SEC}, Sub=${SUB}, Dis=${DIS}, Dev=${EVGDEV}, Idx=1, num=2, desc='Egun Trigger', code=0x04, time=160, mode=1, transm=0"
#dbLoadRecords "${TOP}/db/Events.db", "Sec=${SEC}, Sub=${SUB}, Dis=${DIS}, Dev=${EVGDEV}, Idx=1, num=3, desc='Kicker LTB', code=0x05, time=170, mode=1, transm=0"

#dbLoadRecords "${TOP}/db/Events.db", "Sec=${SEC}, Sub=${SUB}, Dis=${DIS}, Dev=${EVGDEV}, Idx=1, num=4, desc='Diagnostic', code=0x06, time=180, mode=1, transm=0"
#dbLoadRecords "${TOP}/db/Events.db", "Sec=${SEC}, Sub=${SUB}, Dis=${DIS}, Dev=${EVGDEV}, Idx=1, num=5, desc='Septa LTB', code=0x07, time=190, mode=1, transm=0"
#dbLoadRecords "${TOP}/db/Events.db", "Sec=${SEC}, Sub=${SUB}, Dis=${DIS}, Dev=${EVGDEV}, Idx=1, num=6, desc='Egun Trigger', code=0x08, time=200, mode=1, transm=0"
#dbLoadRecords "${TOP}/db/Events.db", "Sec=${SEC}, Sub=${SUB}, Dis=${DIS}, Dev=${EVGDEV}, Idx=1, num=7, desc='Kicker LTB', code=0x09, time=210, mode=1, transm=0"

#dbLoadRecords "${TOP}/db/Events.db", "Sec=${SEC}, Sub=${SUB}, Dis=${DIS}, Dev=${EVGDEV}, Idx=1, num=8, desc='Diagnostic', code=0x0A, time=220, mode=1, transm=0"
#dbLoadRecords "${TOP}/db/Events.db", "Sec=${SEC}, Sub=${SUB}, Dis=${DIS}, Dev=${EVGDEV}, Idx=1, num=9, desc='Septa LTB', code=0x0B, time=230, mode=1, transm=0"

# EVR
#dbLoadRecords("${TOP}/db/evr.db", "Sec=${SEC}, Sub=${SUB}, Dis=${DIS}, Dev=${EVRDEV}, Idx=1, PORT=EVR1, ADDR=0, TIMEOUT=2")
#dbLoadRecords("${TOP}/db/evr.db", "Sec=${SEC}, Sub=${SUB}, Dis=${DIS}, Dev=${EVRDEV}, Idx=2, PORT=EVR2, ADDR=0, TIMEOUT=2")
#dbLoadRecords("${TOP}/db/evr.db", "Sec=${SEC}, Sub=${SUB}, Dis=${DIS}, Dev=${EVRDEV}, Idx=3, PORT=EVR3, ADDR=0, TIMEOUT=2")
#dbLoadRecords("${TOP}/db/evr.db", "Sec=${SEC}, Sub=${SUB}, Dis=${DIS}, Dev=${EVRDEV}, Idx=4, PORT=EVR4, ADDR=0, TIMEOUT=2")
#dbLoadRecords("${TOP}/db/evr.db", "Sec=${SEC}, Sub=${SUB}, Dis=${DIS}, Dev=${EVRDEV}, Idx=5, PORT=EVR5, ADDR=0, TIMEOUT=2")
#dbLoadRecords("${TOP}/db/evr.db", "Sec=${SEC}, Sub=${SUB}, Dis=${DIS}, Dev=${EVRDEV}, Idx=6, PORT=EVR6, ADDR=0, TIMEOUT=2")

# EVE
#dbLoadRecords("${TOP}/db/eve.db", "Sec=${SEC}, Sub=${SUB}, Dis=${DIS}, Dev=${EVEDEV}, Idx=1, PORT=EVE1, ADDR=0, TIMEOUT=2")
dbLoadRecords("${TOP}/db/eve.db", "Sec=${SEC}, Sub=${SUB}, Dis=${DIS}, Dev=${EVEDEV}, Idx=2, PORT=EVE2, ADDR=0, TIMEOUT=2")
#dbLoadRecords("${TOP}/db/eve.db", "Sec=${SEC}, Sub=${SUB}, Dis=${DIS}, Dev=${EVEDEV}, Idx=3, PORT=EVE3, ADDR=0, TIMEOUT=2")
#dbLoadRecords("${TOP}/db/eve.db", "Sec=${SEC}, Sub=${SUB}, Dis=${DIS}, Dev=${EVEDEV}, Idx=4, PORT=EVE4, ADDR=0, TIMEOUT=2")

# Specify save file path
set_savefile_path("$(TOP)", "autosave/save_files")

# Specify request files directories
set_requestfile_path("$(TOP)", "autosave/request_files")

# Specify files to be restored, and when
# EVG
#set_pass0_restoreFile("autosave_evg_NOPROC.sav", "Sec=${SEC}, Sub=${SUB}, Dis=${DIS}, Dev=${EVGDEV}, Idx=1")
# ITBL
#set_pass1_restoreFile("autosave_ITBL_PROC.sav", "Sec=${SEC}, Sub=${SUB}, Dis=${DIS}, Dev=${EVGDEV}, Idx=1")
# Events
#set_pass1_restoreFile("autosave_event0_PROC.sav", "Sec=${SEC}, Sub=${SUB}, Dis=${DIS}, Dev=${EVGDEV}, Idx=1, num=0")
#set_pass1_restoreFile("autosave_event1_PROC.sav", "Sec=${SEC}, Sub=${SUB}, Dis=${DIS}, Dev=${EVGDEV}, Idx=1, num=1")
#set_pass1_restoreFile("autosave_event2_PROC.sav", "Sec=${SEC}, Sub=${SUB}, Dis=${DIS}, Dev=${EVGDEV}, Idx=1, num=2")
#set_pass1_restoreFile("autosave_event3_PROC.sav", "Sec=${SEC}, Sub=${SUB}, Dis=${DIS}, Dev=${EVGDEV}, Idx=1, num=3")
# EVR
#set_pass0_restoreFile("autosave_evr1_NOPROC.sav", "Sec=${SEC}, Sub=${SUB}, Dis=${DIS}, Dev=${EVRDEV}, Idx=1")
#set_pass0_restoreFile("autosave_evr2_NOPROC.sav", "Sec=${SEC}, Sub=${SUB}, Dis=${DIS}, Dev=${EVRDEV}, Idx=2")
#set_pass0_restoreFile("autosave_evr3_NOPROC.sav", "Sec=${SEC}, Sub=${SUB}, Dis=${DIS}, Dev=${EVRDEV}, Idx=3")
#set_pass0_restoreFile("autosave_evr4_NOPROC.sav", "Sec=${SEC}, Sub=${SUB}, Dis=${DIS}, Dev=${EVRDEV}, Idx=4")
#set_pass0_restoreFile("autosave_evr5_NOPROC.sav", "Sec=${SEC}, Sub=${SUB}, Dis=${DIS}, Dev=${EVRDEV}, Idx=5")
#set_pass0_restoreFile("autosave_evr6_NOPROC.sav", "Sec=${SEC}, Sub=${SUB}, Dis=${DIS}, Dev=${EVRDEV}, Idx=6")
# EVE
#set_pass0_restoreFile("autosave_eve1_NOPROC.sav", "Sec=${SEC}, Sub=${SUB}, Dis=${DIS}, Dev=${EVEDEV}, Idx=1")
set_pass0_restoreFile("autosave_eve2_NOPROC.sav", "Sec=${SEC}, Sub=${SUB}, Dis=${DIS}, Dev=${EVEDEV}, Idx=2")
#set_pass0_restoreFile("autosave_eve3_NOPROC.sav", "Sec=${SEC}, Sub=${SUB}, Dis=${DIS}, Dev=${EVEDEV}, Idx=3")
#set_pass0_restoreFile("autosave_eve4_NOPROC.sav", "Sec=${SEC}, Sub=${SUB}, Dis=${DIS}, Dev=${EVEDEV}, Idx=4")

# Enable/Disable backup files (0->Disable, 1->Enable)
save_restoreSet_DatedBackupFiles(0)

# Number of copies of .sav files to maintain
save_restoreSet_NumSeqFiles(0)

## Run this to trace the stages of iocInit
#traceIocInit

cd ${TOP}/iocBoot/${IOC}
iocInit

## Start any sequence programs

# Module initialization and network status
#seq sncEVGSetup, "Sec=${SEC}, Sub=${SUB}, Dis=${DIS}, Dev=${EVGDEV}, Idx=1"

# Injection System State Machine
#seq sncSeqRAM, "Sec=${SEC}, Sub=${SUB}, Dis=${DIS}, Dev=${EVGDEV}, Idx=1, ev_num=${EVENT_NUM}"

#seq sncEVRESetup, "Sec=${SEC}, Sub=${SUB}, Dis=${DIS}, Dev=${EVRDEV}, Idx=1"
#seq sncEVRESetup, "Sec=${SEC}, Sub=${SUB}, Dis=${DIS}, Dev=${EVRDEV}, Idx=2"
#seq sncEVRESetup, "Sec=${SEC}, Sub=${SUB}, Dis=${DIS}, Dev=${EVRDEV}, Idx=3"
#seq sncEVRESetup, "Sec=${SEC}, Sub=${SUB}, Dis=${DIS}, Dev=${EVRDEV}, Idx=4"
#seq sncEVRESetup, "Sec=${SEC}, Sub=${SUB}, Dis=${DIS}, Dev=${EVRDEV}, Idx=5"
#seq sncEVRESetup, "Sec=${SEC}, Sub=${SUB}, Dis=${DIS}, Dev=${EVRDEV}, Idx=6"

#seq sncEVRESetup, "Sec=${SEC}, Sub=${SUB}, Dis=${DIS}, Dev=${EVEDEV}, Idx=1"
seq sncEVRESetup, "Sec=${SEC}, Sub=${SUB}, Dis=${DIS}, Dev=${EVEDEV}, Idx=2"
#seq sncEVRESetup, "Sec=${SEC}, Sub=${SUB}, Dis=${DIS}, Dev=${EVEDEV}, Idx=3"
#seq sncEVRESetup, "Sec=${SEC}, Sub=${SUB}, Dis=${DIS}, Dev=${EVEDEV}, Idx=4"

# Start Autosave monitor
# EVG
#create_monitor_set("autosave_evg_NOPROC.req", 30, "Sec=${SEC}, Sub=${SUB}, Dis=${DIS}, Dev=${EVGDEV}, Idx=1")
# ITBL
#create_monitor_set("autosave_ITBL_PROC.req", 30, "Sec=${SEC}, Sub=${SUB}, Dis=${DIS}, Dev=${EVGDEV}, Idx=1")
# Events
#create_monitor_set("autosave_event0_PROC.req", 30, "Sec=${SEC}, Sub=${SUB}, Dis=${DIS}, Dev=${EVGDEV}, Idx=1, num=0")
#create_monitor_set("autosave_event1_PROC.req", 30, "Sec=${SEC}, Sub=${SUB}, Dis=${DIS}, Dev=${EVGDEV}, Idx=1, num=1")
#create_monitor_set("autosave_event2_PROC.req", 30, "Sec=${SEC}, Sub=${SUB}, Dis=${DIS}, Dev=${EVGDEV}, Idx=1, num=2")
#create_monitor_set("autosave_event3_PROC.req", 30, "Sec=${SEC}, Sub=${SUB}, Dis=${DIS}, Dev=${EVGDEV}, Idx=1, num=3")
# EVR
#create_monitor_set("autosave_evr1_NOPROC.req", 30, "Sec=${SEC}, Sub=${SUB}, Dis=${DIS}, Dev=${EVRDEV}, Idx=1")
#create_monitor_set("autosave_evr2_NOPROC.req", 30, "Sec=${SEC}, Sub=${SUB}, Dis=${DIS}, Dev=${EVRDEV}, Idx=2")
#create_monitor_set("autosave_evr3_NOPROC.req", 30, "Sec=${SEC}, Sub=${SUB}, Dis=${DIS}, Dev=${EVRDEV}, Idx=3")
#create_monitor_set("autosave_evr4_NOPROC.req", 30, "Sec=${SEC}, Sub=${SUB}, Dis=${DIS}, Dev=${EVRDEV}, Idx=4")
#create_monitor_set("autosave_evr5_NOPROC.req", 30, "Sec=${SEC}, Sub=${SUB}, Dis=${DIS}, Dev=${EVRDEV}, Idx=5")
#create_monitor_set("autosave_evr6_NOPROC.req", 30, "Sec=${SEC}, Sub=${SUB}, Dis=${DIS}, Dev=${EVRDEV}, Idx=6")
# EVE
#create_monitor_set("autosave_eve1_NOPROC.req", 30, "Sec=${SEC}, Sub=${SUB}, Dis=${DIS}, Dev=${EVEDEV}, Idx=1")
create_monitor_set("autosave_eve2_NOPROC.req", 30, "Sec=${SEC}, Sub=${SUB}, Dis=${DIS}, Dev=${EVEDEV}, Idx=2")
#create_monitor_set("autosave_eve3_NOPROC.req", 30, "Sec=${SEC}, Sub=${SUB}, Dis=${DIS}, Dev=${EVEDEV}, Idx=3")
#create_monitor_set("autosave_eve4_NOPROC.req", 30, "Sec=${SEC}, Sub=${SUB}, Dis=${DIS}, Dev=${EVEDEV}, Idx=4")

# Create manual trigger for Autosave
#create_triggered_set("autosave_evg_NOPROC.req", "AS-Inj:TI-EVG1:save_T", "Sec=${SEC}, Sub=${SUB}, Dis=${DIS}, Dev=${EVGDEV}, Idx=1")
#create_triggered_set("autosave_ITBL_PROC.req", "AS-Inj:TI-EVG1:save_T", "Sec=${SEC}, Sub=${SUB}, Dis=${DIS}, Dev=${EVGDEV}, Idx=1")
#create_triggered_set("autosave_event0_PROC.req", "AS-Inj:TI-EVG1:save_T", "Sec=${SEC}, Sub=${SUB}, Dis=${DIS}, Dev=${EVGDEV}, Idx=1, num=0")
#create_triggered_set("autosave_event1_PROC.req", "AS-Inj:TI-EVG1:save_T", "Sec=${SEC}, Sub=${SUB}, Dis=${DIS}, Dev=${EVGDEV}, Idx=1, num=1")
#create_triggered_set("autosave_event2_PROC.req", "AS-Inj:TI-EVG1:save_T", "Sec=${SEC}, Sub=${SUB}, Dis=${DIS}, Dev=${EVGDEV}, Idx=1, num=2")
#create_triggered_set("autosave_event3_PROC.req", "AS-Inj:TI-EVG1:save_T", "Sec=${SEC}, Sub=${SUB}, Dis=${DIS}, Dev=${EVGDEV}, Idx=1, num=3")

#create_triggered_set("autosave_evr1_NOPROC.req", "AS-Inj:TI-EVR1:save_T", "Sec=${SEC}, Sub=${SUB}, Dis=${DIS}, Dev=${EVRDEV}, Idx=1")
#create_triggered_set("autosave_evr2_NOPROC.req", "AS-Inj:TI-EVR2:save_T", "Sec=${SEC}, Sub=${SUB}, Dis=${DIS}, Dev=${EVRDEV}, Idx=2")
#create_triggered_set("autosave_evr3_NOPROC.req", "AS-Inj:TI-EVR3:save_T", "Sec=${SEC}, Sub=${SUB}, Dis=${DIS}, Dev=${EVRDEV}, Idx=3")
#create_triggered_set("autosave_evr4_NOPROC.req", "AS-Inj:TI-EVR4:save_T", "Sec=${SEC}, Sub=${SUB}, Dis=${DIS}, Dev=${EVRDEV}, Idx=4")
#create_triggered_set("autosave_evr5_NOPROC.req", "AS-Inj:TI-EVR5:save_T", "Sec=${SEC}, Sub=${SUB}, Dis=${DIS}, Dev=${EVRDEV}, Idx=5")
#create_triggered_set("autosave_evr6_NOPROC.req", "AS-Inj:TI-EVR6:save_T", "Sec=${SEC}, Sub=${SUB}, Dis=${DIS}, Dev=${EVRDEV}, Idx=6")

#create_triggered_set("autosave_eve1_NOPROC.req", "AS-Inj:TI-EVE1:save_T", "Sec=${SEC}, Sub=${SUB}, Dis=${DIS}, Dev=${EVEDEV}, Idx=1")
create_triggered_set("autosave_eve2_NOPROC.req", "AS-Inj:TI-EVE2:save_T", "Sec=${SEC}, Sub=${SUB}, Dis=${DIS}, Dev=${EVEDEV}, Idx=2")
#create_triggered_set("autosave_eve3_NOPROC.req", "AS-Inj:TI-EVE3:save_T", "Sec=${SEC}, Sub=${SUB}, Dis=${DIS}, Dev=${EVEDEV}, Idx=3")
#create_triggered_set("autosave_eve4_NOPROC.req", "AS-Inj:TI-EVE4:save_T", "Sec=${SEC}, Sub=${SUB}, Dis=${DIS}, Dev=${EVEDEV}, Idx=4")
