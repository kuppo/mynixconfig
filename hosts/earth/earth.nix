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
      self.nixosModules.earthNetworking
      self.nixosModules.earthPackages
      self.nixosModules.earthSecurity
      self.nixosModules.earthServices

      self.nixosModules.desktop
      self.nixosModules.dev
      self.nixosModules.fcitx5
      self.nixosModules.fish
      self.nixosModules.font
      self.nixosModules.graphics
      self.nixosModules.locale
      self.nixosModules.myOptions
      self.nixosModules.nixvim
      self.nixosModules.primaryUser
      self.nixosModules.qt
      self.nixosModules.ssh
      self.nixosModules.xdg
      self.nixosModules.yazi

      inputs.nixpkgs.nixosModules.readOnlyPkgs
      inputs.sops-nix.nixosModules.sops
      self.nixosModules.nixpkgs
    ];
  };
}
