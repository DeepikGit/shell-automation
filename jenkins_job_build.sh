#!/bin/bash

# === Config ===
JENKINS_URL="http://your-jenkins-url"
JENKINS_CLI_JAR="jenkins-cli.jar"
JENKINS_USER="your-username"
JENKINS_TOKEN="your-api-token"
JOB_NAME="your-job-name"
LOG_FILE="/var/log/jenkins_trigger.log"

# === Optional: Parameters ===
PARAMS="env=staging version=1.2.3"

# === Run the Job ===
echo "[$(date)] Triggering Jenkins job: $JOB_NAME" >> "$LOG_FILE"

java -jar $JENKINS_CLI_JAR -s "$JENKINS_URL" -auth "$JENKINS_USER:$JENKINS_TOKEN" \
  build "$JOB_NAME" -p "$PARAMS" >> "$LOG_FILE" 2>&1

if [ $? -eq 0 ]; then
  echo "[$(date)] ✅ Jenkins job triggered successfully." >> "$LOG_FILE"
else
  echo "[$(date)] ❌ Failed to trigger Jenkins job." >> "$LOG_FILE"
fi
