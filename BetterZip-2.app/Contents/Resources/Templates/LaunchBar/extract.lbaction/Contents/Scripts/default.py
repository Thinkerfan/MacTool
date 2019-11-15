#!/usr/bin/env python
#
# LaunchBar Action Script
#
import sys
import urllib
import os

preset = '%preset-name%'
files = ';'.join(map(urllib.quote, sys.argv[1:]))
url = '"btrzp://extract/' + urllib.quote(preset) + '?' + files + '"'
os.system('open ' + url)
