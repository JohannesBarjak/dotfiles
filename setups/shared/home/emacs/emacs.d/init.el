(defun load-user-file (file-path) (load-file (expand-file-name (concat user-emacs-directory file-path))))
(load-user-file "meow.el")

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

; Add avy keybindings.
; Got the descriptions from the documentation.

; Input one char, jump to it with a tree.
(global-set-key (kbd "C-'") 'avy-goto-char-2)

; Input two consecutive chars, jump to the first one with a tree.
(global-set-key (kbd "C-:") 'avy-goto-char)

; Input an arbitrary amount of consecutive chars, jump to the first one with a tree.
(global-set-key (kbd "C-;") 'avy-goto-char-timer)
 
; Input zero chars, jump to a line start with a tree.
(global-set-key (kbd "M-g f") 'avy-goto-line)

; Input zero chars, jump to a word start with a tree.
(global-set-key (kbd "M-g e") 'avy-goto-word-0)

; Input one char at word start, jump to a word start with a tree.
(global-set-key (kbd "M-g w") 'avy-goto-word-1)
