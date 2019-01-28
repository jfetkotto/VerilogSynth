#! /usr/bin/env python3

############################################################################
### Purpose: Tool for generating LUTs for both verilog $readmem format and MIF files
###  Author: Sam Mitchell
###    Date: Jan 2019

import os
import argparse
import numpy as np
import matplotlib.pyplot as plt

def args():
    parser = argparse.ArgumentParser()
    parser.add_argument('-d', '--depth', type=int, help='Depth of LUT')
    parser.add_argument('-w', '--width', type=int, help='Width of LUT')
    parser.add_argument('-q', help='Enable quadrature hack', action='store_true')
    parser.add_argument('-s', '--stem', help='Plot Stem', action='store_true')
    parser.add_argument('-f', '--file', help='Location to store LUT')
    parser.add_argument('-m', '--mif', help='Store as MIF', action='store_true')
    return parser.parse_args()

def make_table(depth,width,quad=0):
    if quad:
        lut_depth = (2**depth)/4
        lut_len = 0.5*np.pi
    else:
        lut_depth = (2**depth)
        lut_len = 2*np.pi

    a = ((2**width)-1)/2
    t = np.linspace(0, lut_len, lut_depth)
    y = a*np.sin(t)

    return t,y

def plot(x,y,stem):
    plt.figure('Generated LUT')
    plt.title("Generated LUT")
    plt.ylabel('Amplitude')
    plt.xlabel('Address')

    if stem:
        plt.stem(x,y)
    else:
        plt.plot(x,y)
    plt.show()

if __name__ == '__main__':

    args = args()

    # Default LUT is 16x16
    BIT_DEPTH = args.depth if args.depth else 16
    BIT_WIDTH = args.width if args.width else 16

    print('Depth of LUT: %d' % BIT_DEPTH )
    print('Width of LUT: %d' % BIT_WIDTH)

    t,y = make_table(BIT_DEPTH,BIT_WIDTH,args.q)

    print('Max value: %d' % np.max(y))
    print('Min value: %d' % np.min(y))

    pwd = os.path.dirname(os.path.realpath(__file__))
    dirname = pwd+'/lutdata'

    if not os.path.exists(dirname):
        os.mkdir(dirname)

    if args.file:
        loc = dirname+'/'+args.file
        if args.mif:
            f = open(loc+'.mif',"w")
            f.write("DEPTH = %i;\n" % BIT_DEPTH)
            f.write("WIDTH = %i;\n" % BIT_WIDTH)
            f.write("ADDRESS_RADIX = HEX;\n")
            f.write("DATA_RADIX = BIN;\n")
            f.write("CONTENT BEGIN\n")
            count = 0
            for i in y:
                v = np.binary_repr(int(i),width=BIT_WIDTH)
                f.write('%s : %s;\n' % (np.base_repr(count,16), v))
                count += 1
            f.write("END;")
        else:
            f = open(loc,"w")
            for i in y:
                v = np.binary_repr(int(i),width=BIT_WIDTH)
                f.write('%s\n' % v)

        f.close()
        
    # Convert time to sample for plotting address
    s = (t/(2*np.pi))*((2**BIT_DEPTH)-1)
    plot(s,y,args.stem)
