JENKINS_URL=http://jenkins.172.18.0.3.nip.io
USER=$1
TOKEN=$2
JOB=$3

CRUMB=$(curl -u "$USER:$TOKEN" "$JENKINS_URL"'/crumbIssuer/api/xml?xpath=concat(//crumbRequestField,":",//crumb)')

curl -X POST -u "$USER:$TOKEN" -H "$CRUMB" "$JENKINS_URL"/job/"$JOB"/build