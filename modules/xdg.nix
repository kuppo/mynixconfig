{ self, ... }:
{
  flake.nixosModules.xdg =
    {
      pkgs,
      wlib,
      lib,
      config,
      options,
      ...
    }:
    {
      xdg = {
        autostart.enable = true;
        icons.enable = true;
        mime.enable = true;
        portal.enable = true;
        terminal-exec = {
          settings = {
            default = [
              "wezterm.desktop"
              "kitty.desktop"
              "alacritty.desktop"
              "ghostty.desktop"
            ];
          };
        };
      };
    };
}
