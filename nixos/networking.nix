{
  config,
  pkgs,
  ...
}: {
  # Enable networking
  networking.networkmanager.enable = true;

  # network discovery
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    publish = {
      enable = true;
      domain = true;
      userServices = true;
    };
  };

  # disable rpfilter to allow wireguard to work
  networking.firewall.checkReversePath = false;

  hardware.bluetooth.enable = true;
}
