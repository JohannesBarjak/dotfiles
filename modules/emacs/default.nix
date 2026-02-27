{inputs, ...}: {
  modules.emacs.nixos = {...}: {
    # Declare emacs system overlay.
    nixpkgs.overlays = [
      inputs.emacs-overlay.overlays.default
    ];
  };

  modules.emacs.home = {pkgs, ...}: {
    # Enable emacs background service.
    services.emacs = {
      enable = true;
      defaultEditor = true;
    };

    home.packages = [
      pkgs.texlive.combined.scheme-full
    ];

    # Main gui text editor.
    programs.emacs = {
      enable = true;

      extraPackages = epkgs: [
        # Navigation and selection plugins for Emacs.
        epkgs.avy
        epkgs.consult
        epkgs.vertico
        epkgs.embark
        epkgs.embark-consult
        epkgs.expand-region
        epkgs.orderless
        epkgs.puni
        epkgs.activities
        epkgs.beframe

        # Integration with direnv.
        epkgs.envrc

        # Language modes.
        epkgs.idris2-mode
        epkgs.haskell-ts-mode
        epkgs.nix-ts-mode
        epkgs.markdown-mode
        epkgs.nushell-mode
        epkgs.uiua-ts-mode
        epkgs.bqn-mode
        epkgs.j-mode
        epkgs.racket-mode
        epkgs.treesit-grammars.with-all-grammars

        # Code completion plugins.
        epkgs.corfu
        epkgs.yasnippet

        # Editing plugins.
        epkgs.wgrep
        epkgs.multiple-cursors

        # Documentation plugins.
        epkgs.marginalia
        epkgs.eldoc-box
        epkgs.consult-hoogle

        # Terminal related packages.
        epkgs.eat
        epkgs.kkp

        # Git.
        epkgs.magit
        epkgs.magit-delta
        epkgs.git-gutter

        # Misc.
        epkgs.zoom
        epkgs.pandoc-mode
        epkgs.vundo
        epkgs.try
        (epkgs.melpaBuild {
          ename = "reader";
          pname = "emacs-reader";
          version = "20250629";
          src = pkgs.fetchFromGitea {
            domain = "codeberg.org";
            owner = "divyaranjan";
            repo = "emacs-reader";
            rev = "2d95199bbb0f2c488f8d5d1ae8e9dc2de937f430";
            hash = "sha256-rZ+1PgRS68QN0yXdYyEJafJmbCceaKeDQhT+GfsPiFA=";
          };
          files = ''(:defaults "render-core.so")'';
          nativeBuildInputs = [ pkgs.pkg-config ];
          buildInputs = with pkgs; [ gcc mupdf gnumake pkg-config ];
          preBuild = "make clean all";
        })


        # Latex.
        epkgs.auctex
        epkgs.cdlatex
        epkgs.org-fragtog

        # Themes.
        epkgs.doom-themes
        epkgs.base16-theme
        epkgs.org-superstar
        epkgs.fira-code-mode
      ];

      package = (pkgs.emacs-igc-pgtk.overrideAttrs (prev: {
        NIX_CFLAGS_COMPILE = (prev.NIX_CFLAGS_COMPILE or []) ++
                          [ "-O3" "-march=native"
                            "-fgcse-las" "-fgcse-sm"
                            "-pipe" "-fno-semantic-interposition" ];
      }));
    };

    # Copy Emacs elisp configuration into its appropriate folder.
    xdg.configFile."emacs" = {
      source = ./emacs.d;
      recursive = true;
    };
  };
  }
