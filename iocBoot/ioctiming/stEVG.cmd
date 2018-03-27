#!../../bin/linux-x86_64/timing

## You may have to change timing to something else
## everywhere it appears in this file

< envPaths
< EVG.config

# ################################

epicsEnvSet("STREAM_PROTOCOL_PATH", "$(TOP)/timingApp/Db")

## Register all support components
dbLoadDatabase("${TOP}/dbd/timing.dbd")
timing_registerRecordDeviceDriver pdbbase

asSetFilename("$(TOP)/timingApp/Db/accessSecurityFile.acf")

drvAsynIPPortConfigure ("${PORT}", "${IPADDR}:${IPPORT}:${IPPORT} udp",0,0,0)

## Load record instances

# EVG
dbLoadRecords("${TOP}/db/evg.db", "P=${P}, R=${R}, PORT=${PORT}, ADDR=0, TIMEOUT=2")
dbLoadRecords "${TOP}/db/SeqRAM.db", "P=${P}, R=${R}"

# Events
dbLoadRecords "${TOP}/db/Events.db", "P=${P}, R=${R}, num=0,   desc='Undefined', code='01', time=100, mode=0, transm=0, PORT=${PORT}, ADDR=0, TIMEOUT=2, EVT_DELAY=${EVT_DELAY}"
dbLoadRecords "${TOP}/db/Events.db", "P=${P}, R=${R}, num=1,   desc='Undefined', code='02', time=101, mode=0, transm=0, PORT=${PORT}, ADDR=0, TIMEOUT=2, EVT_DELAY=${EVT_DELAY}"
dbLoadRecords "${TOP}/db/Events.db", "P=${P}, R=${R}, num=2,   desc='Undefined', code='03', time=102, mode=0, transm=0, PORT=${PORT}, ADDR=0, TIMEOUT=2, EVT_DELAY=${EVT_DELAY}"
dbLoadRecords "${TOP}/db/Events.db", "P=${P}, R=${R}, num=3,   desc='Undefined', code='04', time=103, mode=0, transm=0, PORT=${PORT}, ADDR=0, TIMEOUT=2, EVT_DELAY=${EVT_DELAY}"
dbLoadRecords "${TOP}/db/Events.db", "P=${P}, R=${R}, num=4,   desc='Undefined', code='05', time=104, mode=0, transm=0, PORT=${PORT}, ADDR=0, TIMEOUT=2, EVT_DELAY=${EVT_DELAY}"
dbLoadRecords "${TOP}/db/Events.db", "P=${P}, R=${R}, num=5,   desc='Undefined', code='06', time=105, mode=0, transm=0, PORT=${PORT}, ADDR=0, TIMEOUT=2, EVT_DELAY=${EVT_DELAY}"
dbLoadRecords "${TOP}/db/Events.db", "P=${P}, R=${R}, num=6,   desc='Undefined', code='07', time=106, mode=0, transm=0, PORT=${PORT}, ADDR=0, TIMEOUT=2, EVT_DELAY=${EVT_DELAY}"
dbLoadRecords "${TOP}/db/Events.db", "P=${P}, R=${R}, num=7,   desc='Undefined', code='08', time=107, mode=0, transm=0, PORT=${PORT}, ADDR=0, TIMEOUT=2, EVT_DELAY=${EVT_DELAY}"
dbLoadRecords "${TOP}/db/Events.db", "P=${P}, R=${R}, num=8,   desc='Undefined', code='09', time=108, mode=0, transm=0, PORT=${PORT}, ADDR=0, TIMEOUT=2, EVT_DELAY=${EVT_DELAY}"
dbLoadRecords "${TOP}/db/Events.db", "P=${P}, R=${R}, num=9,   desc='Undefined', code='10', time=109, mode=0, transm=0, PORT=${PORT}, ADDR=0, TIMEOUT=2, EVT_DELAY=${EVT_DELAY}"
dbLoadRecords "${TOP}/db/Events.db", "P=${P}, R=${R}, num=10,  desc='Undefined', code='11', time=110, mode=0, transm=0, PORT=${PORT}, ADDR=0, TIMEOUT=2, EVT_DELAY=${EVT_DELAY}"
dbLoadRecords "${TOP}/db/Events.db", "P=${P}, R=${R}, num=11,  desc='Undefined', code='12', time=111, mode=0, transm=0, PORT=${PORT}, ADDR=0, TIMEOUT=2, EVT_DELAY=${EVT_DELAY}"
dbLoadRecords "${TOP}/db/Events.db", "P=${P}, R=${R}, num=12,  desc='Undefined', code='13', time=112, mode=0, transm=0, PORT=${PORT}, ADDR=0, TIMEOUT=2, EVT_DELAY=${EVT_DELAY}"
dbLoadRecords "${TOP}/db/Events.db", "P=${P}, R=${R}, num=13,  desc='Undefined', code='14', time=113, mode=0, transm=0, PORT=${PORT}, ADDR=0, TIMEOUT=2, EVT_DELAY=${EVT_DELAY}"
dbLoadRecords "${TOP}/db/Events.db", "P=${P}, R=${R}, num=14,  desc='Undefined', code='15', time=114, mode=0, transm=0, PORT=${PORT}, ADDR=0, TIMEOUT=2, EVT_DELAY=${EVT_DELAY}"
dbLoadRecords "${TOP}/db/Events.db", "P=${P}, R=${R}, num=15,  desc='Undefined', code='16', time=115, mode=0, transm=0, PORT=${PORT}, ADDR=0, TIMEOUT=2, EVT_DELAY=${EVT_DELAY}"
dbLoadRecords "${TOP}/db/Events.db", "P=${P}, R=${R}, num=16,  desc='Undefined', code='17', time=116, mode=0, transm=0, PORT=${PORT}, ADDR=0, TIMEOUT=2, EVT_DELAY=${EVT_DELAY}"
dbLoadRecords "${TOP}/db/Events.db", "P=${P}, R=${R}, num=17,  desc='Undefined', code='18', time=117, mode=0, transm=0, PORT=${PORT}, ADDR=0, TIMEOUT=2, EVT_DELAY=${EVT_DELAY}"
dbLoadRecords "${TOP}/db/Events.db", "P=${P}, R=${R}, num=18,  desc='Undefined', code='19', time=118, mode=0, transm=0, PORT=${PORT}, ADDR=0, TIMEOUT=2, EVT_DELAY=${EVT_DELAY}"
dbLoadRecords "${TOP}/db/Events.db", "P=${P}, R=${R}, num=19,  desc='Undefined', code='20', time=119, mode=0, transm=0, PORT=${PORT}, ADDR=0, TIMEOUT=2, EVT_DELAY=${EVT_DELAY}"
dbLoadRecords "${TOP}/db/Events.db", "P=${P}, R=${R}, num=20,  desc='Undefined', code='21', time=120, mode=0, transm=0, PORT=${PORT}, ADDR=0, TIMEOUT=2, EVT_DELAY=${EVT_DELAY}"
dbLoadRecords "${TOP}/db/Events.db", "P=${P}, R=${R}, num=21,  desc='Undefined', code='22', time=121, mode=0, transm=0, PORT=${PORT}, ADDR=0, TIMEOUT=2, EVT_DELAY=${EVT_DELAY}"
dbLoadRecords "${TOP}/db/Events.db", "P=${P}, R=${R}, num=22,  desc='Undefined', code='23', time=122, mode=0, transm=0, PORT=${PORT}, ADDR=0, TIMEOUT=2, EVT_DELAY=${EVT_DELAY}"
dbLoadRecords "${TOP}/db/Events.db", "P=${P}, R=${R}, num=23,  desc='Undefined', code='24', time=123, mode=0, transm=0, PORT=${PORT}, ADDR=0, TIMEOUT=2, EVT_DELAY=${EVT_DELAY}"
dbLoadRecords "${TOP}/db/Events.db", "P=${P}, R=${R}, num=24,  desc='Undefined', code='25', time=124, mode=0, transm=0, PORT=${PORT}, ADDR=0, TIMEOUT=2, EVT_DELAY=${EVT_DELAY}"
dbLoadRecords "${TOP}/db/Events.db", "P=${P}, R=${R}, num=25,  desc='Undefined', code='26', time=125, mode=0, transm=0, PORT=${PORT}, ADDR=0, TIMEOUT=2, EVT_DELAY=${EVT_DELAY}"
dbLoadRecords "${TOP}/db/Events.db", "P=${P}, R=${R}, num=26,  desc='Undefined', code='27', time=126, mode=0, transm=0, PORT=${PORT}, ADDR=0, TIMEOUT=2, EVT_DELAY=${EVT_DELAY}"
dbLoadRecords "${TOP}/db/Events.db", "P=${P}, R=${R}, num=27,  desc='Undefined', code='28', time=127, mode=0, transm=0, PORT=${PORT}, ADDR=0, TIMEOUT=2, EVT_DELAY=${EVT_DELAY}"
dbLoadRecords "${TOP}/db/Events.db", "P=${P}, R=${R}, num=28,  desc='Undefined', code='29', time=128, mode=0, transm=0, PORT=${PORT}, ADDR=0, TIMEOUT=2, EVT_DELAY=${EVT_DELAY}"
dbLoadRecords "${TOP}/db/Events.db", "P=${P}, R=${R}, num=29,  desc='Undefined', code='30', time=129, mode=0, transm=0, PORT=${PORT}, ADDR=0, TIMEOUT=2, EVT_DELAY=${EVT_DELAY}"
dbLoadRecords "${TOP}/db/Events.db", "P=${P}, R=${R}, num=30,  desc='Undefined', code='31', time=130, mode=0, transm=0, PORT=${PORT}, ADDR=0, TIMEOUT=2, EVT_DELAY=${EVT_DELAY}"
dbLoadRecords "${TOP}/db/Events.db", "P=${P}, R=${R}, num=31,  desc='Undefined', code='32', time=131, mode=0, transm=0, PORT=${PORT}, ADDR=0, TIMEOUT=2, EVT_DELAY=${EVT_DELAY}"
dbLoadRecords "${TOP}/db/Events.db", "P=${P}, R=${R}, num=32,  desc='Undefined', code='33', time=132, mode=0, transm=0, PORT=${PORT}, ADDR=0, TIMEOUT=2, EVT_DELAY=${EVT_DELAY}"
dbLoadRecords "${TOP}/db/Events.db", "P=${P}, R=${R}, num=33,  desc='Undefined', code='34', time=133, mode=0, transm=0, PORT=${PORT}, ADDR=0, TIMEOUT=2, EVT_DELAY=${EVT_DELAY}"
dbLoadRecords "${TOP}/db/Events.db", "P=${P}, R=${R}, num=34,  desc='Undefined', code='35', time=134, mode=0, transm=0, PORT=${PORT}, ADDR=0, TIMEOUT=2, EVT_DELAY=${EVT_DELAY}"
dbLoadRecords "${TOP}/db/Events.db", "P=${P}, R=${R}, num=35,  desc='Undefined', code='36', time=135, mode=0, transm=0, PORT=${PORT}, ADDR=0, TIMEOUT=2, EVT_DELAY=${EVT_DELAY}"
dbLoadRecords "${TOP}/db/Events.db", "P=${P}, R=${R}, num=36,  desc='Undefined', code='37', time=136, mode=0, transm=0, PORT=${PORT}, ADDR=0, TIMEOUT=2, EVT_DELAY=${EVT_DELAY}"
dbLoadRecords "${TOP}/db/Events.db", "P=${P}, R=${R}, num=37,  desc='Undefined', code='38', time=137, mode=0, transm=0, PORT=${PORT}, ADDR=0, TIMEOUT=2, EVT_DELAY=${EVT_DELAY}"
dbLoadRecords "${TOP}/db/Events.db", "P=${P}, R=${R}, num=38,  desc='Undefined', code='39', time=138, mode=0, transm=0, PORT=${PORT}, ADDR=0, TIMEOUT=2, EVT_DELAY=${EVT_DELAY}"
dbLoadRecords "${TOP}/db/Events.db", "P=${P}, R=${R}, num=39,  desc='Undefined', code='40', time=139, mode=0, transm=0, PORT=${PORT}, ADDR=0, TIMEOUT=2, EVT_DELAY=${EVT_DELAY}"
dbLoadRecords "${TOP}/db/Events.db", "P=${P}, R=${R}, num=40,  desc='Undefined', code='41', time=140, mode=0, transm=0, PORT=${PORT}, ADDR=0, TIMEOUT=2, EVT_DELAY=${EVT_DELAY}"
dbLoadRecords "${TOP}/db/Events.db", "P=${P}, R=${R}, num=41,  desc='Undefined', code='42', time=141, mode=0, transm=0, PORT=${PORT}, ADDR=0, TIMEOUT=2, EVT_DELAY=${EVT_DELAY}"
dbLoadRecords "${TOP}/db/Events.db", "P=${P}, R=${R}, num=42,  desc='Undefined', code='43', time=142, mode=0, transm=0, PORT=${PORT}, ADDR=0, TIMEOUT=2, EVT_DELAY=${EVT_DELAY}"
dbLoadRecords "${TOP}/db/Events.db", "P=${P}, R=${R}, num=43,  desc='Undefined', code='44', time=143, mode=0, transm=0, PORT=${PORT}, ADDR=0, TIMEOUT=2, EVT_DELAY=${EVT_DELAY}"
dbLoadRecords "${TOP}/db/Events.db", "P=${P}, R=${R}, num=44,  desc='Undefined', code='45', time=144, mode=0, transm=0, PORT=${PORT}, ADDR=0, TIMEOUT=2, EVT_DELAY=${EVT_DELAY}"
dbLoadRecords "${TOP}/db/Events.db", "P=${P}, R=${R}, num=45,  desc='Undefined', code='46', time=145, mode=0, transm=0, PORT=${PORT}, ADDR=0, TIMEOUT=2, EVT_DELAY=${EVT_DELAY}"
dbLoadRecords "${TOP}/db/Events.db", "P=${P}, R=${R}, num=46,  desc='Undefined', code='47', time=146, mode=0, transm=0, PORT=${PORT}, ADDR=0, TIMEOUT=2, EVT_DELAY=${EVT_DELAY}"
dbLoadRecords "${TOP}/db/Events.db", "P=${P}, R=${R}, num=47,  desc='Undefined', code='48', time=147, mode=0, transm=0, PORT=${PORT}, ADDR=0, TIMEOUT=2, EVT_DELAY=${EVT_DELAY}"
dbLoadRecords "${TOP}/db/Events.db", "P=${P}, R=${R}, num=48,  desc='Undefined', code='49', time=148, mode=0, transm=0, PORT=${PORT}, ADDR=0, TIMEOUT=2, EVT_DELAY=${EVT_DELAY}"
dbLoadRecords "${TOP}/db/Events.db", "P=${P}, R=${R}, num=49,  desc='Undefined', code='50', time=149, mode=0, transm=0, PORT=${PORT}, ADDR=0, TIMEOUT=2, EVT_DELAY=${EVT_DELAY}"
dbLoadRecords "${TOP}/db/Events.db", "P=${P}, R=${R}, num=50,  desc='Undefined', code='51', time=150, mode=0, transm=0, PORT=${PORT}, ADDR=0, TIMEOUT=2, EVT_DELAY=${EVT_DELAY}"
dbLoadRecords "${TOP}/db/Events.db", "P=${P}, R=${R}, num=51,  desc='Undefined', code='52', time=151, mode=0, transm=0, PORT=${PORT}, ADDR=0, TIMEOUT=2, EVT_DELAY=${EVT_DELAY}"
dbLoadRecords "${TOP}/db/Events.db", "P=${P}, R=${R}, num=52,  desc='Undefined', code='53', time=152, mode=0, transm=0, PORT=${PORT}, ADDR=0, TIMEOUT=2, EVT_DELAY=${EVT_DELAY}"
dbLoadRecords "${TOP}/db/Events.db", "P=${P}, R=${R}, num=53,  desc='Undefined', code='54', time=153, mode=0, transm=0, PORT=${PORT}, ADDR=0, TIMEOUT=2, EVT_DELAY=${EVT_DELAY}"
dbLoadRecords "${TOP}/db/Events.db", "P=${P}, R=${R}, num=54,  desc='Undefined', code='55', time=154, mode=0, transm=0, PORT=${PORT}, ADDR=0, TIMEOUT=2, EVT_DELAY=${EVT_DELAY}"
dbLoadRecords "${TOP}/db/Events.db", "P=${P}, R=${R}, num=55,  desc='Undefined', code='56', time=155, mode=0, transm=0, PORT=${PORT}, ADDR=0, TIMEOUT=2, EVT_DELAY=${EVT_DELAY}"
dbLoadRecords "${TOP}/db/Events.db", "P=${P}, R=${R}, num=56,  desc='Undefined', code='57', time=156, mode=0, transm=0, PORT=${PORT}, ADDR=0, TIMEOUT=2, EVT_DELAY=${EVT_DELAY}"
dbLoadRecords "${TOP}/db/Events.db", "P=${P}, R=${R}, num=57,  desc='Undefined', code='58', time=157, mode=0, transm=0, PORT=${PORT}, ADDR=0, TIMEOUT=2, EVT_DELAY=${EVT_DELAY}"
dbLoadRecords "${TOP}/db/Events.db", "P=${P}, R=${R}, num=58,  desc='Undefined', code='59', time=158, mode=0, transm=0, PORT=${PORT}, ADDR=0, TIMEOUT=2, EVT_DELAY=${EVT_DELAY}"
dbLoadRecords "${TOP}/db/Events.db", "P=${P}, R=${R}, num=59,  desc='Undefined', code='60', time=159, mode=0, transm=0, PORT=${PORT}, ADDR=0, TIMEOUT=2, EVT_DELAY=${EVT_DELAY}"
dbLoadRecords "${TOP}/db/Events.db", "P=${P}, R=${R}, num=60,  desc='Undefined', code='61', time=160, mode=0, transm=0, PORT=${PORT}, ADDR=0, TIMEOUT=2, EVT_DELAY=${EVT_DELAY}"
dbLoadRecords "${TOP}/db/Events.db", "P=${P}, R=${R}, num=61,  desc='Undefined', code='62', time=161, mode=0, transm=0, PORT=${PORT}, ADDR=0, TIMEOUT=2, EVT_DELAY=${EVT_DELAY}"
dbLoadRecords "${TOP}/db/Events.db", "P=${P}, R=${R}, num=62,  desc='Undefined', code='63', time=162, mode=0, transm=0, PORT=${PORT}, ADDR=0, TIMEOUT=2, EVT_DELAY=${EVT_DELAY}"

# < save_restore.cmd

## Run this to trace the stages of iocInit
#traceIocInit

iocInit

## Start any sequence programs

# Module initialization and network status
seq sncEVGSetup, "P=${P}, R=${R}"

# Injection System State Machine
seq sncSeqRAM, "P=${P}, R=${R}, ev_num=${EVT_NUM}"

