;; Magit configuraton.
(use-package magit
  :defer t)

;; Add syntax highlighting to magit diffs.
(use-package magit-delta
  :after magit
  :init (magit-delta-mode)

  ;; Setting the theme to use for magit diff.
  :custom
  (magit-delta-default-dark-theme  "gruvbox-dark")
  (magit-delta-default-light-theme "gruvbox"))
