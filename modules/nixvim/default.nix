{ self, inputs, ... }:
{
  flake.nixosModules.nixvim =
    {
      pkgs,
      lib,
      config,
      ...
    }:
    {
      imports = lib.mkIf config.myoptions.nixvim.enable [
        inputs.nixvim.nixosModules.nixvim
      ];
      config = lib.mkIf config.myoptions.nixvim.enable {

      };
    };
}
