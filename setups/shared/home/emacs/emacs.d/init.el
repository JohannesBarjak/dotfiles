(use-package emacs
  :init
  (load-theme 'doom-gruvbox t)
  (add-hook 'prog-mode-hook 'display-line-numbers-mode)

  (tool-bar-mode -1) ; Disable toolbar and scrollbar.
  (scroll-bar-mode -1)

  (setq custom-file (locate-user-emacs-file "custom_var.el"))

  ; Define prefix for custom commands.
  :bind ("C-z" . mode-specific-command-prefix))

; Helper function to load elisp files.
(defun load-user-file (file-path)
	(load-file (expand-file-name (concat user-emacs-directory file-path))))

(load-user-file "meow.el")
(load-user-file "avy-keys.el")

(use-package company
  :ensure t
  :hook
  (after-init . global-company-mode))

(use-package eglot
  :ensure t
  :config
  (add-hook 'haskell-mode-hook 'eglot-ensure)
  (add-hook 'nix-mode-hook 'eglot-ensure)
  :config
  (setq-default eglot-workspace-configuration
		'((haskell (plugin (stan (globalOn . :json-false))))))  ;; disable stan
  :custom
  (eglot-autoshutdown t)  ;; shutdown language server after closing last file
  (eglot-confirm-server-initiated-edits nil))  ;; allow edits without confirmation

; Add orderless completion style.
(use-package orderless
  :custom
  (completion-styles '(orderless basic))
  (completion-category-defaults nil) ; Ensures that orderless is the only completion style used by default.
  (completion-category-overrides '((file (styles basic partial-completion)))))

; Marginalia adds annotations to the minibuffer.
(use-package marginalia
  ;; Bind `marginalia-cycle' locally in the minibuffer.  To make the binding
  ;; available in the *Completions* buffer, add it to the
  ;; `completion-list-mode-map'.
  :bind (:map minibuffer-local-map ("M-A" . marginalia-cycle))
  :init (marginalia-mode))

(require 'haskell-mode-autoloads)

(use-package kbd-mode
  :vc (:url "https://github.com/kmonad/kbd-mode" :rev :newest))

(use-package vertico
  :custom
  (vertico--resize t)
  :init (vertico-mode))
