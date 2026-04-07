{
  pkgs,
  config,
  ...
}: {
  xdg.configFile = {
    "wl-tray-bridge/config.toml" = {
      source = with config.lib.stylix.colors.withHashtag;
        (pkgs.formats.toml {}).generate "config.toml" {
          # This setting applies an additional scale to the entire UI.
          # Instead of modifying the individual sizes below, you might get better results by
          # changing this value.
          scale = 1.0;
          # The icon theme to use for named icons.
          theme = "Papirus-Dark";
          # Whether menus should stay open after clicking on an entry.
          keep-open = false;

          # These settings apply to the icons displayed in the tray area.
          icon = {
            # The color used for SVG icons that allow recoloring.
            color = base05;
          };

          # These settings apply to menus.
          menu = {
            # The font used in menus.
            font = "DejaVuSansM Nerd Font Mono 10";
            # The normal font color.
            color = base05;
            # The background color.
            background-color = "#000000AA";
            # The font color when hovering over an entry.
            hover-color = base06;
            # The background color when hovering over an entry.
            hover-background-color = "#000000AA";
            # The font color for disabled entries.
            disabled-color = base08;
            # The border color.
            border-color = "#000000";
            # The border width.
            border-width = 0.0;
            # The padding around entries.
            padding = 5.0;
            # Whether sub-menus should be organized from right to left.
            right-to-left = true;
          };

          # These settings apply to tooltips.
          tooltip = {
            # The font used in tooltips.
            font = "DejaVuSansM Nerd Font Mono 10";
            # The font color.
            color = base05;
            # The background color.
            background-color = "#000000AA";
            # The border color.
            border-color = "#000000";
            # The border width.
            border-width = 0.0;
            # The padding around the text.
            padding = 2.0;
          };
        };
    };
  };
}
