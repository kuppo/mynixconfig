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
      };
    };
  };

  perSystem = { lib, pkgs, ... } : {
    packages.alacritty = lib.mkDefault (self.wrappers.alacritty.wrap { inherit pkgs; });
  };
}
