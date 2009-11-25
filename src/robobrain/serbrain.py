#!/usr/bin/env python
import sys
import time
import pickle
import serial
millis = int(time.time() * 1000)

def format(str):
    s = str
    s = s.replace('\r', '')
    s = s.replace('\n', '')
    dat = s.split(',')
    dat = [int(dat[0]) + millis, dat[1], dat[2], dat[3], dat[4]] 
    return dat

def main():
    data = []
    ser = serial.Serial(sys.argv[1], 9600)
    discard = []
    discount = 100
    disi = 0
    try:
        print millis, "Warming Up."
        while(1):
            dl = ser.readline()
            if disi < discount:
                print ".",
                sys.stdout.flush()
            else:
                fdl = format(dl)
                data.append(fdl)
                print fdl
            disi = disi + 1
    except:
        f = open(sys.argv[2], 'w')
        pickle.dump(data, f)
        f.close()
        ser.close()
        sys.exit(0)

        

if __name__ == "__main__":
    main()
