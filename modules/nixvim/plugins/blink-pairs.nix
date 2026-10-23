{ ... }:
{
  flake.nixosModules.nixvimPluginBlinkPairs =
    {
      ...
    }:
    {
      plugins.blink-pairs = {
        enable = true;
        lazyLoad = {
          enable = true;
          settings = {
            event = "DeferredUIEnter";
          };
        };
      };
    };
}
