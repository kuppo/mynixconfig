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
            event = "FileType";
            pattern = "help";
            group = "userConfig";
            command = "wincmd L";
            desc = "Vertical split help window";
          }
      ];
    };
}
