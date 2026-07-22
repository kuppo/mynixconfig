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
          symbol_map = "U+2E80-U+2EFF,U+3000-U+303F,U+3200-U+32FF,U+3300-U+4DB5,U+4E00-U+9FFF,U+F900-U+FAFF,U+FE30-U+FE4F Source Han Sans";
          scrollback_lines = 20000;
          scrollbar = "never";
        };
      };
    };
}
