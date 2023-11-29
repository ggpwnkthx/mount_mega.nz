# mount_mega.nz

## Overview

This project provides a set of tools to mount MEGA.nz WebDAV services on a Linux system. It includes a shell script `mount_mega.sh` for mounting and unmounting the service and a systemd service file `mount-mega.example.service` for managing the mount as a system service.

## Prerequisites

A MEGA.nz account.

`MEGAcmd` and `davfs2` installed.

## Installation

Clone this repository or download the scripts. Ensure the mount_mega.sh script is executable: `chmod +x mount_mega.sh`

## Usage

### Manual Mounting

#### Mount

`./mega_mount.sh --credentials /path/to/credentials --remote //from/abc@xyz.com:Folder --local /mnt/path/to/mount`

or

`./mega_mount.sh --user username --pass password --remote //from/abc@xyz.com:Folder --local /mnt/path/to/mount`

#### Unmount

`./mount_mega.sh --unmount --local /mnt/path/to/mount`

### System Service

Copy `mount-mega.example.service` to `/etc/systemd/system/` and rename to fit your needs.

Edit the service file to specify paths and user details.

Enable the service: `systemctl enable [service-name]`

Start the service: `systemctl start [service-name]`

## Credentials

Should be a plain text file with restricted permissions.

Example: `username password`

# License

This project is licensed under the MIT License - see the LICENSE file for details.
