{ config, pkgs, ... }:

{
############
### BOOT ###
############
  boot = {
    loader = {
      systemd-boot = {
        enable = true;
        configurationLimit = 3;
        editor = false;
      };
      efi.canTouchEfiVariables = true;
    };
    kernelParams = [ "amd_iommu=on" ];
    kernelModules = [ "vfio_virqfd" "vfio_pci" "vfio_iommu_type1" "vfio" ];
    extraModprobeConfig = "options vfio-pci ids=10de:13c0,10de:0fbb";
  };

################
### PACKAGES ###
################
  environment.systemPackages = with pkgs; [
    virt-manager
    win-virtio
  ];
  
######################
### VIRTUALIZATION ###
######################
  virtualisation = {
      libvirtd = {
        enable = true;
        qemuOvmf = true;
        qemuSwtpm = true;
        qemuOvmfPackage = pkgs.OVMFFull;
      };
    };

    environment.sessionVariables.LIBVIRT_DEFAULT_URI = [ "qemu:///system" ];
    users.users.colin = {
      extraGroups = [ "libvirtd" "kvm" "qemu-libvirtd" ];
    };
  
}
  
  
  
