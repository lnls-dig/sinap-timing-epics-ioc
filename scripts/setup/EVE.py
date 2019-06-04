#import numpy as np
import time
import socket

EVE1 = "10.0.18.121" #P1816002
EVE2 = "10.0.18.122" #P1816004
EVE3 = "10.0.18.118" #P1816003

EVE = EVE1
UDP_PORT = 50121

sock = socket.socket(socket.AF_INET, # Internet
                     socket.SOCK_DGRAM) # UDP

sock.settimeout(1.0)
sock.bind(("", UDP_PORT))

def EvoWrite(UDP_IP, add, regA, regB, regC):
	# Write
	cmd = chr(0x40|add)+chr(regA[0])+chr(regA[1])+chr(regA[2])+chr(regA[3])+chr(regB[0])+chr(regB[1])+chr(regB[2])+chr(regB[3])+chr(regC[0])+chr(regC[1])+chr(regC[2])+chr(regC[3])
	sock.sendto(cmd, (UDP_IP, UDP_PORT))
	time.sleep(0.001)	

def EvoRead(UDP_IP, add):
	# Read
	cmd = chr(0x80|add)+chr(0)+chr(0)+chr(0)+chr(0)+chr(0)+chr(0)+chr(0)+chr(0)+chr(0)+chr(0)+chr(0)+chr(0)
	sock.sendto(cmd, (UDP_IP, UDP_PORT))
	data, addr = sock.recvfrom(13) # buffer size of 13 bytes
	#print "received from:", addr
	#print "reg",bin(ord(data[0]))
	regA = [(ord(data[1])),(ord(data[2])),(ord(data[3])),(ord(data[4]))]
	regB = [(ord(data[5])),(ord(data[6])),(ord(data[7])),(ord(data[8]))]
	regC = [(ord(data[9])),(ord(data[10])),(ord(data[11])),(ord(data[12]))]
	return regA, regB, regC
	
def EvoReadStatus(UDP_IP):
	regA, regB, regC = EvoRead(UDP_IP, 63) # Configuration Register
	# function selection
	# 0 -> FOUT, 1 -> EVR, 2 -> EVG
	FUNSEL = (regC[3] & 0b11)
	if (FUNSEL == 2): # EVG
		RFDIV = (regB[1] & 0b1111) + 1
		#======================= Control and Status Register
		regA, regB, regC = EvoRead(UDP_IP, 0) 
		EVGEN = regC[3] & 0b1
		SEQEN = regC[3] & 0b10
		SEQS = (regC[2] & 0b11000)>>3
		RFINS = regC[2] >> 5
		
		#======================= AC line setting Register
		regA, regB, regC = EvoRead(UDP_IP, 40) 
		ACEN = regA[3] & 0b1
		ACDIV = (regC[0]<<24)+(regC[1]<<16)+(regC[2]<<8)+regC[3] + 1
		
		#======================= MUX0 setting Register
		MUXEN = [0,0,0,0,0,0,0,0]
		MUXDIV = [0,0,0,0,0,0,0,0]
		for i in range(8):
			regA, regB, regC = EvoRead(UDP_IP, 41+i) 
			MUXEN[i] = regA[2] & 0b1
			MUXDIV[i] = (regC[0]<<24)+(regC[1]<<16)+(regC[2]<<8)+regC[3] + 1
		
		#======================= SEQRAM switch Register
		regA, regB, regC = EvoRead(UDP_IP, 50) 
		SEQCOUNT = ((regC[2]&0b111111)<<8)+regC[3]
		
		print 'EVG -> IP address: ', UDP_IP, '\tPort: ', UDP_PORT
		print 'EVG enable: ', bool(EVGEN)
		print 'RF input: ', bool(RFINS), '\tRF divider: ', RFDIV
		print 'AC line enable: ', bool(ACEN), '\tAC line divider: ', ACDIV
		print 'SEQRAM enable: ', bool(SEQEN), '\tSEQRAM Status: ', SEQS, '\tSEQRAM Count: ', SEQCOUNT
		for i in range(8):
			print 'Clock output '+str(i)+' -> Enable: ', MUXEN[i], '\tDivider: ', MUXDIV[i]

def EvoEvrSet(UDP_IP):
	add = 63

	regA = [0,0,0,0]
	regB = [0,0,0,16]
	regC = [0,0,0,0b100000]

	EvoWrite(UDP_IP, add, regA, regB, regC)
	
	add = 25

	regA = [0,0,0,0]
	regB = [0,0,0,0]
	regC = [0,0,0,3] # 1=x1 2=x2 3=x4 4=x5 5=x10

	EvoWrite(UDP_IP, add, regA, regB, regC)
	
def EvoEvrOTPSet(UDP_IP, chn, delay, width, polarity, event, en, time):
	add = chn + 1

	regA = [(en<<7)+(polarity<<6)+(time<<5),0,0,event]
	regB = [delay>>24&0xff,delay>>16&0xff,delay>>8&0xff,delay&0xff]
	regC = [width>>24&0xff,width>>16&0xff,width>>8&0xff,width&0xff]
	EvoWrite(UDP_IP, add, regA, regB, regC)
	
def EvoEvrFPSet(UDP_IP, chn, source, finedelay, rfdelay, interlock):
	add = chn + 17

	regA = [(interlock<<7),0,0,source]
	regB = [0,0,(finedelay&0b1100000000)>>8,finedelay&0xff]
	regC = [0,0,0,rfdelay]
	EvoWrite(UDP_IP, add, regA, regB, regC)
	
def EvoEvrEnable(UDP_IP, en):
	add = 0

	regA = [0,0,0,0]
	regB = [0,0,0,0]
	regC = [0,0,0,en]
	EvoWrite(UDP_IP, add, regA, regB, regC)
	
"""
# Set clockmode and rf recovery
EvoEvrSet(EVE)

# OTP 0
EvoEvrOTPSet(EVE, 0, 0, 5, 0, 1, 1)

# OTP 1
EvoEvrOTPSet(EVE, 1, 0, 5, 0, 2, 1)

# OTP 2
EvoEvrOTPSet(EVE, 2, 0, 5, 0, 3, 1)

# OTP 3
EvoEvrOTPSet(EVE, 3, 0, 5, 0, 4, 1)

# OTP 4
EvoEvrOTPSet(EVE, 4, 0, 5, 0, 5, 1)

# OTP 5
EvoEvrOTPSet(EVE, 5, 0, 5, 0, 6, 1)

# OTP 6
EvoEvrOTPSet(EVE, 6, 0, 5, 0, 7, 1)

# OTP 7
EvoEvrOTPSet(EVE, 7, 0, 5, 0, 8, 1)

# OTP 8
EvoEvrOTPSet(EVE, 8, 0, 30000000, 0, 1, 1)

# OTP 9
EvoEvrOTPSet(EVE, 9, 0, 30000000, 0, 2, 1)

# OTP A
EvoEvrOTPSet(EVE, 10, 0, 30000000, 0, 3, 1)

# OTP B
EvoEvrOTPSet(EVE, 11, 0, 30000000, 0, 4, 1)

# OTP C
EvoEvrOTPSet(EVE, 12, 0, 250000/2, 0, 1, 1)

# OTP D
EvoEvrOTPSet(EVE, 13, 0, 30000000, 0, 6, 1)

# OTP E
EvoEvrOTPSet(EVE, 14, 0, 30000000, 0, 7, 1)

# OTP F
EvoEvrOTPSet(EVE, 15, 0, 30000000, 0, 8, 1)

# Front Panel 0
EvoEvrFPSet(EVE, 0, 0x26, 0, 0, 0)

# Front Panel 1
EvoEvrFPSet(EVE, 1, 0x12, 0, 0, 0)

# Front Panel 2
EvoEvrFPSet(EVE, 2, 0x1c, 0, 0, 0)

# Front Panel 3
EvoEvrFPSet(EVE, 3, 0x23, 0, 0, 0)

# Front Panel 4
EvoEvrFPSet(EVE, 4, 0x23, 0, 0, 0)

# Front Panel 5
EvoEvrFPSet(EVE, 5, 0x23, 0, 0, 0)

# Front Panel 6
EvoEvrFPSet(EVE, 6, 0x23, 0, 0, 0)

# Front Panel 7
EvoEvrFPSet(EVE, 7, 0x23, 0, 0, 0)

EvoEvrEnable(EVE, 1)
"""

#def EvoEvrOTPSet(UDP_IP, chn, delay, width, polarity, event, en, time):
EvoEvrOTPSet(EVE, 0, 0, 30000000, 0, 2, 1, 1)
EvoEvrOTPSet(EVE, 1, 0, 30000000, 0, 3, 1, 1)

EvoWrite(EVE, 51, [0,0,0,0], [0,0,0,0], [0,0,0,2]) # time update source

#EvoWrite(EVE, 52, [0,0,0,0], [0,0,0,0], [0,0,0,0b01000000]) # pull timestamp log fifo
#EvoWrite(EVE, 52, [0,0,0,0], [0,0,0,0], [0,0,0,0]) # pull timestamp log fifo

regA, regB, regC = EvoRead(EVE, 51)
print regA, regB, regC

regA, regB, regC = EvoRead(EVE, 52)
print regA, regB, regC

regA, regB, regC = EvoRead(EVE, 62)
print hex(regA[0]), hex(regA[1]), hex(regA[2]), hex(regA[3]),hex(regB[0]), hex(regB[1]), hex(regB[2]), hex(regB[3]),hex(regC[0]), hex(regC[1]), hex(regC[2]), hex(regC[3]),

print "EVE log\n"
for i in range(1):
	#time.sleep(0.5)

	EvoWrite(EVE, 52, [0,0,0,0], [0,0,0,0], [0,0,0,32]) # pull timestamp log fifo

	regA, regB, regC = EvoRead(EVE, 52)
	utc = regA[0]*2**24+regA[1]*2**16+regA[2]*2**8+regA[3]
	subsecond = regB[0]*2**24+regB[1]*2**16+regB[2]*2**8+regB[3]
	print 'sec:', utc, 'nanosec:', subsecond*8, 'event:', regC[0], 'log number:', (regC[1]<<8)+regC[2]


"""
utc = 0
regA, regB, regC = EvoRead(EVE, 51) # Configuration Register
utc = regA[0]*2**24+regA[1]*2**16+regA[2]*2**8+regA[3]
while 1:
	#time.sleep(0.1)
	regA, regB, regC = EvoRead(EVE, 51) # Configuration Register
	if (utc != (regA[0]*2**24+regA[1]*2**16+regA[2]*2**8+regA[3])):
		print "EVE timestamp:", regA[0]*2**24+regA[1]*2**16+regA[2]*2**8+regA[3], int(time.time()), regB[0]*2**24+regB[1]*2**16+regB[2]*2**8+regB[3]
		utc = regA[0]*2**24+regA[1]*2**16+regA[2]*2**8+regA[3]


"""
