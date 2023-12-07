TOP=../..
include $(TOP)/configure/CONFIG
#----------------------------------------
#  ADD MACRO DEFINITIONS AFTER THIS LINE

#----------------------------------------------------
#  Optimization of db files using dbst (DEFAULT: NO)
#DB_OPT = YES

#----------------------------------------------------
# Create and install (or just install)
# databases, templates, substitutions like this
DB += evre_otp.db
DB += evre_otp_scan.db
DB += evre_out.db
DB += evgfout_out.db evgfout_rxenbl.db
DB += evg_clk.db
DB += eve.db
DB += evg.db
DB += evr.db
DB += fout.db
DB += Events.db
DB += HLEvents.db
DB += SeqRAM.db
DB += fw_version.db
DB += event_log.db
DB += rx_locked.db
DB += digital_input.db

DB += $(AUTOSAVE)/asApp/Db/save_restoreStatus.db

DB += $(ASYN)/db/asynRecord.db

#----------------------------------------------------
# If <anyname>.db template is not named <anyname>*.template add
# <anyname>_TEMPLATE = <templatename>

include $(TOP)/configure/RULES
#----------------------------------------
#  ADD RULES AFTER THIS LINE

