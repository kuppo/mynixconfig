{self, ...}: {
  flake.nixosModules.earthHardware = {
    config,
    lib,
    pkgs,
    modulesPath,
    ...
  }: {
    imports = [
      (modulesPath + "/installer/scan/not-detected.nix")
    ];
    boot.initrd.availableKernelModules = [
      "nvme"
      "xhci_pci"
      "ahci"
      "usb_storage"
      "usbhid"
      "sd_mod"
    ];
    hardware.bluetooth.enable = true;
    boot.initrd.kernelModules = ["dm-snapshot"];
    boot.kernelModules = ["kvm-amd"];
    boot.extraModulePackages = [];
    boot.initrd.luks.devices.luksroot.device = "/dev/disk/by-uuid/76fad920-5ae9-4afe-9c99-2c28fa566b56";

    graphic = {
      types = [
        "amd"
        "nvidia"
      ];
      primeMode = "offload";
      busIds = {
        amd = "PCI:6@0:0:0";
        nvidia = "PCI:1@0:0:0";
      };
    };

    fileSystems."/" = {
      device = "/dev/mapper/vg1-root";
      fsType = "ext4";
    };

    fileSystems."/boot" = {
      device = "/dev/disk/by-uuid/150B-5029";
      fsType = "vfat";
      options = [
        "fmask=0022"
        "dmask=0022"
      ];
    };

    swapDevices = [
      {device = "/dev/mapper/vg1-swap";}
    ];

    hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  };
}
