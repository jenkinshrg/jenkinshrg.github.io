#!/bin/bash

JENKINS_URL=http://jenkinshrg.a01.aist.go.jp/

python printJenkinsResultSummary.py ${JENKINS_URL} > index.md

REPORT_JOB=drcutil
mkdir -p ${REPORT_JOB}
wget -q -O ${REPORT_JOB}/badge.svg ${JENKINS_URL}job/${REPORT_JOB}/badge/icon
python printJenkinsResult.py ${REPORT_JOB} ${JENKINS_URL} > ${REPORT_JOB}/index.md

REPORT_JOB=drcutil-64
mkdir -p ${REPORT_JOB}
wget -q -O ${REPORT_JOB}/badge.svg ${JENKINS_URL}job/${REPORT_JOB}/badge/icon
python printJenkinsResult.py ${REPORT_JOB} ${JENKINS_URL} > ${REPORT_JOB}/index.md

REPORT_JOB=drcutil-32
mkdir -p ${REPORT_JOB}
wget -q -O ${REPORT_JOB}/badge.svg ${JENKINS_URL}job/${REPORT_JOB}/badge/icon
python printJenkinsResult.py ${REPORT_JOB} ${JENKINS_URL} > ${REPORT_JOB}/index.md

git add --all
git commit -m "update report"
git push origin master
