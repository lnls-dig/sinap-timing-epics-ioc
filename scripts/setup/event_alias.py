#!/usr/bin/python3

import urllib.request as _urllib_request
import ast
import sys


if (len(sys.argv) == 1):
  URL = 'http://10.0.38.42/control-system-constants/timesys/high-level-events.py'
  print ('Missing url server. Using default: ' + URL + '\n')
elif ((len(sys.argv) == 2) & ('http' in sys.argv[1])):
  URL = sys.argv[1]
  print ('Reading: ' + URL + '\n')
else:
  print ('Invalid url server: ', sys.argv[1:])

TIMEOUT = 1.0
EVT_NUM = 63

def high_level_events(url):
  """Return the data defining the high level events."""
  try:
    response = _urllib_request.urlopen(url, timeout=TIMEOUT)
    data = response.read()
    text = data.decode('utf-8')
  except Exception:
    errtxt = 'Error reading url "' + url + '"!'
    print (errtxt)
    text = "{'Error':'EvtErr'}"
  return text

def HLEvt_to_LLEvt(HLEvents):
  """Generate a LLEvents dictionary from HLEvents"""
  evt_alias = {}
  for i in HLEvents:
    evt_alias[HLEvents[i]] = i
  return evt_alias
  

HLEvents = ast.literal_eval(high_level_events(URL))

f = open('../../iocBoot/ioctiming/event_alias.cmd', 'w')

f.write('########################################################################################\n')
f.write('##### This file was generated automatically by $(TOP)/scripts/setup/event_alias.py #####\n')
f.write('#####                          DO NOT DELETE OR MODIFY IT                          #####\n')
f.write('########################################################################################\n\n')

if ('Error' in HLEvents):
  f.write('# Error reading url "' + URL + '"!')
  
else:
  evt_alias = HLEvt_to_LLEvt(HLEvents)
  
  print ('---- \tEvents \t ----')  
  print ('Code\tName\tAlias')  
  for i in range(EVT_NUM):
    evt_code = str(i + 1).zfill(2)
    evt_name = 'Evt' + str(i + 1).zfill(2)
    if (evt_name in evt_alias):
      print (evt_code + '\t' + evt_name + '\t' + evt_alias[evt_name])
      f.write('dbLoadRecords ' + chr(34) + "${TOP}/db/HLEvents.db" + chr(34) + "," + chr(34) + "P=${P}, R=${R}, num=" + str(i) + ", alias='" + evt_alias[evt_name] + "', code='" + evt_code + "'" + chr(34) + '\n')

f.close()
  
