{ ... }:
{
  flake.nixosModules.nixvimPluginConform =
    { nixosConfig, lib, ... }:
    let
      myOpts = nixosConfig.myoptions;
    in
    lib.mkIf (myOpts.dev.enable && myOpts.dev.formator) {
      plugins.conform-nvim = {
        enable = true;
        settings = {
          formatters_by_ft = {
            lua = lib.mkIf myOpts.dev.languages.lua [ "stylua" ];
            python = lib.mkIf myOpts.dev.languages.lua [ "ruff_format" ];
            nix = lib.mkIf myOpts.dev.languages.lua [ "nixfmt" ];
            typst = lib.mkIf myOpts.dev.languages.lua [ "typstyle" ];
            toml = lib.mkIf myOpts.dev.languages.lua [ "taplo" ];
            tex = lib.mkIf myOpts.dev.languages.lua [ "tex-fmt" ];
            # "_" = [ "treefmt" ];
          };
          format_on_save = {
            lsp_format = "fallback";
            timeout_ms = 1000;
          };

        };
        lazyLoad = {
          enable = true;
          settings = {
            event = "DeferredUIEnter";
          };
        };
      };
    };
}
