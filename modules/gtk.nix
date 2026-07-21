{ self, cursor, ... }:
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
          name = cursor.name;
          package = pkgs.numix-cursor-theme;
          size = cursor.size;
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
