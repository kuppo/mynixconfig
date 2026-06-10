{ self, ... }:
{
  flake.nixosModules.desktop = { pkgs, lib, config, ... }: {
    options = {
      desktop = {
        wm = lib.mkOption {
          type = lib.types.enum [ "niri" ];
          description = "Choose the window manager want to use.";
          default = "niri";
        };

        de = lib.mkOption {
          type = lib.types.enum [ "noctalia-shell" ];
          description = "Choose the desktop environment want to use.";
          default = "noctalia-shell";
        };

        dm = lib.mkOption {
          type = lib.types.enum [ "plasma" "sddm" "gdm" "cosmic" ];
          description = "Choose the display manager";
          default = "cosmic";
        };
      };
    };

    config = {
      desktop.dm = "sddm";
    };

    imports = [
      self.nixosModules.niriNoctalia
      self.nixosModules.dms
    ];
  };
}
