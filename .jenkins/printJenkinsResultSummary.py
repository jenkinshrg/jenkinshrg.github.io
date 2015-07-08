#!/usr/bin/env python
# -*- coding: utf-8 -*-

import sys, os, json, urllib2
from datetime import datetime

url = sys.argv[1] + 'api/json?tree=jobs[name]'
r = urllib2.urlopen(url)
root = json.loads(r.read())
jobs = root['jobs']
r.close()

print "---"
print "layout: default"
print "---"

print "# Jenkins CI report For HRG"
print "## Build and test report" + " (" + datetime.now().strftime("%Y/%m/%d %H:%M:%S") + ")"

print "### Build Summary"
print "___"
print "  "
print "|Name|Status|"
print "|---|---|"

for job in jobs:
    print "|[" + job['name'] + "](http://jenkinshrg.github.io/" + job['name'] + ")|![Build Status](http://jenkinshrg.github.io/"+ job['name'] + "/badge.svg)|"
