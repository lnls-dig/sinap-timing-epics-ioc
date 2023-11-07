#!/usr/bin/env python3

from epics import caget
import os

#import sinap list from file
from sinap_list import devices

#add PV gateway address if not set
ioc_servers = ['10.0.38.46:62000','10.0.38.59:62000']

if "EPICS_CA_ADDR_LIST" in os.environ.keys():
    for ioc_server in ioc_servers:
      if ioc_server not in os.environ["EPICS_CA_ADDR_LIST"]:
        print(f"Appending {ioc_server} to EPICS_CA_ADDR_LIST")
        os.environ["EPICS_CA_ADDR_LIST"] = os.environ["EPICS_CA_ADDR_LIST"] + " " + ioc_server
else:
    print("Creating EPICS_CA_ADDR_LIST")
    os.environ["EPICS_CA_ADDR_LIST"] = ' '.join(ioc_servers)

print("--------------------------------------------------------------")
print("Checking devices firmware version")
print("--------------------------------------------------------------")
n_devices = 0
for category in devices.keys():
  print(f"Number of {category}: {len(devices[category])}")
  n_devices = n_devices + len(devices[category])
print("--------------------------------------------------------------")
print(f"Total devices: {n_devices}")
print("--------------------------------------------------------------")

for category in devices.keys():
  print(f"{category} - {len(devices[category])} device{'s' if len(devices[category]) > 1 else ''}")
  print("--------------------------------------------------------------")
  for device in devices[category]:
    fw_ver = caget(f"{device}:FwVersion-Cte.SVAL")
    print(f"{device:30}{fw_ver}")
  print("--------------------------------------------------------------")