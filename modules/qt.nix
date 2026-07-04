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
      };
      environment = {
        variables.QT_QPA_PLATFORMTHEME = lib.mkForce "qt6ct";
        systemPackages = [
          pkgs.kdePackages.qtwayland
          pkgs.kdePackages.kservice
        ];
      };
    };
}
