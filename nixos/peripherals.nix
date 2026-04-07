{pkgs, ...}: {
  # Enable CUPS to print documents.
  services.printing.enable = true;

  services.udev.packages = with pkgs; [
    nrf-udev
  ];
}
