#!/usr/bin/env bash
# This script automates the setup of a Student Attendance Tracker project

read -p "Enter project name: " input

project_dir="attendance_tracker_${input}"

mkdir -p "$project_dir/Helpers"
mkdir -p "$project_dir/reports"

touch "$project_dir/attendance_checker.py"
touch "$project_dir/Helpers/assets.csv"
touch "$project_dir/Helpers/config.json"
touch "$project_dir/reports/reports.log"

echo "Project directory created successfully!"

# Ask the user if they want to update thresholds
read -p "Do you want to update attendance thresholds? (yes/no): " answer

if [ "$answer" = "yes" ]; then
    read -p "Enter new Warning threshold (default 75): " warning
    read -p "Enter new Failure threshold (default 50): " failure
    sed -i "s/\"warning\": 75/\"warning\": $warning/" "$project_dir/Helpers/config.json"
    sed -i "s/\"failure\": 50/\"failure\": $failure/" "$project_dir/Helpers/config.json"
    echo "Thresholds updated successfully!"
fi
