########################### Run in python 2 ###########################

import time
import socket

EVG = '10.0.18.55'
UDP_PORT = 50116
WAIT = 0.001

sock = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
sock.settimeout(1)
sock.bind(('', UDP_PORT))

def EvoWrite(UDP_IP, add, regA, regB, regC):
    # Write
    cmd = chr(0x40|add)+chr(regA[0])+chr(regA[1])+chr(regA[2])+chr(regA[3])+chr(regB[0])+chr(regB[1])+chr(regB[2])+chr(regB[3])+chr(regC[0])+chr(regC[1])+chr(regC[2])+chr(regC[3])
    sock.sendto(cmd, (UDP_IP, UDP_PORT))
    time.sleep(WAIT)

def EvoRead(UDP_IP, add):
    # Read
    while True:

        cmd = chr(0x80|add)+chr(0)+chr(0)+chr(0)+chr(0)+chr(0)+chr(0)+chr(0)+chr(0)+chr(0)+chr(0)+chr(0)+chr(0)
        sock.sendto(cmd, (UDP_IP, UDP_PORT))
        time.sleep(WAIT)
        try:
            data, addr = sock.recvfrom(13) # buffer size is 13 bytes
            regA = [(ord(data[1])),(ord(data[2])),(ord(data[3])),(ord(data[4]))]
            regB = [(ord(data[5])),(ord(data[6])),(ord(data[7])),(ord(data[8]))]
            regC = [(ord(data[9])),(ord(data[10])),(ord(data[11])),(ord(data[12]))]
            break
        except KeyboardInterrupt:
            break
        except:
            print( 'Error reading address', add)
            time.sleep(WAIT)
            continue
    return regA, regB, regC

def EvoReadStatus(UDP_IP):
    regA, regB, regC = EvoRead(UDP_IP, 63) # Configuration Register
    # function selection
    # 0 -> FOUT, 1 -> EVR, 2 -> EVG
    time_delay = (regC[0]<<8)+regC[1]
    evt_rec = (regC[2])
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
            MUXEN[i] = regA[3] & 0b1
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
        print ('Time delay: ', time_delay)
        print ('Evt rec: ', bin(evt_rec))

def EvoEvgSet(UDP_IP, RFDIV):
    add = 63

    regA = [0,0,0,0]
    regB = [0,RFDIV-1,0,0]
    regC = [0,0,0,18]

    EvoWrite(UDP_IP, add, regA, regB, regC)

def EvoDelaySet(UDP_IP, ch, rfdelay, finedelay):
    add = 17 + ch

    regA = [0,0,0,0]
    regB = [0,0,finedelay>>8&0xff,finedelay&0xff]
    regC = [0,0,0,rfdelay]

    EvoWrite(UDP_IP, add, regA, regB, regC)

def EvoEvrSet(UDP_IP):
    add = 63

    regA = [0,0,0,0]
    regB = [0,0,0,16]
    regC = [0,0,0,17]

    EvoWrite(UDP_IP, add, regA, regB, regC)

def EvoEvgSEQRAMIdle(UDP_IP, num_evt, evt, evt_end):
    regA, regB, regC = EvoRead(UDP_IP, 0)
    SEQEN = regC[3] & 0b10

    if (SEQEN == '1'):
        print ('Impossible to set Idle SEQRAM.')
        return

    print ('Setting Idle SEQRAM...')

    add = 49
    seqadd = 0
    delta = 500000
    delay = 0
    print seqadd, EvoRead(UDP_IP, 50)

    # Setting SEQRAM
    for i in range(num_evt):
        delay = delay + delta
        regA = [0,0,seqadd>>8&0xff,seqadd&0xff]
        regB = [0,0,0,evt]
        regC = [delay>>24&0xff,delay>>16&0xff,delay>>8&0xff,delay&0xff]
        EvoWrite(UDP_IP, add, regA, regB, regC)
        seqadd = seqadd + 1
        print ((seqadd>>8&0xff)|(seqadd&0xff), EvoRead(UDP_IP, 49))

    delay = delay+delta
    evt = evt_end
    regA = [0,0,seqadd>>8&0xff,seqadd&0xff]
    regB = [0,0,0,evt]
    regC = [delay>>24&0xff,delay>>16&0xff,delay>>8&0xff,delay&0xff]
    EvoWrite(UDP_IP, add, regA, regB, regC)
    seqadd = seqadd + 1

    #print (seqadd, EvoRead(UDP_IP, 50))

def EvoEvgSEQRAMInject(UDP_IP, buklen):
    regA, regB, regC = EvoRead(UDP_IP, 0)
    SEQEN = regC[3] & 0b10

    if (SEQEN == '0') | (SEQEN == '2'):
        print ('Impossible to set Injection SEQRAM.')
        return

    print ('Setting Injection SEQRAM for', buklen, 'buckets.')

    add = 49
    seqadd = 0
    totaltime = time.time()
    for i in range(buklen):

        delay = 100
        print ('Bucket', i+1)
        # Setting SEQRAM
        delay = delay + 10
        evt = 1
        regA = [0,0,seqadd>>8&0xff,seqadd&0xff]
        regB = [0,0,0,evt]
        regC = [delay>>24&0xff,delay>>16&0xff,delay>>8&0xff,delay&0xff]
        EvoWrite(UDP_IP, add, regA, regB, regC)

        seqadd = seqadd + 1

        delay = delay + 10
        evt = 2
        regA = [0,0,seqadd>>8&0xff,seqadd&0xff]
        regB = [0,0,0,evt]
        regC = [delay>>24&0xff,delay>>16&0xff,delay>>8&0xff,delay&0xff]
        EvoWrite(UDP_IP, add, regA, regB, regC)

        seqadd = seqadd + 1

        delay = delay + 10
        evt = 3
        regA = [0,0,seqadd>>8&0xff,seqadd&0xff]
        regB = [0,0,0,evt]
        regC = [delay>>24&0xff,delay>>16&0xff,delay>>8&0xff,delay&0xff]
        EvoWrite(UDP_IP, add, regA, regB, regC)

        seqadd = seqadd + 1

        delay = delay + 10
        evt = 4
        regA = [0,0,seqadd>>8&0xff,seqadd&0xff]
        regB = [0,0,0,evt]
        regC = [delay>>24&0xff,delay>>16&0xff,delay>>8&0xff,delay&0xff]
        EvoWrite(UDP_IP, add, regA, regB, regC)

        seqadd = seqadd + 1

        delay = delay + 10
        evt = 5
        regA = [0,0,seqadd>>8&0xff,seqadd&0xff]
        regB = [0,0,0,evt]
        regC = [delay>>24&0xff,delay>>16&0xff,delay>>8&0xff,delay&0xff]
        EvoWrite(UDP_IP, add, regA, regB, regC)

        seqadd = seqadd + 1

        delay = delay + 10
        evt = 6
        regA = [0,0,seqadd>>8&0xff,seqadd&0xff]
        regB = [0,0,0,evt]
        regC = [delay>>24&0xff,delay>>16&0xff,delay>>8&0xff,delay&0xff]
        EvoWrite(UDP_IP, add, regA, regB, regC)

        seqadd = seqadd + 1

        delay = delay + 10
        evt = 7
        regA = [0,0,seqadd>>8&0xff,seqadd&0xff]
        regB = [0,0,0,evt]
        regC = [delay>>24&0xff,delay>>16&0xff,delay>>8&0xff,delay&0xff]
        EvoWrite(UDP_IP, add, regA, regB, regC)

        seqadd = seqadd + 1

        delay = delay + 10
        evt = 8
        regA = [0,0,seqadd>>8&0xff,seqadd&0xff]
        regB = [0,0,0,evt]
        regC = [delay>>24&0xff,delay>>16&0xff,delay>>8&0xff,delay&0xff]
        EvoWrite(UDP_IP, add, regA, regB, regC)

        seqadd = seqadd + 1

        delay = delay + 10
        evt = 0x40 + i
        regA = [0,0,seqadd>>8&0xff,seqadd&0xff]
        regB = [0,0,0,evt]
        regC = [delay>>24&0xff,delay>>16&0xff,delay>>8&0xff,delay&0xff]
        EvoWrite(UDP_IP, add, regA, regB, regC)

        seqadd = seqadd + 1

        delay = delay+10
        evt = 0x70
        regA = [0,0,seqadd>>8&0xff,seqadd&0xff]
        regB = [0,0,0,evt]
        regC = [delay>>24&0xff,delay>>16&0xff,delay>>8&0xff,delay&0xff]
        EvoWrite(UDP_IP, add, regA, regB, regC)

    evt = 0x7E
    regA = [0,0,seqadd>>8&0xff,seqadd&0xff]
    regB = [0,0,0,evt]
    regC = [delay>>24&0xff,delay>>16&0xff,delay>>8&0xff,delay&0xff]
    EvoWrite(UDP_IP, add, regA, regB, regC)
    totaltime = time.time() - totaltime
    print ('Time to charge', buklen, 'buckets to injection table ', totaltime, 'secs (', totaltime/buklen, 'secs per bucket).' )

def EvoEvgSEQRAMSwitch(UDP_IP):
    add = 50

    regA = [0,0,0,0]
    regB = [0,0,0,0]
    regC = [0,0,0,0]
    EvoWrite(UDP_IP, add, regA, regB, regC)

def EvoEvgEnable(UDP_IP, seqen, evgen):
    add = 0

    regA = [0,0,0,0]
    regB = [0,0,0,0]
    regC = [0,0,0,2*seqen+evgen]
    EvoWrite(UDP_IP, add, regA, regB, regC)

def EvoEvgSetACLine(UDP_IP, div, en):
    add = 40
    acdiv = div-1
    regA = [0,0,0,en>0]
    regB = [0,0,0,0]
    regC = [acdiv>>24&0xff,acdiv>>16&0xff,acdiv>>8&0xff,acdiv&0xff]
    EvoWrite(UDP_IP, add, regA, regB, regC)

def EvoEvgSetMUX(UDP_IP, mux, div, en):
    add = 41 + mux
    regA = [0,0,0,en]
    regB = [0,0,0,0]
    regC = [div>>24&0xff,div>>16&0xff,div>>8&0xff,div&0xff]
    EvoWrite(UDP_IP, add, regA, regB, regC)

# Set as EVG
# EVG disable
EvoEvgEnable(EVG, 0, 0)
time.sleep(0.1)

rfdiv = 4
EvoEvgSet(EVG,rfdiv)

# EVG enable
EvoEvgEnable(EVG, 1, 1)
time.sleep(0.1)

EvoReadStatus(EVG)


# Set MUX
EvoEvgSetMUX(EVG, 0, 206, 1)
EvoEvgSetMUX(EVG, 1, 215, 1)
EvoEvgSetMUX(EVG, 2, 4967, 1)
EvoEvgSetMUX(EVG, 3, 1, 1)
EvoEvgSetMUX(EVG, 4, 2, 1)
EvoEvgSetMUX(EVG, 5, 3, 1)
EvoEvgSetMUX(EVG, 7, 4967, 1)

#EvoReadStatus(EVG)

# Turn on AC line
EvoEvgSetACLine(EVG, 30, 1)

# EVG Enable
#EvoEvgEnable(EVG, 1, 1)

# Set Idle SEQRAM
num_evt = 1 # number of 0x67 events in seqram
EvoEvgSEQRAMIdle(EVG, num_evt, 0x0, 0x7f)

# Start SEQRAM
EvoEvgSEQRAMSwitch(EVG)
print( 'Idle SEQRAM running')

time.sleep(1)

EvoReadStatus(EVG)

# Set Idle SEQRAM
num_evt = 1 # number of 0x67 events in seqram
EvoEvgSEQRAMIdle(EVG, num_evt, 0x1, 0x7E)

# Start SEQRAM
EvoEvgSEQRAMSwitch(EVG)
print( 'Idle SEQRAM running')

time.sleep(1)

EvoReadStatus(EVG)


"""
# Set Idle SEQRAM
num_evt = 2 # number of 0x67 events in seqram
EvoEvgSEQRAMIdle(EVG, num_evt, 0x7f)


time.sleep(1)

# Set Injection SEQRAM
EvoEvgSEQRAMInject(EVG, 20)


# Injection SEQRAM
EvoEvgSEQRAMSwitch(EVG)
print ('Injection SEQRAM running')

EvoReadStatus(EVG)

#EvoWrite(EVG, 49, [0,0,0,5], [0,0,0,8], [0,0,0,10])

EvoEvgSetACLine(EVG,30,1)
time.sleep(5)
EvoEvgSetACLine(EVG,30,0)

EvoWrite(EVG, 51, [0,0,0,0], [0,0,0,0], [0,0,0,1]) # time update source

regA, regB, regC = EvoRead(EVG, 51) # Configuration Register
print regA, regB, regC

#EvoEvgSetMUX(EVG, 6, 500000000/4-1, 1)
time.sleep(0.1)

#timestamp = int(time.time())
#timestamp = 0
#EvoWrite(EVG, 51, [(timestamp>>24)&0xFF,(timestamp>>16)&0xFF,(timestamp>>8)&0xFF,timestamp&0xFF], [0,0,0,0], [0,0,0,0])

regA, regB, regC = EvoRead(EVG, 51) # Configuration Register
print regA, regB, regC

utc = 0
regA, regB, regC = EvoRead(EVG, 51) # Configuration Register
utc = regA[0]*2**24+regA[1]*2**16+regA[2]*2**8+regA[3]
while 1:
    #time.sleep(0.1)
    regA, regB, regC = EvoRead(EVG, 51) # Configuration Register
    if (utc != (regA[0]*2**24+regA[1]*2**16+regA[2]*2**8+regA[3])):
        print "EVG timestamp:", regA[0]*2**24+regA[1]*2**16+regA[2]*2**8+regA[3], int(time.time())
        if ((regA[0]*2**24+regA[1]*2**16+regA[2]*2**8+regA[3]) > utc+1):
            break
        utc = regA[0]*2**24+regA[1]*2**16+regA[2]*2**8+regA[3]

"""
