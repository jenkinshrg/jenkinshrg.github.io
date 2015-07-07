#!/usr/bin/env python
# -*- coding: utf-8 -*-

import sys
from datetime import datetime

print "---"
print "layout: default"
print "---"

print "# Jenkins CI report For HRG"
print "## Build and test report" + " (" + datetime.now().strftime("%Y/%m/%d %H:%M:%S") + ")"

print "### Build Status"
print "___"
print "  "
print "|Name|Distro|Status|"
print "|:--|--:|"

print "|[" + sys.argv[1] + "](http://jenkinshrg.github.io/" + sys.argv[1] + ")|Ubuntu T|![Build Status](http://jenkinshrg.github.io/" + sys.argv[1] + "/badge.svg)|"
