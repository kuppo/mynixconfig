{ ... }:
{
  flake.nixosModules.nixvimAutocmds =
    {
      ...
    }:
    {
      autoGroups = {
        userConfig = {
          clear = true;
        };
      };
      autoCmd = [
        {
          event = "TextYankPost";
          group = "userConfig";
          callback = {
            __raw = ''
              function()
                vim.hl.on_yank()
              end
            '';
          };
          desc = "Highlight text after yank";
        }
      ];
    };
}
