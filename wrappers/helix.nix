{ self, ... }:
{
  flake.wrappers.helix =
    {
      config,
      pkgs,
      lib,
      wlib,
      ...
    }:
    {
      imports = [ wlib.wrapperModules.helix ];
      config = {
        aliases = [ "helix" ];
        package = lib.mkDefault pkgs.helix;
        settings = {
          theme = "onedarker";
          editor = {
            line-number = "relative";
            cursorline = true;
            rulers = [
              80
              90
              100
            ];
            statusline = {
            };
            cursor-shape = {
              insert = "bar";
            };
          };
          keys = {
            normal = {
              "c-s" = ":w";
            };
            insert = {
              j = {
                k = "normal_mode";
              };
            };
          };
        };
      };
    };
}
