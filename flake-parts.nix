{
  self,
  inputs,
  ...
}: {
  debug = true;
  systems = [
    "x86_64-linux"
    "aarch64-linux"
  ];

  imports = [
    inputs.wrappers.flakeModules.wrappers
    inputs.flake-parts.flakeModules.modules
  ];

  perSystem = {system, ...}: {
    _module.args.pkgs = import inputs.nixpkgs {
      inherit system;
      config = {
        allowUnfree = true;
      };
    };
  };
}
