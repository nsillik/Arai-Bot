#!/opt/local/bin/python2.6
import sys
import numpy
import pylab
import pickle

def main():
    f = open(sys.argv[1])
    data = pickle.load(f)
    distance = [x[0] for x in data]
    temp = [x[1] for x in data]
    light = [x[2] for x in data]
    touch = [x[3] for x in data]
    pylab.plot(distance, label="distance")
    pylab.plot(temp, label="temp")
    pylab.plot(light, label="light")
    pylab.plot(touch, label="touch")
    pylab.show()

if __name__ == "__main__":
    main()
