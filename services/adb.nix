{ config, pkgs, ... }:

let inherit (import ../variables.nix) var_username; in

{
  environment.systemPackages = with pkgs; [
    android-tools
  ];
  users.users.${var_username}.extraGroups = ["adbusers"];
}
