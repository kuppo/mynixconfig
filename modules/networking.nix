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
      imports = [
        (lib.mkAliasOptionModule [ "networkManager" ] [ "networking" "networkmanager" ])
      ];
      options = {
        hostName = lib.mkOption {
          type = lib.types.str;
          description = "Hostname to use";
        };
        firewallToUse = lib.mkOption {
          type = lib.types.enum [
            "firewalld"
            "nftables"
          ];
          default = "nftables";
          description = "Which firewall backend to use";
        };
      };
      config = {
        networking = {
          firewall.enable = true;
          nftables = {
            enable = true;
          };
        };
        services.firewalld = lib.mkIf (config.firewallToUse == "firewalld") {
          package = pkgs.firewalld-gui;
          enable = true;
        };
        # services.firewalld.enable = true;
        networking.hostName = config.hostName;
      };
    };
}
