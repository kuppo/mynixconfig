return {
  "floatty",
  auto_enable = true,
  event = "DeferredUIEnter",
  keys = {
    { "<c-t>", desc = "Terminal toggle" },
  },
  after = function()
    local term = require("floatty").setup({
      window = {
        width = 0.8,
        height = 1,
      },
    })

    vim.keymap.set({ "n", "t" }, "<c-t>", function()
      term.toggle()
    end, { desc = "Terminal toggle" })
  end,
}
