#!/bin/bash

# Thresholds
CPU_THRESHOLD=80
MEM_THRESHOLD=80

# Log file
LOG_FILE="/var/log/resource_monitor.log"
TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')

# Get CPU usage (top gives all CPU usage as sum of idle + used)
CPU_USAGE=$(top -bn1 | grep "Cpu(s)" | awk '{print 100 - $8}')
CPU_USAGE=${CPU_USAGE%.*}  # Remove decimals

# Get Memory usage
MEM_TOTAL=$(free | awk '/Mem:/ {print $2}')
MEM_USED=$(free | awk '/Mem:/ {print $3}')
MEM_USAGE=$(( MEM_USED * 100 / MEM_TOTAL ))

# Check thresholds
if [ "$CPU_USAGE" -ge "$CPU_THRESHOLD" ]; then
    echo "$TIMESTAMP: HIGH CPU Usage Detected: ${CPU_USAGE}%!" >> "$LOG_FILE"
    # You can trigger a notification or restart a service here
fi

if [ "$MEM_USAGE" -ge "$MEM_THRESHOLD" ]; then
    echo "$TIMESTAMP: HIGH Memory Usage Detected: ${MEM_USAGE}%!" >> "$LOG_FILE"
    # You can trigger a notification or kill heavy processes here
fi

