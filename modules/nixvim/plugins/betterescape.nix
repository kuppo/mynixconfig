{ ... }:
{
  flake.nixosModules.nixvimPluginBetterEscape =
    { ... }:
    {
      plugins.better-escape = {
        enable = true;
        settings = {
          default_mappins = false;
          mappings = {
            i = {
              j = {
                k = "<Esc>";
              };
              " " = {
                "<tab>" = {
                  __raw = ''
                    function()
                      -- Defer execution to avoid side-effects
                      local ok, luasnip = pcall(require, "luasnip")
                      if ok then
                        vim.defer_fn(function()
                            -- set undo point
                            vim.o.ul = vim.o.ul
                            luasnip.expand_or_jump()
                        end, 1)
                      end
                    end
                  '';
                };
              };
            };
            c = {
              j = {
                k = "<C-c>";
              };
            };
            v = {
              j = {
                k = "<Esc>";
              };
            };
            s = {
              j = {
                k = "<Esc>";
              };
            };
          };
        };
        lazyLoad = {
          enable = true;
          settings = {
            event = "InsertEnter";
          };
        };
      };
    };
}
