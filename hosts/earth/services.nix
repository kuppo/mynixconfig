{ self, ... }:
{
  flake.nixosModules.earthServices =
    {
      pkgs,
      wlib,
      lib,
      config,
      options,
      ...
    }:
    {
      services = {
        pipewire = {
          enable = true;
          pulse.enable = true;
        };
        upower.enable = true;
        libinput.enable = true;
        v2raya = {
          enable = true;
          # cliPackage = pkgs.xray;
        };
        gvfs.enable = true;
        power-profiles-daemon.enable = true;
      };
    };
}
