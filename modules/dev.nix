{
  self,
  priUser,
  lib,
  ...
}:
{
  flake.nixosModules.dev =
    {
      pkgs,
      options,
      config,
      ...
    }:
    let
      myOpts = config.myoptions.dev;
    in
    {
      config = lib.mkIf myOpts.enable {
        users.users.${priUser.name}.packages =
          with pkgs;
          lib.flatten [
            # build tools
            (lib.optional myOpts.buildTools.cmake cmake)
            (lib.optional myOpts.buildTools.make gnumake)
            (lib.optional myOpts.buildTools.ninja ninja)

            # c
            (lib.optional myOpts.languages.c [
              gcc
              clang
              (lib.optional myOpts.lsp clang-tools)
              (lib.optional myOpts.dap vscode-extensions.vadimcn.vscode-lldb)
            ])

            # lua
            (lib.optional myOpts.languages.lua [
              lua
              (lib.optional myOpts.lsp lua-language-server)
              (lib.optional myOpts.formator (
                self.wrappers.stylua.wrap {
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
                }
              ))
            ])

            # zig
            (lib.optional myOpts.languages.zig [
              zig
              (lib.optional myOpts.lsp zls)
              (lib.optional myOpts.dap vscode-extensions.vadimcn.vscode-lldb)
            ])

            # latex
            (lib.optional myOpts.languages.zig [
              miktex
              (lib.optional myOpts.lsp texlab)
              (lib.optional myOpts.formator tex-fmt)
            ])

            # python
            (lib.optional myOpts.languages.python [
              python3
              (lib.optional myOpts.buildTools.uv (
                self.wrappers.uv.wrap {
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
                }
              ))
              (lib.optional myOpts.lsp (
                self.wrappers.ruff.wrap {
                  inherit pkgs;
                  settings = {
                    line-length = 100;
                  };
                }
              ))
              ty
            ])

            # nix
            (lib.optional myOpts.languages.nix [
              (lib.optional myOpts.lsp nixd)
              (lib.optional myOpts.formator nixfmt-rs)
            ])

            # typst
            (lib.optional myOpts.languages.typst [
              typst
              (lib.optional myOpts.lsp tinymist)
              (lib.optional myOpts.formator typstyle)
            ])

            # toml
            (lib.optional myOpts.languages.toml [
              taplo
              # tombi
            ])

            # rust
            (lib.optional myOpts.languages.rust [
              (lib.optional myOpts.lsp rust-analyzer)
              (lib.optional myOpts.dap vscode-extensions.vadimcn.vscode-lldb)
              rust-bin.stable.latest.default
              graphviz-nox # dependency for rustaceanvim
            ])

            # other useful tools
            [
              bat
              fd
              fzf
              lazygit
              ripgrep
            ]
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
