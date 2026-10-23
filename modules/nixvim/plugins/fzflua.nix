{ lib, ... }:
{
  flake.nixosModules.nixvimPluginFzflua =
    {
      nixosConfig,
      ...
    }:
    let
      myOpts = nixosConfig.myoptions;
    in
    {
      plugins.fzf-lua = {
        enable = true;
        settings = {
          files = {
            path_shorten = true;
            absolute_path = true;
          };
        };
        keymaps = {
          "<leader>ff" = {
            action = "files";
            options.desc = "Find files";
          };
          "<leader>fr" = {
            action = "oldfiles";
            options.desc = "Find recent files";
          };
          "<leader>bb" = {
            action = "buffers";
            options.desc = "Buffers";
          };
          "<leader>ss" = {
            action = "live_grep";
            options.desc = "Search text";
          };
          "<leader>sk" = {
            action = "keymaps";
            options.desc = "Search keymap";
          };
          "<leader>sh" = {
            action = "helptags";
            options.desc = "Search help";
          };
          "<leader>sm" = {
            action = "manpages";
            options.desc = "Search man";
          };
        };
        lazyLoad = {
          enable = true;
          settings = {
            event = "DeferredUIEnter";
          };
        };
      };
      keymapsOnEvents = lib.mkIf (myOpts.dev.enable && myOpts.dev.lsp){
        LspAttach = [
          {
            key = "<leader>cr";
            action = "<cmd>FzfLua lsp_references<cr>";
            options = {
              desc = "References";
              buffer = true;
            };
          }
          {
            key = "<leader>cn";
            action = {
              __raw = ''
                function()
                  vim.lsp.buf.rename()
                end
              '';
            };
            options = {
              desc = "Rename";
              buffer = true;
            };
          }
          {
            key = "<leader>cd";
            action = "<cmd>FzfLua lsp_definitions<cr>";
            options = {
              desc = "Definitions";
              buffer = true;
            };
          }
          {
            key = "<leader>cD";
            action = "<cmd>FzfLua lsp_declarations<cr>";
            options = {
              desc = "Declarations";
              buffer = true;
            };
          }
          {
            key = "<leader>ctt";
            action = "<cmd>FzfLua lsp_typedefs<cr>";
            options = {
              desc = "Type Definition";
              buffer = true;
            };
          }
          {
            key = "<leader>ctu";
            action = "<cmd>FzfLua lsp_type_super<cr>";
            options = {
              desc = "Super type";
              buffer = true;
            };
          }
          {
            key = "<leader>ctd";
            action = "<cmd>FzfLua lsp_type_sub<cr>";
            options = {
              desc = "Sub type";
              buffer = true;
            };
          }
          {
            key = "<leader>ci";
            action = "<cmd>FzfLua lsp_implementations<cr>";
            options = {
              desc = "Implementations";
              buffer = true;
            };
          }
          {
            key = "<leader>cs";
            action = "<cmd>FzfLua lsp_document_symbols<cr>";
            options = {
              desc = "Document symbols";
              buffer = true;
            };
          }
          {
            key = "<leader>cS";
            action = "<cmd>FzfLua lsp_workspace_symbols<cr>";
            options = {
              desc = "Document symbols";
              buffer = true;
            };
          }
          {
            key = "<leader>cci";
            action = "<cmd>FzfLua lsp_incoming_calls<cr>";
            options = {
              desc = "Incoming calls";
              buffer = true;
            };
          }
          {

            key = "<leader>cco";
            action = "<cmd>FzfLua lsp_outcoming_calls<cr>";
            options = {
              desc = "Outcoming calls";
              buffer = true;
            };
          }
          {

            key = "<leader>ca";
            action = "<cmd>FzfLua lsp_code_actions<cr>";
            options = {
              desc = "Code actions";
              buffer = true;
            };
          }
          {

            key = "<leader>cf";
            action = "<cmd>FzfLua lsp_finder<cr>";
            options = {
              desc = "Find LSP locations";
              buffer = true;
            };
          }
          {

            key = "<leader>cf";
            action = "<cmd>FzfLua lsp_finder<cr>";
            options = {
              desc = "Find LSP locations";
              buffer = true;
            };
          }
          {

            key = "<leader>ce";
            action = "<cmd>FzfLua diagnostics_document<cr>";
            options = {
              desc = "Document Diagnostics";
              buffer = true;
            };
          }
          {

            key = "<leader>cE";
            action = "<cmd>FzfLua diagnostics_workspace<cr>";
            options = {
              desc = "Workspace Diagnostics";
              buffer = true;
            };
          }
        ];
      };
    };
}
