{
  self,
  withSystem,
  ...
}: {
  flake.nixosModules.nixpkgs = {
    pkgs,
    wlib,
    lib,
    config,
    options,
    ...
  }: {
    nixpkgs.pkgs = withSystem "x86_64-linux" ({pkgs, ...}: pkgs);
  };
}
