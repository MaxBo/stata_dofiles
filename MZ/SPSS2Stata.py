#-------------------------------------------------------------------------------
# Name:        SPSS2Stata
# Purpose:
#
# Author:      Max Bohnet
#
# Created:     13.10.2011
# Copyright:   (c) Max Bohnet 2011
#-------------------------------------------------------------------------------
#!/usr/bin/python
# -*- coding: utf-8 -*-

path = r'D:\DatenMaxDiss\ado\dofiles\MZ\anne.sps'

def convert():
    f = open(path)
    try:
        z = f.readline()
        while z:
            if not z.startswith('*'):
                if z.startswith("RECODE"):
                    command = 'recode '
                    link = False
                    while not z.startswith("EXECUTE"):
                        value = z.strip().replace('RECODE','')
                        if link:
                            value = value[1:]
                        if value.endswith('+'):
                            link = True
                            value = value[:-2]
                        else:
                            link = False
                        value = value.replace ("thru","/")
                        command += value
                        z = f.readline()
                    print command
            z = f.readline()
    finally:
        f.close()
