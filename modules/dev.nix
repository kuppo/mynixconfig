{
  self,
  inputs,
  priUser,
  lib,
  config,
  ...
}: {
  flake.nixosModules.dev = {
    pkgs,
    wlib,
    lib,
    config,
    options,
    ...
  }: {
    config = {
      users.users.${priUser.name}.packages = with pkgs; [
        (inputs.wrappers.wrappers.treefmt.wrap {
          inherit pkgs;
          settings = {
            nix = {
              command = "alejandra";
            };
            lua = {
              command = "stylua";
            };
          };
        })
        # lua
        lua-language-server
        (inputs.wrappers.wrappers.stylua.wrap {
          inherit pkgs;
          generateCpScript = true;
          customStyle = {
            call_parentheses = "Always";
            column_width = 100;
            collapse_simple_statement = "ConditionalOnly";
            indent_type = "Spaces";
            indent_width = 2;
            quote_style = "ForceDouble";
            sort_requires.enabled = true;
          };
        })

        # python
        ruff
        ty

        # nix
        nixd
        # nixfmt-rs
        alejandra

        # typst
        tinymist
        typstyle
      ];
    };
  };
}
