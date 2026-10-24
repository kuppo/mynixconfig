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
            nix = true;
            c = true;
            # lua = true;
            rust = true;
            python = true;
            zig = true;
            typst = true;
            latex = true;
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
