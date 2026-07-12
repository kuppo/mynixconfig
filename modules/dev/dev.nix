{
  self,
  inputs,
  priUser,
  lib,
  config,
  ...
}:
{
  flake.nixosModules.dev =
    {
      pkgs,
      wlib,
      lib,
      config,
      options,
      ...
    }:
    {
      imports = [ self.nixosModules.latex ];
      config = {
        users.users.${priUser.name}.packages = with pkgs; [
          (self.wrappers.treefmt.wrap {
            inherit pkgs;
            settings = {
              nix = {
                command = "alejandra";
              };
              lua = {
                command = "stylua";
              };
              typst = {
                command = "typstyle";
              };
            };
          })
          # lua
          lua-language-server
          (inputs.wrappers.wrappers.stylua.wrap {
            inherit pkgs;
            generateCpScript = {
              enable = true;
            };
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

          # C
          gcc
          clang-tools

          # zig
          zig
          zls

          # python
          ruff
          ty

          # nix
          alejandra
          nixd
          nixfmt-rs

          # typst
          typst
          tinymist
          typstyle

          # toml
          tombi

          # rust
          rust-analyzer
          rust-bin.stable.latest.default
          graphviz-nox # dependency for rustaceanvim

          # other common tools
          (self.wrappers.jujutsu.wrap {
            inherit pkgs;
            settings = {
              user = {
                name = "${priUser.fullName}";
                email = "${priUser.email}";
              };
            };
          })
          bat
          fd
          fzf
          lazygit
          ripgrep
        ];
      };
    };
}
