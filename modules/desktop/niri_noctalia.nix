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
      users.users.${priUser.name}.packages = [
        (lib.mkIf (
          config.myoptions.desktop.userTerminal == "wezterm"
        ) self.packages.${pkgs.stdenv.hostPlatform.system}.wezterm)
        (lib.mkIf (
          config.myoptions.desktop.userTerminal == "alacritty"
        ) self.packages.${pkgs.stdenv.hostPlatform.system}.alacritty)
        (lib.mkIf (
          config.myoptions.desktop.userTerminal == "kitty"
        ) self.packages.${pkgs.stdenv.hostPlatform.system}.kitty)
      ];
      programs = {
        niri = lib.mkIf (config.myoptions.desktop.wm == "niri") {
          enable = true;
          package = self.wrappers.niri.wrap {
            inherit pkgs;
            setCursor = true;
            settings = lib.mkIf (config.myoptions.desktop.de == "noctalia") {
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
                    { title = "Noctalia Settings"; }
                  ];
                  open-floating = true;
                  open-fullscreen = false;
                }
              ];
              binds = {
                "Mod+Return" = _: {
                  props.hotkey-overlay-title = "Open a Terminal: ${config.myoptions.desktop.userTerminal}";
                  content.spawn = "${config.myoptions.desktop.userTerminal}";
                };
                "Mod+D" = _: {
                  content.spawn-sh = "noctalia msg panel-toggle launcher";
                  props.hotkey-overlay-title = "Open noctalia launcher";
                };
                "Mod+S" = _: {
                  content.spawn-sh = "noctalia msg settings-toggle";
                  props.hotkey-overlay-title = "Open noctalia settings";
                };
                "Super+Alt+L" = _: {
                  content.spawn-sh = "noctalia msg session lock";
                  props.hotkey-overlay-title = "Lock the screen";
                };

                "XF86AudioRaiseVolume".spawn-sh = "noctalia msg volume-up 1";
                "XF86AudioLowerVolume".spawn-sh = "noctalia msg volume-down 1";

                "XF86AudioMute".spawn-sh = "noctalia msg volume-mute";
                "XF86AudioMicMute".spawn-sh = "noctalia msg mic-mute";

                # "XF86AudioToggle".spawn-sh = "noctalia msg media toggle";
                "XF86AudioStop".spawn-sh = "noctalia msg media stop";
                "XF86AudioPrev".spawn-sh = "noctalia msg media previous";
                "XF86AudioNext".spawn-sh = "noctalia msg media next";

                "XF86MonBrightnessUp".spawn-sh = "noctalia msg brightness-up 1";
                "XF86MonBrightnessDown".spawn-sh = "noctalia msg brightness-down 1";

                "Ctrl+Alt+Delete".spawn-sh = "noctalia msg panel-toggle session";
              };
            };
          };
        };
      };

      # config de
      environment.systemPackages = lib.mkIf (config.myoptions.desktop.de == "noctalia") [
        # inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default
        pkgs.noctalia
        # (inputs.wrappers.wrappers.noctalia.wrap {
        #   inherit pkgs;
        #   settings.appLauncher.terminalCommand = "{config.myoptions.desktop.userTerminal} -e";
        # })
      ];
    };
}
