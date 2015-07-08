export CREDENTIAL_FILE=${HOME}/Documents/jenkinshrg/scripts/jsonCredential.txt
export CLIENT_ID=72243280516-cosk9tsmaf8lgb850l914mtd2bsk5hm5.apps.googleusercontent.com
export CLIENT_SECRET=QVGj5VAxwQ82omYUE00A3o2w
export OAUTH_SCOPE=https://www.googleapis.com/auth/drive
export REDIRECT_URI=urn:ietf:wg:oauth:2.0:oob

cd ${WORKSPACE}

DATE=$(date +"%Y-%m-%d")
TIME=$(date +"%H-%M")

wget -q ${JENKINS_URL}jnlpJars/jenkins-cli.jar

TITLE=${DATE}-${TIME}-changes.txt
FILENAME=${DATE}-${TIME}-changes.txt
java -jar jenkins-cli.jar -noKeyAuth -s ${JENKINS_URL} list-changes ${JOB_NAME} ${BUILD_NUMBER} > ${FILENAME}
if [ -s ${FILENAME} ]; then
    echo "CHANGES:" >> testbed-terrain.url
    python ${WORKSPACE}/drcutil/.jenkins/remoteBackup.py ${TITLE} text/plain ${FILENAME} >> testbed-terrain.url
fi
rm -f ${FILENAME}

TITLE=${DATE}-${TIME}-console.txt
FILENAME=${DATE}-${TIME}-console.txt
java -jar jenkins-cli.jar -noKeyAuth -s ${JENKINS_URL} console ${JOB_NAME} ${BUILD_NUMBER} > ${FILENAME}
if [ -s ${FILENAME} ]; then
    echo "BUILD:" >> testbed-terrain.url
    python ${WORKSPACE}/drcutil/.jenkins/remoteBackup.py ${TITLE} text/plain ${FILENAME} >> testbed-terrain.url
fi
rm -f ${FILENAME}

rm -f jenkins-cli.jar

TITLE=${DATE}-${TIME}-testbed-terrain.txt
FILENAME=testbed-terrain.txt
if [ -s ${FILENAME} ]; then
    echo "CONSOLE:" >> testbed-terrain.url
    python ${WORKSPACE}/drcutil/.jenkins/remoteBackup.py ${TITLE} text/plain ${FILENAME} >> testbed-terrain.url
fi

TITLE=${DATE}-${TIME}-testbed-terrain.png
FILENAME=testbed-terrain.png
if [ -s ${FILENAME} ]; then
    echo "IMAGE:" >> testbed-terrain.url
    python ${WORKSPACE}/drcutil/.jenkins/remoteBackup.py ${TITLE} image/png ${FILENAME} >> testbed-terrain.url
fi

TITLE=${DATE}-${TIME}-testbed-terrain.ogv
FILENAME=testbed-terrain.ogv
if [ -s ${FILENAME} ]; then
    echo "VIDEO:" >> testbed-terrain.url
    python ${WORKSPACE}/drcutil/.jenkins/remoteBackup.py ${TITLE} video/ogg ${FILENAME} >> testbed-terrain.url
fi
