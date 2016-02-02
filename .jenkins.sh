echo $JENKINS_URL
echo $JOB_NAME
echo $BUILD_NUMBER
echo $WORKSPACE

if [ ! -v JENKINS_URL ]; then
    JENKINS_URL=http://jenkinshrg.a01.aist.go.jp/
fi

python printJenkinsResultSummary.py ${JENKINS_URL} > index.md

REPORT_JOB=drcutil-build-32
wget -q -O ${REPORT_JOB}.svg ${JENKINS_URL}/job/${REPORT_JOB}/badge/icon
python printJenkinsResult.py ${REPORT_JOB} ${JENKINS_URL} >> index.md

REPORT_JOB=drcutil-build-64
wget -q -O ${REPORT_JOB}.svg ${JENKINS_URL}/job/${REPORT_JOB}/badge/icon
python printJenkinsResult.py ${REPORT_JOB} ${JENKINS_URL} >> index.md

REPORT_JOB=drcutil-task-balancebeam
wget -q -O ${REPORT_JOB}.svg ${JENKINS_URL}/job/${REPORT_JOB}/badge/icon
python printJenkinsResult.py ${REPORT_JOB} ${JENKINS_URL} >> index.md

REPORT_JOB=drcutil-task-terrain
wget -q -O ${REPORT_JOB}.svg ${JENKINS_URL}/job/${REPORT_JOB}/badge/icon
python printJenkinsResult.py ${REPORT_JOB} ${JENKINS_URL} >> index.md

REPORT_JOB=drcutil-task-valve
wget -q -O ${REPORT_JOB}.svg ${JENKINS_URL}/job/${REPORT_JOB}/badge/icon
python printJenkinsResult.py ${REPORT_JOB} ${JENKINS_URL} >> index.md

REPORT_JOB=drcutil-task-walk
wget -q -O ${REPORT_JOB}.svg ${JENKINS_URL}/job/${REPORT_JOB}/badge/icon
python printJenkinsResult.py ${REPORT_JOB} ${JENKINS_URL} >> index.md

REPORT_JOB=drcutil-task-wall
wget -q -O ${REPORT_JOB}.svg ${JENKINS_URL}/job/${REPORT_JOB}/badge/icon
python printJenkinsResult.py ${REPORT_JOB} ${JENKINS_URL} >> index.md

git add --all
git commit -m "update report"
git push origin master
