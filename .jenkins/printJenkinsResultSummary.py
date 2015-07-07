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
print "|Name|Status|"
print "|---|---|"

print "|" + sys.argv[1] + "|" + "![Build Status](http://jenkinshrg.github.io/images/badge.svg)" + "|"
