# MEGA.nz MEGAcmd WebDAV Systemd Service
This repository contains a systemd service for mounting a MEGA.nz WebDAV folder on a Linux system using MEGAcmd.

## Description
The systemd service provided here is designed to automatically mount a WebDAV folder from MEGA.nz at system startup. It uses MEGAcmd, a command-line tool provided by MEGA.nz, to manage the login and setup of the WebDAV server.

## Requirements
`MEGAcmd`: A command-line tool provided by MEGA.nz for accessing your MEGA.nz account.
`DAVfs2`: A Linux tool for mounting WebDAV resources.

## Configuration
Before using the service, configure your MEGA.nz credentials and mount settings in the `/etc/mega-mount/.conf` file.

### Parameters
* `MEGA_USER`: Your MEGA.nz email address.
* `MEGA_PASS`: Your MEGA.nz password.
* `MEGA_PATH`: The MEGA.nz path you want to mount (e.g., //from/xyz@abc.com:Folder).
* `MEGA_PORT`: The port for the WebDAV server (default is 4443).
* `MOUNT_PATH`: The local path where you want to mount the MEGA.nz folder.

## Installation
```bash
cd /etc
git clone https://github.com/ggpwnkthx/mount_mega.nz.git mega-webdav
cd mega-webdav
ln -s .service /etc/systemd/system/mega-webdav.service
systemctl enable mega-webdav.service
```

## Usage
```bash
systemctl start mega-webdav.service
```

# License
Refer to the LICENSE file for licensing information.