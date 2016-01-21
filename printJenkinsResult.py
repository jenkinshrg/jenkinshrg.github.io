#!/usr/bin/env python
# -*- coding: utf-8 -*-

import sys, urllib2, json
from datetime import datetime

name = sys.argv[1]
if len(sys.argv) > 2:
    url = sys.argv[2]
else:
    url = "http://localhost:8080"

try:
    url = url + '/job/' + name + '/api/json?tree=builds[building,duration,number,result,timestamp,url]'
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
    stability = int(round(((okcnt * 1.0)/ cnt) * 100))
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

print "<div id='" + sys.argv[1] + "'></div>"

print "### " + sys.argv[1]
print "___"

print "#### Build Stability"

print "![Jenkins Icon](http://jenkinshrg.github.io/images/48x48/" + iconUrl + ")"
print str(stability) + "%"
print "  "

print "#### Build History"

print "|Status|Time|Duration|Inspection|Test|Coverage|Changes|Build|Console|Image|Video|Note|"
print "|---|---|---|---|---|---|---|---|---|---|---|---|---|"

for build in builds:
    building = build['building']
    if building == True:
        continue
    result = build['result']
    if result == "SUCCESS":
        color = "blue"
    elif result == "UNSTABLE":
        color = "yellow"
    elif result == "FAILURE":
        color = "red"
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
    if failCount != "":
        failCount = str(failCount) + " err."
    ratio = ""
    try:
        url = build['url'] + "cobertura/api/json?tree=results[elements[*]]"
        r = urllib2.urlopen(url)
        root = json.loads(r.read())
        elements = root['results']['elements']
        n = 0
        for element in elements:
            if (n == 4):
                ratio = int(round(element['ratio']))
            n += 1;
    except:
        pass
    finally:
        r.close()
    if ratio != "":
        ratio = str(ratio) + " %"
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
    if numberErrorSeverity != "":
        numberErrorSeverity = str(numberErrorSeverity) + " err."
    changes = ""
    try:
        url = build['url'] + "artifact/changes.txt"
        r = urllib2.urlopen(url)
        line = r.readline()
        while line:
            line = line.strip()
            githuburl = line.split(",")[0]
            commitid = line.split(",")[1]
            if (githuburl != ""):
                changes += "[" + commitid + "](" + githuburl + ")" + "<br>"
            else:
                changes += commitid + "<br>"
            line = r.readline()
    except:
        pass
    finally:
        r.close()
    build_files = ""
    console_files = ""
    image_files = ""
    video_files = ""
    try:
        url = build['url'] + "artifact/artifacts.txt"
        r = urllib2.urlopen(url)
        line = r.readline()
        while line:
            line = line.strip()
            label = line.split(",")[0]
            filename = line.split(",")[1]
            url = line.split(",")[2]
            if label == "BUILD":
                build_files += "[" + filename + "](" + url + ")" + "<br>"
            elif label == "CONSOLE":
                console_files += "[" + filename + "](" + url + ")" + "<br>"
            elif label == "IMAGE":
                image_files += "[" + filename + "](" + url + ")" + "<br>"
            elif label == "VIDEO":
                video_files += "[" + filename + "](" + url + ")" + "<br>"
            line = r.readline()
    except:
        pass
    finally:
        r.close()
    causes = ""
    print "|" + "![Jenkins Icon](http://jenkinshrg.github.io/images/24x24/"+ color + ".png)" + result + "|" + str(datetime.fromtimestamp(build['timestamp'] / 1000).strftime("%Y/%m/%d %H:%M")) + "|" + str(build['duration'] / 60 / 1000) + " min." + "|" + numberErrorSeverity + "|" + failCount + "|" + ratio + "|" + changes + "|" + build_files + "|" + console_files + "|" + image_files + "|" + video_files + "|" + causes + "|"
