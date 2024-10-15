## Turn on BIOS Settings
Enable "IOMMU" and "SVM" in the BIOS.
Set GT710 slot as primary GPU.

## Install NixOS...
Complete the partitioning and install NixOS 22.05 using the new GUI installer.

## Add packages to config...
```
sudo nano /mnt/etc/nixos/configuration.nix
```

```
  environment.systemPackages = with pkgs; [
    wget
    rsync
    unzip
  ];
```

```
sudo nixos-rebuild switch
sudo reboot
```

## Download configs from Github...
```
cd /etc/nixos
sudo wget https://raw.githubusercontent.com/colino17/nixdots/main/update.sh
sudo sh update.sh
```

## Choose device in configuration...
```bash
sudo configuration.nix
```
```nix
  imports =
    [
      ./hardware-configuration.nix
      ./devices/loki.nix
    ];
```

## Rebuild config...
```bash
sudo nixos-rebuild switch
```

## Start Tailscale...
```bash
sudo tailscale up
sudo reboot
```

## Setup VM in Virt-Manager
Using Virt-Manager create a new VM with the Windows 10 ISO as the install media.
Edit the XML file to include all the various options needed including resource allocations, device passthrough (USB controller + Bluetooth, GPU, NVME, Ethernet Card, WIFI Card), CPU pinning/isolation, memory hugepages, etc.
```xml
<domain type="kvm">
  <name>steampod</name>
  <uuid>d2ffabf7-f3b0-4806-9729-c8ccec2ce2e5</uuid>
  <metadata>
    <libosinfo:libosinfo xmlns:libosinfo="http://libosinfo.org/xmlns/libvirt/domain/1.0">
      <libosinfo:os id="http://microsoft.com/win/10"/>
    </libosinfo:libosinfo>
  </metadata>
  <memory unit="KiB">32768000</memory>
  <currentMemory unit="KiB">32768000</currentMemory>
  <memoryBacking>
    <hugepages/>
  </memoryBacking>
  <vcpu placement="static">12</vcpu>
  <cputune>
    <vcpupin vcpu="0" cpuset="6"/>
    <vcpupin vcpu="1" cpuset="18"/>
    <vcpupin vcpu="2" cpuset="7"/>
    <vcpupin vcpu="3" cpuset="19"/>
    <vcpupin vcpu="4" cpuset="8"/>
    <vcpupin vcpu="5" cpuset="20"/>
    <vcpupin vcpu="6" cpuset="9"/>
    <vcpupin vcpu="7" cpuset="21"/>
    <vcpupin vcpu="8" cpuset="10"/>
    <vcpupin vcpu="9" cpuset="22"/>
    <vcpupin vcpu="10" cpuset="11"/>
    <vcpupin vcpu="11" cpuset="23"/>
    <emulatorpin cpuset="0-3"/>
  </cputune>
  <os>
    <type arch="x86_64" machine="pc-q35-7.0">hvm</type>
    <loader readonly="yes" type="pflash">/run/libvirt/nix-ovmf/OVMF_CODE.fd</loader>
    <nvram template="/run/libvirt/nix-ovmf/OVMF_VARS.fd">/var/lib/libvirt/qemu/nvram/steampod_VARS.fd</nvram>
    <bootmenu enable="no"/>
    <smbios mode="host"/>
  </os>
  <features>
    <acpi/>
    <apic/>
    <hyperv mode="custom">
      <relaxed state="on"/>
      <vapic state="on"/>
      <spinlocks state="on" retries="8191"/>
      <vpindex state="on"/>
      <synic state="on"/>
      <stimer state="on"/>
      <reset state="on"/>
      <vendor_id state="on" value="kvm hyperv"/>
      <frequencies state="on"/>
    </hyperv>
    <kvm>
      <hidden state="on"/>
    </kvm>
    <vmport state="off"/>
    <ioapic driver="kvm"/>
  </features>
  <cpu mode="host-passthrough" check="none" migratable="on">
    <topology sockets="1" dies="1" cores="6" threads="2"/>
    <cache mode="passthrough"/>
    <feature policy="require" name="topoext"/>
    <feature policy="disable" name="hypervisor"/>
  </cpu>
  <clock offset="localtime">
    <timer name="rtc" tickpolicy="catchup"/>
    <timer name="pit" tickpolicy="delay"/>
    <timer name="hpet" present="no"/>
    <timer name="hypervclock" present="yes"/>
  </clock>
  <on_poweroff>destroy</on_poweroff>
  <on_reboot>restart</on_reboot>
  <on_crash>destroy</on_crash>
  <pm>
    <suspend-to-mem enabled="no"/>
    <suspend-to-disk enabled="no"/>
  </pm>
  <devices>
    <emulator>/run/libvirt/nix-emulators/qemu-system-x86_64</emulator>
    <controller type="usb" index="0" model="qemu-xhci" ports="15">
      <address type="pci" domain="0x0000" bus="0x01" slot="0x00" function="0x0"/>
    </controller>
    <controller type="pci" index="0" model="pcie-root"/>
    <controller type="pci" index="1" model="pcie-root-port">
      <model name="pcie-root-port"/>
      <target chassis="1" port="0x10"/>
      <address type="pci" domain="0x0000" bus="0x00" slot="0x02" function="0x0" multifunction="on"/>
    </controller>
    <controller type="pci" index="2" model="pcie-root-port">
      <model name="pcie-root-port"/>
      <target chassis="2" port="0x11"/>
      <address type="pci" domain="0x0000" bus="0x00" slot="0x02" function="0x1"/>
    </controller>
    <controller type="pci" index="3" model="pcie-root-port">
      <model name="pcie-root-port"/>
      <target chassis="3" port="0x12"/>
      <address type="pci" domain="0x0000" bus="0x00" slot="0x02" function="0x2"/>
    </controller>
    <controller type="pci" index="4" model="pcie-root-port">
      <model name="pcie-root-port"/>
      <target chassis="4" port="0x13"/>
      <address type="pci" domain="0x0000" bus="0x00" slot="0x02" function="0x3"/>
    </controller>
    <controller type="pci" index="5" model="pcie-root-port">
      <model name="pcie-root-port"/>
      <target chassis="5" port="0x14"/>
      <address type="pci" domain="0x0000" bus="0x00" slot="0x02" function="0x4"/>
    </controller>
    <controller type="pci" index="6" model="pcie-root-port">
      <model name="pcie-root-port"/>
      <target chassis="6" port="0x15"/>
      <address type="pci" domain="0x0000" bus="0x00" slot="0x02" function="0x5"/>
    </controller>
    <controller type="pci" index="7" model="pcie-root-port">
      <model name="pcie-root-port"/>
      <target chassis="7" port="0x16"/>
      <address type="pci" domain="0x0000" bus="0x00" slot="0x02" function="0x6"/>
    </controller>
    <controller type="pci" index="8" model="pcie-root-port">
      <model name="pcie-root-port"/>
      <target chassis="8" port="0x17"/>
      <address type="pci" domain="0x0000" bus="0x00" slot="0x02" function="0x7"/>
    </controller>
    <controller type="pci" index="9" model="pcie-root-port">
      <model name="pcie-root-port"/>
      <target chassis="9" port="0x18"/>
      <address type="pci" domain="0x0000" bus="0x00" slot="0x03" function="0x0" multifunction="on"/>
    </controller>
    <controller type="pci" index="10" model="pcie-root-port">
      <model name="pcie-root-port"/>
      <target chassis="10" port="0x19"/>
      <address type="pci" domain="0x0000" bus="0x00" slot="0x03" function="0x1"/>
    </controller>
    <controller type="pci" index="11" model="pcie-root-port">
      <model name="pcie-root-port"/>
      <target chassis="11" port="0x1a"/>
      <address type="pci" domain="0x0000" bus="0x00" slot="0x03" function="0x2"/>
    </controller>
    <controller type="pci" index="12" model="pcie-root-port">
      <model name="pcie-root-port"/>
      <target chassis="12" port="0x1b"/>
      <address type="pci" domain="0x0000" bus="0x00" slot="0x03" function="0x3"/>
    </controller>
    <controller type="pci" index="13" model="pcie-root-port">
      <model name="pcie-root-port"/>
      <target chassis="13" port="0x1c"/>
      <address type="pci" domain="0x0000" bus="0x00" slot="0x03" function="0x4"/>
    </controller>
    <controller type="pci" index="14" model="pcie-root-port">
      <model name="pcie-root-port"/>
      <target chassis="14" port="0x1d"/>
      <address type="pci" domain="0x0000" bus="0x00" slot="0x03" function="0x5"/>
    </controller>
    <controller type="sata" index="0">
      <address type="pci" domain="0x0000" bus="0x00" slot="0x1f" function="0x2"/>
    </controller>
    <input type="mouse" bus="ps2"/>
    <input type="keyboard" bus="ps2"/>
    <audio id="1" type="none"/>
    <video>
      <model type="qxl" ram="65536" vram="65536" vgamem="16384" heads="1" primary="yes"/>
      <address type="pci" domain="0x0000" bus="0x00" slot="0x01" function="0x0"/>
    </video>
    <hostdev mode="subsystem" type="pci" managed="yes">
      <source>
        <address domain="0x0000" bus="0x0c" slot="0x00" function="0x0"/>
      </source>
      <address type="pci" domain="0x0000" bus="0x03" slot="0x00" function="0x0"/>
    </hostdev>
    <hostdev mode="subsystem" type="pci" managed="yes">
      <source>
        <address domain="0x0000" bus="0x01" slot="0x00" function="0x0"/>
      </source>
      <boot order="2"/>
      <address type="pci" domain="0x0000" bus="0x04" slot="0x00" function="0x0"/>
    </hostdev>
    <hostdev mode="subsystem" type="pci" managed="yes">
      <source>
        <address domain="0x0000" bus="0x08" slot="0x00" function="0x0"/>
      </source>
      <address type="pci" domain="0x0000" bus="0x06" slot="0x00" function="0x0"/>
    </hostdev>
    <hostdev mode="subsystem" type="pci" managed="yes">
      <source>
        <address domain="0x0000" bus="0x06" slot="0x00" function="0x0"/>
      </source>
      <address type="pci" domain="0x0000" bus="0x07" slot="0x00" function="0x0"/>
    </hostdev>
    <hostdev mode="subsystem" type="pci" managed="yes">
      <source>
        <address domain="0x0000" bus="0x0d" slot="0x00" function="0x0"/>
      </source>
      <address type="pci" domain="0x0000" bus="0x02" slot="0x00" function="0x0"/>
    </hostdev>
    <hostdev mode="subsystem" type="pci" managed="yes">
      <source>
        <address domain="0x0000" bus="0x0d" slot="0x00" function="0x1"/>
      </source>
      <address type="pci" domain="0x0000" bus="0x05" slot="0x00" function="0x0"/>
    </hostdev>
    <hostdev mode="subsystem" type="pci" managed="yes">
      <source>
        <address domain="0x0000" bus="0x0a" slot="0x00" function="0x0"/>
      </source>
      <address type="pci" domain="0x0000" bus="0x08" slot="0x00" function="0x0"/>
    </hostdev>
    <hostdev mode="subsystem" type="pci" managed="yes">
      <source>
        <address domain="0x0000" bus="0x0a" slot="0x00" function="0x1"/>
      </source>
      <address type="pci" domain="0x0000" bus="0x09" slot="0x00" function="0x0"/>
    </hostdev>
    <hostdev mode="subsystem" type="pci" managed="yes">
      <source>
        <address domain="0x0000" bus="0x0a" slot="0x00" function="0x3"/>
      </source>
      <address type="pci" domain="0x0000" bus="0x0a" slot="0x00" function="0x0"/>
    </hostdev>
    <hostdev mode="subsystem" type="pci" managed="yes">
      <source>
        <address domain="0x0000" bus="0x09" slot="0x00" function="0x0"/>
      </source>
      <address type="pci" domain="0x0000" bus="0x0b" slot="0x00" function="0x0"/>
    </hostdev>
    <watchdog model="itco" action="reset"/>
    <memballoon model="virtio">
      <address type="pci" domain="0x0000" bus="0x0c" slot="0x00" function="0x0"/>
    </memballoon>
  </devices>
</domain>

```



## Tweak Performance in BIOS
