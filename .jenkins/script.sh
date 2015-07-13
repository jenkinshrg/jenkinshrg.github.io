#!/bin/bash

JENKINS_URL=http://jenkinshrg.a01.aist.go.jp/

REPORT_JOB=jenkinshrg-drcutil-feature1-ubuntu-trusty-amd64
mkdir -p ${REPORT_JOB}
wget -q -O ${REPORT_JOB}/badge.svg ${JENKINS_URL}job/${REPORT_JOB}/badge/icon
#wget -q -O ${REPORT_JOB}/test.png ${JENKINS_URL}job/${REPORT_JOB}/test/trend
#wget -q -O ${REPORT_JOB}/cccc.png ${JENKINS_URL}job/${REPORT_JOB}/ccccResult/graph
#wget -q -O ${REPORT_JOB}/cppcheck.png ${JENKINS_URL}job/${REPORT_JOB}/cppcheckResult/graph
python .jenkins/printJenkinsResult.py ${REPORT_JOB} ${JENKINS_URL} > ${REPORT_JOB}/index.md

REPORT_JOB=jenkinshrg-drcutil-feature2-debian-wheezy-i386
mkdir -p ${REPORT_JOB}
wget -q -O ${REPORT_JOB}/badge.svg ${JENKINS_URL}job/${REPORT_JOB}/badge/icon
#wget -q -O ${REPORT_JOB}/test.png ${JENKINS_URL}job/${REPORT_JOB}/test/trend
#wget -q -O ${REPORT_JOB}/cccc.png ${JENKINS_URL}job/${REPORT_JOB}/ccccResult/graph
#wget -q -O ${REPORT_JOB}/cppcheck.png ${JENKINS_URL}job/${REPORT_JOB}/cppcheckResult/graph
python .jenkins/printJenkinsResult.py ${REPORT_JOB} ${JENKINS_URL} > ${REPORT_JOB}/index.md

python .jenkins/printJenkinsResultSummary.py ${JENKINS_URL} > index.md

git add --all
git commit -m "update report"
git push origin master
