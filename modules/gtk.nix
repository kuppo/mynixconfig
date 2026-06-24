{ self, ... }:
{
  flake.nixosModules.gtk =
    {
      pkgs,
      wlib,
      lib,
      config,
      options,
      ...
    }:
    {
      gtk = {
        enable = true;
        cursorTheme = {
          name = "numix-cursor-theme";
          package = pkgs.numix-cursor-theme;
          size = 20;
        };
        colorScheme = "dark";
        iconTheme = {
          name = "numix-icon-theme-square";
          package = pkgs.numix-icon-theme-square;
        };
        font = {
          name = "WenQuanYi Zen Hei";
          package = pkgs.wqy-zenhei;
          size = 12;
        };
      };
    };
}
