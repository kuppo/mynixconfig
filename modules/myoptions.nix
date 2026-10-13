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
            options = {
              hardware = {
                graphic = {
                  types = lib.mkOption {
                    type = lib.types.listOf (
                      lib.types.enum [
                        "intel"
                        "amd"
                        "nvidia"
                      ]
                    );
                    description = "Choose what configuration of the graphics of the PC";
                    default = [ ];
                  };
                  primeMode = lib.mkOption {
                    type = lib.types.enum [
                      "sync"
                      "rsync"
                      "offload"
                    ];
                    description = "Which mode to use for power managerment. 'offload' only works for wayland.";
                    default = "sync";
                  };
                  busIds = lib.mkOption {
                    description = "GPU bus IDs";
                    default = { };
                    type = lib.types.submodule {
                      options = {
                        intel = lib.mkOption {
                          type = lib.types.str;
                          description = "Intel GPU bus id. 'nix shell nixpkgs#pciutils -c lspci -D -d ::03xx'. <domain>:<bus>:<device>.<func> -> PCI:<bus>@<domain>:<device>:<func>";
                          default = "";
                        };
                        amd = lib.mkOption {
                          type = lib.types.str;
                          description = "AMD GPU bus id. 'nix shell nixpkgs#pciutils -c lspci -D -d ::03xx'";
                          default = "";
                        };
                        nvidia = lib.mkOption {
                          type = lib.types.str;
                          description = "Nvidia iGPU bus id. 'nix shell nixpkgs#pciutils -c lspci -D -d ::03xx'";
                          default = "";
                        };
                      };
                    };
                  };
                };
              };
              enableSshd = lib.mkEnableOption "Whether enable the sshd.";
              desktop = {
                userTerminal = lib.mkOption {
                  type = lib.types.enum [
                    "alacritty"
                    "wezterm"
                    "kitty"
                  ];
                  description = ''User configured terminal. One of "alacritty", "wezterm" and "kitty"'';
                };
                wm = lib.mkOption {
                  type = lib.types.enum [ "niri" ];
                  description = "Choose the window manager want to use.";
                  default = "niri";
                };

                de = lib.mkOption {
                  type = lib.types.enum [
                    "noctalia"
                  ];
                  description = "Choose the desktop environment want to use.";
                  default = "noctalia";
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
    };
}
