{ self, ... }:
{
  flake.nixosModules.earthNetworking =
    {
      pkgs,
      wlib,
      lib,
      config,
      options,
      ...
    }:
    {
      imports = [
        (lib.mkAliasOptionModule [ "networkManager" ] [ "networking" "networkmanager" ])
      ];
      config = {
        networkManager = {
          enable = true;
        };
        networking = {
          firewall.enable = true;
          nftables = {
            enable = true;
          };
        };
        services.firewalld = {
          package = pkgs.firewalld-gui;
          enable = true;
        };
        # services.firewalld.enable = true;
        networking.hostName = "earth";
      };
    };
}
