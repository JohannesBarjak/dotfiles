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

;; God mode enables a pseudo-modal interface for Emacs.
(use-package god-mode
  :custom
  (god-exempt-major-modes nil)
  (god-exempt-predicates nil)

  :bind ("<escape>" . god-mode-all))

;; Add kitty terminal protocol extension for terminal compatibility.
(use-package kkp
  :config (global-kkp-mode t))

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

;; A theme I like to occasionally use.
(use-package everforest
  (:vc (:url "https://github.com/Theory-of-Everything/everforest-emacs" :rev :newest)))

