TOP=../..

include $(TOP)/configure/CONFIG
#----------------------------------------
#  ADD MACRO DEFINITIONS AFTER THIS LINE

#=============================
# Build the IOC support library

LIBRARY_IOC += timingSupport

# Link locally-provided code into the support library,
# rather than directly into the IOC application.
timingSupport_SRCS += timingHello.c
timingSupport_SRCS += initTrace.c

timingSupport_LIBS += $(EPICS_BASE_IOC_LIBS)

#=============================
# Build the IOC application

PROD_IOC = timing
# timing.dbd will be created and installed
DBD += timing.dbd

# timing.dbd will be made up from these files:
timing_DBD += base.dbd
timing_DBD += timingHello.dbd
timing_DBD += initTrace.dbd

# timing_registerRecordDeviceDriver.cpp derives from timing.dbd
timing_SRCS += timing_registerRecordDeviceDriver.cpp

# Build the main IOC entry point on workstation OSs.
timing_SRCS_DEFAULT += timingMain.cpp
timing_SRCS_vxWorks += -nil-

# Add support from base/src/vxWorks if needed
#timing_OBJS_vxWorks += $(EPICS_BASE_BIN)/vxComLibrary

# Link in the code from the support library
timing_LIBS += timingSupport

# NOTE: To build SNL programs, SNCSEQ must be defined
# in the <top>/configure/RELEASE file

ifneq ($(SNCSEQ),)
    # Build sncEVRESetup into timingSupport
    sncEVRESetup_SNCFLAGS += +r
    timing_DBD += sncEVRESetup.dbd
    timingSupport_SRCS += sncEVRESetup.stt
    timingSupport_LIBS += seq pv
    timing_LIBS += seq pv

    # Build sncEVRESetupProgram as a standalone program
    PROD_HOST += sncEVRESetupProgram
    sncEVRESetupProgram_SNCFLAGS += +m
    sncEVRESetupProgram_SRCS += sncEVRESetupProgram.st
    sncEVRESetupProgram_LIBS += seq pv
    sncEVRESetupProgram_LIBS += $(EPICS_BASE_HOST_LIBS)

    # Build sncSeqRAM into timingSupport
    sncSeqRAM_SNCFLAGS += +r
    timing_DBD += sncSeqRAM.dbd
    timingSupport_SRCS += sncSeqRAM.stt
    timingSupport_LIBS += seq pv
    timing_LIBS += seq pv

    # Build sncSeqRAMProgram as a standalone program
    PROD_HOST += sncSeqRAMProgram
    sncSeqRAMProgram_SNCFLAGS += +m
    sncSeqRAMProgram_SRCS += sncSeqRAMProgram.st
    sncSeqRAMProgram_LIBS += seq pv
    sncSeqRAMProgram_LIBS += $(EPICS_BASE_HOST_LIBS)

    # Build sncEVGSetup into timingSupport
    sncEVGSetup_SNCFLAGS += +r
    timing_DBD += sncEVGSetup.dbd
    timingSupport_SRCS += sncEVGSetup.stt
    timingSupport_LIBS += seq pv
    timing_LIBS += seq pv

    # Build sncEVGSetupProgram as a standalone program
    PROD_HOST += sncEVGSetupProgram
    sncEVGSetupProgram_SNCFLAGS += +m
    sncEVGSetupProgram_SRCS += sncEVGSetupProgram.st
    sncEVGSetupProgram_LIBS += seq pv
    sncEVGSetupProgram_LIBS += $(EPICS_BASE_HOST_LIBS)

    # Build sncFOUTSetup into timingSupport
    sncFOUTSetup_SNCFLAGS += +r
    timing_DBD += sncFOUTSetup.dbd
    timingSupport_SRCS += sncFOUTSetup.stt
    timingSupport_LIBS += seq pv
    timing_LIBS += seq pv

    # Build sncFOUTSetupProgram as a standalone program
    PROD_HOST += sncFOUTSetupProgram
    sncFOUTSetupProgram_SNCFLAGS += +m
    sncFOUTSetupProgram_SRCS += sncFOUTSetupProgram.st
    sncFOUTSetupProgram_LIBS += seq pv
    sncFOUTSetupProgram_LIBS += $(EPICS_BASE_HOST_LIBS)
endif

# Finally link to the EPICS Base libraries
timing_LIBS += $(EPICS_BASE_IOC_LIBS)

#=============================

include $(TOP)/configure/RULES
#----------------------------------------
#  ADD RULES AFTER THIS LINE

timing_DBD += drvAsynIPPort.dbd
timing_DBD += drvVxi11.dbd
timing_DBD += stream.dbd
timing_DBD += calcSupport.dbd
timing_DBD += asSupport.dbd

timing_LIBS += asyn
timing_LIBS += stream
timing_LIBS += calc
timing_LIBS += autosave
