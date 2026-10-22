{ self, priUser, ... }:
{
  flake.nixosModules.earthSecurity =
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
      # services.gnome.gnome-keyring.enable = true;
      users.users.${priUser.name}.packages = [
        pkgs.polkit_gnome
      ];
    };
}
