{
  pkgs,
  lib,
  config,
  ...
}: {
  imports = [
    ./uwsm.nix
    ./i3status.nix
  ];

  home.packages = with pkgs; [
    wl-clipboard
    bzmenu
    nerd-fonts.dejavu-sans-mono
  ];

  services = {
    awww.enable = true;
    mako = {
      enable = true;
      settings = {
        border-size = 0;
        outer-margin = "24,0,0,0";
      };
    };
    polkit-gnome.enable = true;
  };

  programs = {
    fuzzel = {
      enable = true;
      settings = {
        main = {
          font = lib.mkForce "${config.stylix.fonts.monospace.name}:size=20";
          width = 45;
        };
        border.width = 0;
        colors = {
          background = lib.mkForce "#000000E6";
        };
      };
    };
    swaylock.enable = true;
  };

  xdg.configFile = {
    "jay/config.toml" = {
      source = (pkgs.formats.toml {}).generate "config.toml" {
        keymap.rmlvo = {
          layout = "us";
          variants = "altgr-intl";
        };
        outputs = [
          {
            match.connector = "eDP-1";
            scale = 1.75;
            color-space = "bt2020";
            transfer-function = "pq";
            format = "xrgb2101010";
            blend-space = "linear";
          }
        ];
        inputs = [
          {
            match.name = "Logitech G305";
            accel-profile = "Flat";
            transform-matrix = [[0.65 0] [0 0.65]];
          }
          {
            match.name = "TPPS/2 Synaptics TrackPoint";
            accel-profile = "Flat";
          }
          {
            match.is-gesture = true;
            natural-scrolling = true;
          }
        ];
        gfx-api = "Vulkan";
        color-management.enabled = true;
        show-bar = true;
        show-titles = false;
        middle-click-paste = false;
        workspace-display-order = "sorted";
        actions = {
          lock = {
            type = "exec";
            exec = {
              prog = "${lib.getExe pkgs.swaylock}";
              privileged = true;
            };
          };
          poweroff = {
            type = "exec";
            exec = [
              "systemctl"
              "poweroff"
            ];
          };
          reboot = {
            type = "exec";
            exec = [
              "systemctl"
              "reboot"
            ];
          };
          suspend = {
            type = "exec";
            exec = [
              "systemctl"
              "suspend"
            ];
          };
        };

        shortcuts =
          {
            "alt-q" = "quit";
            "alt-shift-c" = "close";
            "alt-shift-r" = "reload-config-toml";
            "logo-space" = {
              type = "exec";
              exec = lib.getExe pkgs.fuzzel;
            };
            "logo-q" = {
              type = "exec";
              exec = lib.getExe pkgs.librewolf;
            };
            "logo-x" = {
              type = "exec";
              exec = lib.getExe pkgs.foot;
            };
            "logo-b" = {
              type = "exec";
              exec = [(lib.getExe pkgs.bzmenu) "-l" "fuzzel"];
            };
            "ctrl-alt-F1" = {
              type = "switch-to-vt";
              num = 1;
            };
            "ctrl-alt-F2" = {
              type = "switch-to-vt";
              num = 2;
            };
            "ctrl-alt-F3" = {
              type = "switch-to-vt";
              num = 3;
            };
            "logo-1" = {
              type = "show-workspace";
              name = "1";
            };
            "logo-2" = {
              type = "show-workspace";
              name = "2";
            };
            "logo-3" = {
              type = "show-workspace";
              name = "3";
            };
          }
          // (lib.attrsets.mergeAttrsList (
            map (
              x: let
                xStr = builtins.toString x;
              in {
                # generate move to tty
                "ctrl-alt-F${xStr}" = {
                  type = "switch-to-vt";
                  num = x;
                };
              }
            ) (builtins.genList (x: x + 1) 12)
          ))
          // (lib.attrsets.mergeAttrsList (
            map (
              x: let
                xStr = builtins.toString x;
              in {
                # generate to switch and move to workspaces
                "logo-${xStr}" = {
                  type = "show-workspace";
                  name = xStr;
                };
                "logo-shift-${xStr}" = {
                  type = "move-to-workspace";
                  name = xStr;
                };
              }
            ) (builtins.genList (x: x + 1) 9)
          ));
        complex-shortcuts = {
          XF86AudioRaiseVolume = {
            mod-mask = "";
            action = {
              type = "exec";
              exec = ["${pkgs.wireplumber}/bin/wpctl" "set-volume" "@DEFAULT_SINK@" "5%+"];
            };
          };
          XF86AudioLowerVolume = {
            mod-mask = "";
            action = {
              type = "exec";
              exec = ["${pkgs.wireplumber}/bin/wpctl" "set-volume" "@DEFAULT_SINK@" "5%-"];
            };
          };
          XF86AudioMute = {
            mod-mask = "";
            action = {
              type = "exec";
              exec = ["${pkgs.wireplumber}/bin/wpctl" "set-mute" "@DEFAULT_SINK@" "toggle"];
            };
          };
          XF86MonBrightnessUp = {
            mod-mask = "";
            action = {
              type = "exec";
              exec = [(lib.getExe pkgs.brightnessctl) "s" "5%+"];
            };
          };
          XF86MonBrightnessDown = {
            mod-mask = "";
            action = {
              type = "exec";
              exec = [(lib.getExe pkgs.brightnessctl) "s" "5%-"];
            };
          };
        };
        windows = [
          {
            match.app-id = "gcr-prompter";
            action = "float";
          }
          {
            match.app-id-regex = "polkit-gnome-authentication-agent-.*";
            action = "float";
          }
        ];
        status = {
          format = "i3bar";
          exec = [(lib.getExe pkgs.i3status-rust) "config-default.toml"];
          i3bar-separator = "";
        };
        theme = with config.lib.stylix.colors.withHashtag; {
          # Desktop background
          bg-color = "#0000";
          # Bar background
          bar-bg-color = "#000000BF";
          # Status text in the bar
          bar-status-text-color = base05;
          # Borders between tiled windows
          border-color = "#0000";
          # Background of the focused window’s title
          focused-title-bg-color = base06;
          # Text color of the focused window’s title
          focused-title-text-color = base00;
          # Background of unfocused window titles
          unfocused-title-bg-color = "#0000";
          # Text color of unfocused window titles
          unfocused-title-text-color = base05;
          # Background of focused-but-inactive titles
          focused-inactive-title-bg-color = "#0000";
          # Text color of focused-but-inactive titles
          focused-inactive-title-text-color = base05;
          # Background of titles that have requested attention
          attention-requested-bg-color = "#0000";
          # Background of focused titles that are being recorded
          captured-focused-title-bg-color = "#0000";
          # Background of unfocused titles that are being recorded
          captured-unfocused-title-bg-color = "#0000";
          # Separator between title bars and window content
          separator-color = "#0000";
          # Accent color used to highlight parts of the UI
          highlight-color = base06;
          # Width of borders between windows (px)
          border-width = 0;
          # Height of window title tabs (px)
          # title-height = 32;
          # Height of the bar (px). Defaults to the same as title-height.
          bar-height = 24;
          # Width of the bar’s bottom separator (px). Default: 1.
          bar-separator-width = 0;
          # General font for the compositor
          font = "DejaVuSansM Nerd Font Mono 10";
        };
      };
    };
  };
}
