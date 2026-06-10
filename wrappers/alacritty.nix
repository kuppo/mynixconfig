{ self, ... }: {
  flake.wrappers.alacritty = { pkgs, wlib, ... }: {
    imports = [ wlib.wrapperModules.alacritty ];
    options = {
    };
    config = {
      settings = {
        font.size = 11;
        scrolling.history = 20000;
        cursor.style.blinking = "On";
        mouse.hide_when_typing = true;
        window.decorations = "None";
        # debug.log_level = "Debug";
        # debug.persistent_logging = true;
      };
    };
  };
}
