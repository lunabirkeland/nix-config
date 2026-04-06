{
  pkgs,
  lib,
  vars,
  ...
}: {
  environment.systemPackages = with pkgs; [
    jay
    foot
    fuzzel
    swaylock
    brightnessctl
  ];

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      jay
      xdg-desktop-portal-gtk
    ];
    configPackages = with pkgs; [
      jay
    ];
  };

  programs = {
    uwsm = {
      enable = true;

      waylandCompositors.jay = {
        prettyName = "Jay";
        comment = "Jay compositor";

        binPath = lib.getExe pkgs.jay + " run";
      };
    };

    dconf.enable = true;
    xwayland.enable = true;
  };

  security = {
    polkit.enable = true;
    pam.services = {
      greetd = {
        # Add pam_fde_boot_pw rule BEFORE gnome_keyring in the session phase
        # This ensures the LUKS password is injected before gnome-keyring tries to unlock
        # Order 12500: gnome_keyring is typically at 12600, so this runs before it
        rules.session.fde_boot_pw = {
          order = 12500;
          enable = true;
          control = "optional";
          modulePath = "${pkgs.pam_fde_boot_pw}/lib/security/pam_fde_boot_pw.so";
          args = ["inject_for=gkr"];
        };
        fprintAuth = false;
      };
      greetd.enableGnomeKeyring = true;
      login.enableGnomeKeyring = true;
    };
  };

  services = {
    displayManager.sessionPackages = with pkgs; [jay];
    pipewire.enable = true;
    gnome.gnome-keyring.enable = true;
    # needed for bzmenu
    resolved.enable = true;
    greetd = let
      session = "uwsm start -F jay run";
    in {
      enable = true;
      useTextGreeter = true;
      settings = {
        terminal.vt = 1;

        # auto-login into session without requiring a password on initial boot
        initial_session = {
          command = session;
          user = vars.username;
        };

        # require username and password on subsequent logins
        default_session = {
          command = ''${lib.getExe pkgs.tuigreet} --time --cmd "${session}"'';
          user = "greeter";
        };
      };
    };
  };
}
