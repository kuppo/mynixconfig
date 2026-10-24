{ ... }:
{
  flake.nixosModules.nixvimPluginLazydev =
    { lib, nixosConfig, ... }:
    let
      myDev = nixosConfig.myoptions.dev;
    in
    lib.mkIf (myDev.enable && myDev.languages.lua) {
      plugins.lazydev = {
        enable = true;
        settings = {
          enabled = lib.nixvim.mkRaw ''
            function(root_dir)
              return vim.g.lazydev_enabled == nil and true or vim.g.lazydev_enabled
            end
          '';
          library = [
            # "~/projects/my-awesome-lib"
            # "lazy.nvim"
            # "LazyVim"
            # {
            #   path = "LazyVim";
            #   words = [
            #     "LazyVim"
            #   ];
            # }
          ];
          runtime = lib.nixvim.mkRaw "vim.env.VIMRUNTIME";
        };
        lazyLoad = {
          enable = true;
          settings = {
            ft = "lua";
          };
        };
      };
    };
}
