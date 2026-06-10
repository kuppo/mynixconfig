{ self, ... }: {
  flake.nixosModules.dms = { pkgs, lib, config, ... } : {
    services.displayManager = {
      sddm = lib.mkIf (config.desktop.dm == "sddm") {
        enable = true;
        enableHidpi = true;
        wayland.enable = true;
        theme = "${pkgs.sddm-chili-theme}/share/sddm/themes/chili";
        extraPackages = [ pkgs.sddm-chili-theme ];
      };
      plasma-login-manager = lib.mkIf (config.desktop.dm == "plasma") {
        enable = true;
      };
      gdm = lib.mkIf (config.desktop.dm == "gdm") {
        enable = true;
        wayland = true;
      };
      cosmic-greeter = lib.mkIf (config.desktop.dm == "cosmic") {
        enable = true;
      };
    };
  };
}

