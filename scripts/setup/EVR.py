import time
import socket


EVR = "10.0.18.65"
UDP_PORT = 50118

sock = socket.socket(socket.AF_INET, # Internet
                     socket.SOCK_DGRAM) # UDP

sock.bind(('', UDP_PORT))

def EvoWrite(UDP_IP, add, regA, regB, regC):
    # Write
    cmd = chr(0x40|add)+chr(regA[0])+chr(regA[1])+chr(regA[2])+chr(regA[3])+chr(regB[0])+chr(regB[1])+chr(regB[2])+chr(regB[3])+chr(regC[0])+chr(regC[1])+chr(regC[2])+chr(regC[3])
    sock.sendto(cmd, (UDP_IP, UDP_PORT))
    time.sleep(0.001)

def EvoRead(UDP_IP, add):
    # Read
    cmd = chr(0x80|add)+chr(0)+chr(0)+chr(0)+chr(0)+chr(0)+chr(0)+chr(0)+chr(0)+chr(0)+chr(0)+chr(0)+chr(0)
    sock.sendto(cmd, (UDP_IP, UDP_PORT))
    data, addr = sock.recvfrom(13) # buffer size is 13 bytes
    #print "received from:", addr
    #print "reg",ord(data[0])&0x3f
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

        print ('EVG -> IP address: ', UDP_IP, '\tPort: ', UDP_PORT)
        print ('EVG enable: ', bool(EVGEN))
        print ('RF input: ', bool(RFINS), '\tRF divider: ', RFDIV)
        print ('AC line enable: ', bool(ACEN), '\tAC line divider: ', ACDIV)
        print ('SEQRAM enable: ', bool(SEQEN), '\tSEQRAM Status: ', SEQS, '\tSEQRAM Count: ', SEQCOUNT)
        for i in range(8):
            print ('Clock output '+str(i)+' -> Enable: ', MUXEN[i], '\tDivider: ', MUXDIV[i])

def EvoEvrSet(UDP_IP):
    add = 63

    regA = [0,0,0,0]
    regB = [0,0,0,16]
    regC = [0,0,0,17]

    EvoWrite(UDP_IP, add, regA, regB, regC)

def EvoEvrOTPSet(UDP_IP, chn, delay, width, polarity, event, en, time, pulses):
    add = chn + 1

    regA = [(en<<7)+(polarity<<6)+(time<<5),pulses>>8&0xff,pulses&0xff,event]
    regB = [delay>>24&0xff,delay>>16&0xff,delay>>8&0xff,delay&0xff]
    regC = [width>>24&0xff,width>>16&0xff,width>>8&0xff,width&0xff]
    EvoWrite(UDP_IP, add, regA, regB, regC)

def EvoEvrFPSet(UDP_IP, chn, source, finedelay, rfdelay, interlock):
    add = chn + 17

    regA = [(interlock<<7),0,0,source]
    regB = [0,0,(finedelay&0b1100000000)>>8,finedelay&0xff]
    regC = [0,0,0,rfdelay]
    EvoWrite(UDP_IP, add, regA, regB, regC)

def EvoEvrEnable(UDP_IP):
    add = 0

    regA = [0,0,0,0]
    regB = [0,0,0,0]
    regC = [0,0,0,0]
    EvoWrite(UDP_IP, add, regA, regB, regC)

    regA = [0,0,0,0]
    regB = [0,0,0,0]
    regC = [0,0,0,1]
    EvoWrite(UDP_IP, add, regA, regB, regC)

# Set as EVR
EvoEvrSet(EVR)
"""
# OTP 0
EvoEvrOTPSet(EVR, 0, 0, 5, 1, 1, 1)

# OTP 1
EvoEvrOTPSet(EVR, 1, 0, 5, 1, 2, 1)

# OTP 2
EvoEvrOTPSet(EVR, 2, 0, 5, 0, 3, 1)

# OTP 3
EvoEvrOTPSet(EVR, 3, 0, 5, 0, 4, 1)

# OTP 4
EvoEvrOTPSet(EVR, 4, 0, 5, 0, 5, 1)

# OTP 5
EvoEvrOTPSet(EVR, 5, 0, 5, 0, 6, 1)

# OTP 6
EvoEvrOTPSet(EVR, 6, 0, 5, 0, 7, 1)

# OTP 7
EvoEvrOTPSet(EVR, 7, 0, 5, 0, 8, 1)

# OTP 8
EvoEvrOTPSet(EVR, 8, 0, 30000000, 0, 1, 1)

# OTP 9
EvoEvrOTPSet(EVR, 9, 0, 30000000, 0, 2, 1)

# OTP A
EvoEvrOTPSet(EVR, 10, 0, 30000000, 0, 3, 1)

# OTP B
EvoEvrOTPSet(EVR, 11, 0, 30000000, 0, 4, 1)

# OTP C
EvoEvrOTPSet(EVR, 12, 0, 30000000, 0, 5, 1)

# OTP D
EvoEvrOTPSet(EVR, 13, 0, 30000000, 0, 6, 1)

# OTP E
EvoEvrOTPSet(EVR, 14, 0, 30000000, 0, 7, 1)

# OTP F
EvoEvrOTPSet(EVR, 15, 0, 30000000, 0, 8, 1)

# Front Panel 0
EvoEvrFPSet(EVR, 0, 0x23, 0, 0, 0)

# Front Panel 1
EvoEvrFPSet(EVR, 1, 0x24, 0, 0, 0)

# Front Panel 2
EvoEvrFPSet(EVR, 2, 0x25, 0, 0, 0)

# Front Panel 3
EvoEvrFPSet(EVR, 3, 0x26, 0, 0, 0)

# Front Panel 4
EvoEvrFPSet(EVR, 4, 0x20, 0, 0, 0)

# Front Panel 5
EvoEvrFPSet(EVR, 5, 0x21, 0, 0, 0)

# Front Panel 6
EvoEvrFPSet(EVR, 6, 0x22, 0, 0, 0)

# Front Panel 7
EvoEvrFPSet(EVR, 7, 0x23, 0, 0, 0)
"""
EvoEvrEnable(EVR)

#def EvoEvrOTPSet(UDP_IP, chn, delay, width, polarity, event, en, time, pulses):
RF = 477999000.0
width = 0.0008
pulses = 10
w = int(width*RF/(8))

EvoEvrOTPSet(EVR, 0, 0, w, 0, 1, 1, 0, pulses)
EvoEvrOTPSet(EVR, 1, 0, w, 0, 1, 1, 0, pulses)

"""

EvoWrite(EVR, 51, [0,0,0,0], [0,0,0,0], [0,0,0,2]) # time update source

#EvoWrite(EVR, 52, [0,0,0,0], [0,0,0,0], [0,0,0,0b01000000]) # pull timestamp log fifo
#EvoWrite(EVR, 52, [0,0,0,0], [0,0,0,0], [0,0,0,0]) # pull timestamp log fifo

regA, regB, regC = EvoRead(EVR, 51)
print regA, regB, regC

regA, regB, regC = EvoRead(EVR, 52)
print regA, regB, regC

regA, regB, regC = EvoRead(EVR, 62)
print hex(regA[0]), hex(regA[1]), hex(regA[2]), hex(regA[3]),hex(regB[0]), hex(regB[1]), hex(regB[2]), hex(regB[3]),hex(regC[0]), hex(regC[1]), hex(regC[2]), hex(regC[3]),

print "EVR log\n"
for i in range(1):
    #time.sleep(0.5)

    EvoWrite(EVR, 52, [0,0,0,0], [0,0,0,0], [0,0,0,32]) # pull timestamp log fifo

    regA, regB, regC = EvoRead(EVR, 52)
    utc = regA[0]*2**24+regA[1]*2**16+regA[2]*2**8+regA[3]
    subsecond = regB[0]*2**24+regB[1]*2**16+regB[2]*2**8+regB[3]
    print 'sec:', utc, 'nanosec:', subsecond*8, 'event:', regC[0], 'log number:', (regC[1]<<8)+regC[2]
"""
