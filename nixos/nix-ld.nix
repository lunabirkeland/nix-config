{pkgs, ...}: {
  # allows running unpatched binaries on nixos
  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [libusb1];
  };
}
