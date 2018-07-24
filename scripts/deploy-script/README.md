## deploy-script.sh
This interactive script is a basic template for project deployment. It functions as follows:

* Creates a backup of the project if an existing copy is detected (i.e. the `<project_name>-app` directory is detected)
* Cleans up the older copy
* Checks out the specified branch from the specified repository into `<project_name>-git`
* Copies over all files from `<project_name>-git` to `<project_name>-app`

This script is not a complete deploy script since every project has different requirements, but a general process is suggested in the script.

