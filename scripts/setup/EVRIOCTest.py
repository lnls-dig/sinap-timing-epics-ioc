# IOC test

from epics import caget, caput
from time import sleep, time
from os import system

updatetime = 1.0

P = 'TEST-DIG:'
R = 'TI-EVR-1:'

print 'Testing', P+R

PVindex = 'OTP'
PVnames = ['State-Sel', 'Width-SP', 'Polarity-Sel', 'Delay-SP', 'Log-Sel', 'Evt-SP', 'NrPulses-SP']
PVvalues = [1,10,1,10,1,10,10]
PVvalues = [0,20,0,20,0,20,20]

sleep(5)
elapsed_time = time()
for j in range(24):
  Index = PVindex + str(j).zfill(2)
  i = 0
  while i < (len(PVnames)):
    print P+R+Index+PVnames[i],PVvalues[i]
    caput(P+R+Index+PVnames[i],PVvalues[i],wait=False)
    #caput(P+R+Index+PVnames[i],PVvalues[i],wait=True)
    i = i + 1

elapsed_time = time() - elapsed_time
print 'elapsed_time', elapsed_time
'''	
j = 0
while j < (len(PVindex)):
	i = 0
	while i < (len(PVname)):
		caput(P+R+PVname[i]+PVindex[j],PVvalue[i],wait=True)
		sleep(updatetime)
		value = caget(P+R+PVname[i]+PVindex[j]+'RBV')
		sleep(updatetime)
		if (PVvalue[i] == value):
			print P+R+PVname[i]+PVindex[j], '\t', PVvalue[i], '\t', value, '\tOK'
			i = i + 1
		else:
			print P+R+PVname[i]+PVindex[j], '\t', PVvalue[i], '\t', value, '\tOPS'
	j = j + 1
'''	
