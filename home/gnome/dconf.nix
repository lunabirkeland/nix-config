# Generated via dconf2nix: https://github.com/gvolpe/dconf2nix
{lib, ...}:
with lib.hm.gvariant; {
  dconf.settings = {
    "org/gnome/shell" = {
      favorite-apps = ["librewolf.desktop" "foot.desktop"];
      enabled-extensions = ["user-theme@gnome-shell-extensions.gcampax.github.com" "dash-to-panel@jderose9.github.com" "appindicatorsupport@rgcjonas.gmail.com" "Bluetooth-Battery-Meter@maniacx.github.com" "tiling-shell@domferr.github.com"];
    };

    "org/gnome/shell/extensions/dash-to-panel" = {
      appicon-style = "NORMAL";
      dot-size = 4;
      dot-style-focused = "DOTS";
      dot-style-unfocused = "DOTS";
      global-border-radius = 4;
      intellihide = true;
      intellihide-hide-from-windows = true;
      intellihide-use-pressure = true;
      panel-anchors = ''
        {"SDC-0x00000000":"MIDDLE"}
      '';
      panel-element-positions = ''
        {"SDC-0x00000000":[{"element":"showAppsButton","visible":false,"position":"stackedTL"},{"element":"activitiesButton","visible":false,"position":"stackedTL"},{"element":"leftBox","visible":false,"position":"stackedTL"},{"element":"taskbar","visible":true,"position":"stackedTL"},{"element":"centerBox","visible":false,"position":"stackedBR"},{"element":"rightBox","visible":false,"position":"stackedBR"},{"element":"dateMenu","visible":false,"position":"stackedBR"},{"element":"systemMenu","visible":false,"position":"stackedBR"},{"element":"desktopButton","visible":false,"position":"stackedBR"}]}
      '';
      panel-lengths = ''
        {"SDC-0x00000000":-1}
      '';
      panel-positions = ''
        {"SDC-0x00000000":"LEFT"}
      '';
      panel-sizes = ''
        {"SDC-0x00000000":48}
      '';
      scroll-icon-action = "PASS_THROUGH";
      show-favorites = true;
      show-favorites-all-monitors = true;
      show-running-apps = true;
      stockgs-keep-dash = false;
      stockgs-keep-top-panel = true;
      tray-padding = -1;
    };

    "org/gnome/terminal/legacy/profiles:" = {
      default = "95894cfd-82f7-430d-af6e-84d168bc34f5";
      list = ["95894cfd-82f7-430d-af6e-84d168bc34f5"];
    };

    "org/gnome/terminal/legacy/profiles:/:95894cfd-82f7-430d-af6e-84d168bc34f5" = {
      background-color = "#000000";
      cursor-background-color = "#f5e0dc";
      cursor-colors-set = true;
      cursor-foreground-color = "#000000";
      foreground-color = "#cdd6f4";
      highlight-background-color = "#000000";
      highlight-colors-set = true;
      highlight-foreground-color = "#585b70";
      palette = ["#45475a" "#f38ba8" "#a6e3a1" "#f9e2af" "#89b4fa" "#f5c2e7" "#94e2d5" "#bac2de" "#585b70" "#f38ba8" "#a6e3a1" "#f9e2af" "#89b4fa" "#f5c2e7" "#94e2d5" "#a6adc8"];
      scrollbar-policy = "never";
      use-theme-colors = false;
      visible-name = "Catppuccin Mocha";
    };
  };
}
