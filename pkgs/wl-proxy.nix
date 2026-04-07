{
  lib,
  rustPlatform,
  fetchFromGitHub,
  makeWrapper,
  pkg-config,
  wayland,
  sqlite,
}:
rustPlatform.buildRustPackage (finalAttrs: {
  pname = "wl-proxy";
  version = "0.1.2";

  src = fetchFromGitHub {
    owner = "mahkoh";
    repo = "wl-proxy";
    rev = "acd1954e9cd9a5bc9b8d20132d250c91dd10647d";
    hash = "sha256-lrLK0U84y8IWpvmDoGeqkpqor9EKrwrKSkfi/aSMpc0=";
  };

  cargoHash = "sha256-7ZJrm7SnkI0beinw+azcJGKPHPjb60pPwyZq2DCbowo=";

  nativeBuildInputs = [
    makeWrapper
    pkg-config
  ];

  buildInputs = [
    sqlite
  ];

  checkFlags = [
    # tests fail as they require env variable XDG_RUNTIME_DIR to be set
    "--skip=acceptor::tests::test"
    "--skip=state::tests::acceptor"
  ];

  postInstall = ''
    wrapProgram $out/bin/update-protocols \
      --set LD_LIBRARY_PATH ${lib.makeLibraryPath [wayland]}
    wrapProgram $out/bin/window-to-tray \
      --set LD_LIBRARY_PATH ${lib.makeLibraryPath [wayland]}
    wrapProgram $out/bin/wl-cm-filter \
      --set LD_LIBRARY_PATH ${lib.makeLibraryPath [wayland]}
    wrapProgram $out/bin/wl-format-filter \
      --set LD_LIBRARY_PATH ${lib.makeLibraryPath [wayland]}
    wrapProgram $out/bin/wl-paper \
      --set LD_LIBRARY_PATH ${lib.makeLibraryPath [wayland]}
    wrapProgram $out/bin/wl-veil \
      --set LD_LIBRARY_PATH ${lib.makeLibraryPath [wayland]}
  '';

  meta = {
    description = "applications used to proxy wayland connections and intercept and manipulate wayland messages";
    homepage = "https://github.com/mahkoh/wl-tray-bridge";
    license = lib.licenses.gpl3;
    platforms = lib.platforms.linux;
  };
})
