(defun load-user-file (file-path) (load-file (expand-file-name (concat user-emacs-directory file-path))))
(load-user-file "meow.el")
(load-user-file "avy-keys.el")

(require 'idris2-mode)
(require 'haskell-mode-autoloads)

(use-package eglot
  :ensure t
  :config
  (add-hook 'haskell-mode-hook 'eglot-ensure)
  :config
  (setq-default eglot-workspace-configuration
                '((haskell
                   (plugin
                    (stan
                     (globalOn . :json-false))))))  ;; disable stan
  :custom
  (eglot-autoshutdown t)  ;; shutdown language server after closing last file
  (eglot-confirm-server-initiated-edits nil)  ;; allow edits without confirmation
  )

(use-package company
  :ensure t
  :hook (after-init . global-company-mode))

(load-theme 'doom-gruvbox t)
(add-hook 'prog-mode-hook 'display-line-numbers-mode)

; Disable toolbar.
(tool-bar-mode -1)
