{
  pkgs,
  lib,
  ...
}: {
  imports = [
    ../../nixos

    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  # Bootloader.
  boot = {
    # switch to latest kernel for bluetooth issues fixed in 6.9.6
    kernelPackages = pkgs.linuxPackages_latest;
    kernelParams = [
      "amdgpu.dcdebugmask=0x8000"
    ];
    loader = {
      systemd-boot.enable = lib.mkForce false;
      efi.canTouchEfiVariables = true;
    };
    lanzaboote = {
      enable = true;
      pkiBundle = "/etc/secureboot";
    };
  };

  networking.hostName = "caudatus";

  # fix wifi issues after sleep
  # https://wiki.archlinux.org/title/Lenovo_ThinkPad_T14_(AMD)_Gen_4#Unreliable/High_latency
  networking.networkmanager.wifi.powersave = false;

  # enable fingerprint reader support
  services.fprintd = {
    enable = true;
  };

  systemd.services = {
    fprintd.onSuccess = ["fingerprint-fix.service"];
    fprintd.onFailure = ["fingerprint-fix.service"];
    fingerprint-fix = {
      enable = true;
      description = "Check and reset fingerprint reader after fprintd initialization";
      script = ''
        if journalctl -Iu fprintd.service | grep 'Ignoring device due to initialization error: endpoint stalled or request not supported'; then
          tee "/sys/bus/pci/drivers/xhci_hcd/unbind" > /dev/null <<< "0000:c3:00.3"
          sleep 0.2s
          tee "/sys/bus/pci/devices/0000:c3:00.3/reset" > /dev/null <<< 1
          sleep 0.2s
          tee "/sys/bus/pci/drivers/xhci_hcd/bind" > /dev/null <<< "0000:c3:00.3"
        fi
      '';
    };
    wifi-fix = {
      enable = true;
      after = ["suspend.target" "suspend-then-hibernate.target" "hibernate.target" "hybrid-sleep.target"];
      wantedBy = ["suspend.target" "suspend-then-hibernate.target" "hibernate.target" "hybrid-sleep.target"];
      description = "Reset wifi device after wake up";
      script = ''
        tee "/sys/bus/pci/devices/0000:01:00.0/remove" > /dev/null <<< 1
        sleep 0.2s
        tee "/sys/bus/pci/rescan" > /dev/null <<< 1
      '';
    };
  };

  security.pam.services.login.fprintAuth = false;

  # enable firmware update daemon
  services.fwupd.enable = true;

  services.xserver = {
    xkb = {
      layout = "us";
      variant = "altgr-intl";
    };
  };

  services.auto-cpufreq = {
    enable = true;
    settings = {
      battery = {
        governor = "powersave";
        turbo = "auto";
      };
      charger = {
        governor = "performance";
        turbo = "auto";
      };
    };
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "26.05";
}
