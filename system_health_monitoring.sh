#!/bin/bash

CPU_THRESHOLD=80
MEMORY_THRESHOLD=80
DISK_THRESHOLD=80
LOG_FILE="/var/log/system_health.log"

log_alert() {
    local message=$1
    echo "$(date): $message" >> $LOG_FILE
}

cpu_usage() {
    usage=$(top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print 100 - $1}')
    echo "CPU usage: $usage%"
    if (( $(echo "$usage > $CPU_THRESHOLD" | bc -l) )); then
        log_alert "High CPU usage: $usage%"
    fi
}


memory_usage() {
    usage=$(free | grep Mem | awk '{print $3/$2 * 100.0}')
    echo "Memory usage: $usage%"
    if (( $(echo "$usage > $MEMORY_THRESHOLD" | bc -l) )); then
        log_alert "High memory usage: $usage%"
    fi
}


disk_usage() {
    usage=$(df / | grep / | awk '{ print $5 }' | sed 's/%//g')
    echo "Disk usage: $usage%"
    if [ $usage -gt $DISK_THRESHOLD ]; then
        log_alert "High disk usage: $usage%"
    fi
}


check_processes() {
    processes=$(ps aux --no-heading | wc -l)
    echo "Running processes: $processes"
    if [ $processes -gt 300 ]; then
        log_alert "High number of running processes: $processes"
    fi
}


cpu_usage
memory_usage
disk_usage
check_processes
