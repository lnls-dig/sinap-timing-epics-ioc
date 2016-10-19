# IOC test

from epics import caget, caput
from time import sleep
from os import system

updatetime = 1.0

########################## EVG Test ####################################
print 'Testing EVG parameters'
module = 'EVG:'
PVname = ['enable','seqen','acen','acdiv', 'muxen0', 'muxdiv0', 'muxen1', 'muxdiv1', 'muxen2', 'muxdiv2', 'muxen3', 'muxdiv3', 'muxen4', 'muxdiv4', 'muxen5', 'muxdiv5', 'muxen6', 'muxdiv6', 'muxen7', 'muxdiv7','rfdiv']
PVvalue = [1,1,1,30,1,10,1,10,1,10,1,10,1,10,1,10,1,10,1,10,4]

i = 0
while i < (len(PVname)):
	caput(module+PVname[i],PVvalue[i],wait=True)
	sleep(updatetime)
	value = caget(module+PVname[i]+'RBV')
	sleep(updatetime)
	if (PVvalue[i] == value):
		print module+PVname[i], '\t', PVvalue[i], '\t', value, '\tOK'
		i = i + 1
	else:
		print module+PVname[i], '\t', PVvalue[i], '\t', value, '\tOPS'
	
########################## EVR Test ####################################
print 'Testing EVR5 parameters'
module = 'EVR5:'
PVname = ['enable', 'clkmode']
PVvalue = [1,16]

i = 0
while i < (len(PVname)):
	caput(module+PVname[i],PVvalue[i],wait=True)
	sleep(updatetime)
	value = caget(module+PVname[i]+'RBV')
	sleep(updatetime)
	if (PVvalue[i] == value):
		print module+PVname[i], '\t', PVvalue[i], '\t', value, '\tOK'
		i = i + 1
	else:
		print module+PVname[i], '\t', PVvalue[i], '\t', value, '\tOPS'
	
module = 'EVR5:'
PVname = ['enable', 'pol', 'event', 'delay', 'width']
PVindex = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'A', 'B', 'C', 'D', 'E', 'F']
PVvalue = [1,1,7,301,301]

j = 0
while j < (len(PVindex)):
	i = 0
	while i < (len(PVname)):
		caput(module+PVname[i]+PVindex[j],PVvalue[i],wait=True)
		sleep(updatetime)
		value = caget(module+PVname[i]+PVindex[j]+'RBV')
		sleep(updatetime)
		if (PVvalue[i] == value):
			print module+PVname[i]+PVindex[j], '\t', PVvalue[i], '\t', value, '\tOK'
			i = i + 1
		else:
			print module+PVname[i]+PVindex[j], '\t', PVvalue[i], '\t', value, '\tOPS'
	j = j + 1
	
module = 'EVR5:'
PVname = ['itl', 'sel', 'finedly', 'rfdly']
PVindex = ['0', '1', '2', '3', '4', '5', '6', '7']
PVvalue = [1,4,7,5]

j = 0
while j < (len(PVindex)):
	i = 0
	while i < (len(PVname)):
		caput(module+PVname[i]+PVindex[j],PVvalue[i],wait=True)
		sleep(updatetime)
		value = caget(module+PVname[i]+PVindex[j]+'RBV')
		sleep(updatetime)
		if (PVvalue[i] == value):
			print module+PVname[i]+PVindex[j], '\t', PVvalue[i], '\t', value, '\tOK'
			i = i + 1
		else:
			print module+PVname[i]+PVindex[j], '\t', PVvalue[i], '\t', value, '\tOPS'
	j = j + 1
	
########################## EVE Test ####################################
print 'Testing EVE1 parameters'
module = 'EVE1:'
PVname = ['enable', 'clkmode', 'cmsel']
PVvalue = [1,16,3]

i = 0
while i < (len(PVname)):
	caput(module+PVname[i],PVvalue[i],wait=True)
	sleep(updatetime)
	value = caget(module+PVname[i]+'RBV')
	sleep(updatetime)
	if (PVvalue[i] == value):
		print module+PVname[i], '\t', PVvalue[i], '\t', value, '\tOK'
		i = i + 1
	else:
		print module+PVname[i], '\t', PVvalue[i], '\t', value, '\tOPS'
	
module = 'EVE1:'
PVname = ['enable', 'pol', 'event', 'delay', 'width']
PVindex = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'A', 'B', 'C', 'D', 'E', 'F']
PVvalue = [1,1,7,301,301]

j = 0
while j < (len(PVindex)):
	i = 0
	while i < (len(PVname)):
		caput(module+PVname[i]+PVindex[j],PVvalue[i],wait=True)
		sleep(updatetime)
		value = caget(module+PVname[i]+PVindex[j]+'RBV')
		sleep(updatetime)
		if (PVvalue[i] == value):
			print module+PVname[i]+PVindex[j], '\t', PVvalue[i], '\t', value, '\tOK'
			i = i + 1
		else:
			print module+PVname[i]+PVindex[j], '\t', PVvalue[i], '\t', value, '\tOPS'
	j = j + 1
	
module = 'EVE1:'
PVname = ['itl', 'sel', 'finedly', 'rfdly']
PVindex = ['0', '1', '2', '3', '4', '5', '6', '7']
PVvalue = [1,4,7,5]

j = 0
while j < (len(PVindex)):
	i = 0
	while i < (len(PVname)):
		caput(module+PVname[i]+PVindex[j],PVvalue[i],wait=True)
		sleep(updatetime)
		value = caget(module+PVname[i]+PVindex[j]+'RBV')
		sleep(updatetime)
		if (PVvalue[i] == value):
			print module+PVname[i]+PVindex[j], '\t', PVvalue[i], '\t', value, '\tOK'
			i = i + 1
		else:
			print module+PVname[i]+PVindex[j], '\t', PVvalue[i], '\t', value, '\tOPS'
	j = j + 1
	
