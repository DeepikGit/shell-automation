#!/bin/bash

LOG_FILE="/var/log/docker_cleanup.log"
TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')

echo "[$TIMESTAMP] Starting Docker cleanup..." >> "$LOG_FILE"

# Remove stopped containers
echo "Removing stopped containers..." >> "$LOG_FILE"
docker container prune -f >> "$LOG_FILE"

# Remove dangling images (images not associated with a container)
echo "Removing dangling images..." >> "$LOG_FILE"
docker image prune -f >> "$LOG_FILE"

# Remove unused volumes
echo "Removing unused volumes..." >> "$LOG_FILE"
docker volume prune -f >> "$LOG_FILE"

# Remove unused networks
echo "Removing unused networks..." >> "$LOG_FILE"
docker network prune -f >> "$LOG_FILE"

echo "[$TIMESTAMP] Docker cleanup completed." >> "$LOG_FILE"
