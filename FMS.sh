#!/bin/bash

# ==========================================
# Automated File & System Utility Script
# Author: Sarthak Swain
# Description: Automated directory navigation, 
#              file organization, and log inspection.
# ==========================================

# 1. AUTOMATED FILE ORGANIZATION: Sorts files in a target directory by type
organize_files() {
    local target_dir="${1:-.}"
    echo "[INFO] Starting automated file organization in: $target_dir"
    
    cd "$target_dir" || { echo "[ERROR] Directory not found."; return 1; }

    # Create category folders if they don't exist
    mkdir -p Images Documents Scripts Archives Others

    # Loop through all files (excluding directories)
    for file in *; do
        if [ -f "$file" ]; then
            case "${file##*.}" in
                jpg|jpeg|png|gif|svg)
                    mv "$file" Images/
                    echo "  -> Moved $file to Images/"
                    ;;
                pdf|docx|txt|xlsx|csv)
                    mv "$file" Documents/
                    echo "  -> Moved $file to Documents/"
                    ;;
                sh|py|js|c|java)
                    mv "$file" Scripts/
                    echo "  -> Moved $file to Scripts/"
                    ;;
                zip|tar|gz|rar)
                    mv "$file" Archives/
                    echo "  -> Moved $file to Archives/"
                    ;;
                *)
                    mv "$file" Others/
                    echo "  -> Moved $file to Others/"
                    ;;
            esac
        fi
    done
    echo "[SUCCESS] File organization completed automatically!"
}

# 2. AUTOMATED LOG INSPECTION: Automatically scans logs for errors and warnings
inspect_logs() {
    local log_file="$1"
    if [ -f "$log_file" ]; then
        echo "=========================================="
        echo " AUTOMATED LOG SCAN REPORT: $log_file"
        echo "=========================================="
        echo "-> Total Errors Found:"
        grep -i "error" "$log_file" | wc -l
        echo "-> Recent Error Entries:"
        grep -i "error" "$log_file" | tail -n 5
        echo "-> Total Warnings Found:"
        grep -i "warn" "$log_file" | wc -l
        echo "=========================================="
    else
        echo "[ERROR] Log file '$log_file' does not exist."
    fi
}

# Interactive / CLI Execution Handler
if [ "$#" -eq 0 ]; then
    echo "Usage options:"
    echo "  1. Organize files automatically: ./file_utility.sh organize [path]"
    echo "  2. Inspect logs automatically:   ./file_utility.sh inspect [logfile]"
    exit 0
fi

case "$1" in
    organize)
        organize_files "$2"
        ;;
    inspect)
        inspect_logs "$2"
        ;;
    *)
        echo "Invalid argument. Use 'organize' or 'inspect'."
        exit 1
        ;;
es:
