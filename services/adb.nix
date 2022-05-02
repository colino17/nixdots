{ config, pkgs, ... }:
{
  programs.adb.enable = true;
  users.users.colin.extraGroups = ["adbusers"];
}
