#!/bin/bash

JENKINS_URL=http://jenkinshrg.a01.aist.go.jp/

REPORT_JOB=jenkinshrg-drcutil-ubuntu-trusty-amd64-ex-slave
mkdir -p ${REPORT_JOB}
wget -q -O ${REPORT_JOB}/badge.svg ${JENKINS_URL}job/${REPORT_JOB}/badge/icon
python .jenkins/printJenkinsResult.py ${REPORT_JOB} ${JENKINS_URL} > ${REPORT_JOB}/index.md

REPORT_JOB=jenkinshrg-drcutil-ubuntu-trusty-amd64-slave-ubuntu-trusty-amd64
mkdir -p ${REPORT_JOB}
wget -q -O ${REPORT_JOB}/badge.svg ${JENKINS_URL}job/${REPORT_JOB}/badge/icon
python .jenkins/printJenkinsResult.py ${REPORT_JOB} ${JENKINS_URL} > ${REPORT_JOB}/index.md

REPORT_JOB=jenkinshrg-drcutil-debian-wheezy-i386-slave-debian-wheezy-i386
mkdir -p ${REPORT_JOB}
wget -q -O ${REPORT_JOB}/badge.svg ${JENKINS_URL}job/${REPORT_JOB}/badge/icon
python .jenkins/printJenkinsResult.py ${REPORT_JOB} ${JENKINS_URL} > ${REPORT_JOB}/index.md

python .jenkins/printJenkinsResultSummary.py ${JENKINS_URL} > index.md

git add --all
git commit -m "update report"
git push origin master
