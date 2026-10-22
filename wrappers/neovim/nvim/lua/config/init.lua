require("config.keybindings")
require("config.options")
require("config.ui2")
require("config.autocmds")
require("config.lsp")

local success, files = pcall(vim.fn.readdir, vim.fn.stdpath("config") .. "/lua/plugins")
if success and not nixInfo.is_mini then
  for _, file in ipairs(files) do
    nixInfo.lze.load({ import = "plugins." .. file:gsub("%.lua$", "") })
  end
end

vim.api.nvim_create_user_command("NixInfo", function()
  print(vim.inspect(nixInfo))
end, {})

vim.cmd("colorscheme catppuccin")
