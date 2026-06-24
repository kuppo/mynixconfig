{ self, ... }:
{
  flake.wrappers.noctalia-shell =
    { pkgs, wlib, ... }:
    {
      imports = [ wlib.wrapperModules.noctalia-shell ];
      options = {
      };
      config = {
      };
    };
}
