{ ... }:
{
  flake.nixosModules.nixvimLsp =
    {
      lib,
      nixosConfig,
      ...
    }:
    let
      myOpts = nixosConfig.myoptions;
    in
    lib.mkIf (myOpts.nixvim.full && myOpts.dev.enable && myOpts.dev.lsp) {
      extraFiles = {
        "lsp" = {
          source = ./lsp;
        };
      };
      lsp = {
        servers =
          let
            myDev = myOpts.dev.languages;
          in
          {
            "*" = {
              config = {
                root_markers = [ ".git" ];
              };
            };
            nixd.enable = lib.mkIf myDev.nix true;
            ty.enable = lib.mkIf myDev.python true;
            ruff.enable = lib.mkIf myDev.python true;
            lua_ls.enable = lib.mkIf myDev.lua true;
            tinymist.enable = lib.mkIf myDev.typst true;
            texlab.enable = lib.mkIf myDev.latex true;
            clangd.enable = lib.mkIf myDev.c true;
          };
        keymaps = [
          {
            key = "grci";
            lspBufAction = "incoming_calls";
          }
          {
            key = "grco";
            lspBufAction = "outgoing_calls";
          }
          {
            key = "grf";
            lspBufAction = "format";
          }
          {
            key = "grS";
            lspBufAction = "workspace_symbol";
          }
          {
            key = "grs";
            lspBufAction = "document_symbol";
          }
          {
            key = "grd";
            lspBufAction = "definition";
          }
          {
            key = "grD";
            lspBufAction = "declaration";
          }
          {
            key = "gre";
            lspBufAction = "workspace_diagnostics";
          }
          {
            key = "grk";
            action = "<cmd>lsp restart<cr>";
          }
          {
            key = "grl";
            action = lib.nixvim.mkRaw ''
              function()
                vim.cmd("tabnew " .. vim.lsp.log.get_filename())
              end'';
          }
        ];
      };
      userCommands = {
        LspLog = {
          command = lib.nixvim.mkRaw ''
            function()
              vim.cmd("tabnew " .. vim.lsp.log.get_filename())
            end
          '';
          desc = "LSP log";
        };
        LspRestart = {
          command = lib.nixvim.mkRaw ''
            function()
              vim.cmd("lsp restart")
            end
          '';
          desc = "LSP restart";
        };
        LspInfo = {
          command = "checkhealth vim.lsp";
          desc = "LSP information";
        };
      };
      diagnostic.settings = {
        jump = {
          on_jump = {
            __raw = "vim.diagnostic.open_float";
          };
        };
        severity_sort = true;
        update_in_insert = true;
      };
    };
}
