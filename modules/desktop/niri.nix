{pkgs, config, ...}:

{

  programs.niri.settings = {
    prefer-no-csd = true;
    environment = {
      MOZ_ENABLE_WAYLAND = "1";
      NIXOS_OZONE_WL = "1";
      DISPLAY = null;
    };
    spawn-at-startup = [
      {command = [ "xwayland-sattelite" ];}
      {command = ["swaybg -i ./modules/desktop/ign_robots.png" ]; }
    ];
    layout = {
      shadow.enable = true;
      border.width = 2;
      gaps = 4;
      default-column-width = {proportion = 0.5;};
      preset-column-widths = [
          {proportion = 0.25;}
          {proportion = 0.5;}
          {proportion = 0.75;}
          {proportion = 1.0;}
        ];
      tab-indicator = {
          hide-when-single-tab = true;
          place-within-column = true;
          position = "left";
          corner-radius = 20.0;
          gap = -12.0;
          gaps-between-tabs = 10.0;
          width = 4.0;
          length.total-proportion = 0.1;
        };
    };
    outputs = {
        "eDP-1" = {
          scale = 1.0;
          position = {
            x = 2560;
            y = 0;
          };
        };
        "HDMI-A-1" = {
          mode = {
            width = 2560;
            height = 1440;
            refresh = null;
          };
          scale = 1.0;
          position = {
            x = 0;
            y = 0;
          };
        };
      };
    input = {
      focus-follows-mouse = {
        enable = true;
      };
    };
    window-rules = [
      {
        matches = [ {app-id = "pwvucontrol|blueman";} ];
        open-floating = true;
      }
      {clip-to-geometry = true;}
      {geometry-corner-radius = null;}
      ];
    layer-rules = [
      {geometry-corner-radius = null;}
    ];
    hotkey-overlay.skip-at-startup = true;
    binds = 
      with config.lib.niri.actions;
      {
      "Mod+D".action.spawn = "fuzzel";
      "Mod+Shift+Slash".action = show-hotkey-overlay;
      "Mod+Return".action.spawn = "ghostty";


        # XF86AudioRaiseVolume.action = set-volume "5%+";
        # XF86AudioLowerVolume.action = set-volume "5%-";
        # XF86AudioMute.action = spawn "wpctl" "set-mute" "@DEFAULT_AUDIO_SINK@" "toggle";
        # XF86AudioMicMute.action = spawn "wpctl" "set-mute" "@DEFAULT_AUDIO_SOURCE@" "toggle";
 
        # XF86AudioPlay.action = playerctl "play-pause";
        # XF86AudioStop.action = playerctl "pause";
        # XF86AudioPrev.action = playerctl "previous";
        # XF86AudioNext.action = playerctl "next";
 
 
        # // Open/close the Overview: a zoomed-out view of workspaces and windows.
        # // You can also move the mouse into the top-left hot corner,
        # // or do a four-finger swipe up on a touchpad.
        "Mod+Shift+O" = { action = toggle-overview; repeat = false; };
 
        "Mod+Q".action = close-window;
        "Mod+Left".action = focus-column-left;
        "Mod+Down".action = focus-window-down;
        "Mod+Up".action = focus-window-up;
        "Mod+Right".action = focus-column-right;
        "Mod+H".action = focus-column-left;
        "Mod+J".action = focus-window-down;
        "Mod+K".action = focus-window-up;
        "Mod+L".action = focus-column-right;
 
        "Mod+Ctrl+Left".action = move-column-left-or-to-monitor-left;
        "Mod+Ctrl+Down".action = move-window-down-or-to-workspace-down;
        "Mod+Ctrl+Up".action = move-window-up-or-to-workspace-up;
        "Mod+Ctrl+Right".action = move-column-right-or-to-monitor-right;
        "Mod+Ctrl+H".action = move-column-left-or-to-monitor-left;
        "Mod+Ctrl+J".action = move-window-down-or-to-workspace-down;
        "Mod+Ctrl+K".action = move-window-up-or-to-workspace-up;
        "Mod+Ctrl+L".action = move-column-right-or-to-monitor-right;
 
        "Mod+Home".action = focus-column-first;
        "Mod+End".action = focus-column-last;
        "Mod+Ctrl+Home".action = move-column-to-first;
        "Mod+Ctrl+End".action = move-column-to-last;
 
        "Mod+Shift+Left".action = focus-monitor-left;
        "Mod+Shift+Down".action = focus-monitor-down;
        "Mod+Shift+Up".action = focus-monitor-up;
        "Mod+Shift+Right".action = focus-monitor-right;
        "Mod+Shift+H".action = focus-monitor-left;
        "Mod+Shift+J".action = focus-monitor-down;
        "Mod+Shift+K".action = focus-monitor-up;
        "Mod+Shift+L".action = focus-monitor-right;
 
        "Mod+Shift+Ctrl+Left".action = move-column-to-monitor-left;
        "Mod+Shift+Ctrl+Down".action = move-column-to-monitor-down;
        "Mod+Shift+Ctrl+Up".action = move-column-to-monitor-up;
        "Mod+Shift+Ctrl+Right".action = move-column-to-monitor-right;
        "Mod+Shift+Ctrl+H".action = move-column-to-monitor-left;
        "Mod+Shift+Ctrl+J".action = move-column-to-monitor-down;
        "Mod+Shift+Ctrl+K".action = move-column-to-monitor-up;
        "Mod+Shift+Ctrl+L".action = move-column-to-monitor-right;
 
        # // Alternatively, there are commands to move just a single window:
        # // Mod+Shift+Ctrl+Left  { move-window-to-monitor-left; }
        # // ...
 
        # // And you can also move a whole workspace to another monitor:
        # // Mod+Shift+Ctrl+Left  { move-workspace-to-monitor-left; }
        # // ...
 
        "Mod+Page_Down".action = focus-workspace-down;
        "Mod+Page_Up".action = focus-workspace-up;
        "Mod+U".action = focus-workspace-down;
        "Mod+I".action = focus-workspace-up;
        # "Mod+Ctrl+Page_Down".action = move-column-to-workspace-down;
        # "Mod+Ctrl+Page_Up".action = move-column-to-workspace-up;
        "Mod+Ctrl+U".action = move-column-to-workspace-down;
        "Mod+Ctrl+I".action = move-column-to-workspace-up;
        # // Alternatively, there are commands to move just a single window:
        # // Mod+Ctrl+Page_Down { move-window-to-workspace-down; }
        # // ...
 
        # "Mod+Shift+Page_Down".action = move-workspace-down;
        # "Mod+Shift+Page_Up".action = move-workspace-up;
        "Mod+Shift+U".action = move-workspace-down;
        "Mod+Shift+I".action = move-workspace-up;
 
        # // You can bind mouse wheel scroll ticks using the following syntax.
        # // These binds will change direction based on the natural-scroll setting.
        # //
        # // To avoid scrolling through workspaces really fast, you can use
        # // the cooldown-ms property. The bind will be rate-limited to this value.
        # // You can set a cooldown on any bind, but it's most useful for the wheel.
        "Mod+WheelScrollDown" = {
          action = focus-workspace-down;
          cooldown-ms = 150;
        };
        "Mod+WheelScrollUp" = {
          action = focus-workspace-up;
          cooldown-ms = 150;
        };
        "Mod+Ctrl+WheelScrollDown" = {
          action = move-column-to-workspace-down;
          cooldown-ms = 150;
        };
        "Mod+Ctrl+WheelScrollUp" = {
          action = move-column-to-workspace-up;
          cooldown-ms = 150;
        };
 
        "Mod+WheelScrollRight".action = focus-column-right;
        "Mod+WheelScrollLeft".action = focus-column-left;
        "Mod+Ctrl+WheelScrollRight".action = move-column-right;
        "Mod+Ctrl+WheelScrollLeft".action = move-column-left;
 
        # // Usually scrolling up and down with Shift in applications results in
        # // horizontal scrolling; these binds replicate that.
        "Mod+Shift+WheelScrollDown".action = focus-column-right;
        "Mod+Shift+WheelScrollUp".action = focus-column-left;
        "Mod+Ctrl+Shift+WheelScrollDown".action = move-column-right;
        "Mod+Ctrl+Shift+WheelScrollUp".action = move-column-left;
 
        # // Similarly, you can bind touchpad scroll "ticks".
        # // Touchpad scrolling is continuous, so for these binds it is split into
        # // discrete intervals.
        # // These binds are also affected by touchpad's natural-scroll, so these
        # // example binds are "inverted", since we have natural-scroll enabled for
        # // touchpads by default.
        # // Mod+TouchpadScrollDown { spawn "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "0.02+"; }
        # // Mod+TouchpadScrollUp   { spawn "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "0.02-"; }
 
        # // You can refer to workspaces by index. However, keep in mind that
        # // niri is a dynamic workspace system, so these commands are kind of
        # // "best effort". Trying to refer to a workspace index bigger than
        # // the current workspace count will instead refer to the bottommost
        # // (empty) workspace.
        # //
        # // For example, with 2 workspaces + 1 empty, indices 3, 4, 5 and so on
        # // will all refer to the 3rd workspace.
        "Mod+1".action = focus-workspace 1;
        "Mod+2".action = focus-workspace 2;
        "Mod+3".action = focus-workspace 3;
        "Mod+4".action = focus-workspace 4;
        "Mod+5".action = focus-workspace 5;
        "Mod+6".action = focus-workspace 6;
        "Mod+7".action = focus-workspace 7;
        "Mod+8".action = focus-workspace 8;
        "Mod+9".action = focus-workspace 9;
 
        # The wonky format used here is to work-around https://github.com/sodiboo/niri-flake/issues/944
        "Mod+Ctrl+1".action.move-column-to-workspace = [ 1 ];
        "Mod+Ctrl+2".action.move-column-to-workspace = [ 2 ];
        "Mod+Ctrl+3".action.move-column-to-workspace = [ 3 ];
        "Mod+Ctrl+4".action.move-column-to-workspace = [ 4 ];
        "Mod+Ctrl+5".action.move-column-to-workspace = [ 5 ];
        "Mod+Ctrl+6".action.move-column-to-workspace = [ 6 ];
        "Mod+Ctrl+7".action.move-column-to-workspace = [ 7 ];
        "Mod+Ctrl+8".action.move-column-to-workspace = [ 8 ];
        "Mod+Ctrl+9".action.move-column-to-workspace = [ 9 ];
 
        # // Alternatively, there are commands to move just a single window:
        # // Mod+Ctrl+1 { move-window-to-workspace 1; }
 
        # // Switches focus between the current and the previous workspace.
        # // Mod+Tab { focus-workspace-previous; }
 
        "Mod+Comma".action = consume-window-into-column;
        "Mod+Period".action = expel-window-from-column;
 
        # There are also commands that consume or expel a single window to the side.
        "Mod+BracketLeft".action = consume-or-expel-window-left;
        "Mod+BracketRight".action = consume-or-expel-window-right;
 
        "Mod+R".action = switch-preset-column-width;
        "Mod+Shift+R".action = reset-window-height;
        "Mod+F".action = maximize-column;
        "Mod+Shift+F".action = fullscreen-window;
        "Mod+C".action = center-column;
 
        # // Finer width adjustments.
        # // This command can also:
        # // * set width in pixels: "1000"
        # // * adjust width in pixels: "-5" or "+5"
        # // * set width as a percentage of screen width: "25%"
        # // * adjust width as a percentage of screen width: "-10%" or "+10%"
        # // Pixel sizes use logical, or scaled, pixels. I.e. on an output with scale 2.0,
        # // set-column-width "100" will make the column occupy 200 physical screen pixels.
        "Mod+Minus".action = set-column-width "-10%";
        "Mod+Equal".action = set-column-width "+10%";
 
        # // Finer height adjustments when in column with other windows.
        "Mod+Shift+Minus".action = set-window-height "-10%";
        "Mod+Shift+Equal".action = set-window-height "+10%";
 
        # // Move the focused window between the floating and the tiling layout.
        "Mod+V".action = toggle-window-floating;
        "Mod+Shift+V".action = switch-focus-between-floating-and-tiling;
 
        # // Toggle tabbed column display mode.
        # // Windows in this column will appear as vertical tabs,
        # // rather than stacked on top of each other.
        "Mod+W".action = toggle-column-tabbed-display;
 
        # // Actions to switch layouts.
        # // Note: if you uncomment these, make sure you do NOT have
        # // a matching layout switch hotkey configured in xkb options above.
        # // Having both at once on the same hotkey will break the switching,
        # // since it will switch twice upon pressing the hotkey (once by xkb, once by niri).
        # // Mod+Space       { switch-layout "next"; }
        # // Mod+Shift+Space { switch-layout "prev"; }
 
        "Print".action = screenshot;
        "Alt+Print".action = screenshot-window;
 
        # // The quit action will show a confirmation dialog to avoid accidental exits.
        "Mod+Shift+E".action = quit;
 
        # // Powers off the monitors. To turn them back on, do any input like
        # // moving the mouse or pressing any other key.
        "Mod+Shift+P".action = power-off-monitors;
      };

    };
  }


