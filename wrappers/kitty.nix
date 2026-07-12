{ self, ... }:
{
  flake.wrappers.kitty =
    {
      pkgs,
      wlib,
      lib,
      config,
      options,
      ...
    }:
    {
      imports = [ wlib.wrapperModules.kitty ];
      config = {
        settings = {
          font_size = 12.0;
          scrollback_lines = 20000;
          scrollbar = "never";
        };
      };
    };
}
