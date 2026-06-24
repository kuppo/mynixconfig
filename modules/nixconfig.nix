{
  nixConfig,
  ...
}:
{
  flake.nixosModules.nixconfig = {
    nix.settings = nixConfig;
  };
}
