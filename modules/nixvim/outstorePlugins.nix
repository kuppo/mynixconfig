{ self, inputs, ... }:
{
  flake.nixosModules.outstoreVimplugins =
    {
      config,
      lib,
      pkgs,
      ...
    }:
    {
      rustaceanvimOut = pkgs.vimUtils.buildVimPlugin {
        name = "rustaceanvimOut";
        src = pkgs.fetchgit {
          url = "https://github.com/mrcjkb/rustaceanvim";
          rev = "4e25c6cab03f707c1ced715eeb37a0250d1c2377";
          hash = "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA";
        };
      };
    };
}
