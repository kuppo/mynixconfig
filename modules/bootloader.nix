{ self, ... }:
{
  flake.nixosModules.bootloader = {
    options = {
    };

    config = {
      boot.loader = {
        systemd-boot = {
          enable = true;
          configurationLimit = 5;
          edk2-uefi-shell.enable = true;
        };
        efi.canTouchEfiVariables = true;
      };
    };
  };
}
