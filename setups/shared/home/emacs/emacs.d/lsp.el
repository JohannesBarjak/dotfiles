;; Use eglot as my lsp manager.
(use-package eglot
  :hook					; Add language hooks.
  (haskell-mode   . eglot-ensure)
  (nix-mode       . eglot-ensure)
  (python-ts-mode . eglot-ensure)

  :custom
  (eglot-autoshutdown t) ; shutdown language server after closing last file.
  (eglot-confirm-server-initiated-edits nil)) ; allow edits without confirmation.

;; Envrc automatically loads direnv environments in a per-buffer basis.
(use-package envrc
  :hook (after-init . envrc-global-mode))

;; Manage tree-sitter grammars.
(use-package treesit-auto
  :custom (treesit-auto-install 'prompt)

  :config
  ;; Extra tree-sitter language grammars.
  (setq treesit-language-source-alist
   '((kanata . ("https://github.com/postsolar/tree-sitter-kanata" "master" "src"))))

  (treesit-auto-add-to-auto-mode-alist 'all)
  (global-treesit-auto-mode))

;; Haskell mode configuration.
(use-package haskell-mode
  :defer t
  :custom
  (haskell-indentation-layout-offset 2)	; Tweak indentation settings to my preferences.
  (haskell-indentation-left-offset 2)
  (haskell-indentation-where-pre-offset 2)
  (haskell-indentation-where-post-offset 2))

(use-package uiua-ts-mode
  :mode "\\.ua\\'")

