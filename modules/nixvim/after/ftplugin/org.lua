local map = vim.keymap.set
local ok, org = pcall(require, "orgmode")

if ok then
  map("i", "<S-CR>", function() org.action("org_mappings.meta_return") end, {
    silent = true,
    buffer = true,
  })
end
