; Helper function to load elisp files.
(defun load-user-file (file-path)
  (load-file (expand-file-name (concat user-emacs-directory file-path))))

(use-package emacs
  :init
  (load-theme 'doom-gruvbox t)

  (tool-bar-mode -1) ; Disable toolbar and scrollbar.
  (scroll-bar-mode -1)

  (load-user-file "meow.el")

  :custom
  (tab-always-indent 'complete) ; Enable indentation + completion using the TAB key.
  (custom-file "~/.config/emacs/custom_var.el")

  :hook (prog-mode-hook . display-line-numbers-mode))

; Avy allows for fast jumping in buffers.
(use-package avy
  :init
  (require 'transient)

  ; Define avy keybingings using transient.
  (transient-define-prefix avy-transient ()
    "Transient menu for avy"
    ["Avy command"
     ("c" "avy-goto-char" avy-goto-char)
     ("l" "avy-goto-line" avy-goto-line)
     ("r" "avy-resume" avy-resume)
     ("s" "avy-isearch" avy-isearch)
     ("f" "avy-goto-char-timer" avy-goto-char-timer)
     ("w" "avy-goto-subword-1" avy-goto-subword-1)
     ("q" "quit" transient-quit-one)])
  :bind ("C-; a" . avy-transient))

; Use corfu for completion prompts.
(use-package corfu
  :custom
  (corfu-cycle t)
  (corfu-preselect 'prompt)

  ; Use tab to cycle completions.
  :bind (:map corfu-map
	      ("TAB" . corfu-next)
	      ([tab] . corfu-next)
	      ("S-TAB" . corfu-previous)
	      ([backtab] . corfu-previous))

  :init
  (global-corfu-mode)
  (corfu-popupinfo-mode)
  (setq corfu-popupinfo-delay '(0.5 . 0)))

; Add completion preview.
(use-package completion-preview
  :hook (after-init-hook . global-completion-preview-mode))

; Use eglot as my lsp manager.
(use-package eglot
  :config
  (add-hook 'haskell-mode-hook 'eglot-ensure)
  (add-hook 'nix-mode-hook 'eglot-ensure)

  :config
  (setq-default eglot-workspace-configuration
		'((haskell (plugin (stan (globalOn . :json-false))))))  ; disable stan.
  :custom
  (eglot-autoshutdown t)  ; shutdown language server after closing last file.
  (eglot-confirm-server-initiated-edits nil))  ; allow edits without confirmation.

; Use eldoc for documentation popups.
(use-package eldoc-box
  :bind ("C-h ;" . #'eldoc-box-help-at-point))

; Add orderless completion style.
(use-package orderless
  :custom
  (completion-styles '(orderless flex))
  (completion-category-defaults nil) ; Ensures that orderless is the only completion style used by default.
  (completion-category-overrides '((file (styles basic partial-completion)))))

; Marginalia adds annotations to the minibuffer.
(use-package marginalia
  ;; Bind `marginalia-cycle' locally in the minibuffer.  To make the binding
  ;; available in the *Completions* buffer, add it to the
  ;; `completion-list-mode-map'.
  :bind (:map minibuffer-local-map ("M-A" . marginalia-cycle))
  :init (marginalia-mode))

; Embark provides actions on buffer targets.
(use-package embark
  :bind
  ("C-." . embark-act)
  ("M-." . embark-dwim)
  ("C-h B" . embark-bindings))

; Use consult for better searching interfaces.
(use-package consult
  :bind
  ("M-s r" . consult-ripgrep)
  ("M-s d" . consult-fd)
  ("C-c h" . consult-history)
  ("M-g m" . consult-mark)

  :init
  (require 'transient)

  ; Consult transient.
  (transient-define-prefix consult-transient()
    "Transient for consult"
    ["Consult command"
     ("f" "consult-ripgrep" consult-ripgrep)
     ("l" "consult-line" consult-line)
     ("d" "consult-fd" consult-fd)
     ("q" "quit" transient-quit-one)])
  :bind ("C-; f" . consult-transient))

; Vertico is a package for interactive completion.
(use-package vertico
  :custom
  (vertico--resize t)
  :init (vertico-mode))

; Add syntax highlighting to magit diffs.
(use-package magit-delta
  :after magit
  :init (magit-delta-mode)
  ; Setting the theme to use for magit diff.
  :custom
  (magit-delta-default-dark-theme "gruvbox-dark")
  (magit-delta-default-light-theme "gruvbox"))

(use-package haskell-mode
  :init (require 'haskell-mode-autoloads))

; Mode for keyboard configuration language.
(use-package kbd-mode
  :vc (:url "https://github.com/kmonad/kbd-mode" :rev :newest))

; Make ispell use hunspell.
(eval-after-load 'ispell
  (setq ispell-program-name (executable-find "hunspell")
        ispell-dictionary   "en_US"))

(setq ispell-local-dictionary "en_US")
(setq ispell-local-dictionary-alist
      '("en_US" "[[:alpha:]]" "[^[:alpha:]]" "[']" nil ("-d" "en_US") nil utf-8()))
