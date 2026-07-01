{
  self,
  inputs,
  ...
}: {
  flake.nixosModules.niriNoctalia = {
    lib,
    config,
    pkgs,
    ...
  }: {
    programs = {
      niri = lib.mkIf (config.desktop.wm == "niri") {
        enable = true;
        package = self.wrappers.niri.wrap {
          inherit pkgs;
          setCursor = true;
          settings = lib.mkIf (config.desktop.de == "noctalia-shell") {
            extraConfig = ''
              debug {
                // Allows notification actions and window activation from Noctalia.
                honor-xdg-activation-with-invalid-serial
              }
            '';
            spawn-at-startup = [
              ["noctalia-shell"]
            ];
            binds = {
              "Mod+D" = _: {
                content.spawn-sh = "noctalia-shell ipc call launcher toggle";
                props.hotkey-overlay-title = "Open noctalia launcher";
              };
              # "Super".spawn-sh = "noctalia-shell ipc call bar showBar";
              # "Mod+S" = _: {
              #   content.spawn-sh "noctalia-shell ipc call controlCenter toggle";
              #   prop.hotkey-overlay-title = "Open noctalia controlCenter";
              # };
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
      (self.wrappers.noctalia-shell.wrap {inherit pkgs;})
    ];
  };
}
