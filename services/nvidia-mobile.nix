{ config, pkgs, ... }:

{

# DEFAULT CONFIGURATION
  services.xserver.videoDrivers = [ "modesetting" ];
  boot.initrd.kernelModules = [ "amdgpu" ];
  boot.blacklistedKernelModules = [ "nvidia" "nvidia_uvm" "nvidia_modeset" "nvidia_drm" "nouveau" ];
  services.udev.extraRules = ''
    ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x040300", ATTR{power/control}="auto", ATTR{remove}="1"
    ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x03[0-9]*", ATTR{power/control}="auto", ATTR{remove}="1"
  '';

# GAMING CONFIGURATION
  specialisation."Gaming".configuration = {
    services.xserver.videoDrivers = [ "nvidia" ];
    boot.blacklistedKernelModules = [ "nouveau" ];
    services.udev.extraRules = pkgs.lib.mkForce "";
    hardware.nvidia = {
      modesetting.enable = true;
      open = false; 
      nvidiaSettings = true;
      prime = {
        sync.enable = true; # All apps run on NVIDIA by default
        amdgpuBusId = "PCI:4:0:0";  
        nvidiaBusId = "PCI:1:0:0";  
      };
    };
  };

}
