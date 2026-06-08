{ self, ... }:
{
  flake.nixosModules.graphics = { pkgs, lib, config, ... } :
  let
    elemIn = type: builtins.elem type config.graphic.types;

    isWayland = config.programs.hyprland.enable 
              || config.programs.sway.enable 
              || config.programs.niri.enable
              || config.services.desktopManager.gnome.enable
              || config.services.desktopManager.plasma6.enable;

    cfgBus = config.graphic.busIds;
    hasIntel = (cfgBus.intel != "");
    hasAmd = (cfgBus.amd != "");
    hasNvidia = (cfgBus.nvidia != "");
  in
  {
    options = {
      graphic = {
        types = lib.mkOption {
          type = lib.types.listOf (lib.types.enum [ "intel" "amd" "nvidia" ]);
          description = "Choose what configuration of the graphics of the PC";
          default = [];
        };
        primeMode = lib.mkOption {
          type = lib.types.enum [ "sync" "rsync" "offload" ];
          description = "Which mode to use for power managerment. 'offload' only works for wayland.";
          default = "sync";
        };
        busIds = lib.mkOption {
          description = "GPU bus IDs";
          default = {};
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

    config = lib.mkMerge [
      {
        hardware.graphics.enable = true;
        users.users.peng.extraGroups = [ "video" "render" ];
      }

      # Intel
      (lib.mkIf (elemIn "intel") {
        services.xserver.videoDrivers = [ "modesetting" ];
        hardware.graphics = {
          extraPackages = with pkgs; [
            intel-media-driver     # VA-API (iHD) userspace
            vpl-gpu-rt             # oneVPL (QSV) runtime
            intel-compute-runtime  # OpenCL (NEO) + Level Zero for Arc/Xe
          ];
        };
        environment.sessionVariables = {
          LIBVA_DRIVER_NAME = "iHD";     # Prefer the modern iHD backend
        };

        hardware.enableRedistributableFirmware = true;
        boot.kernelParams = [ "i915.enable_guc=3" ];
      })

      # AMD
      (lib.mkIf (elemIn "amd") {
        hardware.amdgpu.opencl = {
          enable = true;
        };
        hardware.graphics = {
          extraPackages = with pkgs; [
            # amd-vlk # AMDVLK. Discontinued. If have issue with RADV, enable it.
          ];
        };
        services.lact.enable = true;  # Allow overclocking
      })

      # Nvidia
      (lib.mkIf (elemIn "nvidia") {
        services = {
          xserver.videoDrivers = [ "nvidia" ];
        };

        boot.blacklistedKernelModules = [ "nouveau" ];

        hardware = lib.mkMerge [
          {
            nvidia.open = true;
            nvidia.modesetting.enable = true;
          }

          # PRIME settings
          {
            nvidia.prime = {
              intelBusId = lib.mkIf hasIntel config.graphic.busIds.intel;
              nvidiaBusId = lib.mkIf hasNvidia config.graphic.busIds.nvidia;
              amdgpuBusId = lib.mkIf hasAmd config.graphic.busIds.amd;
            };
          }

          {
            nvidia = lib.mkMerge [
              (lib.mkIf isWayland {
                modesetting.enable = true;
                prime.offload = {
                  enable = true;
                  enableOffloadCmd = true;
                };
              })

              (lib.mkIf (!isWayland) {
                prime = {
                  sync.enable = lib.mkIf (config.graphic.primeMode == "sync") true;
                  reverseSync.enable = lib.mkIf (config.graphic.primeMode == "rsync") true;
                };
              })
            ];
          }
        ];
      })
    ];
  };
}
