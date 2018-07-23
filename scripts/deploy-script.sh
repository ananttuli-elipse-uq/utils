# Generic deploy script/process outline for projects
# This script is meant to be run on the zone itself, in the project's root directory

# Enable if application uses systemd
# Stop the currently running systemd daemon
#sudo systemctl stop <service_name>

# Enter project name
read -p "Enter project name (this is/will be your folder tag for the project): " project_name

while [[ $project_name == '' ]]
do
    read -p "Enter project name (this is/will be your folder tag for the project): " project_name
done

echo "\n######\n";

echo "Enter absolute root directory for deployment [Default: /var/www | Leave blank for default]\n";
echo "NOTE: DO NOT APPEND A TRAILING SLASH e.g. /var/www/";
read root_dir_tmp;
root_directory=${root_dir_tmp:-/var/www}

###############
echo "\n######\n";
echo "Backing up existing instance (if any) . . .\n"; 
if [ -d ${root_directory}/${project_name}-app ] 
then
    sudo cp -R ${root_directory}/${project_name}-app ${root_directory}/${project_name}-app-backup
else
	echo "App instance does not exist";
fi

###############
# Cleaning old copy

sudo rm -rf ${root_dir}/${$project_name}-git
sudo rm -rf ${root_dir}/${$project_name}-app

###############
echo "\n######\n";

# Pulling latest code from remote git repository
read -p "Enter git repository URL: " git_repo;

echo "\n######\n";

read -p "Which branch do you want to clone? [Default: master | Leave blank for default]" git_branch;
branch_name=${git_branch:-master}

echo "\n######\n";
echo "Cloning ${branch_name} branch from ${git_repo} . . .\n"
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