{ ... }:
{
  flake.nixosModules.nixvimPluginBlink =
    {
      ...
    }:
    {
      plugins.blink-cmp = {
        enable = true;
        lazyLoad = {
          enable = true;
          settings = {
            event = "InsertEnter";
          };
        };
        settings = {
          sources = {
            default = [
              "snippets"
              "lsp"
              "buffer"
              "path"
            ];
            per_filetype = {
              org = [
                "orgmode"
              ];
            };
            providers = {
              orgmode = {
                name = "Orgmode";
                module = "orgmode.org.autocompletion.blink";
                fallbacks = [ "buffer" ];
              };
            };
          };
          keymap = {
            preset = "super-tab";
            "<Up>" = {
              __unkeyed-1 = "select_prev";
              __unkeyed-2 = "fallback";
            };
            "<Down>" = {
              __unkeyed-1 = "select_next";
              __unkeyed-2 = "fallback";
            };
            "<c-d>" = {
              __unkeyed-1 = "scroll_documentation_down";
              __unkeyed-2 = "fallback";
            };
            "<c-u>" = {
              __unkeyed-1 = "scroll_documentation_up";
              __unkeyed-2 = "fallback";
            };
            "<C-k>" = {
              __unkeyed-1 = "select_prev";
              __unkeyed-2 = "fallback_to_mappings";
            };
            "<C-j>" = {
              __unkeyed-1 = "select_next";
              __unkeyed-2 = "fallback_to_mappings";
            };
            "<C-p>" = false;
            "<C-n>" = false;
            "<C-b>" = false;
            "<C-f>" = false;
          };
          snippets = {
            preset = "luasnip";
          };
          fuzzy = {
            implementation = "prefer_rust_with_warning";
            sorts = [
              "exact"
              "score"
              "sort_text"
            ];
          };
          completion = {
            documentation = {
              auto_show = true;
            };
            keyword = {
              range = "full";
            };
            ghost_text = {
              enabled = true;
            };
            # list = { selection = { preselect = false; }; };
          };
          signature = {
            enabled = true;
          };
          cmdline = {
            keymap = {
              preset = "inherit";
            };
            # sources = [ "omni" "cmdline" ];
            completion = {
              # list = { selection = { preselect = false; }; };
              menu = {
                auto_show = true;
              };
            };
          };
        };
      };
    };
}
