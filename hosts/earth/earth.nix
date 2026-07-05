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
      self.nixosModules.earthConfiguration
      self.nixosModules.earthPackages
      self.nixosModules.earthServices

      self.nixosModules.desktop
      self.nixosModules.font
      self.nixosModules.fcitx5
      self.nixosModules.qt
      # self.nixosModules.gtk
      self.nixosModules.dev
      self.nixosModules.primaryUser
      self.nixosModules.xdg
      self.nixosModules.graphics
      self.nixosModules.ssh
      self.nixosModules.network
      self.nixosModules.security

      inputs.sops-nix.nixosModules.sops
      inputs.nixpkgs.nixosModules.readOnlyPkgs
      self.nixosModules.nixpkgs
    ];
  };
}
