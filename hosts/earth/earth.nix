{
  self,
  inputs,
  withSystem,
  ...
}:
{
  flake.nixosConfigurations.earth = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      self.nixosModules.earthBootloader
      self.nixosModules.desktop
      self.nixosModules.font
      self.nixosModules.fcitx5
      self.nixosModules.qt
      # self.nixosModules.gtk
      self.nixosModules.earthPackages
      self.nixosModules.earthServices
      self.nixosModules.primaryUser
      self.nixosModules.xdg

      self.nixosModules.graphics

      self.nixosModules.earthConfiguration
      inputs.nixpkgs.nixosModules.readOnlyPkgs
      (
        { config, ... }:
        {
          nixpkgs.pkgs = withSystem "x86_64-linux" ({ pkgs, ... }: pkgs);
        }
      )
    ];
  };
}
