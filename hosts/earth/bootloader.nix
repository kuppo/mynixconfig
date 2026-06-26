{ self, ... }:
{
  flake.nixosModules.earthBootloader = {
    options = {
    };

    config = {
      boot.loader = {
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
}
