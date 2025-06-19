#!/bin/bash

# ==========================================================
# setup_cron.sh - Configure cron to run monitoring scripts
# ==========================================================
# This script adds scheduled jobs (cron) to run your scripts
#     automatically every X minutes.
# Ce script ajoute des tâches planifiées (cron) pour exécuter
#     vos scripts automatiquement toutes les X minutes.
# ==========================================================

# Get the directory where this script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Define relative paths
USER_SCRIPT_PATH="$SCRIPT_DIR/monitor_users.sh"
NETWORK_SCRIPT_PATH="$SCRIPT_DIR/monitor_network.sh"
ALERT_SCRIPT_PATH="$SCRIPT_DIR/send_alerts.sh"
LOG_PATH="$SCRIPT_DIR/../logs"
BACKUP_PATH="$SCRIPT_DIR/../backup"

# Create directories if they don’t exist
# Créer le dossier de logs s’il n’existe pas
mkdir -p "$LOG_PATH"
mkdir -p "$BACKUP_PATH"  

# Backup current crontab
BACKUP_FILE="$BACKUP_PATH/cron_backup_$(date +%Y%m%d_%H%M%S).bak"
crontab -l > "$BACKUP_FILE" 2>/dev/null

# Write new cron tasks (every 5 minutes)
# Ajouter les nouvelles tâches cron (toutes les 5 minutes)
(
  crontab -l 2>/dev/null
  echo "*/5 * * * * bash $USER_SCRIPT_PATH >> $LOG_PATH/user.log 2>&1"
  echo "*/5 * * * * bash $NETWORK_SCRIPT_PATH >> $LOG_PATH/network.log 2>&1"
  echo "*/5 * * * * bash $ALERT_SCRIPT_PATH >> $LOG_PATH/alerts.log 2>&1"
) | crontab -

echo "Cron jobs added! Monitoring scripts will run every 5 minutes."
