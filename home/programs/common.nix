{pkgs, ...}: {
  # enable user fonts
  fonts.fontconfig.enable = true;

  programs = {
    gpg.enable = true;

    zsh = {
      enable = true;
      autosuggestion.enable = true;
      enableCompletion = true;
      syntaxHighlighting.enable = true;
      initContent = "eval \"$(direnv hook zsh)\"\n";
    };

    direnv = {
      enable = true;
      enableZshIntegration = true;
      nix-direnv.enable = true;
    };

    starship = {
      enable = true;
      # custom settings
      enableZshIntegration = true;
      settings = {
        add_newline = true;
        aws.disabled = true;
        gcloud.disabled = true;
      };
    };

    mpv = {
      enable = true;
      config = {
        sub-auto = "fuzzy";
        vo = "gpu-next";
        target-colorspace-hint = true;
        target-peak = 400;
        gpu-api = "vulkan";
        gpu-context = "waylandvk";
      };
    };

    librewolf = {
      enable = true;
      nativeMessagingHosts = with pkgs; [
        bitwarden-desktop
      ];
    };
    foot = {
      enable = true;
      settings = {
        csd = {
          preferred = "none";
        };
      };
    };
  };

  home.packages = with pkgs; [
    wget
    curl
    git
    fd
    ripgrep
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-color-emoji
    gcc
    nerd-fonts.symbols-only
    foliate
    hunspell
    hunspellDicts.nb-no
    hunspellDicts.en-gb-large
    bitwarden-desktop
    tutanota-desktop
  ];

  services.easyeffects.enable = true;

  xdg = {
    autostart = {
      enable = true;
      entries = with pkgs; [
        "${bitwarden-desktop}/share/applications/bitwarden.desktop"
        "${tutanota-desktop}/share/applications/tutanota-desktop.desktop"
      ];
    };
  };
}
