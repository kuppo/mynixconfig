return {
  "neorg",
  auto_enable = true,
  event = "DeferredUIEnter",
  after = function()
    vim.wo.foldlevel = 99
    vim.wo.conceallevel = 2
    vim.keymap.set("n", "<leader>nn", "<Plug>(neorg.dirman.new-note)", { desc = "New note" })
    require("neorg").setup({
      load = {
        ["core.defaults"] = {},
        ["core.concealer"] = { config = { folds = false } },
        ["core.dirman"] = {
          config = {
            workspaces = {
              notes = "~/notes",
            },
            default_workspace = "notes",
            index = "index.norg",
          },
        },
      },
    })
  end,
}
