{ lib, config, ... }:
{
  settings = {
    binds = {
      "Mod+D" = _: {
        props.hotkey-overlay-title = "Run an Application: fuzzel";
        content.spawn = "fuzzel";
      };
      "Super+Alt+L" = _: {
        props.hotkey-overlay-title = "Lock the Screen: swaylock";
        content.spawn = "swaylock";
      };
    
      "XF86AudioRaiseVolume" = _: {
        props.allow-when-locked = true;
        content.spawn-sh = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.1+ -l 1.0";
      };
      "XF86AudioLowerVolume" = _: {
        props.allow-when-locked = true;
        content.spawn-sh = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.1-";
      };
      "XF86AudioMute" = _: {
        props.allow-when-locked = true;
        content.spawn-sh = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
      };
      "XF86AudioMicMute" = _: {
        props.allow-when-locked = true;
        content.spawn-sh = "wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle";
      };
    
      "XF86AudioPlay" = _: {
        props.allow-when-locked = true;
        content.spawn-sh = "playerctl play-pause";
      };
      "XF86AudioPause" = _: {
        props.allow-when-locked = true;
        content.spawn-sh = "playerctl play-pause";
      };
      "XF86AudioStop" = _: {
        props.allow-when-locked = true;
        content.spawn-sh = "playerctl stop";
      };
      "XF86AudioPrev" = _: {
        props.allow-when-locked = true;
        content.spawn-sh = "playerctl previous";
      };
      "XF86AudioNext" = _: {
        props.allow-when-locked = true;
        content.spawn-sh = "playerctl next";
      };
    
      "XF86MonBrightnessUp" = _: {
        props.allow-when-locked = true;
        content.spawn-sh = "brightnessctl --class=backlight set +10%";
      };
      "XF86MonBrightnessDown" = _: {
        props.allow-when-locked = true;
        content.spawn-sh = "brightnessctl --class=backlight set 10%-";
      };
    };
  };
}
