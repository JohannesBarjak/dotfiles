(use-package emacs
  :init
  (load-theme 'doom-gruvbox t)

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

  :bind
  ;; Custom prefix map.
  (:prefix-map personal-map
               :prefix "C-z"
               :prefix-docstring "Personal keybindings prefix"
               ("z" . suspend-frame))

  :custom
  (tab-always-indent 'complete) ; Enable indentation + completion using the TAB key.
  (indent-tabs-mode nil)       ; Do not indent with the tab character.
  (custom-file (expand-file-name
                (concat user-emacs-directory "custom_var.el"))) ; Write variables into a separate file.

  :hook
  (prog-mode-hook . display-line-numbers-mode)
  (prog-mode-hook . electric-pair-mode))

;; Configure packages related to more efficient navigation.
(load-file (user-file "navigation.el"))

;; Completion frameworks.
(load-file (user-file "completion.el"))

;; Configuration that improves the Emacs editing experience.
(load-file (user-file "edition.el"))

;; Lsp and programming language support related configuration.
(load-file (user-file "lsp.el"))

;; Load magit configuration.
(load-file (user-file "magit.el"))

;; Emacs configuration which helps with documentation.
(load-file (user-file "documentation.el"))

;; Configuration that primarily concerns itself with keybindings.
(load-file (user-file "keybinds.el"))

;; Random configurations that do not fit the previous categories but provide minor improvements.
(load-file (user-file "qol.el"))

