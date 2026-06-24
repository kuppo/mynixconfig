{ self, ... }:
{
  flake.nixosModules.myServices =
    {
      pkgs,
      wlib,
      lib,
      config,
      options,
      ...
    }:
    {

      services.pipewire = {
        enable = true;
        pulse.enable = true;
      };
      services.libinput.enable = true;
      services.v2raya = {
        enable = true;
        # package = pkgs.xray;
      };
      services.gvfs.enable = true;
    };
}
