return {
  "lazygit.nvim",
  auto_enable = true,
  event = "DeferredUIEnter",
  cmd = {
    "LazyGit",
    "LazyGitConfig",
    "LazyGitCurrentFile",
    "LazyGitFilter",
    "LazyGitFilterCurrentFile",
  },
  keys = {
    { "<leader>gg", desc = "LazyGit" },
  },
  after = function()
    vim.keymap.set("n", "<leader>gg", ":LazyGit<cr>", { desc = "Lazy[G]it" })
  end,
}
