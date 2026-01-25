;; Magit configuraton.
(use-package magit :defer t)

;; Emacs git gutter implementation.
(use-package git-gutter
  :config (global-git-gutter-mode t))

;; Add syntax highlighting to magit diffs.
(use-package magit-delta
  :after magit
  :init (magit-delta-mode))
