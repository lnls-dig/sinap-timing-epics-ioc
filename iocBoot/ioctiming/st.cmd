#!../../bin/linux-x86_64/timing

## You may have to change timing to something else
## everywhere it appears in this file

< envPaths

cd ${TOP}

epicsEnvSet("STREAM_PROTOCOL_PATH", "$(TOP)/timingApp/Db")

## Register all support components
dbLoadDatabase "dbd/timing.dbd"
timing_registerRecordDeviceDriver pdbbase

asSetFilename("$(TOP)/accessSecurityFile.acf")

drvAsynIPPortConfigure ("EVG", "10.0.18.116:50116:50116 udp",0,0,0)

#drvAsynIPPortConfigure ("EVR1", "10.0.18.111:50111:50111 udp",0,0,0)
#drvAsynIPPortConfigure ("EVR2", "10.0.18.112:50112:50112 udp",0,0,0)
#drvAsynIPPortConfigure ("EVR3", "10.0.18.113:50113:50113 udp",0,0,0)
#drvAsynIPPortConfigure ("EVR4", "10.0.18.114:50114:50114 udp",0,0,0)
#drvAsynIPPortConfigure ("EVR5", "10.0.18.115:50115:50115 udp",0,0,0)
#drvAsynIPPortConfigure ("EVR6", "10.0.18.117:50117:50117 udp",0,0,0)
#drvAsynIPPortConfigure ("EVR7", "10.0.18.118:50118:50118 udp",0,0,0)

drvAsynIPPortConfigure ("EVE1", "10.0.18.121:50121:50121 udp",0,0,0)
#drvAsynIPPortConfigure ("EVE2", "10.0.18.122:50122:50122 udp",0,0,0)
#drvAsynIPPortConfigure ("EVE3", "10.0.18.123:50123:50123 udp",0,0,0)
#drvAsynIPPortConfigure ("EVE4", "10.0.18.124:50124:50124 udp",0,0,0)

## Load record instances

# EVG
dbLoadRecords("${TOP}/db/evg.db", "device=EVG, ITBL_LEN=2000, PORT=EVG, ADDR=0, TIMEOUT=2")
dbLoadRecords "${TOP}/db/SeqRAM.db", "device=EVG"

# Events
dbLoadRecords "${TOP}/db/Eventos.db", "device=EVG, num=0, desc='Diagnostic', code=0x02, time=100, mode=0, transm=0"
dbLoadRecords "${TOP}/db/Eventos.db", "device=EVG, num=1, desc='Septa LTB', code=0x03, time=150, mode=1, transm=0"
dbLoadRecords "${TOP}/db/Eventos.db", "device=EVG, num=2, desc='Egun Trigger', code=0x04, time=160, mode=1, transm=0"
dbLoadRecords "${TOP}/db/Eventos.db", "device=EVG, num=3, desc='Kicker LTB', code=0x05, time=170, mode=1, transm=0"

dbLoadRecords "${TOP}/db/Eventos.db", "device=EVG, num=4, desc='Diagnostic', code=0x06, time=173, mode=1, transm=0"
dbLoadRecords "${TOP}/db/Eventos.db", "device=EVG, num=5, desc='Septa LTB', code=0x07, time=176, mode=1, transm=0"
dbLoadRecords "${TOP}/db/Eventos.db", "device=EVG, num=6, desc='Egun Trigger', code=0x08, time=180, mode=1, transm=0"
dbLoadRecords "${TOP}/db/Eventos.db", "device=EVG, num=7, desc='Kicker LTB', code=0x09, time=190, mode=1, transm=0"

# Pulse Train Event
dbLoadRecords "${TOP}/db/PulseTrain.db", "device=EVG, enable=1, code=0x0A, time=150, count=20, size=120"

# EVR
#dbLoadRecords("${TOP}/db/evr.db", "device=EVR1, PORT=EVR1, ADDR=0, TIMEOUT=2")
#dbLoadRecords("${TOP}/db/evr.db", "device=EVR2, PORT=EVR2, ADDR=0, TIMEOUT=2")
#dbLoadRecords("${TOP}/db/evr.db", "device=EVR3, PORT=EVR3, ADDR=0, TIMEOUT=2")
#dbLoadRecords("${TOP}/db/evr.db", "device=EVR4, PORT=EVR4, ADDR=0, TIMEOUT=2")
#dbLoadRecords("${TOP}/db/evr.db", "device=EVR5, PORT=EVR5, ADDR=0, TIMEOUT=2")
#dbLoadRecords("${TOP}/db/evr.db", "device=EVR6, PORT=EVR6, ADDR=0, TIMEOUT=2")
#dbLoadRecords("${TOP}/db/evr.db", "device=EVR7, PORT=EVR7, ADDR=0, TIMEOUT=2")

# EVE
dbLoadRecords("${TOP}/db/eve.db", "device=EVE1, PORT=EVE1, ADDR=0, TIMEOUT=2")
#dbLoadRecords("${TOP}/db/eve.db", "device=EVE2, PORT=EVE2, ADDR=0, TIMEOUT=2")
#dbLoadRecords("${TOP}/db/eve.db", "device=EVE3, PORT=EVE3, ADDR=0, TIMEOUT=2")
#dbLoadRecords("${TOP}/db/eve.db", "device=EVE4, PORT=EVE4, ADDR=0, TIMEOUT=2")

## Run this to trace the stages of iocInit
#traceIocInit

cd ${TOP}/iocBoot/${IOC}
iocInit

## Start any sequence programs

# Module initialization and network status
seq sncModuleSupport, "device=EVG"

seq sncModuleSupport, "device=EVE1"
#seq sncModuleSupport, "device=EVE2"
#seq sncModuleSupport, "device=EVE3"
#seq sncModuleSupport, "device=EVE4"

#seq sncModuleSupport, "device=EVR1"
#seq sncModuleSupport, "device=EVR2"
#seq sncModuleSupport, "device=EVR3"
#seq sncModuleSupport, "device=EVR4"
#seq sncModuleSupport, "device=EVR5"
#seq sncModuleSupport, "device=EVR6"
#seq sncModuleSupport, "device=EVR7"

# Injection System State Machine
seq sncSeqRAM, "device=EVG, ev_num=8"
