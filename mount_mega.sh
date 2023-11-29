#!/bin/bash

# Initialize variables
credentialsFile=""
remotePath=""
localMountPoint=""
username=""
password=""

# Function to check if a command exists. Exits the script if the command is not found.
check_command() {
    if ! command -v $1 &> /dev/null
    then
        echo "Error: Required command '$1' not found. Please install it and retry."
        exit 1
    fi
}

# Check for required commands
check_command mega-login
check_command mount.davfs

# Function to display script usage instructions
usage() {
    echo "Usage: $0 [--credentials FILE | --user USERNAME --pass PASSWORD] [--remote REMOTE_PATH] [--local LOCAL_MOUNT_POINT]"
    echo "       $0 --unmount [--local LOCAL_MOUNT_POINT]"
    exit 1
}

# Function to handle the mounting process
start() {
    # Check if credentials are provided via file or directly
    if [ -n "$credentialsFile" ]; then
        if [ -f "$credentialsFile" ]; then
            IFS=$'\n' read -d '' -r -a credentials < "$credentialsFile"
            username=${credentials[0]}
            password=${credentials[1]}
        else
            echo "Error: Credentials file not found."
            exit 1
        fi
    elif [ -z "$username" ] || [ -z "$password" ]; then
        echo "Error: Either credentials file or username and password must be provided."
        exit 1
    fi

    # Log in to MEGA using the provided credentials
    mega-login $username $password

    # Generate a WebDAV URL for the specified remote path and store it
    mega_webdav=$(mega-webdav "$remotePath" | grep -o 'http://[^ ]*')

    # Mount the WebDAV share to the specified local directory
    mount -t davfs $mega_webdav $localMountPoint
}

# Function to handle the unmounting process
stop() {
    umount $localMountPoint
    mega-webdav --d --all
}

# Parse command-line options
unmountFlag=0

while [[ $# -gt 0 ]]; do
    key="$1"

    case $key in
        --credentials)
        credentialsFile="$2"
        shift # past argument
        shift # past value
        ;;
        --user)
        username="$2"
        shift # past argument
        shift # past value
        ;;
        --pass)
        password="$2"
        shift # past argument
        shift # past value
        ;;
        --remote)
        remotePath="$2"
        shift # past argument
        shift # past value
        ;;
        --local)
        localMountPoint="$2"
        shift # past argument
        shift # past value
        ;;
        --unmount)
        unmountFlag=1
        shift # past argument
        ;;
        *)
        usage
        ;;
    esac
done

# Execute the appropriate function
if [ $unmountFlag -eq 1 ]; then
    if [ -z "$localMountPoint" ]; then
        echo "Error: Local mount point is required for unmounting."
        usage
    fi
    stop
else
    if [ -z "$remotePath" ] || [ -z "$localMountPoint" ]; then
        echo "Error: Remote path and local mount point are required for mounting."
        usage
    fi
    start
fi
