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

      myoptions = {
        nixvim = {
          enable = true;
          full = true;
        };
        dev = {
          enable = true;
          lsp = true;
        };
        enableSshd = false;
      };
      nix.settings = nixConfig;
      time.timeZone = "Asia/Shanghai";

      system.stateVersion = "25.06";
    };
}
