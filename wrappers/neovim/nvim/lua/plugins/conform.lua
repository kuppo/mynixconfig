return {
  "conform.nvim",
  auto_enable = true,
  event = "DeferredUIEnter",
  -- cmd = { "" },
  -- event = "",
  -- ft = "",
  keys = {
    { "<leader>FF", desc = "[F]ormat [F]ile" },
  },
  -- colorscheme = "",
  after = function()
    local conform = require("conform")

    conform.setup({
      formatters_by_ft = {
        ["lua"] = { "stylua" },
        ["python"] = { "ruff_format" },
        ["nix"] = { "nixfmt" },
        ["typst"] = { "typstyle" },
        ["toml"] = { "taplo" },
        ["tex"] = { "tex-fmt" },

        -- ["_"] = { "treefmt" },
      },
      format_on_save = {
        lsp_format = "fallback",
        timeout_ms = 1000,
      },
      -- formatters = {
      --   treefmt = {
      --     require_cwd = false,
      --   },
      -- },
    })

    vim.keymap.set({ "n", "v" }, "<leader>FF", function()
      conform.format({
        -- lsp_fallback = true,
        async = false,
        timeout_ms = 1000,
      })
    end, { desc = "[F]ormat [F]ile" })
  end,
}
