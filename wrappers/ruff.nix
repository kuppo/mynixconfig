{
  self,
  inputs,
  ...
}:
{
  flake.wrappers.ruff =
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
            Configuration of ruff
          '';
        };
      };
      config = {
        constructFiles.config = {
          content = builtins.toJSON config.settings;
          relPath = "${config.binName}-config.toml";
          builder = ''${pkgs.remarshal}/bin/json2toml "$1" "$2"'';
        };
        package = lib.mkDefault pkgs.ruff;
        flags."--config" = config.constructFiles.config.path;
      };
    };
}
