{ self, priUser, ... }:
{
  flake.nixosModules.marswslSecurity =
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
    };
}
