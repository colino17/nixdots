#!/bin/bash

# MODIFIED COMMAND
# The aAX option transfers in archive mode which ensures that symbolic links, permissions and attributes are preserved.
# The P option gives you a progress bar and allows you to resume interrupted transfers.
# The exclude option excludes the temporary storage folders, Temp and Recordings, and the deleted bin, from being backed up.
# The delete option means files deleted on the source are to be deleted on the backup as well.
# Storage is the source folder.
# Backup is the detsination folder.
# https://wiki.archlinux.org/index.php/Rsync

rsync -aAXP --delete --exclude={"Temp","Recordings","lost+found",".Trash-1000"} /Storage/ /Backup/
