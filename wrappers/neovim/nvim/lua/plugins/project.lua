return {
  "project",
  auto_enable = true,
  event = "DeferredUIEnter",
  after = function()
    require("project").setup({
      patterns = {
        ".git",
        ".jj",
      },
      -- enable_autochdir = true,
      scope_chdir = "win",
      fzf_lua = {
        enabled = true,
      },
    })
  end,
  vim.keymap.set("n", "<leader>pp", ":Project fzf-lua<cr>", { silent = true, desc = "Projects" }),
  vim.keymap.set("n", "<leader>ps", ":Project session<cr>", { silent = true, desc = "Sessions" }),
  vim.keymap.set(
    "n",
    "<leader>pr",
    ":Project recents<cr>",
    { silent = true, desc = "Recent projects" }
  ),
}
