#!/bin/bash

JENKINS_URL=http://jenkinshrg.a01.aist.go.jp

wget -q -O drcutil-64.png ${JENKINS_URL}/job/drcutil-64/test/trend
wget -q -O drcutil-desktop.png ${JENKINS_URL}/job/drcutil-desktop/test/trend
python printJenkinsResultSummary.py ${JENKINS_URL} > index.md

REPORT_JOB=drcutil-32
wget -q -O ${REPORT_JOB}.svg ${JENKINS_URL}/job/${REPORT_JOB}/badge/icon
python printJenkinsResult.py ${REPORT_JOB} ${JENKINS_URL} >> index.md

REPORT_JOB=drcutil-64
wget -q -O ${REPORT_JOB}.svg ${JENKINS_URL}/job/${REPORT_JOB}/badge/icon
python printJenkinsResult.py ${REPORT_JOB} ${JENKINS_URL} >> index.md

REPORT_JOB=drcutil-desktop
wget -q -O ${REPORT_JOB}.svg ${JENKINS_URL}/job/${REPORT_JOB}/badge/icon
python printJenkinsResult.py ${REPORT_JOB} ${JENKINS_URL} >> index.md

REPORT_JOB=drcutil-task-terrain
wget -q -O ${REPORT_JOB}.svg ${JENKINS_URL}/job/${REPORT_JOB}/badge/icon
python printJenkinsResult.py ${REPORT_JOB} ${JENKINS_URL} >> index.md

git add --all
git commit -m "update report"
git push origin master
