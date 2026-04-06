{pkgs, ...}: {
  programs.librewolf = {
    enable = true;
    nativeMessagingHosts = with pkgs; [
      bitwarden-desktop
    ];
    profiles.default = {
      userChrome = ''
        :root {
          --bg: #000000BF;
          --tabpanel-background-color: transparent !important;
        }


        #main-window {
          background: var(--bg) !important;
        }

        #navigator-toolbox, #browser, nav-bar, #urlbar-background, toolbar {
          background: transparent !important;
        }

        .tab-background {
          --tab-selected-bgcolor: #60606060 !important;
          --tab-hover-background-color: #60606060 !important;
        }

        hbox#urlbar[open="true"] hbox#urlbar-background {
          background: #FFFFFF40 !important;
        }
      '';
      userContent = ''
        :root {
          --newtab-background-color: transparent !important;
          --content-search-handoff-ui-background-color: transparent !important;
        }
      '';
    };
  };
}
