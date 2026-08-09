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
        # overrides = [
        #   (pkg: pkg.override { useMupdf = false; })
        # ];
        settings = {
          font = "Sans normal 12";
          recolor = true;
          recolor-lightcolor = "#111111";
          recolor-darkcolor = "#aaaaaa";
          recolor-keephue = true;
        };
        mappings = {
          "[normal] bb" = "feedkeys :bmark<Space>";
          "[normal] bd" = "feedkeys :bdelete<Space> ";
          "[normal] bl" = "feedkeys :blist<Return>";
          "[normal] <C-o>" = "file_chooser";
        };
      };
    };
}
