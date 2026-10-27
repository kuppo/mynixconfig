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
      self.nixosModules.earthNetworking
      self.nixosModules.earthSecurity

      self.nixosModules.desktop
      self.nixosModules.dev
      self.nixosModules.fcitx5
      self.nixosModules.fish
      self.nixosModules.font
      self.nixosModules.graphics
      self.nixosModules.locale
      self.nixosModules.primaryUser
      self.nixosModules.qt
      self.nixosModules.ssh
      self.nixosModules.xdg
      self.nixosModules.yazi

      self.nixosModules.myOptions

      inputs.sops-nix.nixosModules.sops
      inputs.direnv-instant.nixosModules.direnv-instant
      inputs.nixpkgs.nixosModules.readOnlyPkgs
      self.nixosModules.nixpkgs
    ];
  };
}
