{ self, inputs, ... }: {
  systems = [
    "x86_64-linux"
    "aarch64-linux"
  ];
  imports = [ inputs.wrappers.flakeModules.wrappers ];
  perSystem = { system, ... }: {
    _module.args.pkgs = import inputs.nixpkgs {
      inherit system;
      config = {
        allowUnfree = true;
      };
    };
  };
}
