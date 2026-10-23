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
      config =
      # let
      # myDev = config.myoptions.dev;
      # in
      {
        users.users.${priUser.name}.packages = with pkgs; [
          # (self.wrappers.treefmt.wrap {
          #   inherit pkgs;
          #   settings = {
          #     nix = {
          #       command = "alejandra";
          #     };
          #     lua = {
          #       command = "stylua";
          #     };
          #     typst = {
          #       command = "typstyle";
          #     };
          #   };
          # })
          lua
          lua-language-server
          (self.wrappers.stylua.wrap {
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
          # lldb
          # vscode-extensions.llvm-org.lldb-vscode
          gcc
          vscode-extensions.vadimcn.vscode-lldb
          clang
          clang-tools
          gnumake
          cmake
          ninja

          # zig
          zig
          zls

          # python
          (self.wrappers.uv.wrap {
            inherit pkgs;
            settings = {
              index = [
                {
                  name = "pypi";
                  url = "https://mirrors.ustc.edu.cn/pypi/simple";
                  default = true;
                }
              ];
            };
          })
          (self.wrappers.ruff.wrap {
            inherit pkgs;
            settings = {
              line-length = 100;
            };
          })
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
          # tombi
          taplo

          # rust
          rust-analyzer
          rust-bin.stable.latest.default
          graphviz-nox # dependency for rustaceanvim

          # other common tools
          # (self.wrappers.jujutsu.wrap {
          #   inherit pkgs;
          #   settings = {
          #     user = {
          #       name = "${priUser.fullName}";
          #       email = "${priUser.email}";
          #     };
          #   };
          # })
          bat
          fd
          fzf
          lazygit
          ripgrep
        ];
        # fix for "NixOS cannot run dynamically linked executables intended for generic Linux environments out of the box."
        programs.nix-ld = {
          enable = true;
          libraries =
            options.programs.nix-ld.libraries.default
            ++ (with pkgs; [
              dbus # libdbus-1.so.3
              fontconfig # libfontconfig.so.1
              freetype # libfreetype.so.6
              glib # libglib-2.0.so.0
              libGL # libGL.so.1
              libxkbcommon # libxkbcommon.so.0
              libX11 # libX11.so.6
              wayland
            ]);
        };
      };
    };
}
