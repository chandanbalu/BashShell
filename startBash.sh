#!/bin/bash
#
# This bash script acts as reusable template for writting new shell sctipts on Linux.
#
# Usage:
# sh startBash.sh param1 param1 param1
# Example:
# sh startBash.sh username /tmp/output.log /data/sample_data.csv
#
# Contriutors: Chandan Balu
# More info here: Concepts and Theory https://github.com/chandanbalu/BashShell
#
#
# Info: getopts 
# https://wiki.bash-hackers.org/howto/getopts_tutorial
#
# GLOBAL VARIABLES
SERVER_NAME='ppsserver'
USER_NAME='cbalu'
PASSWORD='password'

# Function that diplays usage of the script.
usage() {
  # Display the usage and exit.
  echo "Usage: ${0} [-nsv] [-f FILE]" >&2
  echo "  -f FILE  Use FILE for the list of servers. Default: ${SERVER_LIST}." >&2
  echo '  -n       Dry run mode. Display the COMMAND that would have been executed and exit.' >&2
  echo '  -s       Execute the COMMAND using sudo on the remote server.' >&2
  echo '  -v       Verbose mode. Displays the server name before executing COMMAND.' >&2
  exit 1
}

# Parse the options.
while getopts f:nsv OPTION
do
  case ${OPTION} in
    f) CONFIG_FILE="${OPTARG}" ;;
    n) DRY_RUN='true' ;;
    s) SUDO='sudo' ;;
    v) VERBOSE='true' ;;
    ?) usage ;;
  esac
done

# If the user doesn't supply at least one argument, give them help.
if [[ "${#}" -lt 1 ]]
then
  usage
else
  echo "Your command line contains $# arguments"
fi

# Make sure the CONFIG_FILE file exists.
if [[ ! -e "${CONFIG_FILE}" ]]
then
  echo "Cannot open configuration file ${CONFIG_FILE}." >&2
  exit 1
fi
