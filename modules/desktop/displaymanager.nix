{ self, ... }:
{
  flake.nixosModules.dms =
    {
      pkgs,
      lib,
      config,
      ...
    }:
    {
      services.displayManager = {
        noctalia-greeter = lib.mkIf (config.desktop.dm == "greetd") {
          enable = true;
          greeter-args = "";
          settings = {
            cursor = {
              theme = "Numix-Cursor";
              size = 24;
              path = "${pkgs.numix-cursor-theme}/share/icons";
            };
            keyboard = {
              layout = "us";
            };
          };
        };
        sddm = lib.mkIf (config.desktop.dm == "sddm") {
          enable = true;
          enableHidpi = true;
          wayland.enable = true;
          theme = "${pkgs.sddm-astronaut}/share/sddm/themes/sddm-astronaut-theme";
          extraPackages = [ pkgs.sddm-astronaut ];
        };
        plasma-login-manager = lib.mkIf (config.desktop.dm == "plasma") {
          enable = true;
        };
        gdm = lib.mkIf (config.desktop.dm == "gdm") {
          enable = true;
        };
        cosmic-greeter = lib.mkIf (config.desktop.dm == "cosmic") {
          enable = true;
        };
        ly = lib.mkIf (config.desktop.dm == "ly") {
          enable = true;
          settings = {
            animation = "doom";
            # animation = "gameoflife";
            animation_frame_delay = 100;
            battery_id = "BAT0";
            bigclock = "en";
            doom_fire_height = 4;
            vi_mode = true;
            vi_default_mode = "insert";
            clear_password = true;
            session_log = "/tmp/ly_session.log";
          };
        };
        lemurs = lib.mkIf (config.desktop.dm == "lemurs") {
          enable = true;
        };
      };
    };
}
