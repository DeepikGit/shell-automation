#!/bin/bash

SERVICE_NAME="nginx"                    # Change to your service
LOG_FILE="/var/log/service_monitor.log"
TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')

# Check if service is active
if systemctl is-active --quiet "$SERVICE_NAME"; then
    echo "$TIMESTAMP: $SERVICE_NAME is running." >> "$LOG_FILE"
else
    echo "$TIMESTAMP: $SERVICE_NAME is NOT running. Attempting restart..." >> "$LOG_FILE"
    systemctl restart "$SERVICE_NAME"

    # Recheck status
    if systemctl is-active --quiet "$SERVICE_NAME"; then
        echo "$TIMESTAMP: Restart successful." >> "$LOG_FILE"
    else
        echo "$TIMESTAMP: Restart FAILED. Manual intervention needed!" >> "$LOG_FILE"
    fi
fi
