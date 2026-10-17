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

      self.nixosModules.desktop
      self.nixosModules.font
      self.nixosModules.fcitx5
      self.nixosModules.qt
      self.nixosModules.dev
      self.nixosModules.primaryUser
      self.nixosModules.xdg
      self.nixosModules.graphics
      self.nixosModules.ssh
      self.nixosModules.security
      self.nixosModules.yazi
      self.nixosModules.locale

      self.nixosModules.myOptions

      inputs.sops-nix.nixosModules.sops
      inputs.nixpkgs.nixosModules.readOnlyPkgs
      self.nixosModules.nixpkgs
    ];
  };
}
