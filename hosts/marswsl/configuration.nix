{
  self,
  priUser,
  nixConfig,
  ...
}:
{
  flake.nixosModules.marswslConfiguration =
    { ... }:
    {
      wsl = {
        enable = true;
        defaultUser = "${priUser.name}";
      };
      myoptions = {
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
            python = true;
            zig = true;
            typst = true;
            toml = true;
          };
        };
      };
      nix.settings = nixConfig;
      time.timeZone = "Asia/Shanghai";

      system.stateVersion = "25.06";
    };
}
