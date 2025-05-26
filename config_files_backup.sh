#!/bin/bash

CONFIG_PATHS=(
  "/etc/nginx"
  "/etc/systemd/system"
  "/opt/myapp/config"
)

BACKUP_ROOT="/backups/config"
RETENTION_DAYS=7
NOW=$(date +"%Y-%m-%d_%H-%M")
BACKUP_DIR="$BACKUP_ROOT/$NOW"

mkdir -p "$BACKUP_DIR"

echo "Starting config backup..."

for path in "${CONFIG_PATHS[@]}"; do
  if [ -e "$path" ]; then
    name=$(echo "$path" | sed 's|/|_|g' | sed 's|^_||')
    tar -czf "$BACKUP_DIR/${name}.tar.gz" "$path"
    echo "Backed up $path → ${name}.tar.gz"
  else
    echo "⚠️ Warning: $path does not exist"
  fi
done

echo "Deleting backups older than $RETENTION_DAYS days..."
find "$BACKUP_ROOT" -mindepth 1 -maxdepth 1 -type d -mtime +$RETENTION_DAYS -exec rm -rf {} \;

echo "[$(date)] Config backup complete." >> /var/log/config-backup.log
