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
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot/efi";
      };
    };
    kernelParams = [ "mitigations=off" "amd_iommu=on" "default_hugepagesz=1G" "hugepagesz=1G" "hugepages=32" "isolcpus=6-11,18-23" "nohz_full=6-11,18-23" "rcu_nocbs=6-11,18-23" ];
    kernelModules = [ "vfio_virqfd" "vfio_pci" "vfio_iommu_type1" "vfio" ];
    extraModprobeConfig = "options vfio-pci ids=10de:2488,10de:228b,10ec:8161";
    
### IOMMU GROUPS AND DEVICE IDS ###
# GPU - 29 - 10de:2488,10de:228b - 0C:00:0 and 0C:00:1
# NVME - 14 - 1987:5016 - 01:00:0
# ETHERNET - 28 - 10ec:8161 - 08:00:0
# WIFI - 26 - 8086:24fb - 06:00:0
# SATA - 22 - 1022:57a4,1022:7901 - 0A:00:0
# USB/BLUETOOTH - 21 - 1022:57a4,1022:1485,1022:149c - 09:00:0 and 09:00:1 and 09:00:3
    
  };

################
### PACKAGES ###
################
  environment.systemPackages = with pkgs; [
    virt-manager
    stress-ng
  ];
  
################
### GOVERNOR ###
################
  powerManagement.cpuFreqGovernor = "performance";
  
######################
### VIRTUALIZATION ###
######################
  virtualisation = {
      libvirtd = {
        enable = true;
        qemu = {
          package = pkgs.qemu_kvm;
          ovmf.enable = true;
          ovmf.packages = pkgs.OVMFFull;
          swtpm.enable = true;
          runAsRoot = false;
        };
      };
    };

    environment.sessionVariables.LIBVIRT_DEFAULT_URI = [ "qemu:///system" ];
    users.users.colin = {
      extraGroups = [ "libvirtd" "kvm" "qemu-libvirtd" ];
    };
  
}
