#!/usr/bin/env python
# -*- coding: utf-8 -*-

import sys, urllib2, json
from datetime import datetime

try:
    url = sys.argv[2] + 'job/' + sys.argv[1] + '/api/json?tree=builds[number,result,timestamp,duration,url]'
    r = urllib2.urlopen(url)
    root = json.loads(r.read())
    builds = root['builds']
except:
    sys.exit(1)
finally:
    r.close()

cnt = 0
okcnt = 0
for build in builds:
    result = build['result']
    if result == "SUCCESS":
        okcnt += 1
    elif result == "UNSTABLE":
        pass
    elif result == "FAILURE":
        pass
    else:
        continue
    cnt += 1
if cnt > 0:
    stability = int(((okcnt * 1.0)/ cnt) * 100)
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
else:
    stability = 0
    iconUrl = "health-00to19.png"

print "---"
print "layout: default"
print "---"

print "## " + sys.argv[1]

print "### Build Stability"
print "___"

print "![Jenkins Icon](http://jenkinshrg.github.io/images/48x48/" + iconUrl + ")"
print str(stability) + "%"
print "  "

print "### Build History"
print "___"

print "|Status|Time|Duration|Test|Coverage|Inspection|Changes|Logs|Note|"
print "|---|---|---|---|---|---|---|---|---|---|"

for build in builds:
    result = build['result']
    if result == "SUCCESS":
        color = "blue"
    elif result == "UNSTABLE":
        color = "yellow"
    elif result == "FAILURE":
        color = "red"
    else:
        continue
    failCount = ""
    try:
        url = build['url'] + "testReport/api/json?tree=failCount"
        r = urllib2.urlopen(url)
        root = json.loads(r.read())
        failCount = root['failCount']
    except:
        pass
    finally:
        r.close()
    cause = ""
    ratio = ""
    try:
        url = build['url'] + "cobertura/api/json?tree=results[elements[*]]"
        r = urllib2.urlopen(url)
        root = json.loads(r.read())
        elements = root['results']['elements']
        n = 0
        for element in elements:
            if (n == 4):
                ratio = element['ratio']
            n += 1;
    except:
        pass
    finally:
        r.close()
    numberErrorSeverity = ""
    try:
        url = build['url'] + "cppcheckResult/api/json?tree=numberErrorSeverity"
        r = urllib2.urlopen(url)
        root = json.loads(r.read())
        numberErrorSeverity = root['numberErrorSeverity']
    except:
        pass
    finally:
        r.close()
    changes = ""
    try:
        url = build['url'] + "artifact/changes.txt"
        r = urllib2.urlopen(url)
        line = r.readline()
        while line:
            line = line.strip()
            changes += "[" + line.split(",")[1] + "](" + line.split(",")[0] + ")" + "<br>"
            line = r.readline()
    except:
        pass
    finally:
        r.close()
    logs = ""
    try:
        url = build['url'] + "artifact/googledrive.txt"
        r = urllib2.urlopen(url)
        line = r.readline()
        while line:
            line = line.strip()
            logs += "[" + line.split(",")[1] + "](" + line.split(",")[0] + ")" + "<br>"
            line = r.readline()
    except:
        pass
    finally:
        r.close()
    print "|" + "![Jenkins Icon](http://jenkinshrg.github.io/images/24x24/"+ color + ".png)" + str(result) + "|" + str(datetime.fromtimestamp(build['timestamp'] / 1000).strftime("%Y/%m/%d %H:%M")) + "|" + str(build['duration'] / 60 / 1000) + " min." + "|" + str(failCount) + "|" + str(ratio) + "|" + str(numberErrorSeverity) + "|" + changes + "|" + logs + "|" + cause + "|"
