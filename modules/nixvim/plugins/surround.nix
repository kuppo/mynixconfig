{ ... }:
{
  flake.nixosModules.nixvimPluginSurround =
    { ... }:
    {
      plugins.nvim-surround = {
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
