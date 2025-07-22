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
  (magit-delta-default-light-theme "gruvbox-light")

  :config
  (defun my/update-system-flake ()
    "Automatically update the system flake and commit it to git."
  (interactive)
  (shell-command "nix flake update")
  (magit-call-git "commit" "-m" "Update flake."))

  :bind ("C-c l" . my/update-system-flake))
