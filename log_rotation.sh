

#!/bin/bash

<< COMMENT

This script is for log rotation and compression.
it finds and compresses log files older than a specified number of days,
moves them to an archive directory, and cleans up old archives.
Usage: ./logrotation.sh


COMMENT

LOG_DIR="/var/log/myapp"
ARCHIVE_DIR="/archive/logs"
DAYS_TO_COMPRESS=3
DAYS_TO_DELETE=30

TODAY=$(date +"%Y-%m-%d")
TARGET_ARCHIVE_DIR="$ARCHIVE_DIR/$TODAY"

sudo mkdir -p "$TARGET_ARCHIVE_DIR"

echo "Compressing logs older than $DAYS_TO_COMPRESS days in $LOG_DIR..."
sudo find "$LOG_DIR" -type f -name "*.log" -mtime -$DAYS_TO_COMPRESS -exec gzip {} \;

echo "Moving compressed logs to $TARGET_ARCHIVE_DIR..."
sudo find "$LOG_DIR" -type f -name "*.gz" -mtime -1 -exec mv {} "$TARGET_ARCHIVE_DIR" \;

echo "Cleaning up archives older than $DAYS_TO_DELETE days in $ARCHIVE_DIR..."
sudo find "$ARCHIVE_DIR" -type f -name "*.gz" -mtime +$DAYS_TO_DELETE -exec rm -f {} \;

sudo echo "[$(date)] Log rotation complete." >> /tmp/log-rotation.log

