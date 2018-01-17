########################### Run in python 2 ###########################

# Find timing modules in a subnetwork

import numpy as np
import time
import socket
import sys
import subprocess

WAIT = 0.005

if (len(sys.argv) == 1):
  ipsub_list = ['10.0.18','10.0.17','10.2.118','10.2.117']
else:
  ipsub_list = sys.argv[1:]
  
port_ini = 50111
port_end = 50128
ip_ini = 2
ip_end = 254

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
  sock.sendto(cmd, (UDP_IP, UDP_PORT))
  time.sleep(WAIT)
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
  return ok, regA, regB, regC, addr
  
ok = 0
port_list = range(port_ini,port_end+1)
ipaddr_list = range(ip_ini,ip_end+1)
start_time = time.time()
for ipsub in ipsub_list:
  print 'Searching for timing modules in subnet', ipsub
  for port in port_list:
    for ipaddr in ipaddr_list:
      ip = ipsub+'.'+str(ipaddr)
      ok, a, b, c, addr = FindMod(ip, port)
      if ((ok==1) & (c[3]!=0)):
        port_list.remove(port)
        if (c[3]==32):
          print 'EVE ip:', addr[0], 'port:', addr[1]
          f.write('EVE ip: ' + addr[0] + ' port: ' + str(addr[1]) + '\n')
        elif (c[3]==16):
          print 'FOUT ip:', addr[0], 'port:', addr[1]
          f.write('FOUT ip: ' + addr[0] + ' port: ' + str(addr[1]) + '\n')
        elif (c[3]==17):
          print 'EVR ip:', addr[0], 'port:', addr[1]
          f.write('EVR ip: ' + addr[0] + ' port: ' + str(addr[1]) + '\n')
        elif (c[3]==18):
          print 'EVG ip:', addr[0], 'port:', addr[1]
          f.write('EVG ip: ' + addr[0] + ' port: ' + str(addr[1]) + '\n')
        break

elapsed_time = time.time() - start_time
print 'Elapsed time:', elapsed_time, 'sec'
  
f.close()
