SUBDIRS := $(SUBDIRS) ./IOC_User_Guide
SUBDIRS := $(SUBDIRS) ./SOE_Hardware_Manual
SUBDIRS := $(SUBDIRS) ./STD-EVE_Hardware_Manual
SUBDIRS := $(SUBDIRS) ./STD-EVO_Hardware_Manual
SUBDIRS := $(SUBDIRS) ./STD-MOE_Hardware_Manual
SUBDIRS := $(SUBDIRS) ./STD-SOE_Hardware_Manual

CLEANDIRS = $(SUBDIRS:%=clean-%)

all: $(SUBDIRS)
$(SUBDIRS):
	$(MAKE) -C $@

clean: $(CLEANDIRS)
$(CLEANDIRS): 
	$(MAKE) -C $(@:clean-%=%) clean
	
.PHONY: all $(SUBDIRS) clean $(CLEANDIRS)

