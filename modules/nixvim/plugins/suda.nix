{ ... }:
{
  flake.nixosModules.nixvimPluginSuda =
    { ... }:
    {
      plugins.vim-suda = {
        enable = true;
        lazyLoad = {
          enable = true;
          settings = {
            event = "InsertEnter";
          };
        };
      };
    };
}
