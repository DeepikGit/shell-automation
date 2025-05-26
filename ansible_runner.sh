#!/bin/bash

# === Configuration ===
LOG_DIR="/var/log/ansible_runs"
mkdir -p "$LOG_DIR"

# === Input Validation ===
PLAYBOOK=$1
INVENTORY=$2
RUNNER=$(whoami)
TIMESTAMP=$(date '+%Y-%m-%d_%H-%M-%S')
LOG_FILE="${LOG_DIR}/ansible_run_${TIMESTAMP}.log"

if [ -z "$PLAYBOOK" ] || [ -z "$INVENTORY" ]; then
  echo "Usage: $0 <playbook.yml> <inventory>"
  exit 1
fi

# === Execution ===
echo "[$(date)] User '$RUNNER' started playbook: $PLAYBOOK with inventory: $INVENTORY" >> "$LOG_FILE"
echo "----------------------------------------" >> "$LOG_FILE"

ansible-playbook -i "$INVENTORY" "$PLAYBOOK" >> "$LOG_FILE" 2>&1
RESULT=$?

echo "----------------------------------------" >> "$LOG_FILE"
if [ $RESULT -eq 0 ]; then
  echo "[$(date)] ✅ Playbook executed successfully." >> "$LOG_FILE"
else
  echo "[$(date)] ❌ Playbook failed. Exit code: $RESULT" >> "$LOG_FILE"
fi

exit $RESULT
