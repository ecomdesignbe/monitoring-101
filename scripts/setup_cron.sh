#!/bin/bash

# ==========================================================
# setup_cron.sh - Configure cron to run monitoring scripts
# ==========================================================
# This script adds scheduled jobs (cron) to run your scripts
#     automatically every X minutes.
# Ce script ajoute des tâches planifiées (cron) pour exécuter
#     vos scripts automatiquement toutes les X minutes.
# ==========================================================

<<<<<<< HEAD
# Define script paths (adjust if needed)
USER_SCRIPT_PATH="$HOME/monitoring-101/scripts/monitor_user.sh"
NETWORK_SCRIPT_PATH="$HOME/monitoring-101/scripts/monitor_network.sh"
ALERT_SCRIPT_PATH="$HOME/monitoring-101/scripts/send_alert.sh"
LOG_PATH="$HOME/monitoring-101/logs"
=======
# Get the directory where this script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Define relative paths
USER_SCRIPT_PATH="$SCRIPT_DIR/monitor_user.sh"
NETWORK_SCRIPT_PATH="$SCRIPT_DIR/monitor_network.sh"
ALERT_SCRIPT_PATH="$SCRIPT_DIR/send_alert.sh"
LOG_PATH="$SCRIPT_DIR/../logs"
BACKUP_PATH="$SCRIPT_DIR/../backup"
>>>>>>> 0c5db60f7f8b76212fa11af0408381f3c0ca77ca

# Create log & backup directory if it doesn’t exist
# Créer le dossier de logs s’il n’existe pas
mkdir -p "$LOG_PATH"
mkdir -p "$BACKUP_PATH"

# Create timestamped backup of current crontab
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
CRON_BACKUP_FILE="$BACKUP_PATH/cron_backup_$TIMESTAMP.bak"

# Backup crontab (if any)
crontab -l > "$CRON_BACKUP_FILE" 2>/dev/null
echo "✅ Crontab backed up to: $CRON_BACKUP_FILE"

# Write new cron tasks (every 5 minutes)
# Ajouter les nouvelles tâches cron (toutes les 5 minutes)
(
  crontab -l 2>/dev/null
  echo "*/5 * * * * bash $USER_SCRIPT_PATH >> $LOG_PATH/user.log 2>&1"
  echo "*/5 * * * * bash $NETWORK_SCRIPT_PATH >> $LOG_PATH/network.log 2>&1"
  echo "*/5 * * * * bash $ALERT_SCRIPT_PATH >> $LOG_PATH/alerts.log 2>&1"
) | crontab -

echo "✅ Cron jobs added! Monitoring scripts will run every 5 minutes."
