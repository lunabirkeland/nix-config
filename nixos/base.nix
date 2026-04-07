{
  inputs,
  pkgs,
  vars,
  ...
}: {
  nixpkgs.config.allowUnfree = true;

  environment = {
    systemPackages = with pkgs; [
      git
      perf
      neovim
      curl
      wget
      file
      which
      tree
      sbctl
      bitwarden-desktop
    ];
    shells = with pkgs; [zsh];
    # allows completion for system packages
    pathsToLink = ["/share/zsh"];
    # for security reasons, do not load neovim's user config
    # since EDITOR may be used to edit some critical files
    variables.EDITOR = "nvim --clean";
  };

  boot.initrd.systemd.enable = true;

  # enable opengl
  hardware.graphics.enable = true;

  services.seatd.enable = true;

  powerManagement.enable = true;

  # allows pipewire to gain realtime priority
  security.rtkit.enable = true;

  programs.zsh.enable = true;
  programs.firejail.enable = true;

  programs.nh = {
    enable = true;
    clean.enable = true;
    clean.extraArgs = "--keep-since 14d --keep 3";
    flake = "/home/luna/nix-config/";
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users = {
    defaultUserShell = pkgs.zsh;
    users.${vars.username} = {
      isNormalUser = true;
      extraGroups = ["networkmanager" "wheel" "wireshark" "dialout" "adbusers"];
    };
  };

  nix = {
    settings = {
      # Enable flakes and new 'nix' command
      experimental-features = "nix-command flakes";
      # Deduplicate and optimize nix store
      auto-optimise-store = true;
      builders-use-substitutes = true;
      # Use cached hyprland builds to avoid rebuidling
      substituters = [
        "https://cache.nixos.org"
        "https://nix-community.cachix.org"
        "https://nvf.cachix.org"
      ];
      trusted-public-keys = [
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "nvf.cachix.org-1:GMQWiUhZ6ux9D5CvFFMwnc2nFrUHTeGaXRlVBXo+naI="
      ];
      download-buffer-size = 524288000;
    };
    registry."nixpkgs-unfree" = {
      from = {
        id = "nixpkgs-unfree";
        type = "indirect";
      };
      flake = inputs.nixpkgs-unfree;
    };
    registry."nixpkgs-unstable" = {
      from = {
        id = "nixpkgs-unstable";
        type = "indirect";
      };
      flake = inputs.nixpkgs-unstable;
    };
    registry."nixpkgs-unstable-unfree" = {
      from = {
        id = "nixpkgs-unstable-unfree";
        type = "indirect";
      };
      flake = inputs.nixpkgs-unstable-unfree;
    };
  };
}
