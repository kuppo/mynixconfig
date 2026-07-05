{ self, ... }:
{
  flake.nixosModules.network =
    {
      pkgs,
      wlib,
      lib,
      config,
      options,
      ...
    }:
    {
      options = {
        hostName = lib.mkOption {
          type = lib.types.str;
          description = "Hostname to use";
        };
        networkManager = options.networking.networkmanager;
        fireWallToUse = lib.mkOption {
          type = lib.types.enum [
            "firewalld"
            "nftables"
            "iptables"
          ];
          default = "nftables";
          description = "Which firewall backend to use";
        };
      };
      config = {
        networking.firewall = {
          enable = true;
        };
        services.${config.fireWallToUse}.enable = true;
        networking.hostName = config.hostName;
        networking.networkmanager.enable = config.networkManager;
      };
    };
}
