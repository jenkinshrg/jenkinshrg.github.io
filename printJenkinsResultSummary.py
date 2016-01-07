#!/usr/bin/env python
# -*- coding: utf-8 -*-

import sys, urllib2, json
from datetime import datetime

if len(sys.argv) > 1:
    url = sys.argv[1]
else:
    url = "http://localhost:8080"

try:
    url = url + '/api/json?tree=jobs[name]'
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

print "## Build and test report"
print "Last update : " + datetime.now().strftime("%Y/%m/%d %H:%M:%S")
print "  "

print "### Job Summary"
print "___"
print "  "
print "|Name|Status|"
print "|---|---|"

for job in jobs:
    if job['name'] != "drcutil":
        print "|[" + job['name'] + "](http://jenkinshrg.github.io/" + job['name'] + ")|![Build Status](http://jenkinshrg.github.io/"+ job['name'] + ".svg)|"

