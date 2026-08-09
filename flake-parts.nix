{
  self,
  inputs,
  ...
}:
{
  debug = true;
  systems = [
    "x86_64-linux"
    "aarch64-linux"
  ];

  imports = [
    inputs.wrappers.flakeModules.wrappers
    inputs.flake-parts.flakeModules.modules
  ];

  perSystem =
    { system, ... }:
    let
      overlays = [
        inputs.rust-overlay.overlays.default
        # use wl-clipboard-rs instead of wl-clipboard
        (final: prev: {
          wl-clipboard = final.wl-clipboard-rs;
        })
      ];
      config = {
        allowUnfree = true;
      };
    in
    {
      _module.args.pkgs = import inputs.nixpkgs {
        inherit system overlays config;
      };
    };
}
