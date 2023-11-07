import socket
import time

class EVO(object):
    def __init__(self, ip, port=50132,wait_time=0.001,protocol='tcp',header=True):
        self.ip = ip
        self.port = port
        self.wait_time = wait_time
        self.protocol = protocol
        self.include_header = header
        print ('EVO -> IP address: ', self.ip, '\tPort: ', self.port)
        if self.protocol == 'udp-force-local':
            self.socket = socket.socket(family=socket.AF_INET, type=socket.SOCK_DGRAM)
            self.socket.bind(('', self.port))
        elif self.protocol == 'udp':
            self.socket = socket.socket(family=socket.AF_INET, type=socket.SOCK_DGRAM)
        elif self.protocol == 'tcp':
            self.socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
            self.socket.connect((self.ip, self.port))
        else:
            print("Protocol not supported: using 'udp'")
            self.socket = socket.socket(family=socket.AF_INET, type=socket.SOCK_DGRAM)
            self.protocol = 'udp'
        self.socket.settimeout(5)

        
        
    def Write(self,address, regA, regB, regC):
        # Write
        cmd = chr(0x40|address)+chr(regA[0])+chr(regA[1])+chr(regA[2])+chr(regA[3])+chr(regB[0])+chr(regB[1])+chr(regB[2])+chr(regB[3])+chr(regC[0])+chr(regC[1])+chr(regC[2])+chr(regC[3])
        if self.protocol == 'udp-force-local':
            self.socket.sendto(bytes(cmd, 'latin-1'), (self.ip,self.port))
        elif self.protocol == 'udp':
            self.socket.sendto(bytes(cmd, 'latin-1'), (self.ip,self.port))
        else:
            self.socket.sendall(bytes(cmd, 'latin-1'))
        time.sleep(self.wait_time)

    def Read(self,address):
        # Read
        cmd = chr(0x80|address)+chr(0)+chr(0)+chr(0)+chr(0)+chr(0)+chr(0)+chr(0)+chr(0)+chr(0)+chr(0)+chr(0)+chr(0)
    
        if self.protocol == 'udp-force-local':
            if self.include_header == False:
                self.socket.sendto(bytes(cmd, 'latin-1'),(self.ip,self.port))
            else:
                self.socket.sendto(bytes.fromhex('020A0A0A79000D')+bytes(cmd, 'latin-1'),(self.ip,self.port))
            data, addr = self.socket.recvfrom(20) # buffer size is 13 bytes or 20 bytes if header has been included
        elif self.protocol == 'udp':
            if self.include_header == False:
                self.socket.sendto(bytes(cmd, 'latin-1'),(self.ip,self.port))
            else:
                self.socket.sendto(bytes.fromhex('020A0A0A79000D')+bytes(cmd, 'latin-1'),(self.ip,self.port))
            data, addr = self.socket.recvfrom(30) # buffer size is 13 bytes or 20 bytes if header has been included
        else:
            if self.include_header == False:
                self.socket.sendall(bytes(cmd, 'latin-1'))
            else:
                self.socket.sendall(bytes.fromhex('020A0A0A79000D')+bytes(cmd, 'latin-1'))
            data = self.socket.recv(20) # buffer size is 13 bytes or 20 bytes if header has been included
            expected_len=20 if self.include_header==True else 13
            while len(data) < expected_len:
                data += self.socket.recv(20)
        print("Data length: %d"%len(data))
        if len(data) == 20: #Remove header
            data = data[7:] 
        print("Corrected Data length: %d"%len(data))   
        regA = [((data[1])),((data[2])),((data[3])),((data[4]))]
        regB = [((data[5])),((data[6])),((data[7])),((data[8]))]
        regC = [((data[9])),((data[10])),((data[11])),((data[12]))]
        
        return regA, regB, regC

    def ReadStatus(self):
        print("\n\n\r***********************************************************************")
        print ('EVO -> IP address: ', self.ip, '\tPort: ', self.port)
        regA, regB, regC = self.Read(63) # Configuration Register
        # function selection
        self.FUNSEL = (regC[3] & 0b11) 
        self.RFDIV = (regB[1] & 0b1111) + 1
        
        if self.FUNSEL == 0:
            self.mode = 'FOUT'
        elif self.FUNSEL == 1:
            self.mode = 'EVR'
        elif self.FUNSEL == 2:
            self.mode = 'EVG'
        else:
            self.mode = 'unknown'
        
        print ('EVO Module Function: %s'%self.mode)
        print ('RF divider: ', self.RFDIV)
    
    def ReadVersion(self):
         regA, regB, regC = self.Read(62) # Configuration Register
         print("Commit hash version: %s"%bytes(regA+regB+regC).hex())
    
        
    def close(self):
        self.socket.close()
        

class EVG(EVO):
    def __init__(self, ip, port=50132,wait_time=0.001):
        EVO.__init__(self,ip,port,wait_time) 
        self.enable(0,0)
        self.set_rfdiv(4)
        self.enable(1,1)
        time.sleep(0.1)
    
    def ReadStatus(self):
        EVO.ReadStatus(self)
        if (self.mode == 'EVG'): # EVG
            #======================= Control and Status Register
            regA, regB, regC = self.Read(0)
            self.EVGEN = regC[3] & 0b1
            self.SEQEN = regC[3] & 0b10
            self.SEQS = (regC[2] & 0b11000)>>3
            self.RFINS = regC[2] >> 5

            #======================= AC line setting Register
            regA, regB, regC = self.Read(40)
            self.ACEN = regA[3] & 0b1
            self.ACDIV = (regC[0]<<24)+(regC[1]<<16)+(regC[2]<<8)+regC[3] + 1

            #======================= MUX0 setting Register
            self.MUXEN = [0,0,0,0,0,0,0,0]
            self.MUXDIV = [0,0,0,0,0,0,0,0]
            for i in range(8):
                regA, regB, regC = self.Read(41+i)
                self.MUXEN[i] = regA[3] & 0b1
                self.MUXDIV[i] = (regC[0]<<24)+(regC[1]<<16)+(regC[2]<<8)+regC[3] + 1

            #======================= SEQRAM switch Register
            regA, regB, regC = self.Read(50)
            self.SEQCOUNT = ((regC[2]&0b111111)<<8)+regC[3]

            print ('EVG enable: ', bool(self.EVGEN))
            print ('RF input: ', bool(self.RFINS), '\tRF divider: ', self.RFDIV)
            print ('AC line enable: ', bool(self.ACEN), '\tAC line divider: ', self.ACDIV)
            print ('SEQRAM enable: ', bool(self.SEQEN), '\tSEQRAM Status: ', self.SEQS, '\tSEQRAM Count: ', self.SEQCOUNT)
            for i in range(8):
                print ('Clock output '+str(i)+' -> Enable: ', self.MUXEN[i], '\tDivider: ', self.MUXDIV[i])

    def set_rfdiv(self,RFDIV):
        self.RFDIV = RFDIV
        add = 63
        regA = [0,0,0,0]
        regB = [0,RFDIV-1,0,0]
        regC = [0,0,0,18]
        self.Write(63, regA, regB, regC)

    def enable(self,seqen, evgen):
        regA = [0,0,0,0]
        regB = [0,0,0,0]
        regC = [0,0,0,2*seqen+evgen]

        self.Write(0, regA, regB, regC)