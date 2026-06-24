{ self, ... }:
{
  flake.nixosModules.qt =
    {
      pkgs,
      wlib,
      lib,
      config,
      options,
      ...
    }:
    {
      qt = {
        enable = true;
        platformTheme = "qt5ct";
        style = "breeze";
      };
      environment = {
        variables.QT_QPA_PLATFORMTHEME = "qt5ct";
        systemPackages = [
          pkgs.kdePackages.qtwayland
          pkgs.kdePackages.kservice
        ];
      };
    };
}
