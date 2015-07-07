#!/bin/bash

if [ ! -e images ]; then
    mkdir -p images
    sudo cp /var/cache/jenkins/war/images/headshot.png images
    mkdir -p images/48x48
    sudo cp /var/cache/jenkins/war/images/48x48/nobuilt.png images/48x48
    sudo cp /var/cache/jenkins/war/images/48x48/blue.png images/48x48
    sudo cp /var/cache/jenkins/war/images/48x48/red.png images/48x48
    sudo cp /var/cache/jenkins/war/images/48x48/yellow.png images/48x48
    sudo cp /var/cache/jenkins/war/images/48x48/aborted.png images/48x48
    sudo cp /var/cache/jenkins/war/images/48x48/disabled.png images/48x48
    sudo cp /var/cache/jenkins/war/images/48x48/health-00to19.png images/48x48
    sudo cp /var/cache/jenkins/war/images/48x48/health-20to39.png images/48x48
    sudo cp /var/cache/jenkins/war/images/48x48/health-40to59.png images/48x48
    sudo cp /var/cache/jenkins/war/images/48x48/health-60to79.png images/48x48
    sudo cp /var/cache/jenkins/war/images/48x48/health-80plus.png images/48x48
    mkdir -p images/24x24
    sudo cp /var/cache/jenkins/war/images/24x24/nobuilt.png images/24x24
    sudo cp /var/cache/jenkins/war/images/24x24/blue.png images/24x24
    sudo cp /var/cache/jenkins/war/images/24x24/red.png images/24x24
    sudo cp /var/cache/jenkins/war/images/24x24/yellow.png images/24x24
    sudo cp /var/cache/jenkins/war/images/24x24/aborted.png images/24x24
    sudo cp /var/cache/jenkins/war/images/24x24/disabled.png images/24x24
fi

mkdir -p ${REPORT_JOB}
wget -q -O ${REPORT_JOB}/badge.svg ${JENKINS_URL}job/${REPORT_JOB}/badge/icon
wget -q -O ${REPORT_JOB}/test.png ${JENKINS_URL}job/${REPORT_JOB}/test/trend
wget -q -O ${REPORT_JOB}/cccc.png ${JENKINS_URL}job/${REPORT_JOB}/ccccResult/graph
wget -q -O ${REPORT_JOB}/cppcheck.png ${JENKINS_URL}job/${REPORT_JOB}/cppcheckResult/graph
python .jenkins/printJenkinsResult.py ${REPORT_JOB} ${JENKINS_URL} > ${REPORT_JOB}/index.md

python .jenkins/printJenkinsResultSummary.py ${REPORT_JOB} ${JENKINS_URL} > index.md

git add --all
git commit -m "update report"
git push origin master
