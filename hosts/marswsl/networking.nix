{ self, ... }:
{
  flake.nixosModules.marswslNetworking =
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
        # networkManager = {
        #   enable = true;
        # };
        networking = {
          firewall.enable = true;
          nftables = {
            enable = true;
          };
        };
        # services.firewalld.enable = true;
        networking.hostName = "marswsl";
      };
    };
}
