return {
  "mini.icons",
  deps_of = "which-key.nvim",
  event = "DeferredUIEnter",
  auto_enable = true,
  after = function()
    require("mini.icons").setup({
      -- style = "ascii",
    })
  end,
}
