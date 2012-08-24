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


def addFilter(command,Filter):
    if Filter:
        if ',' in command:
            command = command.replace(',',' %s,' %Filter)
        else:
            command += ' %s' %Filter
    return command

def convert(infile=path,outfile=path.replace('.sps','do')):
    """
    Converts SPSS Syntax-Files into Stata do-files
    """
    Filter = False
    f = open(infile)
    fout = open(outfile,'w')
    try:
        z = f.readline()
        while z:
            if not z.startswith('*'):

                if z.strip().startswith("FILTER"):
                    filterVar = z.strip().replace('FILTER BY','').strip(' $.')
                    Filter = 'if ' + filterVar

                if z.strip().startswith("RECODE"):
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
                    command = command.replace('SYSMIS','.')
                    command = re.sub(pw,' ',command)

                    m = p_into.search(command)
                    if m:
                        newVarName = m.group(0)
##                        print newVarName
                        command = command.replace('INTO %s' %newVarName, ', generate(%s)' %newVarName)
                    command = addFilter(command,Filter)
                    fout.write(command + '\n')


                if z.strip().startswith("VARIABLE LABELS"):
                    command = z.strip().replace("VARIABLE LABELS", "label variable").rstrip('.')
                    fout.write(command + '\n')

                if z.strip().startswith("VALUE LABELS"):
                    command = z.strip().replace("VALUE LABELS", "label define").rstrip('.')
                    command = command.replace('$','')
                    fout.write(command + '\n')
                    command2 = z.strip().rstrip('.')
                    command2 = re.sub(pw,' ',command2).replace('$','')
                    m = p_labels.search(command2)
                    if m:
                        varName = m.group(0)
##                        print varName
                        command2 = 'label values %(vn)s %(vn)s' %{'vn': varName}
                        fout.write(command2 + '\n')


                if z.strip().startswith("COMPUTE"):
                    command = z.strip().replace("COMPUTE", "generate").rstrip('.')
                    command = command.replace('_$','')
                    # to do: = durch == ersetzen
                    command = addFilter(command,Filter)
                    fout.write(command + '\n')

                if z.strip().startswith("CROSSTABS"):
                    command = 'tab'
                    while True:
                        if z.strip().startswith('/TABLES'):
                            tableNames = z.strip().replace('/TABLES','').split('BY')
                            for tableName in tableNames:
                               command += ' '+tableName.strip('= ')
                        if z.strip().endswith('.'):
                            command = command.rstrip('.')
                            break
                        z = f.readline()
                    command = addFilter(command,Filter)
                    fout.write(command + '\n')

            z = f.readline()
    finally:
        f.close()
        fout.close()
