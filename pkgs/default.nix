pkgs: {
  # package = pkgs.callPackage ./package.nix {};
  jay = pkgs.callPackage ./jay.nix {};
  foot = pkgs.foot.overrideAttrs {
    postFixup = ''
      rm -f $out/share/applications/footclient.desktop
      rm -f $out/share/applications/foot-server.desktop
    '';
  };
}
