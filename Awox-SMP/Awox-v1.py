#!/usr/bin/python
# -*- coding: utf-8 -*-

from __future__ import print_function
  
# domoticz server & port information
domoticzserver = "192.168.10.37:8080"

# SmartPlug Adress
ble_addr="F4:B8:5E:E5:4F:FD"

# domoticz IDX
Idx="71"

#___________________________________________________________________________________________________


import pprint
import argparse
import urllib
import urllib2
import urlparse
import sys
import time
import pexpect


# some const
RET_CODE_OK = 0
RET_CODE_ERROR = 1

# some var
return_code = RET_CODE_OK


# format gatttool commands
cmd_prefix = 'gatttool -b {0}'.format(ble_addr)
cmd_status = cmd_prefix + ' --handle=0x2b --char-write-req --value=0f050400000005ffff --listen'

# launch command and wait notification
p = pexpect.spawn(cmd_status)
i = p.expect([pexpect.TIMEOUT, pexpect.EOF, r'0f 0f.*ff ff'], timeout=10.0)
p.terminate()

# print status
if i == 0 or i == 1:
	print('error occur (gatttool say = \'%s\')' % p.before.rstrip(), file=sys.stderr)
	return_code = RET_CODE_ERROR
elif i == 2:
	# decode data (plug state at byte index 4, power in mW at bytes index 6 to 9)
	data = p.after.split()
	# print('RAW = %s' % data)
	status = 'on' if int(data[4], 16) == 1 else 'off'
	power = str(int(data[6]+data[7]+data[8]+data[9], 16) / 1000)
	# print result
	print('plug state = %s' % status)
	print('plug power = %s W' % power)
	url = 'http://'+domoticzserver+'/json.htm?type=command&param=udevice&idx='+Idx+'&nvalue=0&svalue='+power+''

	httpresponse = urllib.urlopen(url)
	print ('Uploaded Instant Conso')

	
	
	return_code = RET_CODE_OK
	
# return error code
sys.exit(return_code)
