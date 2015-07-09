#!/usr/bin/env python
# -*- coding: utf-8 -*-

import sys, urllib2, json
from datetime import datetime

try:
    url = sys.argv[1] + 'api/json?tree=jobs[name]'
    r = urllib2.urlopen(url)
    root = json.loads(r.read())
    jobs = root['jobs']
except:
    sys.exit(1)
finally:
    r.close()

print "---"
print "layout: default"
print "---"

print "## " + datetime.now().strftime("%Y/%m/%d %H:%M:%S")

print "### Build Summary"
print "___"
print "  "
print "|Name|Status|"
print "|---|---|"

for job in jobs:
    print "|[" + job['name'] + "](http://jenkinshrg.github.io/" + job['name'] + ")|![Build Status](http://jenkinshrg.github.io/"+ job['name'] + "/badge.svg)|"
