#!/opt/local/bin/python2.6
import sys
import pylab
import pickle



def main():
    f = open(sys.argv[1])
    data = pickle.load(f)
    x0 = [x[0] for x in data]
    x1 = [x[1] for x in data]
    x2 = [x[2] for x in data]
    x3 = [x[3] for x in data]
    x4 = [x[4] for x in data]

    pylab.plot(x0, x1)
    pylab.plot(x0, x2)
    pylab.plot(x0, x3)
    pylab.plot(x0, x4)

    pylab.show()

if __name__ == "__main__":
    main()


