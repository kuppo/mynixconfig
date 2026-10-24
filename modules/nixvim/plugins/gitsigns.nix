{ ... }:
{
  flake.nixosModules.nixvimPluginGitsigns =
    {
      lib,
      ...
    }:
    {
      plugins.gitsigns = {
        enable = true;
        settings = {
          on_attach = lib.nixvim.mkRaw ''
            function()
              local gitsigns = require('gitsigns')
              local function map(mode, l, r, opts)
                opts = opts or {}
                opts.buffer = bufnr
                vim.keymap.set(mode, l, r, opts)
              end

              -- Navigation
              map('n', ']c', function()
                if vim.wo.diff then
                  vim.cmd.normal({']c', bang = true})
                else
                  gitsigns.nav_hunk('next')
                end
              end)

              map('n', '[c', function()
                if vim.wo.diff then
                  vim.cmd.normal({'[c', bang = true})
                else
                  gitsigns.nav_hunk('prev')
                end
              end)

            -- Actions
              map('n', '<leader>gs', gitsigns.stage_hunk, { desc = "Stage hunk" })
              map('n', '<leader>gr', gitsigns.reset_hunk, { desc = "Reset hunk" })
              map('v', '<leader>gs', function()
                gitsigns.stage_hunk({ vim.fn.line('.'), vim.fn.line('v') })
              end, { desc = "Stage line" })
              map('v', '<leader>gr', function()
                gitsigns.reset_hunk({ vim.fn.line('.'), vim.fn.line('v') })
              end, { desc = "Reset line" })
              map('n', '<leader>gS', gitsigns.stage_buffer, { desc = "Stage buffer" })
              map('n', '<leader>gR', gitsigns.reset_buffer, { desc = "Reset buffer" })
              map('n', '<leader>gp', gitsigns.preview_hunk_inline, { desc = "Preview hunk inline" })
              map('n', '<leader>gb', function() gitsigns.blame_line({ full = true }) end, { desc = "Blame line" })
              map('n', '<leader>gd', gitsigns.diffthis, { desc = "Git diff buffer" })
              map('n', '<leader>gD', function() gitsigns.diffthis('~') end, { desc = "Git diff with last commit" })
              map({'o', 'x'}, 'ih', gitsigns.select_hunk, { desc = "Git hunk" })
            end
          '';
        };
        lazyLoad = {
          enable = true;
          settings = {
            event = "DeferredUIEnter";
          };
        };
      };
    };
}
