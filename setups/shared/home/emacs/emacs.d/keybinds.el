;; God mode enables a pseudo-modal interface for Emacs.
(use-package god-mode
  :custom
  (god-exempt-major-modes nil)
  (god-exempt-predicates nil)

  :bind ("<escape>" . god-mode-all))

