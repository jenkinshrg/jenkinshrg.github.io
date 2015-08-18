#!/bin/bash

python printJenkinsResultSummary.py > index.md

REPORT_JOB=drcutil-64
mkdir -p ${REPORT_JOB}
wget -q -O ${REPORT_JOB}/badge.svg http://localhost:8080/job/${REPORT_JOB}/badge/icon
python printJenkinsResult.py ${REPORT_JOB} > ${REPORT_JOB}/index.md

REPORT_JOB=drcutil-32
mkdir -p ${REPORT_JOB}
wget -q -O ${REPORT_JOB}/badge.svg http://localhost:8080/job/${REPORT_JOB}/badge/icon
python printJenkinsResult.py ${REPORT_JOB} > ${REPORT_JOB}/index.md

git add --all
git commit -m "update report"
git push origin master
