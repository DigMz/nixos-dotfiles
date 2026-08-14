# IF USING THIS FROM GITHUB, REPLACE THIS FILE WITH YOUR OWN FROM 
#   'nixos-generate-config' THIS IS TWEAKED FOR MY OWN LAPTOP

{ config, lib, pkgs, modulesPath, ... }:

{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot = {
    initrd.availableKernelModules = [ "xhci_pci" "thunderbolt" "vmd" "ahci" "nvme" "usbhid" "usb_storage" "sd_mod" ];
    initrd.kernelModules = [ ];
    kernelModules = [ "kvm-intel" "intel_backlight" ];
    extraModulePackages = [ ];
    kernelParams = [
      "acpi_backlight=native"
    ];
  };

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/110b08b4-2f84-4f24-b467-d2ac19c2b088";
    fsType = "ext4";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/9738-EA1E";
    fsType = "vfat";
    options = [ "fmask=0022" "dmask=0022" ];
  };

  swapDevices = [ { device = "/dev/disk/by-uuid/97cdd89e-a40e-4ea8-b835-a723bb1fe614"; } ];

  hardware.graphics.enable = true;

  services.xserver.videoDrivers = [ 
    "modesetting"
    "nvidia" 
  ];

  powerManagement.enable = true;

  hardware = {
    cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

    nvidia = {
      open = true;

      modesetting.enable = true;

      powerManagement.enable = true;
      powerManagement.finegrained = true;

      package = config.boot.kernelPackages.nvidiaPackages.stable;
      nvidiaSettings = true;

      prime = {
        offload.enable = true;
        offload.enableOffloadCmd = true;

        intelBusId = "PCI:0@0:2:0";
        nvidiaBusId = "PCI:1@0:0:0";
      };
    };

    bluetooth.enable = true;
  };

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
}
