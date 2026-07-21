{ self, ... }:
{
  flake.wrappers.sioyek =
    {
      pkgs,
      wlib,
      lib,
      config,
      options,
      ...
    }:
    {
      imports = [ wlib.modules.default ];
      config = {
        package = pkgs.sioyek;
        constructFiles.userKeys = {
          content = ''
            move_up k
            move_down j
            zoom_in  <C-=>
            zoom_out <C-->

            open_document_embedded_from_current_path o
            open_prev_doc O
            open_last_document gl
          '';
          relPath = "user/sioyek/keys_user.config";
        };
        constructFiles.userPrefs = {
          content = ''
            background_color 0.5 0.5 0.5
            dark_mode_contrast 0.5
            default_dark_mode 1
          '';
          relPath = "user/sioyek/prefs_user.config";
        };
        env = {
          XDG_CONFIG_HOME = "${placeholder config.outputName}/user";
        };
      };
    };
}
