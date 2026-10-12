{ self, ... }:
{
  flake.nixosModules.myOptions =
    {
      pkgs,
      wlib,
      lib,
      config,
      options,
      ...
    }:
    {
      options = {
        myoptions = lib.mkOption {
          description = "All personal options";
          default = { };
          type = lib.types.submodule {
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
                type = lib.types.enum [
                  "plasma"
                  "sddm"
                  "cosmic"
                  "ly"
                  "lemurs"
                  "greetd"
                ];
                description = "Choose the display manager";
                default = "sddm";
              };
            };
          };
        };
      };
    };
}
