{self, ...}: {
  flake.nixosModules.earthServices = {
    pkgs,
    wlib,
    lib,
    config,
    options,
    ...
  }: {
    services = {
      pipewire = {
        enable = true;
        pulse.enable = true;
      };
      upower.enable = true;
      libinput.enable = true;
      v2raya = {
        enable = true;
        # package = pkgs.xray;
      };
      gvfs.enable = true;
    };
  };
}
