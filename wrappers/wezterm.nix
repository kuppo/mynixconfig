{ self, ... }:
{
  flake.wrappers.wezterm =
    {
      pkgs,
      wlib,
      lib,
      config,
      options,
      ...
    }:
    {
      imports = [ wlib.wrapperModules.wezterm ];
      config = {
        luaInfo = {
          # term = "wezterm";
          font_size = 12;
          # freetype_load_flags = "FORCE_AUTOHINT";
          freetype_load_flags = "DEFAULT";
          color_scheme = "DotGov";
          disable_default_key_bindings = true;
          key_tables = {
            resize_pane = [
              {
                key = "LeftArrow";
                action = lib.generators.mkLuaInline "wezterm.action.AdjustPaneSize { 'Left', 1 }";
              }
              {
                key = "h";
                action = lib.generators.mkLuaInline ''wezterm.action.AdjustPaneSize { "Left", 1 }'';
              }

              {
                key = "RightArrow";
                action = lib.generators.mkLuaInline ''wezterm.action.AdjustPaneSize { "Right", 1 }'';
              }
              {
                key = "l";
                action = lib.generators.mkLuaInline ''wezterm.action.AdjustPaneSize { "Right", 1 }'';
              }

              {
                key = "UpArrow";
                action = lib.generators.mkLuaInline ''wezterm.action.AdjustPaneSize { "Up", 1 }'';
              }
              {
                key = "k";
                action = lib.generators.mkLuaInline ''wezterm.action.AdjustPaneSize { "Up", 1 }'';
              }

              {
                key = "DownArrow";
                action = lib.generators.mkLuaInline ''wezterm.action.AdjustPaneSize { "Down", 1 }'';
              }
              {
                key = "j";
                action = lib.generators.mkLuaInline ''wezterm.action.AdjustPaneSize { "Down", 1 }'';
              }

              {
                key = "Escape";
                action = "PopKeyTable";
              }
            ];
          };

          keys = [
            {
              key = "m";
              mods = "CTRL|SHIFT";
              action = lib.generators.mkLuaInline ''wezterm.action.ActivateKeyTable { name = "resize_pane", one_shot = false }'';
            }
            {
              key = "C";
              mods = "CTRL|SHIFT";
              action = lib.generators.mkLuaInline ''wezterm.action.CopyTo "ClipboardAndPrimarySelection"'';
            }
            {
              key = "V";
              mods = "CTRL|SHIFT";
              action = lib.generators.mkLuaInline ''wezterm.action.PasteFrom "Clipboard"'';
            }
            {
              key = "Copy";
              action = lib.generators.mkLuaInline ''wezterm.action.CopyTo "ClipboardAndPrimarySelection"'';
            }
            {
              key = "Paste";
              action = lib.generators.mkLuaInline ''wezterm.action.PasteFrom "Clipboard"'';
            }
            {
              key = "M";
              mods = "CTRL|SHIFT";
              action = lib.generators.mkLuaInline "wezterm.action.Hide";
            }
            {
              key = "W";
              mods = "CTRL|SHIFT";
              action = lib.generators.mkLuaInline "wezterm.action.CloseCurrentTab{confirm=true}";
            }
            {
              key = "Enter";
              mods = "ALT";
              action = "ToggleFullScreen";
            }
            {
              key = "=";
              mods = "CTRL";
              action = "IncreaseFontSize";
            }
            {
              key = "-";
              mods = "CTRL";
              action = "DecreaseFontSize";
            }
            {
              key = "0";
              mods = "CTRL";
              action = "ResetFontSize";
            }
            {
              key = "N";
              mods = "CTRL|SHIFT";
              action = lib.generators.mkLuaInline "wezterm.action.SpawnWindow";
            }
            {
              key = "T";
              mods = "CTRL|SHIFT";
              action = lib.generators.mkLuaInline ''wezterm.action.SpawnTab "CurrentPaneDomain"'';
            }
            {
              key = "{";
              mods = "CTRL|SHIFT";
              action = lib.generators.mkLuaInline "wezterm.action.ActivateTabRelative(-1)";
            }
            {
              key = "}";
              mods = "CTRL|SHIFT";
              action = lib.generators.mkLuaInline "wezterm.action.ActivateTabRelative(1)";
            }
            {
              key = "{";
              mods = "CTRL|SHIFT|ALT";
              action = lib.generators.mkLuaInline "wezterm.action.MoveTabRelative(-1)";
            }
            {
              key = "}";
              mods = "CTRL|SHIFT|ALT";
              action = lib.generators.mkLuaInline "wezterm.action.MoveTabRelative(1)";
            }
            {
              key = "R";
              mods = "CTRL|SHIFT";
              action = lib.generators.mkLuaInline "wezterm.action.ReloadConfiguration";
            }
            {
              key = "D";
              mods = "CTRL|SHIFT";
              action = lib.generators.mkLuaInline "wezterm.action.ShowDebugOverlay";
            }
            {
              key = "P";
              mods = "CTRL|SHIFT";
              action = lib.generators.mkLuaInline "wezterm.action.ActivateCommandPalette";
            }
            {
              key = "F";
              mods = "CTRL|SHIFT";
              action = lib.generators.mkLuaInline ''wezterm.action.Search{CaseSensitiveString=""}'';
            }
            {
              key = "K";
              mods = "CTRL|SHIFT";
              action = lib.generators.mkLuaInline ''wezterm.action.ClearScrollback "ScrollbackOnly"'';
            }
            {
              key = "UpArrow";
              mods = "CTRL|SHIFT";
              action = lib.generators.mkLuaInline "wezterm.action.ScrollByPage(-1)";
            }
            {
              key = "DownArrow";
              mods = "CTRL|SHIFT";
              action = lib.generators.mkLuaInline "wezterm.action.ScrollByPage(1)";
            }
            {
              key = "H";
              mods = "CTRL|SHIFT";
              action = lib.generators.mkLuaInline "wezterm.action.HideApplication";
            }
            {
              key = "Space";
              mods = "CTRL|SHIFT";
              action = lib.generators.mkLuaInline "wezterm.action.ActivateCopyMode";
            }
            {
              key = "X";
              mods = "CTRL|SHIFT";
              action = lib.generators.mkLuaInline "wezterm.action.QuickSelect";
            }
            {
              key = "?";
              mods = "CTRL|SHIFT";
              action = lib.generators.mkLuaInline ''wezterm.action.SplitVertical {domain="CurrentPaneDomain"}'';
            }
            {
              key = "|";
              mods = "CTRL|SHIFT";
              action = lib.generators.mkLuaInline ''wezterm.action.SplitHorizontal {domain="CurrentPaneDomain"}'';
            }
            {
              key = "!";
              mods = "CTRL|SHIFT";
              action = lib.generators.mkLuaInline "wezterm.action.ActivateTab(1)";
            }
            {
              key = "@";
              mods = "CTRL|SHIFT";
              action = lib.generators.mkLuaInline "wezterm.action.ActivateTab(2)";
            }
            {
              key = "#";
              mods = "CTRL|SHIFT";
              action = lib.generators.mkLuaInline "wezterm.action.ActivateTab(3)";
            }
            {
              key = "$";
              mods = "CTRL|SHIFT";
              action = lib.generators.mkLuaInline "wezterm.action.ActivateTab(4)";
            }
            {
              key = "%";
              mods = "CTRL|SHIFT";
              action = lib.generators.mkLuaInline "wezterm.action.ActivateTab(5)";
            }
            {
              key = "^";
              mods = "CTRL|SHIFT";
              action = lib.generators.mkLuaInline "wezterm.action.ActivateTab(6)";
            }
            {
              key = "&";
              mods = "CTRL|SHIFT";
              action = lib.generators.mkLuaInline "wezterm.action.ActivateTab(7)";
            }
            {
              key = "*";
              mods = "CTRL|SHIFT";
              action = lib.generators.mkLuaInline "wezterm.action.ActivateTab(8)";
            }
            {
              key = "(";
              mods = "CTRL|SHIFT";
              action = lib.generators.mkLuaInline "wezterm.action.ActivateTab(9)";
            }

          ];
        };
      };
    };
}
