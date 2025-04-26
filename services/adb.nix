{ config, pkgs, ... }:

let inherit (import ../variables.nix) var_username; in

{
  programs.adb.enable = true;
  users.users.${var_username}.extraGroups = ["adbusers"];
}
