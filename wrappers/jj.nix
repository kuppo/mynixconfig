{ self, ... }:
{
  flake.wrappers.jujutsu =
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
      options = {
        settings = lib.mkOption {
          type = lib.types.attrs;
          default = { };
          description = "Settings for jj, pure nix exporession";
        };
      };
      config = {
        constructFiles.generatedConfig = lib.mkIf (config.settings != { }) {
          content = builtins.toJSON config.settings;
          relPath = "${config.binName}-config.toml";
          builder = ''${pkgs.remarshal}/bin/json2toml "$1" "$2"'';
        };
        flags."--config-file" = config.constructFiles.generatedConfig.path;
        package = lib.mkDefault pkgs.jujutsu;
      };

    };
}
