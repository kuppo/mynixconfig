{
  self,
  inputs,
  withSystem,
  ...
}:
{
  flake.nixosConfigurations.earth = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      self.nixosModules.bootloader
      self.nixosModules.nixconfig
      self.nixosModules.desktop
      self.nixosModules.font
      self.nixosModules.fcitx5
      self.nixosModules.qt
      # self.nixosModules.gtk
      self.nixosModules.myPackages
      self.nixosModules.myServices
      self.nixosModules.primaryUser
      self.nixosModules.xdg

      self.nixosModules.graphics
      {
        graphic = {
          types = [
            "amd"
            "nvidia"
          ];
          primeMode = "offload";
          busIds = {
            amd = "PCI:6@0:0:0";
            nvidia = "PCI:1@0:0:0";
          };
        };
      }

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
