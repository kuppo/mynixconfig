{
  self,
  inputs,
  ...
}:
{
  flake.wrappers.uv =
    {
      pkgs,
      wlib,
      config,
      lib,
      ...
    }:
    {
      imports = [ wlib.modules.default ];
      options = {
        settings = lib.mkOption {
          type = wlib.types.structuredValueWith {
            nullable = false;
            typeName = "TOML";
          };
          default = { };
          description = ''
            Configuration of uv
          '';
        };
      };
      config = {
        constructFiles.config = {
          content = builtins.toJSON config.settings;
          relPath = "${config.binName}-config.toml";
          builder = ''${pkgs.remarshal}/bin/json2toml "$1" "$2"'';
        };
        package = lib.mkDefault pkgs.uv;
        flags."--config-file" = config.constructFiles.config.path;
      };
    };
}
