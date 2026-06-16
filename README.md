# deploy_agent_Abigail-Cobbina
This project contains a shell script that automates the setup of a Student Attendance Tracker project. This README explains:
1. The steps a user can follow to run the script.
2. An explanation on how a user can trigger the archive feature. 

## Requirements
Make sure you have access to a Linux/Ubuntu terminal, Git installed, and Python 3 installed.

## How to Run the Script

1. Open the Linux/Ubuntu terminal and clone the repository. Cloning means downloading the project from GitHub to your computer.
Type this command and press Enter: **git clone https://github.com/Abigail-Cobbina/deploy_agent_Abigail-Cobbina.git**

2. Move into the project folder called deploy_agent_Abigail-Cobbina. To achieve this, type **cd ~/deploy_agent_Abigail-Cobbina** in the terminal and press the Enter key to run the command.

3. Make the script executable (this gives the script permission to run): To achieve this, type and run **chmod +x setup_project.sh** in the terminal.

4. Run the script: To achieve this, type and run **./setup_project.sh**

5. When prompted, enter a project name.

6. The script will automatically:

   * Create the required project folders and files.
   * Add the attendance tracker source files.
   * Ask if you would like to update the attendance warning and failure thresholds. If yes, you then go ahead and update the thresholds.
   * Check whether Python 3 is installed on your system.

## Archive Feature

The script includes a signal trap that handles user interruptions. To test this feature:

1. Start the script by running: **./setup_project.sh**

2. While the script is running (before it finishes), press: **Ctrl + C**

3. The script will:

   * Create an archive named **attendance_tracker_<project_name>_archive**.
   * Delete the incomplete project directory.
   * Exit safely.

This helps keep the workspace clean if the setup process is interrupted before completion.

## Video Walkthrough

Here is a link to my project demonstration video:
https://drive.google.com/file/d/1ysunsXtipNimmvTscwphrNc3bNCEu-o6/view?usp=sharing
