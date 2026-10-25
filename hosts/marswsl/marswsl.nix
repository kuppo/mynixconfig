{
  self,
  inputs,
  withSystem,
  ...
}:
{
  flake.nixosConfigurations.marswsl = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      self.nixosModules.marswslConfiguration
      self.nixosModules.marswslPackages
      self.nixosModules.marswslNetworking
      self.nixosModules.marswslSecurity

      self.nixosModules.dev
      self.nixosModules.fish
      self.nixosModules.locale
      self.nixosModules.primaryUser
      self.nixosModules.ssh
      self.nixosModules.yazi

      self.nixosModules.myOptions

      inputs.nixos-wsl.nixosModules.default
      inputs.sops-nix.nixosModules.sops
      inputs.nixpkgs.nixosModules.readOnlyPkgs
      self.nixosModules.nixpkgs
    ];
  };
}
