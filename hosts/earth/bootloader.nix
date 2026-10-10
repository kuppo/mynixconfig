{ self, ... }:
{
  flake.nixosModules.earthBootloader = {
    options = {
    };

    config = {
      boot = {
        plymouth = {
          enable = true;
          # theme = "breeze";
        };
        resumeDevice = "/dev/vg1/swap";
        consoleLogLevel = 0;
        kernelParams = [
          "quiet"
          "udev.log_level=3"
        ];
        initrd = {
          verbose = false;
        };
        loader = {
          systemd-boot = {
            enable = true;
            configurationLimit = 5;
            edk2-uefi-shell.enable = true;
            windows.windowsHome = {
              title = "Windows 11 Home Edition (For RuiRui)";
              efiDeviceHandle = "HD0b";
            };
          };
          efi.canTouchEfiVariables = true;
        };
      };
    };
  };
}
