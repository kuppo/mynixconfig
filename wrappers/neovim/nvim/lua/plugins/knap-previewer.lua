return {
  "knap",
  auto_enable = true,
  before = function()
    local gknapsettings = {
      htmltohtmlviewerlaunch = "firefox %outputfile%",
    }
    vim.g.knap_settings = gknapsettings
  end,
}
