{ config, pkgs, ... }:

{
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia.open = false;
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };
  services.switcherooControl.enable = true;
  hardware.nvidia.prime = {
    offload.enable = true;
    amdgpuBusId = "PCI:4:00:0";
    nvidiaBusId = "PCI:1:00:0";
  };
}
