{ ... }:
{
  flake.nixosModules.nixvimPluginBetterEscape =
    {
      lib,
      ...
    }:
    {
      plugins.better-escaper = {
        enable = true;
        settings = {
          mapping = {
            i = {
              " " = {
                "<tab>" = {
                  __raw = ''
                    function()
                      -- Defer execution to avoid side-effects
                      local ok, luasnip = pcall(require, "luasnip")
                      if ok, then
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
          };
          timeout = "vim.o.timeoutlen";
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
