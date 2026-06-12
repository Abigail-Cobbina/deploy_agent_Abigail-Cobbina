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
