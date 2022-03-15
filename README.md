# ssh_config

If you are regularly connecting to multiple remote systems over SSH, you’ll find that remembering all of the remote IP addresses, different usernames, non-standard ports, and various command-line options is difficult, if not impossible.

One option would be to create a bash alias for each remote server connection. However, there is another, much better, and more straightforward solution to this problem. OpenSSH allows you to set up a per-user configuration file where you can store different SSH options for each remote machine you connect to.
This article covers the basics of the SSH client configuration file and explains some of the most common configuration options.
Prerequisites
We are assuming that you are using a Linux or a macOS system with an OpenSSH client installed.

SSH Config File Location
OpenSSH client-side configuration file is named config, and it is stored in the .ssh directory under the user’s home directory.

The ~/.ssh directory is automatically created when the user runs the ssh command for the first time. If the directory doesn’t exist on your system, create it using the command below:
mkdir -p ~/.ssh && chmod 700 ~/.ssh
Copy
By default, the SSH configuration file may not exist, so you may need to create it using the touch command :

touch ~/.ssh/config
Copy
This file must be readable and writable only by the user and not accessible by others:

chmod 600 ~/.ssh/config

SSH Config File Structure and Patterns
The SSH Config File takes the following structure:

Host hostname1
    SSH_OPTION value
    SSH_OPTION value

Host hostname2
    SSH_OPTION value

Host *
    SSH_OPTION value
    
Also, you can create a script file. Give the execute permission to the script file by running the command $chmod +x yourscript.sh then run it.
Check the ssh_config.sh script where you will notice it checks if the config file is present or not on ~/.ssh directory. If present you will be asked to provide the details of the host that you want to add.

