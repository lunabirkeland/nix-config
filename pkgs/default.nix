pkgs: {
  # package = pkgs.callPackage ./package.nix {};
  jay = pkgs.callPackage ./jay.nix {};
  wl-tray-bridge = pkgs.callPackage ./wl-tray-bridge.nix {};
  wl-proxy = pkgs.callPackage ./wl-proxy.nix {};
  bitwarden-desktop = pkgs.bitwarden-desktop.overrideAttrs (_: prev: {
    postPatch =
      prev.postPatch
      + ''
        sed -i 's/\/images\/icon.png/\/images\/tray.png/g' apps/desktop/src/main/tray.main.ts
        cp ${./bitwarden.png} apps/desktop/src/images/tray.png
      '';
  });
  foot = pkgs.foot.overrideAttrs {
    postFixup = ''
      rm -f $out/share/applications/footclient.desktop
      rm -f $out/share/applications/foot-server.desktop
    '';
  };
}
