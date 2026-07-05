{ self, ... }:
{
  flake.nixosModules.security =
    {
      pkgs,
      wlib,
      lib,
      config,
      options,
      ...
    }:
    {
      security.polkit = {
        enable = true;
      };
      services.gnome.gnome-keyring.enable = true;
      # environment.systemPackages = [ pkgs.polkit_gnome ];
    };
}
