 #!/bin/bash
# Generic deploy script/process outline for projects
# This script is meant to be run on the zone itself, in the project's root directory

# Enable if application uses systemd
# Stop the currently running systemd daemon
#sudo systemctl stop <service_name>

# Enter project name
read -p "Enter project name (this is/will be your folder tag for the project): " project_name

while [[ $project_name == "" ]]
do
    read -p "Enter project name (this is/will be your folder tag for the project): " project_name
done

echo -e "\n######\n";

read -p "Enter absolute path for the ${project_name}'s root directory [Default: /var/www] (NOTE: NO TRAILING SLASH)" root_dir_tmp;
root_directory=${root_dir_tmp:-"/var/www"}

###############
echo -e "\n######\n";
echo -e "Backing up existing instance (if any) . . .\n"; 
if [ -d "${root_directory}/${project_name}-app" ] 
then
    sudo cp -R "${root_directory}/${project_name}-app" "${root_directory}/${project_name}-app-backup"
else
	echo -e "\n\tNote: App instance does not exist\n";
fi

###############
# Cleaning old copy

sudo rm -rf "${root_directory}/${project_name}-git"
sudo rm -rf "${root_directory}/${project_name}-app"

###############
echo -e "\n######\n";

# Pulling latest code from remote git repository
read -p "Enter git repository URL: " git_repo;

echo -e "\n######\n";

read -p "Which branch do you want to clone? [Default: master | Leave blank for default]" git_branch;
branch_name=${git_branch:-master}

echo -e "\n######\n";
echo -e "Cloning ${branch_name} branch from ${git_repo} . . .\n"
sudo git clone --single-branch -b ${branch_name} ${git_repo} "${root_directory}/${project_name}-git"

################
# Set appropriate permissions on the files
# Un-comment this and replace <user/group>
# sudo chgrp -R <group> ${root_directory}/${$project_name}-app
# sudo chmod -R g+w <group>



# Add install/build scripts here e.g. npm run build for node projects/composer for PHP projects


# Enable if application uses systemd
# Restart the systemd daemon for the application
#sudo systemctl start <service_name>
#sudo systemctl status <service_name>
