{ config, pkgs, ... }:

{
################
### PACKAGES ###
################
  environment.systemPackages = with pkgs; [
    btrfs-progs
    btrbk
    lz4
  ];

#################
### SCRUBBING ###
#################
  services.btrfs.autoScrub = {
    enable = true;
    interval = "weekly";
  };

################
### SECURITY ###
################

  security.sudo = {
    enable = true;
    extraRules = [{
      commands = [
        {
          command = "${pkgs.coreutils-full}/bin/test";
          options = [ "NOPASSWD" ];
        }
        {
          command = "${pkgs.coreutils-full}/bin/readlink";
          options = [ "NOPASSWD" ];
        }
        {
          command = "${pkgs.btrfs-progs}/bin/btrfs";
          options = [ "NOPASSWD" ];
        }
      ];
      users = [ "btrbk" ];
    }];
  };
}
