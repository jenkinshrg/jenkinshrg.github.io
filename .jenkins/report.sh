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

wget -q -O images/badge.svg http://jenkinshrg:8080/job/update/badge/icon
wget -q -O images/test.png http://jenkinshrg:8080/job/update/test/trend
wget -q -O images/cccc.png http://jenkinshrg:8080/job/update/ccccResult/graph
wget -q -O images/cppcheck.png http://jenkinshrg:8080/job/update/cppcheckResult/graph
python .jenkins/printJenkinsResult.py update > index.md

git add --all
git commit -m "update report"
git push origin master
