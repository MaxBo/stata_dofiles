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

import re
p_into = re.compile('(?<=INTO )\w+')
p_labels = re.compile('(?<=LABELS )\w+')
pw = re.compile("\s{2,}")
def convert():
    f = open(path)
    try:
        z = f.readline()
        while z:
            if not z.startswith('*'):
                if z.startswith("RECODE"):
                    command = 'recode '
                    link = False
                    while True:
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
                        if z.strip().endswith('.'):
                            command = command.rstrip('.')
                            break
                        z = f.readline()
                    command = command.replace('ELSE','else')
                    command = re.sub(pw,' ',command)

                    m = p_into.search(command)
                    if m:
                        newVarName = m.group(0)
##                        print newVarName
                        command = command.replace('INTO %s' %newVarName, ', generate(%s)' %newVarName)
                    print command


                if z.startswith("VARIABLE LABELS"):
                    command = z.strip().replace("VARIABLE LABELS", "label variable").rstrip('.')
                    print command

                if z.startswith("VALUE LABELS"):
                    command = z.strip().replace("VALUE LABELS", "label define").rstrip('.')
                    command = command.replace('_$','')
                    print command
                    command2 = z.strip().rstrip('.')
                    command2 = re.sub(pw,' ',command2).replace('_$','')
                    m = p_labels.search(command2)
                    if m:
                        varName = m.group(0)
##                        print varName
                        command2 = 'label values %(vn)s %(vn)s' %{'vn': varName}
                        print command2


                if z.startswith("COMPUTE"):
                    command = z.strip().replace("COMPUTE", "generate").rstrip('.')
                    command = command.replace('_$','')
                    # to do: = durch == ersetzen
                    print command


            z = f.readline()
    finally:
        f.close()
