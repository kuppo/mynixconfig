{ ... }:
{
  flake.nixosModules.nixvimPluginLzn =
    {
      ...
    }:
    {
      plugins.lz-n = {
        enable = true;
      };
    };
}
