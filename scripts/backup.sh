#! /bin/bash

coloron='\033[30;46;5;1m'
coloroff='\033[0m'

set -e

##################
## BACKUP FILES ##
##################

# CREATE NEW SNAPSHOT
echo -e "${coloron}Creating new FILES snapshot...${coloroff}"
btrfs subvolume snapshot -r /Storage/Files /Storage/Snapshots/Files_New
# SEND INCREMENTAL BACKUP
echo -e "${coloron}Sending new FILES snapshot to KHONSU...${coloroff}"
btrfs send -p /Storage/Snapshots/Files /Storage/Snapshots/Files_New | ssh root@khonsu btrfs receive -v /Backup
# DELETE PREVIOUS SNAPSHOT
echo -e "${coloron}Deleting previous FILES snapshot from OSIRIS...${coloroff}"
btrfs subvolume delete /Storage/Snapshots/Files
# DELETE PREVIOUS BACKUP
echo -e "${coloron}Deleting previous FILES snapshot from KHONSU...${coloroff}"
ssh root@khonsu btrfs subvolume delete /Backup/Files
# RENAME PREVIOUS SNAPSHOT
echo -e "${coloron}Renaming new FILES snapshot on OSIRIS...${coloroff}"
mv /Storage/Snapshots/Files_New /Storage/Snapshots/Files
# RENAME NEW BACKUP
echo -e "${coloron}Renaming new FILES snapshot on KHONSU...${coloroff}"
ssh root@khonsu mv /Backup/Files_New /Backup/Files

##################
## BACKUP MEDIA ##
##################
# CREATE NEW SNAPSHOT
echo -e "${coloron}Creating new MEDIA snapshot...${coloroff}"
btrfs subvolume snapshot -r /Storage/Media /Storage/Snapshots/Media_New
# SEND INCREMENTAL BACKUP
echo -e "${coloron}Sending new MEDIA snapshot to KHONSU...${coloroff}"
btrfs send -p /Storage/Snapshots/Media /Storage/Snapshots/Media_New | ssh root@khonsu btrfs receive -v /Backup
# DELETE PREVIOUS SNAPSHOT
echo -e "${coloron}Deleting previous MEDIA snapshot from OSIRIS...${coloroff}"
btrfs subvolume delete /Storage/Snapshots/Media
# DELETE PREVIOUS BACKUP
echo -e "${coloron}Deleting previous MEDIA snapshot from KHONSU...${coloroff}"
ssh root@khonsu btrfs subvolume delete /Backup/Media
# RENAME PREVIOUS SNAPSHOT
echo -e "${coloron}Renaming new MEDIA snapshot on OSIRIS...${coloroff}"
mv /Storage/Snapshots/Media_New /Storage/Snapshots/Media
# RENAME NEW BACKUP
echo -e "${coloron}Renaming new MEDIA snapshot on KHONSU...${coloroff}"
ssh root@khonsu mv /Backup/Media_New /Backup/Media

####################
## BACKUP CONFIGS ##
####################
# CREATE NEW SNAPSHOT
echo -e "${coloron}Creating new CONFIGS snapshot...${coloroff}"
btrfs subvolume snapshot -r /Storage/Configs /.snapshots/Configs_New
# SEND INCREMENTAL BACKUP
echo -e "${coloron}Sending new CONFIGS snapshot to KHONSU...${coloroff}"
btrfs send -p /.snapshots/Configs /.snapshots/Configs_New | ssh root@khonsu btrfs receive -v /Backup
# DELETE PREVIOUS SNAPSHOT
echo -e "${coloron}Deleting previous CONFIGS snapshot from OSIRIS...${coloroff}"
btrfs subvolume delete /.snapshots/Configs
# DELETE PREVIOUS BACKUP
echo -e "${coloron}Deleting previous CONFIGS snapshot from KHONSU...${coloroff}"
ssh root@khonsu btrfs subvolume delete /Backup/Configs
# RENAME PREVIOUS SNAPSHOT
echo -e "${coloron}Renaming new CONFIGS snapshot on OSIRIS...${coloroff}"
mv /.snapshots/Configs_New /.snapshots/Configs
# RENAME NEW BACKUP
echo -e "${coloron}Renaming new CONFIGS snapshot on KHONSU...${coloroff}"
ssh root@khonsu mv /Backup/Configs_New /Backup/Configs

#####################
## POWEROFF KHONSU ##
#####################
echo -e "${coloron}Shutting Down KHONSU...${coloroff}"
ssh root@khonsu poweroff
