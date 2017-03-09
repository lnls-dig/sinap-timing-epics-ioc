########################### Run in python 2 ###########################

# Find timing modules in a subnetwork

import numpy as np
import time
import socket

WAIT = 0.005

ipsub = '10.0.18.'
port_ini = 50111
port_end = 50128
ip_ini = 2
ip_end = 150

def FindMod(UDP_IP, UDP_PORT):
	# Read
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
		if ((regC[3]&0b11) in range(0,3)):
			ok = 1
	except:
		ok = 0
		addr = 0
		regA = regB = regC = [0, 0, 0, 0]
	return ok, regA, regB, regC, addr
	
ok = 0
for port in range(port_ini,port_end+1):
	for ipend in range(ip_ini,ip_end+1):
		ip = ipsub+str(ipend)
		ok, a, b, c, addr = FindMod(ip, port)
		if ((ok==1) & (c[3]!=0)):
			if (c[3]==32):
				print('EVE ip ', addr)
			elif (c[3]==16):
				print('EVO/FOUT ip ', addr)
			elif (c[3]==17):
				print('EVO/EVR ip ', addr)
			elif (c[3]==18):
				print('EVO/EVG ip ', addr)
			break
