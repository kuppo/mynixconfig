{
  self,
  inputs,
  priUser,
  ...
}:
{
  flake.nixosModules.niriNoctalia =
    {
      lib,
      config,
      pkgs,
      ...
    }:
    {
      options = {
        userTerminal = lib.mkOption {
          type = lib.types.enum [
            "alacritty"
            "wezterm"
            "kitty"
          ];
          description = ''User configured terminal. One of "alacritty", "wezterm" and "kitty"'';
        };

      };
      config = {
        users.users.${priUser.name}.packages = [
          (lib.mkIf (
            config.userTerminal == "wezterm"
          ) self.packages.${pkgs.stdenv.hostPlatform.system}.wezterm)
          (lib.mkIf (
            config.userTerminal == "alacritty"
          ) self.packages.${pkgs.stdenv.hostPlatform.system}.alacritty)
          (lib.mkIf (config.userTerminal == "kitty") self.packages.${pkgs.stdenv.hostPlatform.system}.kitty)
        ];
        programs = {
          niri = lib.mkIf (config.desktop.wm == "niri") {
            enable = true;
            package = self.wrappers.niri.wrap {
              inherit pkgs;
              setCursor = true;
              settings = lib.mkIf (config.desktop.de == "noctalia-shell") {
                extraConfig = ''
                  // debug {
                  //   honor-xdg-activation-with-invalid-serial
                  // }
                '';
                spawn-at-startup = [
                  [ "noctalia" ]
                ];
                window-rules = [
                  {
                    matches = [
                      { app-id = "org.wezfurlong.wezterm"; }
                      { app-id = "kitty"; }
                      { app-id = "ghostty"; }
                    ];
                    open-maximized-to-edges = true;
                  }
                  {
                    matches = [
                      { app-id = ''r#"^org\.wezfurlong\.wezterm$"#''; }
                    ];
                    default-column-width = _: { };
                  }

                ];
                outputs = {
                  # Legion laptop
                  "California Institute of Technology 0x1600 Unknown" =
                    lib.mkIf (config.networking.hostName == "earth")
                      {
                        mode = "2560x1600@60.008";
                        scale = 1.25;
                        hot-corners = {
                          top-left = _: { };
                        };

                      };
                };
                binds = {
                  "Mod+Return" = _: {
                    props.hotkey-overlay-title = "Open a Terminal: ${config.userTerminal}";
                    content.spawn = "${config.userTerminal}";
                  };

                  "Mod+D" = _: {
                    content.spawn-sh = "noctalia-shell ipc call launcher toggle";
                    props.hotkey-overlay-title = "Open noctalia launcher";
                  };
                  "Mod+S" = _: {
                    content.spawn-sh = "noctalia-shell ipc call settings toggle";
                    props.hotkey-overlay-title = "Open noctalia settings";
                  };
                  "Super+Alt+L" = _: {
                    content.spawn = [
                      "noctalia-shell"
                      "ipc"
                      "call"
                      "lockScreen"
                      "lock"
                    ];
                    props.hotkey-overlay-title = "Lock the screen";
                  };

                  "XF86AudioRaiseVolume".spawn = [
                    "noctalia-shell"
                    "ipc"
                    "call"
                    "volume"
                    "increase"
                  ];
                  "XF86AudioLowerVolume".spawn = [
                    "noctalia-shell"
                    "ipc"
                    "call"
                    "volume"
                    "decrease"
                  ];
                  "XF86AudioMute".spawn = [
                    "noctalia-shell"
                    "ipc"
                    "call"
                    "volume"
                    "muteOutput"
                  ];
                  "XF86AudioMicMute".spawn = [
                    "noctalia-shell"
                    "ipc"
                    "call"
                    "volume"
                    "muteInput"
                  ];

                  "XF86AudioPlay".spawn = [
                    "noctalia-shell"
                    "ipc"
                    "call"
                    "media"
                    "play"
                  ];
                  "XF86AudioPause".spawn = [
                    "noctalia-shell"
                    "ipc"
                    "call"
                    "media"
                    "pause"
                  ];
                  "XF86AudioPrev".spawn = [
                    "noctalia-shell"
                    "ipc"
                    "call"
                    "media"
                    "previous"
                  ];
                  "XF86AudioNext".spawn = [
                    "noctalia-shell"
                    "ipc"
                    "call"
                    "media"
                    "next"
                  ];

                  "XF86MonBrightnessUp".spawn = [
                    "noctalia-shell"
                    "ipc"
                    "call"
                    "brightness"
                    "increase"
                  ];
                  "XF86MonBrightnessDown".spawn = [
                    "noctalia-shell"
                    "ipc"
                    "call"
                    "brightness"
                    "decrease"
                  ];
                };
              };
            };
          };
        };

        # config de
        environment.systemPackages = lib.mkIf (config.desktop.de == "noctalia-shell") [
          inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default
          # pkgs.noctalia-shell
          # (inputs.wrappers.wrappers.noctalia-shell.wrap {
          #   inherit pkgs;
          #   settings.appLauncher.terminalCommand = "{config.userTerminal} -e";
          # })
        ];
      };
    };
}
