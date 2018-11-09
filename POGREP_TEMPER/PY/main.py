import serial
import time,datetime

ports = ['COM%s' % (i + 1) for i in range(256)]
#print(ports)
result = []
for port in ports:
    try:
        s = serial.Serial(port)
        s.close()
        result.append(port)
    except (OSError, serial.SerialException):
        pass
#print(result)

wrk_port=""

for port in result[-1:]:
    try:
        #print(port)
        s=serial.Serial(port,9600,timeout=3)
        p=s.readline()
        #if len(p)>0:#!="" :
            #print(port," ----- ",p)
        s.close()
        #if p==b"handshake\r\n":
        if p.find(b"OK")!= -1:
            #global wrk_port
            wrk_port=port
            #print("Порт с устройством найден %s" % wrk_port)
        #else:
            #wrk_port="2"
        
    except (OSError, serial.SerialException):
        pass

#if wrk_port: print("Порт с устройством найден %s" % wrk_port)

next_start_time = datetime.datetime.now()
#print (next_start_time)
next_start_time+=datetime.timedelta(0,10,0,0,0,0,0)
#print (next_start_time)

while True:
    if datetime.datetime.now()<next_start_time:
        time.sleep(1)
    else:
        next_start_time = datetime.datetime.now()
        print (next_start_time)
        next_start_time+=datetime.timedelta(0,10,0,0,0,0,0)
        print (next_start_time)

        s=serial.Serial(wrk_port,9600,timeout=3)
        p=s.readline()
        s.close()
        if len(p)>0:#!="" :
            #print(p)
            if p.find(b"OK"):
                p1=p.find(b"OK")
                p2=p.find(b"CRC")
                pp=p[p1+2:p2].decode('UTF-8')
                p_str=datetime.datetime.now().strftime('%Y-%m-%d %H:%M:%S') + "   температура: " + pp + "°C"
                print(p_str)
                f=open("log.txt",'a')
                f.write(p_str+'\n')
                f.close()
