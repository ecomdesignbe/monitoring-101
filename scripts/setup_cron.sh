#!/bin/bash

# ==========================================================
# setup_cron.sh - Configure cron to run monitoring scripts
# ==========================================================
# This script adds scheduled jobs (cron) to run your scripts
#     automatically every X minutes.
# Ce script ajoute des tâches planifiées (cron) pour exécuter
#     vos scripts automatiquement toutes les X minutes.
# ==========================================================

# Define script paths (adjust if needed)
USER_SCRIPT_PATH="$HOME/monitoring-101/scripts/monitor_user.sh"
NETWORK_SCRIPT_PATH="$HOME/monitoring-101/scripts/monitor_network.sh"
ALERT_SCRIPT_PATH="$HOME/monitoring-101/scripts/send_alert.sh"
LOG_PATH="$HOME/monitoring-101/logs"

# Create log directory if it doesn’t exist
# Créer le dossier de logs s’il n’existe pas
mkdir -p "$LOG_PATH"

# Backup current crontab
# Sauvegarder la crontab actuelle
crontab -l > cron_backup_$(date +%s).bak 2>/dev/null

# Write new cron tasks (every 5 minutes)
# Ajouter les nouvelles tâches cron (toutes les 5 minutes)
(
  crontab -l 2>/dev/null
  echo "*/5 * * * * bash $USER_SCRIPT_PATH >> $LOG_PATH/user.log 2>&1"
  echo "*/5 * * * * bash $NETWORK_SCRIPT_PATH >> $LOG_PATH/network.log 2>&1"
  echo "*/5 * * * * bash $ALERT_SCRIPT_PATH >> $LOG_PATH/alerts.log 2>&1"
) | crontab -

echo "Cron jobs added! Monitoring scripts will run every 5 minutes."
