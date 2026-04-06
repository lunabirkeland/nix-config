{pkgs, ...}: {
  home.packages = with pkgs; [
    font-awesome_6
  ];
  fonts.fontconfig.enable = true;

  programs.i3status-rust = {
    enable = true;
    bars.default = {
      blocks = [
        {
          block = "amd_gpu";
          format = " $utilization $icon ";
        }
        {
          block = "cpu";
          format = " $utilization $icon ";
        }
        {
          block = "memory";
          format = " $mem_used.eng(prefix:Mi) $icon ";
        }
        {
          block = "sound";
          format = "{ $volume|} $icon ";
        }
        {
          block = "backlight";
          format = " $brightness $icon ";
        }
        {
          block = "battery";
          format = " $percentage $icon ";
          full_format = "";
          not_charging_format = "";
        }
        {
          block = "time";
          format = " $timestamp.datetime(f:'%a %b %-d %R') ";
          interval = 5;
        }
      ];
      icons = "material-nf";
      settings = {
        theme = {
          theme = "native";
        };
      };
    };
  };
}
