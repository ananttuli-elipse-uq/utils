# Generic deploy script/process outline for projects
# This script is meant to be run on the zone itself, in the project's root directory

# Enable if application uses systemd
# Stop the currently running systemd daemon
#sudo systemctl stop <service_name>

# Enter project name

while [[ $project_name == '' ]]
do
    read -p echo "Enter project name (this is/will be your folder tag for the project): " project_name
done


echo "Enter absolute root directory for deployment [Default: /var/www | Leave blank for default]";
echo "NOTE: DO NOT APPEND A TRAILING SLASH e.g. /var/www/";
read root_dir_tmp;
root_directory=${root_dir_tmp:-/var/www}

###############

# Backing up existing instance (if any)

sudo cp -R ${root_directory}/${project_name}-app ${root_directory}/${project_name}-app-backup

###############
# Cleaning old copy

sudo rm -rf ${root_dir}/${$project_name}-git
sudo rm -rf ${root_dir}/${$project_name}-app

###############
# Pulling latest code from remote git repository
echo "Enter git repository URL: ";
read git_repo;

echo "Which branch do you want to clone? [Default: master | Leave blank for default]";
read git_branch;
branch_name=${git_branch:-master}

echo "Cloning ${branch_name} branch from ${git_repo} . . ."
sudo git clone --single-branch -b ${branch_name} ${git_repo} ${root_directory}/${project_name}-git

################
# Set appropriate permissions on the files
# Un-comment this and replace <user/group>
# sudo chgrp -R <group> ${root_dir}/${$project_name}-app
# sudo chmod -R g+w <group>



# Add install/build scripts here e.g. npm run build for node projects/composer for PHP projects


# Enable if application uses systemd
# Restart the systemd daemon for the application
#sudo systemctl start <service_name>
#sudo systemctl status <service_name>