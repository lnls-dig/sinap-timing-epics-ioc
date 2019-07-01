#!/usr/bin/python3.5
########################### Run in python 3 ###########################

# Find timing modules in a subnetwork

import time
import socket
import sys
import telnetlib

############################# Functions ###############################
def FindMod(UDP_IP, UDP_PORT):
  # Read
  funsel = [16, 17, 18, 32]
  addr = (UDP_IP, UDP_PORT)
  
  try:
    sock = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
    sock.settimeout(WAIT)
    sock.bind(('', UDP_PORT))
  except:
    ok = 0
    addr = ('0.0.0.0', 0)
    regA = regB = regC = [0, 0, 0, 0]
    return ok, 0, hex(0), addr
    
  # Try read module function
  reg = 63
  ok = 0
  func = 0
  commit = hex(0)
  cmd = bytes([0x80|reg]+[0]+[0]+[0]+[0]+[0]+[0]+[0]+[0]+[0]+[0]+[0]+[0])

  for i in range(NrTry):

    sock.sendto(cmd, addr)
    time.sleep(WAIT)

    try: 
      data, addr = sock.recvfrom(13) # buffer size is 13 bytes
      regA = [data[1],data[2],data[3],data[4]]
      regB = [data[5],data[6],data[7],data[8]]
      regC = [data[9],data[10],data[11],data[12]]
      if (regC[3] in funsel):
        func = regC[3]
        ok = 1
      # Read firmware version
      reg = 62
      cmd = bytes([0x80|reg]+[0]+[0]+[0]+[0]+[0]+[0]+[0]+[0]+[0]+[0]+[0]+[0])
      sock.sendto(cmd, addr)
      time.sleep(WAIT)
      data, addr = sock.recvfrom(13) # buffer size is 13 bytes
      value = 0
      for regnum in range(11):
        value = value | data[regnum+1]<<(8*(11-regnum))
      commit = hex(value)
    except:
      #print('aqui',UDP_PORT)
      ok = 0
      regA = regB = regC = [0, 0, 0, 0]

    if (ok == 1):
      break

  sock.close()
  return ok, func, commit, addr
  
############################# End Functions############################

WAIT = 0.05
NrTry = 3 

if (len(sys.argv) == 1):
  print('Missing subnet argument: Find_Modules3.py subnet1 subnet2 ... subnetN')
  ipsub_list = ['10.0.18']
  #exit()
else:
  ipsub_list = sys.argv[1:]
  
hw_map = open('mac_to_serial.csv','r')

mac_to_serial = {} # empty dictionary

for line in hw_map:
    mac = line.split(';')[0]
    serial = line.split(';')[1][0:-1]
    if (mac == ''):
      continue
    mac_to_serial[mac] = serial
    
hw_map.close()
    
f = open('Find_Modules.log','w')

start_time = time.time()

for ipsub in ipsub_list:
  print('Searching for timing modules in subnet', ipsub)

  # Searching for Lantronix modules, telnet port 9999
  for i in range(2,255):
    addr = (ipsub+'.'+str(i),9999)
    host = ipsub+'.'+str(i)

    try:
      tn = telnetlib.Telnet(host, 9999, WAIT)
    except:
      continue

    ans = str(tn.read_until(bytes('\0','ascii'),1))
    if ('MAC address' in ans):
      mac = ans.split(' ')[2].split('\\')[0]
    else:
      mac = '00:00:00:00:00:00'

    tn.write(bytes('\r','ascii'))
    ans_raw = tn.read_until(bytes('\0','ascii'),1)
    if (len(str(ans_raw,'utf-8')) < 1000):
      continue
    ans = str(ans_raw).replace(' ','')
    
    dhcpname = ans.split('DHCPdevicename:')[1].split('\\n')[0]
    ans = ans.split('Channel1')[1]
    ans = ans.split('Port')[1]
    ans = ans.split('\\r')[0]
    port = int(ans)
  
    ok, func, commit, addr = FindMod(host, port)
    if ((ok==1) & (func!=0)):
      if (func==32):
        print ('   EVE ip:', host.ljust(15), 'port:', port, 'mac:', mac, 'gateware commit:', commit, 'serial number:', mac_to_serial[mac], 'DHCP Name:', dhcpname)
        f.write('   EVE ip: ' + host.ljust(15) + ' port: ' + str(port) + ' mac: ' + mac + 'gateware commit:' + commit + '\n')
      elif (func==16):
        print ('  FOUT ip:', host.ljust(15), 'port:', port, 'mac:', mac, 'gateware commit:', commit, 'serial number:', mac_to_serial[mac], 'DHCP Name:', dhcpname)
        f.write('  FOUT ip: ' + host.ljust(15) + ' port: ' + str(port) + ' mac: ' + mac + 'gateware commit:' + commit + '\n')
      elif (func==17):
        print ('   EVR ip:', host.ljust(15), 'port:', port, 'mac:', mac, 'gateware commit:', commit, 'serial number:', mac_to_serial[mac], 'DHCP Name:', dhcpname)
        f.write('   EVR ip:  ' + host.ljust(15) + ' port: ' + str(port) + ' mac: ' + mac + 'gateware commit:' + commit + '\n')
      elif (func==18):
        print ('   EVG ip:', host.ljust(15), 'port:', port, 'mac:', mac, 'gateware commit:', commit, 'serial number:', mac_to_serial[mac], 'DHCP Name:', dhcpname)
        f.write('   EVG ip:  ' + host.ljust(15) + ' port: ' + str(port) + ' mac: ' + mac + 'gateware commit:' + commit + '\n')

    if (ok == 0):
      if (mac in mac_to_serial):
        print ('NO ANS ip:', host.ljust(15), 'port:', port, 'mac:', mac, 'serial number:', mac_to_serial[mac], 'DHCP Name:', dhcpname)
      else:
        print ('NO ANS ip:', host.ljust(15), 'port:', port, 'mac:', mac, 'DHCP Name:', dhcpname)
      f.write('NO ANS ip:  ' + host.ljust(15) + ' port: ' + str(port) + ' mac: ' + mac + '\n')

elapsed_time = time.time() - start_time
print ('Elapsed time:', elapsed_time, 'sec')
  
f.close()
