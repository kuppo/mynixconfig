return {
  "blink.indent",
  auto_enable = true,
  event = "DeferredUIEnter",
  after = function()
    vim.g.indent_guide = false
    local indent = require("blink.indent")
    vim.keymap.set("n", "<leader>ug", function()
      indent.enable(not indent.is_enabled())
    end, { desc = "Toggle indent guides" })
  end,
}
