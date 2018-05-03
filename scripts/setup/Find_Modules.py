########################### Run in python 2 ###########################

# Find timing modules in a subnetwork

import numpy as np
import time
import socket
import sys
import subprocess
import nmap

WAIT = 0.01
NrTry = 3 

if (len(sys.argv) == 1):
  ipsub_list = ['10.0.18','10.0.17','10.0.21','10.0.38']
else:
  ipsub_list = sys.argv[1:]
  
port_ini = 50100
port_end = 50150

f = open('Find_Modules.log','w')

def FindMod(UDP_IP, UDP_PORT):
  # Read
  funsel = [16, 17, 18, 32]
  sock = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
  sock.settimeout(WAIT)
  sock.bind(('', UDP_PORT))
  add = 63
  ok = 0
  cmd = chr(0x80|add)+chr(0)+chr(0)+chr(0)+chr(0)+chr(0)+chr(0)+chr(0)+chr(0)+chr(0)+chr(0)+chr(0)+chr(0)
  
  for i in range(NrTry):
    sock.sendto(cmd, (UDP_IP, UDP_PORT))
    try: 
      data, addr = sock.recvfrom(13) # buffer size is 13 bytes
      regA = [(ord(data[1])),(ord(data[2])),(ord(data[3])),(ord(data[4]))]
      regB = [(ord(data[5])),(ord(data[6])),(ord(data[7])),(ord(data[8]))]
      regC = [(ord(data[9])),(ord(data[10])),(ord(data[11])),(ord(data[12]))]
      if (regC[3] in funsel):
        ok = 1
    except:
      ok = 0
      addr = ['0.0.0.0', 0]
      regA = regB = regC = [0, 0, 0, 0]
    if (ok == 1):
      break
    
  return ok, regA, regB, regC, addr
  
port_list = range(port_ini,port_end+1)
start_time = time.time()

for ipsub in ipsub_list:
  print 'Searching for timing modules in subnet', ipsub, 'and port range', port_ini, 'to', port_end

  nm = nmap.PortScanner() 
  nm.scan(ipsub+'.2-254', '9999') # scan host ipsub.2-254, port 9999
  
  for host in nm.all_hosts():
    prod = nm[host]['tcp'][9999]['product']
    port_state = nm[host]['tcp'][9999]['state']
    if (('Lantronix' in prod) & (port_state == 'open')):
      mac = nm[host]['tcp'][9999]['extrainfo'].split(' ')[1]
    else:
      continue
 
    ok = 0
    for port in port_list:
      ok, a, b, c, addr = FindMod(host, port)
      if ((ok==1) & (c[3]!=0)):
        if (c[3]==32):
          print 'EVE ip: ', host, 'port:', port, 'mac:', mac
          f.write('EVE ip:  ' + host + ' port: ' + str(port) + ' mac: ' + mac + '\n')
        elif (c[3]==16):
          print 'FOUT ip:', host, 'port:', port, 'mac:', mac
          f.write('FOUT ip: ' + host + ' port: ' + str(port) + ' mac: ' + mac + '\n')
        elif (c[3]==17):
          print 'EVR ip: ', host, 'port:', port, 'mac:', mac
          f.write('EVR ip:  ' + host + ' port: ' + str(port) + ' mac: ' + mac + '\n')
        elif (c[3]==18):
          print 'EVG ip: ', host, 'port:', port, 'mac:', mac
          f.write('EVG ip:  ' + host + ' port: ' + str(port) + ' mac: ' + mac + '\n')
        break

    if (ok == 0):
      print 'NO ANS ip: ', host, 'mac:', mac
      f.write('NO ANS ip:  ' + host + ' mac: ' + mac + '\n')

elapsed_time = time.time() - start_time
print 'Elapsed time:', elapsed_time, 'sec'
  
f.close()
