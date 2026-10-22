-- use the new ui2
if vim.fn.has("nvim-0.12") == 1 then
  -- 1. Enable the new experimental ui2 subsystem
  require("vim._core.ui2").enable()

  -- 2. Apply 0.12 specific UI improvements
  vim.opt.pumborder = "rounded" -- Rounded borders for command line completions
  vim.opt.pummaxwidth = 50 -- Keep popup menu clean and compact
  vim.opt.winborder = "rounded"
end
