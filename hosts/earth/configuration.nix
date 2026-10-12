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

      enableSshd = false;
      nix.settings = nixConfig;
      time.timeZone = "Asia/Shanghai";

      system.stateVersion = "25.06";
    };
}
