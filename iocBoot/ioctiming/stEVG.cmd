#!../../bin/linux-x86_64/timing

< envPaths

epicsEnvSet("TOP", "../..")

< EVG.config

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

# EVG
dbLoadRecords("${TOP}/db/evg.db", "P=${P}, R=${R}, IPADDR=${IPADDR}, IPPORT=${IPPORT}, PORT=${PORT}, ADDR=0, TIMEOUT=2")
dbLoadRecords "${TOP}/db/SeqRAM.db", "P=${P}, R=${R}"

dbLoadRecords("${TOP}/db/fw_version.db", "P=${P}, R=${R}, PORT=${PORT}, ADDR=0, TIMEOUT=2")
dbLoadRecords("${TOP}/db/event_log.db", "P=${P}, R=${R}, PORT=${PORT}, ADDR=0, TIMEOUT=2")
dbLoadRecords("${TOP}/db/evg_interlock.db", "P=${P}, R=${R}, PORT=${PORT}, ADDR=0, TIMEOUT=2")

dbLoadRecords("${TOP}/db/rx_locked.db", "P=${P}, R=${R}, PORT=${PORT}, ADDR=0, TIMEOUT=2, DEVICE=evg")

dbLoadRecords("${TOP}/db/evgfout_out.db", "P=${P}, R=${R}, num=0, PORT=${PORT}, ADDR=0, TIMEOUT=2")
dbLoadRecords("${TOP}/db/evgfout_out.db", "P=${P}, R=${R}, num=1, PORT=${PORT}, ADDR=0, TIMEOUT=2")
dbLoadRecords("${TOP}/db/evgfout_out.db", "P=${P}, R=${R}, num=2, PORT=${PORT}, ADDR=0, TIMEOUT=2")
dbLoadRecords("${TOP}/db/evgfout_out.db", "P=${P}, R=${R}, num=3, PORT=${PORT}, ADDR=0, TIMEOUT=2")
dbLoadRecords("${TOP}/db/evgfout_out.db", "P=${P}, R=${R}, num=4, PORT=${PORT}, ADDR=0, TIMEOUT=2")
dbLoadRecords("${TOP}/db/evgfout_out.db", "P=${P}, R=${R}, num=5, PORT=${PORT}, ADDR=0, TIMEOUT=2")
dbLoadRecords("${TOP}/db/evgfout_out.db", "P=${P}, R=${R}, num=6, PORT=${PORT}, ADDR=0, TIMEOUT=2")
dbLoadRecords("${TOP}/db/evgfout_out.db", "P=${P}, R=${R}, num=7, PORT=${PORT}, ADDR=0, TIMEOUT=2")

dbLoadRecords("${TOP}/db/evg_clk.db", "P=${P}, R=${R}, num=0, PORT=${PORT}, ADDR=0, TIMEOUT=2")
dbLoadRecords("${TOP}/db/evg_clk.db", "P=${P}, R=${R}, num=1, PORT=${PORT}, ADDR=0, TIMEOUT=2")
dbLoadRecords("${TOP}/db/evg_clk.db", "P=${P}, R=${R}, num=2, PORT=${PORT}, ADDR=0, TIMEOUT=2")
dbLoadRecords("${TOP}/db/evg_clk.db", "P=${P}, R=${R}, num=3, PORT=${PORT}, ADDR=0, TIMEOUT=2")
dbLoadRecords("${TOP}/db/evg_clk.db", "P=${P}, R=${R}, num=4, PORT=${PORT}, ADDR=0, TIMEOUT=2")
dbLoadRecords("${TOP}/db/evg_clk.db", "P=${P}, R=${R}, num=5, PORT=${PORT}, ADDR=0, TIMEOUT=2")
dbLoadRecords("${TOP}/db/evg_clk.db", "P=${P}, R=${R}, num=6, PORT=${PORT}, ADDR=0, TIMEOUT=2")
dbLoadRecords("${TOP}/db/evg_clk.db", "P=${P}, R=${R}, num=7, PORT=${PORT}, ADDR=0, TIMEOUT=2")

dbLoadRecords "${TOP}/db/Events.db", "P=${P}, R=${R}, num=0,  code='01', time=100, mode=0, transm=0, PORT=${PORT}, ADDR=0, TIMEOUT=2, EVT_DELAY=${EVT_DELAY}"
dbLoadRecords "${TOP}/db/Events.db", "P=${P}, R=${R}, num=1,  code='02', time=101, mode=0, transm=0, PORT=${PORT}, ADDR=0, TIMEOUT=2, EVT_DELAY=${EVT_DELAY}"
dbLoadRecords "${TOP}/db/Events.db", "P=${P}, R=${R}, num=2,  code='03', time=102, mode=0, transm=0, PORT=${PORT}, ADDR=0, TIMEOUT=2, EVT_DELAY=${EVT_DELAY}"
dbLoadRecords "${TOP}/db/Events.db", "P=${P}, R=${R}, num=3,  code='04', time=103, mode=0, transm=0, PORT=${PORT}, ADDR=0, TIMEOUT=2, EVT_DELAY=${EVT_DELAY}"
dbLoadRecords "${TOP}/db/Events.db", "P=${P}, R=${R}, num=4,  code='05', time=104, mode=0, transm=0, PORT=${PORT}, ADDR=0, TIMEOUT=2, EVT_DELAY=${EVT_DELAY}"
dbLoadRecords "${TOP}/db/Events.db", "P=${P}, R=${R}, num=5,  code='06', time=105, mode=0, transm=0, PORT=${PORT}, ADDR=0, TIMEOUT=2, EVT_DELAY=${EVT_DELAY}"
dbLoadRecords "${TOP}/db/Events.db", "P=${P}, R=${R}, num=6,  code='07', time=106, mode=0, transm=0, PORT=${PORT}, ADDR=0, TIMEOUT=2, EVT_DELAY=${EVT_DELAY}"
dbLoadRecords "${TOP}/db/Events.db", "P=${P}, R=${R}, num=7,  code='08', time=107, mode=0, transm=0, PORT=${PORT}, ADDR=0, TIMEOUT=2, EVT_DELAY=${EVT_DELAY}"
dbLoadRecords "${TOP}/db/Events.db", "P=${P}, R=${R}, num=8,  code='09', time=108, mode=0, transm=0, PORT=${PORT}, ADDR=0, TIMEOUT=2, EVT_DELAY=${EVT_DELAY}"
dbLoadRecords "${TOP}/db/Events.db", "P=${P}, R=${R}, num=9,  code='10', time=109, mode=0, transm=0, PORT=${PORT}, ADDR=0, TIMEOUT=2, EVT_DELAY=${EVT_DELAY}"
dbLoadRecords "${TOP}/db/Events.db", "P=${P}, R=${R}, num=10, code='11', time=110, mode=0, transm=0, PORT=${PORT}, ADDR=0, TIMEOUT=2, EVT_DELAY=${EVT_DELAY}"
dbLoadRecords "${TOP}/db/Events.db", "P=${P}, R=${R}, num=11, code='12', time=111, mode=0, transm=0, PORT=${PORT}, ADDR=0, TIMEOUT=2, EVT_DELAY=${EVT_DELAY}"
dbLoadRecords "${TOP}/db/Events.db", "P=${P}, R=${R}, num=12, code='13', time=112, mode=0, transm=0, PORT=${PORT}, ADDR=0, TIMEOUT=2, EVT_DELAY=${EVT_DELAY}"
dbLoadRecords "${TOP}/db/Events.db", "P=${P}, R=${R}, num=13, code='14', time=113, mode=0, transm=0, PORT=${PORT}, ADDR=0, TIMEOUT=2, EVT_DELAY=${EVT_DELAY}"
dbLoadRecords "${TOP}/db/Events.db", "P=${P}, R=${R}, num=14, code='15', time=114, mode=0, transm=0, PORT=${PORT}, ADDR=0, TIMEOUT=2, EVT_DELAY=${EVT_DELAY}"
dbLoadRecords "${TOP}/db/Events.db", "P=${P}, R=${R}, num=15, code='16', time=115, mode=0, transm=0, PORT=${PORT}, ADDR=0, TIMEOUT=2, EVT_DELAY=${EVT_DELAY}"
dbLoadRecords "${TOP}/db/Events.db", "P=${P}, R=${R}, num=16, code='17', time=116, mode=0, transm=0, PORT=${PORT}, ADDR=0, TIMEOUT=2, EVT_DELAY=${EVT_DELAY}"
dbLoadRecords "${TOP}/db/Events.db", "P=${P}, R=${R}, num=17, code='18', time=117, mode=0, transm=0, PORT=${PORT}, ADDR=0, TIMEOUT=2, EVT_DELAY=${EVT_DELAY}"
dbLoadRecords "${TOP}/db/Events.db", "P=${P}, R=${R}, num=18, code='19', time=118, mode=0, transm=0, PORT=${PORT}, ADDR=0, TIMEOUT=2, EVT_DELAY=${EVT_DELAY}"
dbLoadRecords "${TOP}/db/Events.db", "P=${P}, R=${R}, num=19, code='20', time=119, mode=0, transm=0, PORT=${PORT}, ADDR=0, TIMEOUT=2, EVT_DELAY=${EVT_DELAY}"
dbLoadRecords "${TOP}/db/Events.db", "P=${P}, R=${R}, num=20, code='21', time=120, mode=0, transm=0, PORT=${PORT}, ADDR=0, TIMEOUT=2, EVT_DELAY=${EVT_DELAY}"
dbLoadRecords "${TOP}/db/Events.db", "P=${P}, R=${R}, num=21, code='22', time=121, mode=0, transm=0, PORT=${PORT}, ADDR=0, TIMEOUT=2, EVT_DELAY=${EVT_DELAY}"
dbLoadRecords "${TOP}/db/Events.db", "P=${P}, R=${R}, num=22, code='23', time=122, mode=0, transm=0, PORT=${PORT}, ADDR=0, TIMEOUT=2, EVT_DELAY=${EVT_DELAY}"
dbLoadRecords "${TOP}/db/Events.db", "P=${P}, R=${R}, num=23, code='24', time=123, mode=0, transm=0, PORT=${PORT}, ADDR=0, TIMEOUT=2, EVT_DELAY=${EVT_DELAY}"
dbLoadRecords "${TOP}/db/Events.db", "P=${P}, R=${R}, num=24, code='25', time=124, mode=0, transm=0, PORT=${PORT}, ADDR=0, TIMEOUT=2, EVT_DELAY=${EVT_DELAY}"
dbLoadRecords "${TOP}/db/Events.db", "P=${P}, R=${R}, num=25, code='26', time=125, mode=0, transm=0, PORT=${PORT}, ADDR=0, TIMEOUT=2, EVT_DELAY=${EVT_DELAY}"
dbLoadRecords "${TOP}/db/Events.db", "P=${P}, R=${R}, num=26, code='27', time=126, mode=0, transm=0, PORT=${PORT}, ADDR=0, TIMEOUT=2, EVT_DELAY=${EVT_DELAY}"
dbLoadRecords "${TOP}/db/Events.db", "P=${P}, R=${R}, num=27, code='28', time=127, mode=0, transm=0, PORT=${PORT}, ADDR=0, TIMEOUT=2, EVT_DELAY=${EVT_DELAY}"
dbLoadRecords "${TOP}/db/Events.db", "P=${P}, R=${R}, num=28, code='29', time=128, mode=0, transm=0, PORT=${PORT}, ADDR=0, TIMEOUT=2, EVT_DELAY=${EVT_DELAY}"
dbLoadRecords "${TOP}/db/Events.db", "P=${P}, R=${R}, num=29, code='30', time=129, mode=0, transm=0, PORT=${PORT}, ADDR=0, TIMEOUT=2, EVT_DELAY=${EVT_DELAY}"
dbLoadRecords "${TOP}/db/Events.db", "P=${P}, R=${R}, num=30, code='31', time=130, mode=0, transm=0, PORT=${PORT}, ADDR=0, TIMEOUT=2, EVT_DELAY=${EVT_DELAY}"
dbLoadRecords "${TOP}/db/Events.db", "P=${P}, R=${R}, num=31, code='32', time=131, mode=0, transm=0, PORT=${PORT}, ADDR=0, TIMEOUT=2, EVT_DELAY=${EVT_DELAY}"
dbLoadRecords "${TOP}/db/Events.db", "P=${P}, R=${R}, num=32, code='33', time=132, mode=0, transm=0, PORT=${PORT}, ADDR=0, TIMEOUT=2, EVT_DELAY=${EVT_DELAY}"
dbLoadRecords "${TOP}/db/Events.db", "P=${P}, R=${R}, num=33, code='34', time=133, mode=0, transm=0, PORT=${PORT}, ADDR=0, TIMEOUT=2, EVT_DELAY=${EVT_DELAY}"
dbLoadRecords "${TOP}/db/Events.db", "P=${P}, R=${R}, num=34, code='35', time=134, mode=0, transm=0, PORT=${PORT}, ADDR=0, TIMEOUT=2, EVT_DELAY=${EVT_DELAY}"
dbLoadRecords "${TOP}/db/Events.db", "P=${P}, R=${R}, num=35, code='36', time=135, mode=0, transm=0, PORT=${PORT}, ADDR=0, TIMEOUT=2, EVT_DELAY=${EVT_DELAY}"
dbLoadRecords "${TOP}/db/Events.db", "P=${P}, R=${R}, num=36, code='37', time=136, mode=0, transm=0, PORT=${PORT}, ADDR=0, TIMEOUT=2, EVT_DELAY=${EVT_DELAY}"
dbLoadRecords "${TOP}/db/Events.db", "P=${P}, R=${R}, num=37, code='38', time=137, mode=0, transm=0, PORT=${PORT}, ADDR=0, TIMEOUT=2, EVT_DELAY=${EVT_DELAY}"
dbLoadRecords "${TOP}/db/Events.db", "P=${P}, R=${R}, num=38, code='39', time=138, mode=0, transm=0, PORT=${PORT}, ADDR=0, TIMEOUT=2, EVT_DELAY=${EVT_DELAY}"
dbLoadRecords "${TOP}/db/Events.db", "P=${P}, R=${R}, num=39, code='40', time=139, mode=0, transm=0, PORT=${PORT}, ADDR=0, TIMEOUT=2, EVT_DELAY=${EVT_DELAY}"
dbLoadRecords "${TOP}/db/Events.db", "P=${P}, R=${R}, num=40, code='41', time=140, mode=0, transm=0, PORT=${PORT}, ADDR=0, TIMEOUT=2, EVT_DELAY=${EVT_DELAY}"
dbLoadRecords "${TOP}/db/Events.db", "P=${P}, R=${R}, num=41, code='42', time=141, mode=0, transm=0, PORT=${PORT}, ADDR=0, TIMEOUT=2, EVT_DELAY=${EVT_DELAY}"
dbLoadRecords "${TOP}/db/Events.db", "P=${P}, R=${R}, num=42, code='43', time=142, mode=0, transm=0, PORT=${PORT}, ADDR=0, TIMEOUT=2, EVT_DELAY=${EVT_DELAY}"
dbLoadRecords "${TOP}/db/Events.db", "P=${P}, R=${R}, num=43, code='44', time=143, mode=0, transm=0, PORT=${PORT}, ADDR=0, TIMEOUT=2, EVT_DELAY=${EVT_DELAY}"
dbLoadRecords "${TOP}/db/Events.db", "P=${P}, R=${R}, num=44, code='45', time=144, mode=0, transm=0, PORT=${PORT}, ADDR=0, TIMEOUT=2, EVT_DELAY=${EVT_DELAY}"
dbLoadRecords "${TOP}/db/Events.db", "P=${P}, R=${R}, num=45, code='46', time=145, mode=0, transm=0, PORT=${PORT}, ADDR=0, TIMEOUT=2, EVT_DELAY=${EVT_DELAY}"
dbLoadRecords "${TOP}/db/Events.db", "P=${P}, R=${R}, num=46, code='47', time=146, mode=0, transm=0, PORT=${PORT}, ADDR=0, TIMEOUT=2, EVT_DELAY=${EVT_DELAY}"
dbLoadRecords "${TOP}/db/Events.db", "P=${P}, R=${R}, num=47, code='48', time=147, mode=0, transm=0, PORT=${PORT}, ADDR=0, TIMEOUT=2, EVT_DELAY=${EVT_DELAY}"
dbLoadRecords "${TOP}/db/Events.db", "P=${P}, R=${R}, num=48, code='49', time=148, mode=0, transm=0, PORT=${PORT}, ADDR=0, TIMEOUT=2, EVT_DELAY=${EVT_DELAY}"
dbLoadRecords "${TOP}/db/Events.db", "P=${P}, R=${R}, num=49, code='50', time=149, mode=0, transm=0, PORT=${PORT}, ADDR=0, TIMEOUT=2, EVT_DELAY=${EVT_DELAY}"
dbLoadRecords "${TOP}/db/Events.db", "P=${P}, R=${R}, num=50, code='51', time=150, mode=0, transm=0, PORT=${PORT}, ADDR=0, TIMEOUT=2, EVT_DELAY=${EVT_DELAY}"
dbLoadRecords "${TOP}/db/Events.db", "P=${P}, R=${R}, num=51, code='52', time=151, mode=0, transm=0, PORT=${PORT}, ADDR=0, TIMEOUT=2, EVT_DELAY=${EVT_DELAY}"
dbLoadRecords "${TOP}/db/Events.db", "P=${P}, R=${R}, num=52, code='53', time=152, mode=0, transm=0, PORT=${PORT}, ADDR=0, TIMEOUT=2, EVT_DELAY=${EVT_DELAY}"
dbLoadRecords "${TOP}/db/Events.db", "P=${P}, R=${R}, num=53, code='54', time=153, mode=0, transm=0, PORT=${PORT}, ADDR=0, TIMEOUT=2, EVT_DELAY=${EVT_DELAY}"
dbLoadRecords "${TOP}/db/Events.db", "P=${P}, R=${R}, num=54, code='55', time=154, mode=0, transm=0, PORT=${PORT}, ADDR=0, TIMEOUT=2, EVT_DELAY=${EVT_DELAY}"
dbLoadRecords "${TOP}/db/Events.db", "P=${P}, R=${R}, num=55, code='56', time=155, mode=0, transm=0, PORT=${PORT}, ADDR=0, TIMEOUT=2, EVT_DELAY=${EVT_DELAY}"
dbLoadRecords "${TOP}/db/Events.db", "P=${P}, R=${R}, num=56, code='57', time=156, mode=0, transm=0, PORT=${PORT}, ADDR=0, TIMEOUT=2, EVT_DELAY=${EVT_DELAY}"
dbLoadRecords "${TOP}/db/Events.db", "P=${P}, R=${R}, num=57, code='58', time=157, mode=0, transm=0, PORT=${PORT}, ADDR=0, TIMEOUT=2, EVT_DELAY=${EVT_DELAY}"
dbLoadRecords "${TOP}/db/Events.db", "P=${P}, R=${R}, num=58, code='59', time=158, mode=0, transm=0, PORT=${PORT}, ADDR=0, TIMEOUT=2, EVT_DELAY=${EVT_DELAY}"
dbLoadRecords "${TOP}/db/Events.db", "P=${P}, R=${R}, num=59, code='60', time=159, mode=0, transm=0, PORT=${PORT}, ADDR=0, TIMEOUT=2, EVT_DELAY=${EVT_DELAY}"
dbLoadRecords "${TOP}/db/Events.db", "P=${P}, R=${R}, num=60, code='61', time=160, mode=0, transm=0, PORT=${PORT}, ADDR=0, TIMEOUT=2, EVT_DELAY=${EVT_DELAY}"
dbLoadRecords "${TOP}/db/Events.db", "P=${P}, R=${R}, num=61, code='62', time=161, mode=0, transm=0, PORT=${PORT}, ADDR=0, TIMEOUT=2, EVT_DELAY=${EVT_DELAY}"
dbLoadRecords "${TOP}/db/Events.db", "P=${P}, R=${R}, num=62, code='63', time=162, mode=0, transm=0, PORT=${PORT}, ADDR=0, TIMEOUT=2, EVT_DELAY=${EVT_DELAY}"

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

dbLoadRecords("${TOP}/db/evre_otp_scan.db", "P=${P}, R=${R}, PORT=${PORT}, ADDR=0, TIMEOUT=2, SCAN=Passive")

< event_alias.cmd

< save_restore.cmd

## Run this to trace the stages of iocInit
#traceIocInit

iocInit

## Start any sequence programs

# Module initialization and network status
seq sncEVGSetup, "P=${P}, R=${R}"

# Injection System State Machine
seq sncSeqRAM, "P=${P}, R=${R}, ev_num=${EVT_NUM}"

# Create monitor for Autosave
create_monitor_set("autosave_evg.req", 60, "P=${P}, R=${R}")

# Create manual trigger for Autosave
create_triggered_set("autosave_evg.req", "${P}${R}Save-Cmd", "P=${P}, R=${R}")

set_savefile_name("autosave_evg.req", "auto_settings_${P}${R}.sav")

iocLogPrefix "${IOC_LOG_PREFIX}"
caPutJsonLogInit
