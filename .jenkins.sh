#!/bin/bash

URL=http://jenkinshrg

wget -q -O drcutil-64.png ${URL}/job/drcutil-64/test/trend
wget -q -O drcutil-desktop.png ${URL}/job/drcutil-desktop/test/trend
python printJenkinsResultSummary.py > index.md

REPORT_JOB=drcutil-32
wget -q -O ${REPORT_JOB}.svg ${URL}/job/${REPORT_JOB}/badge/icon
python printJenkinsResult.py ${REPORT_JOB} >> index.md

REPORT_JOB=drcutil-64
wget -q -O ${REPORT_JOB}.svg ${URL}/job/${REPORT_JOB}/badge/icon
python printJenkinsResult.py ${REPORT_JOB} >> index.md

REPORT_JOB=drcutil-desktop
wget -q -O ${REPORT_JOB}.svg ${URL}/job/${REPORT_JOB}/badge/icon
python printJenkinsResult.py ${REPORT_JOB} >> index.md

git add --all
git commit -m "update report"
git push origin master
