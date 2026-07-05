{
  self,
  priUser,
  nixConfig,
  ...
}:
{
  flake.nixosModules.earthConfiguration =
    {
      config,
      lib,
      pkgs,
      ...
    }:
    {
      imports = [
        self.nixosModules.earthHardware
      ];

      hostName = "earth";
      networkManager = {
        enable = true;
      };
      # firewallToUse = "firewalld";

      enableSshd = false;

      nix.settings = nixConfig;
      time.timeZone = "Asia/Shanghai";
      i18n.defaultLocale = "en_US.UTF-8";

      system.stateVersion = "25.06";
    };
}
