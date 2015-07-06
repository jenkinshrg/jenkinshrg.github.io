#!/usr/bin/env python
# -*- coding: utf-8 -*-

import sys, os, json, urllib2
from datetime import datetime

print "---"
print "layout: default"
print "---"

print "# Jenkins CI report For HRG"
print "## Build and test report" + " (" + datetime.now().strftime("%Y/%m/%d %H:%M:%S") + ")"

url = 'http://jenkinshrg:8080/job/' + sys.argv[1] + '/api/json?tree=color,lastCompletedBuild[result],builds[number,result,timestamp,duration,url]'
r = urllib2.urlopen(url)
root = json.loads(r.read())
color = root['color']
lastCompletedBuild = root['lastCompletedBuild']
builds = root['builds']
r.close()

cnt = 0
okcnt = 0.0
for build in builds:
    if build['result'] == "SUCCESS":
        okcnt += 1
    cnt += 1
#    if cnt == 10:
#        break
stability = int((okcnt / cnt) * 100)
if stability >= 80:
    iconUrl = "health-80plus.png"
elif stability >= 60:
    iconUrl = "health-60to79.png"
elif stability >= 40:
    iconUrl = "health-40to59.png"
elif stability >= 20:
    iconUrl = "health-20to39.png"
else:
    iconUrl = "health-00to19.png"

print "### Build Status"
print "___"
print "![Build Status](http://jenkinshrg.github.io/images/badge.svg)"
print "  "

print "### Build Trend"
print "___"
print "* gui test(choreonoid)"
print "  "
print "![Test Trend](http://jenkinshrg.github.io/images/test.png)"
print "  "
print "* code counter(cccc)"
print "  "
print "![Cccc Trend](http://jenkinshrg.github.io/images/cccc.png)"
print "  "
print "* code checker(cppcheck)"
print "  "
print "![Cppcheck Trend](http://jenkinshrg.github.io/images/cppcheck.png)"
print "  "

print "### Build History"
print "___"

print "* Status"
print "  "
print "![Jenkins Icon](http://jenkinshrg.github.io/images/48x48/"+ color + ".png)"
print lastCompletedBuild['result']
print "  "

print "* Stability"
print "  "
print "![Jenkins Icon](http://jenkinshrg.github.io/images/48x48/" + iconUrl + ")"
print str(stability) + "%"
print "  "

print "* Latest Results"
print "  "
print "|Status|Time|Duration|Changes|Build|Test|Note|"
print "|---|---|---|---|---|---|---|"

cnt = 0
for build in builds:
    result = build['result']
    if result == "SUCCESS":
        color = "blue"
    elif result == "UNSTABLE":
        color = "yellow"
    elif result == "FAILURE":
        color = "red"
    else:
        color = "red"
    errorDetails = ""
    errorStackTrace = ""
    if result == "UNSTABLE":
        url = build['url'] + 'testReport/api/json?tree=suites[cases[errorDetails,errorStackTrace]]'
        r = urllib2.urlopen(url)
        root = json.loads(r.read())
        r.close()
        errorDetails = root['suites'][0]['cases'][0]['errorDetails']
        errorStackTrace = root['suites'][0]['cases'][0]['errorStackTrace']
        cause = "(" + errorDetails + "/" + errorStackTrace + ")"
#    path = "/var/lib/jenkins/jobs/" + sys.argv[1] + "/builds/" + str(build['number']) + "/archive/testbed-terrain.url"
    path = build['url'] + 'artifact/testbed-terrain.url'
    link1 = ""
    link2 = ""
    link3 = ""
#    if os.path.exists(path) :
    if True :
#        f = open(path)
        f = urllib2.urlopen(path)
        line = f.readline()
        while line:
            if "BUILD" in line:
                tag = "BUILD"
            elif "CHANGES" in line:
                tag = "CHANGES"
            elif "CONSOLE" in line:
                tag = "CONSOLE"
            elif "IMAGE" in line:
                tag = "IMAGE"
            elif "VIDEO" in line:
                tag = "VIDEO"
            else:
                if tag == "CHANGES":
                    link1 = "[" + str(tag) + "](" + line.strip() + ")" + " "
                elif tag == "BUILD":
                    link2 = "[" + str(tag) + "](" + line.strip() + ")" + " "
                else:
                    link3 += "[" + str(tag) + "](" + line.strip() + ")" + " "
            line = f.readline()
        f.close()
    print "|" + "![Jenkins Icon](http://jenkinshrg.github.io/images/24x24/"+ color + ".png)" + str(result) + "|" + str(datetime.fromtimestamp(build['timestamp'] / 1000).strftime("%Y/%m/%d %H:%M")) + "|" + str(build['duration'] / 60 / 1000) + " min." + "|" + str(link1) + "|" + str(link2) + "|" + str(link3) + "|" + str(errorDetails) + " " + str(errorStackTrace) + "|"
    cnt += 1
#    if cnt == 10:
#        break
