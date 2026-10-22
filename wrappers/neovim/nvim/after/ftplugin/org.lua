if nixInfo.installed("orgmode") then
  local map = vim.keymap.set
  local wk = require("which-key")
  map("i", "<S-CR>", "<cmd>lua require(\"orgmode\").action(\"org_mappings.meta_return\")<CR>", {
    silent = true,
    buffer = true,
  })
end
