{ self, ... }:
{
  flake.wrappers.zathura =
    {
      pkgs,
      wlib,
      lib,
      config,
      options,
      ...
    }:
    {
      imports = [ wlib.wrapperModules.zathura ];
      config = {
        overrides = [
          (pkg: pkg.override { useMupdf = false; })
        ];
        settings = {
          font = "monospace normal 11";
        };
      };
    };
}
