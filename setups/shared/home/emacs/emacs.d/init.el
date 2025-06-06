(use-package emacs
  :init
  (load-theme 'everforest-hard-dark t)

  ;; Disable toolbar, menu bar, and scroll bar.
  (tool-bar-mode   -1)
  (scroll-bar-mode -1)
  (menu-bar-mode   -1)

  ;; Disable left-right fringes and add a uniform border width.
  (set-fringe-mode 0)
  (add-to-list 'default-frame-alist '(internal-border-width . 7))

  ;; Helper function to get user files.
  (defun user-file (file-path)
    (expand-file-name (concat user-emacs-directory file-path)))

  ;; Add smart open line, the idea and code came from this site:
  ;; https://emacsredux.com/blog/2013/03/26/smarter-open-line/.
  (defun smart-open-line ()
    "A smarter open line that inserts indentation."
    (interactive)
    (move-end-of-line nil)
    (newline-and-indent))

  ;; Scroll the text half a page up.
  (defun scroll-half-page-up (&optional arg)
    "Move half a page up. If an argument is supplied it is passed to 'scroll-up-command'."
    (interactive)
    (if arg
        (scroll-up-command arg)
        (scroll-up-command (/ (window-body-height) 2))))

  ;; Scroll the text half a page down.
  (defun scroll-half-page-down (&optional arg)
    "Move half a page down. If an argument is supplied it is passed to 'scroll-down-command'."
    (interactive)
    (if arg
        (scroll-down-command arg)
        (scroll-down-command (/ (window-body-height) 2))))

  :bind
  ("M-o" . smart-open-line)             ; Vim-like open line.

  ("C-v" . scroll-half-page-up)
  ("M-v" . scroll-half-page-down)

  ;; Custom prefix map.
  (:prefix-map personal-map
               :prefix "C-z"
               :prefix-docstring "Personal keybindings prefix"
               ("z" . suspend-frame))

  :custom
  (tab-always-indent 'complete) ; Enable indentation + completion using the TAB key.
  (indent-tabs-mode nil)       ; Do not indent with the tab character.
  (custom-file (expand-file-name (concat user-emacs-directory "custom_var.el"))) ; Write variables into a separate file.

  :hook
  (prog-mode-hook . display-line-numbers-mode)
  (prog-mode-hook . electric-pair-mode))

;; Setup which key.
(use-package which-key
  :config
  (which-key-mode)
  (which-key-setup-side-window-bottom))

;; Avy allows for fast jumping in buffers.
(use-package avy
  :bind
  ("C-:" . avy-goto-char)
  ("C-'" . avy-goto-char-2)

  ("M-g e" . avy-goto-word-0)
  ("M-g w" . avy-goto-word-1)
  ("M-g l" . avy-goto-line)
  ("M-g s" . avy-goto-char-timer)

  :custom (avy-timeout-seconds 2))

;; Use corfu for completion prompts.
(use-package corfu
  :custom
  (corfu-cycle t)
  (corfu-preselect 'prompt)

  (corfu-popupinfo-delay '(0.5 . 0))

  ;; Use tab to cycle completions.
  :bind (:map corfu-map
	      ("TAB"     . corfu-next)
	      ([tab]     . corfu-next)
	      ("S-TAB"   . corfu-previous)
	      ([backtab] . corfu-previous))

  :init
  (global-corfu-mode)
  (corfu-popupinfo-mode))


;; Use eglot as my lsp manager.
(use-package eglot
  :hook					; Add language hooks.
  (haskell-mode   . eglot-ensure)
  (nix-mode       . eglot-ensure)
  (python-ts-mode . eglot-ensure)

  :custom
  (eglot-autoshutdown t) ; shutdown language server after closing last file.
  (eglot-confirm-server-initiated-edits nil)) ; allow edits without confirmation.

;; Use consult for better searching interfaces.
(use-package consult
  :bind
  ;; Buffer switching using consult.
  ("C-x b" . consult-buffer)            ; Orig. switch-to-buffer.

  ("M-y" . consult-yank-pop)            ; Orig. yank-pop.

  ("M-g f"   . consult-flymake)
  ("M-g M-g" . consult-goto-line)       ; Orig. goto-line.
  ("M-g g"   . consult-goto-line)       ; Orig. goto-line.
  ("M-g m"   . consult-mark)
  ("M-g i"   . consult-imenu)
  ("M-g I"   . consult-imenu-multi)

  ;; Seaching commands.
  ("M-s d" . consult-fd)
  ("M-s c" . consult-locate)
  ("M-s r" . consult-ripgrep)
  ("M-s l" . consult-line)
  ("M-s L" . consult-line-multi)
  ("M-s k" . consult-keep-lines)
  ("M-s u" . consult-focus-lines)

  ("M-#" . consult-register-load)
  ("M-'" . consult-register-store)
  ("C-M-#" . consult-register)

  ;; Commands for fast register access.
  ("C-c h" . consult-history)
  ("C-c K" . consult-kmacro)
  ("C-c i" . consult-info)

  (:map isearch-mode-map

  ;; These keybindings help consult-line detect isearch.
  ("M-s l" . consult-line)
  ("M-s L" . consult-line-multi)))

;; Add orderless completion style.
(use-package orderless
  :custom
  (completion-styles '(orderless flex))
  (completion-category-defaults nil) ; Ensures that orderless is the only completion style used by default.
  (completion-category-overrides '((file (styles basic partial-completion)))))

;; Embark provides actions on buffer targets.
(use-package embark
  :bind
  ("C-."   . embark-act)
  ("M-."   . embark-dwim)
  ("C-h B" . embark-bindings)

  ;; Add custom variable for embark indicator.
  :custom (embark-indicators '(embark-minimal-indicator
			       embark-highlight-indicator
			       embark-isearch-highlight-indicator)))

;; Add embark consult integration.
(use-package embark-consult
  :hook (embark-collect-mode . consult-preview-at-point-mode))

;; Vertico is a package for interactive completion.
(use-package vertico
  :custom (vertico--resize t)

  :init
  (vertico-mode)
  (vertico-multiform-mode)

  ;; Use grid for embark completion.
  (add-to-list 'vertico-multiform-categories '(embark-keybinding grid)))

;; Envrc automatically loads direnv environments in a per-buffer basis.
(use-package envrc
  :hook (after-init . envrc-global-mode))

;; Haskell mode configuration.
(use-package haskell-mode
  :defer t
  :custom
  (haskell-indentation-layout-offset 2)	; Tweak indentation settings to my preferences.
  (haskell-indentation-left-offset 2)
  (haskell-indentation-where-pre-offset 2)
  (haskell-indentation-where-post-offset 2))

;; Manage tree-sitter grammars.
(use-package treesit-auto
  :custom (treesit-auto-install 'prompt)

  :config
  ;; Extra tree-sitter language grammars.
  (setq treesit-language-source-alist
   '((kanata . ("https://github.com/postsolar/tree-sitter-kanata" "master" "src"))))

  (treesit-auto-add-to-auto-mode-alist 'all)
  (global-treesit-auto-mode))

;; Add completion preview.
(use-package completion-preview
  :hook (after-init-hook . global-completion-preview-mode))

;; Use eldoc for documentation popups.
(use-package eldoc-box
  :bind ("C-h ;" . #'eldoc-box-help-at-point))

;; An undo-tree for Emacs.
(use-package vundo
  :bind ("C-c u" . vundo))

;; Add kitty terminal protocol extension for terminal compatibility.
(use-package kkp
  :config (global-kkp-mode t))

;; Marginalia adds annotations to the minibuffer.
(use-package marginalia
  ;; Bind `marginalia-cycle' locally in the minibuffer.  To make the binding
  ;; available in the *Completions* buffer, add it to the
  ;; `completion-list-mode-map'.
  :bind (:map minibuffer-local-map ("M-A" . marginalia-cycle))
  :init (marginalia-mode))

;; ispell configuration.
(use-package ispell
  :defer t
  :custom
  (ispell-program-name (executable-find "hunspell")) ; Make ispell use hunspell.

  ;; Set default ispell language to english.
  (ispell-dictionary       "en_US")
  (ispell-local-dictionary "en_US")

  ;; Necessary changes to make ispell work with hunspell.
  (spell-local-dictionary-alist
   '("en_US" "[[:alpha:]]" "[^[:alpha:]]" "[']" nil ("-d" "en_US") nil utf-8())))

;; Add syntax highlighting to magit diffs.
(use-package magit-delta
  :after magit
  :init (magit-delta-mode)

  ;; Setting the theme to use for magit diff.
  :custom
  (magit-delta-default-dark-theme  "gruvbox-dark")
  (magit-delta-default-light-theme "gruvbox"))

;; A theme I like to occasionally use.
(use-package everforest
  (:vc (:url "https://github.com/Theory-of-Everything/everforest-emacs" :rev :newest)))

