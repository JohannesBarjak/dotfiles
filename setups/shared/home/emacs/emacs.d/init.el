; Helper function to load elisp files.
(defun load-user-file (file-path)
  (load-file (expand-file-name (concat user-emacs-directory file-path))))

(use-package emacs
  :init
  (load-theme 'doom-gruvbox t)

  (tool-bar-mode -1) ; Disable toolbar and scrollbar.
  (scroll-bar-mode -1)

  (load-user-file "meow.el")

  ;; Add smart open line, the idea and code came from this site:
  ;; https://emacsredux.com/blog/2013/03/26/smarter-open-line/.
  (defun smart-open-line ()
    "A smarter open line that inserts indentation."
    (interactive)
    (move-end-of-line nil)
    (newline-and-indent))

  :bind ("M-o" . smart-open-line)

  :custom
  (tab-always-indent 'complete) ; Enable indentation + completion using the TAB key.
  (custom-file "~/.config/emacs/custom_var.el")

  :hook (prog-mode-hook . display-line-numbers-mode))

; Avy allows for fast jumping in buffers.
(use-package avy
  :bind
  ("C-:" . avy-goto-char)
  ("C-'" . avy-goto-char-2)

  ("M-g e" . avy-goto-word-0)
  ("M-g w" . avy-goto-word-1)
  ("M-g l" . avy-goto-line)

  ("M-s s" . avy-goto-char-timer)
  :custom
  (avy-timeout-seconds 2))

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

; Add orderless completion style.
(use-package orderless
  :custom
  (completion-styles '(orderless flex))
  (completion-category-defaults nil) ; Ensures that orderless is the only completion style used by default.
  (completion-category-overrides '((file (styles basic partial-completion)))))

;; Embark provides actions on buffer targets.
(use-package embark
  :bind
  ("C-." . embark-act)
  ("M-." . embark-dwim)
  ("C-h B" . embark-bindings)

  ;; Add custom variable for embark indicator.
  :custom (embark-indicators '(embark-minimal-indicator
			       embark-highlight-indicator
			       embark-isearch-highlight-indicator)))

;; Use consult for better searching interfaces.
(use-package consult
  :bind
  ("C-x b" . consult-buffer)

  ("M-g f" . consult-flymake)
  ("M-g m" . consult-mark)
  ("M-g M-g" . consult-goto-line)
  ("M-g g" . consult-goto-line)

  ("M-s d" . consult-fd)
  ("M-s c" . consult-locate)
  ("M-s r" . consult-ripgrep)
  ("M-s l" . consult-line)

  ("C-c h" . consult-history)
  ("C-c k" . consult-kmacro))

;; Add embark consult integration.
(use-package embark-consult
  :hook (embark-collect-mode . consult-preview-at-point-mode))

;; Vertico is a package for interactive completion.
(use-package vertico
  :custom
  (vertico--resize t)
  :init
  (vertico-mode)
  (vertico-multiform-mode)
  (add-to-list 'vertico-multiform-categories '(embark-keybinding grid)))

; Marginalia adds annotations to the minibuffer.
(use-package marginalia
  ;; Bind `marginalia-cycle' locally in the minibuffer.  To make the binding
  ;; available in the *Completions* buffer, add it to the
  ;; `completion-list-mode-map'.
  :bind (:map minibuffer-local-map ("M-A" . marginalia-cycle))
  :init (marginalia-mode))

(use-package haskell-mode
  :init (require 'haskell-mode-autoloads))

;; Manage tree-sitter grammars.
(use-package treesit-auto
  :custom (treesit-auto-install 'prompt)
  :config
  (treesit-auto-add-to-auto-mode-alist 'all)
  (global-treesit-auto-mode))

; Use eldoc for documentation popups.
(use-package eldoc-box
  :bind ("C-h ;" . #'eldoc-box-help-at-point))

; Add syntax highlighting to magit diffs.
(use-package magit-delta
  :after magit
  :init (magit-delta-mode)
  ; Setting the theme to use for magit diff.
  :custom
  (magit-delta-default-dark-theme "gruvbox-dark")
  (magit-delta-default-light-theme "gruvbox"))

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
