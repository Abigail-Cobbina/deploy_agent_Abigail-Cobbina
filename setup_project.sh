#!/usr/bin/env bash
# This script automates the setup of a Student Attendance Tracker project

read -p "Enter project name: " input
project_dir="attendance_tracker_${input}"
if [ -d "$project_dir" ]; then
    echo "Error: Directory $project_dir already exists!"
    exit 1
fi

# Handle Ctrl+C signal
cleanup() {
    echo "Script interrupted! Cleaning up..."
    tar -czf "${project_dir}_archive" "$project_dir"
    rm -rf "$project_dir"
    echo "Archive created: ${project_dir}_archive"
    exit 1
}

trap cleanup SIGINT

mkdir -p "$project_dir/Helpers"
mkdir -p "$project_dir/reports"

# Create files with actual content
cat > "$project_dir/attendance_checker.py" << 'EOF'
import csv
import json
import os
from datetime import datetime
def run_attendance_check():
    with open('Helpers/config.json', 'r') as f:
        config = json.load(f)
    if os.path.exists('reports/reports.log'):
        timestamp = datetime.now().strftime("%Y%m%d_%H%M%S")
        os.rename('reports/reports.log', f'reports/reports_{timestamp}.log.archive')
    with open('Helpers/assets.csv', mode='r') as f, open('reports/reports.log', 'w') as log:
        reader = csv.DictReader(f)
        total_sessions = config['total_sessions']
        log.write(f"--- Attendance Report Run: {datetime.now()} ---\n")
        for row in reader:
            name = row['Names']
            email = row['Email']
            attended = int(row['Attendance Count'])
            attendance_pct = (attended / total_sessions) * 100
            message = ""
            if attendance_pct < config['thresholds']['failure']:
                message = f"URGENT: {name}, your attendance is {attendance_pct:.1f}%. You will fail this class."
            elif attendance_pct < config['thresholds']['warning']:
                message = f"WARNING: {name}, your attendance is {attendance_pct:.1f}%. Please be careful."
            if message:
                if config['run_mode'] == "live":
                    log.write(f"[{datetime.now()}] ALERT SENT TO {email}: {message}\n")
                    print(f"Logged alert for {name}")
                else:
                    print(f"[DRY RUN] Email to {email}: {message}")
if __name__ == "__main__":
    run_attendance_check()
EOF

cat > "$project_dir/Helpers/assets.csv" << 'EOF'
Email,Names,Attendance Count,Absence Count
alice@example.com,Alice Johnson,14,1
bob@example.com,Bob Smith,7,8
charlie@example.com,Charlie Davis,4,11
diana@example.com,Diana Prince,15,0
EOF

cat > "$project_dir/Helpers/config.json" << 'EOF'
{
    "thresholds": {
        "warning": 75,
        "failure": 50
    },
    "run_mode": "live",
    "total_sessions": 15
}
EOF

cat > "$project_dir/reports/reports.log" << 'EOF'
--- Attendance Report Run: 2026-02-06 18:10:01.468726 ---
[2026-02-06 18:10:01.469363] ALERT SENT TO bob@example.com: URGENT: Bob Smith, your attendance is 46.7%. You will fail this class.
[2026-02-06 18:10:01.469424] ALERT SENT TO charlie@example.com: URGENT: Charlie Davis, your attendance is 26.7%. You will fail this class.
EOF

echo "Project directory created successfully!"

# Ask the user if they want to update thresholds
read -p "Do you want to update attendance thresholds? (yes/no): " answer
if [ "$answer" = "yes" ]; then
    read -p "Enter new Warning threshold (default 75): " warning
    read -p "Enter new Failure threshold (default 50): " failure
    if ! [[ "$warning" =~ ^[0-9]+$ ]] || ! [[ "$failure" =~ ^[0-9]+$ ]]; then
        echo "Invalid input! Thresholds must be numbers. Keeping default values."
    else
        sed -i "s/\"warning\": 75/\"warning\": $warning/" "$project_dir/Helpers/config.json"
        sed -i "s/\"failure\": 50/\"failure\": $failure/" "$project_dir/Helpers/config.json"
        echo "Thresholds updated successfully!"
    fi
fi

# Environment validation - check if python3 is installed
if python3 --version 2>/dev/null; then
    echo "Python3 is installed. Environment is ready!"
else
    echo "Warning: Python3 is not installed. Please install it to run the application."
fi
