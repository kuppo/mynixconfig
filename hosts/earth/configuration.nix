{
  self,
  priUser,
  nixConfig,
  ...
}:
{
  flake.nixosModules.earthConfiguration =
    { ... }:
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
          formator = true;
          dap = true;
          buildTools = {
            make = true;
            cmake = true;
            ninja = true;
            uv = true;
          };
          languages = {
            c = true;
            lua = true;
            rust = true;
            json = false;
            python = true;
            zig = true;
            typst = true;
            typescript = false;
            latex = false;
            toml = true;
          };
        };
        enableSshd = false;
      };
      nix.settings = nixConfig;
      time.timeZone = "Asia/Shanghai";

      system.stateVersion = "25.06";
    };
}
