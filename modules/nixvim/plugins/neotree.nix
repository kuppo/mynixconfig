{ ... }:
{
  flake.nixosModules.nixvimPluginNeotree =
    {
      lib,
      ...
    }:
    {
      plugins.neo-tree = {
        enable = true;
        settings = {
          close_if_last_window = false;
          source_selector = {
            winbar = true;
            statusline = false;
          };
          window = {
            position = "right";
            width = 30;
            mappings = {
              "C" = "none";
              "<C-b>" = {
                __unkeyed-1 = "scroll_preview";
                config = {
                  direction = 10;
                };
              };
              "<C-f>" = {
                __unkeyed-1 = "scroll_preview";
                config = {
                  direction = -10;
                };
              };
              "S" = "none";
              "s" = "none";
              "t" = "none";
              "<c-s>" = "open_split";
              "<c-v>" = "open_vsplit";
              "<c-t>" = "open_tabnew";
            };
          };
          filesystem = {
            follow_current_file = {
              enabled = true;
            };
            filtered_items = {
              always_show = [ ".gitignore" ];
            };
            window = {
              mappings = {
                "H" = "none";
                "<A-h>" = "toggle_hidden";
              };
            };
          };
        };
        lazyLoad = {
          enable = true;
          settings = {
            cmd = "Neotree";
            keys = [
              {
                __unkeyed-1 = "<leader>fe";
                __unkeyed-2 = "<cmd>Neotree toggle reveal_force_cwd<cr>";
                mode = [ "n" ];
                desc = "Explorer";
              }
              {
                __unkeyed-1 = "<leader>fo";
                __unkeyed-2 = "<cmd>Neotree<cr>";
                mode = [ "n" ];
                desc = "Focus explorer";
              }
            ];
            after = lib.nixvim.mkRaw ''
              function()
                require("neo-tree").setup({
                  -- close_if_last_window = true,
                  source_selector = { winbar = true, statusline = false },
                  window = {
                    position = "right",
                    width = 30,
                    mappings = {
                      ["C"] = "none",
                      ["<C-b>"] = { "scroll_preview", config = { direction = 10 } },
                      ["<C-f>"] = { "scroll_preview", config = { direction = -10 } },
                      ["S"] = "none",
                      ["s"] = "none",
                      ["t"] = "none",
                      ["<c-s>"] = "open_split",
                      ["<c-v>"] = "open_vsplit",
                      ["<c-t>"] = "open_tabnew",
                    },
                  },
                  filesystem = {
                    follow_current_file = { enabled = true },
                    filtered_items = {
                      always_show = { ".gitignore" },
                    },
                    window = {
                      mappings = {
                        ["H"] = "none",
                        ["<A-h>"] = "toggle_hidden",
                      },
                    },
                  },
                })
              end
            '';
          };
        };
      };
    };
}
