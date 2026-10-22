-- enable bytecode
vim.loader.enable()

-- get nix-info plugin, and get data with it from nix
do
  local ok
  ok, _G.nixInfo = pcall(require, vim.g.nix_info_plugin_name)
  if not ok then
    package.loaded[vim.g.nix_info_plugin_name] = setmetatable({}, {
      __call = function(_, default)
        return default
      end,
    })
    _G.nixInfo = require(vim.g.nix_info_plugin_name)
  end
  nixInfo.isNix = vim.g.nix_info_plugin_name ~= nil
  nixInfo.profile = nixInfo(nil, "profile")

  function nixInfo.get_nix_plugin_path(name)
    return nixInfo(nil, "plugins", "lazy", name) or nixInfo(nil, "plugins", "start", name)
  end

  function nixInfo.installed(plugin)
    return nixInfo(plugin) ~= nil
  end

  nixInfo.is_mini = (nixInfo(nil, "settings", "profile") == "mini")
  nixInfo.is_full = (nixInfo(nil, "settings", "profile") == "full")

  if nixInfo(nil, "settings", "profile") ~= "mini" then
    nixInfo.lze = setmetatable(require("lze"), getmetatable(require("lzextras")))

    -- register a handler for lze. If the vim plugins is not installed by nix, it will be
    -- disabled. So we can use the config without nix.
    nixInfo.lze.register_handlers({
      {
        -- adds an `auto_enable` field to lze specs
        -- if true, will disable it if not installed by nix.
        -- if string, will disable if that name was not installed by nix.
        -- if a table of strings, it will disable if any were not.
        spec_field = "auto_enable",
        set_lazy = false,
        modify = function(plugin)
          if vim.g.nix_info_plugin_name then
            if type(plugin.auto_enable) == "table" then
              for _, name in pairs(plugin.auto_enable) do
                if not nixInfo.get_nix_plugin_path(name) then
                  plugin.enabled = false
                  break
                end
              end
            elseif type(plugin.auto_enable) == "string" then
              if not nixInfo.get_nix_plugin_path(plugin.auto_enable) then plugin.enabled = false end
            elseif type(plugin.auto_enable) == "boolean" and plugin.auto_enable then
              if not nixInfo.get_nix_plugin_path(plugin.name) then plugin.enabled = false end
            end
          end
          return plugin
        end,
      },
    })
  end
end
