{ ... }:
{
  flake.nixosModules.nixvimPluginRustacean =
    {
      nixosConfig,
      lib,
      pkgs,
      ...
    }:
    let
      myOpts = nixosConfig.myoptions.dev;
    in
    {
      plugins.rustaceanvim = lib.mkIf (myOpts.enable && myOpts.languages.rust) {
        enable = true;
        settings = {
          dap = lib.mkIf myOpts.dap {
            adapter = {
              type = "executable";
              command = "${pkgs.vscode-extensions.vadimcn.vscode-lldb}/share/vscode/extensions/vadimcn.vscode-lldb/adapter/codelldb";
            };
          };
          server = {
            default_settings = {
              rust-analyzer = {
                lens = {
                  debug = {
                    enable = true;
                  };
                  enable = true;
                  implementations = {
                    enable = true;
                  };
                  references = {
                    adt = {
                      enable = true;
                    };
                    enumVariant = {

                      enable = true;
                    };
                    method = {
                      enable = true;
                    };
                    trait = {
                      enable = true;
                    };
                  };
                  run = {
                    enable = true;
                  };
                  updateTest = {
                    enable = true;
                  };
                };
              };
            };
          };
        };
      };
    };
}
