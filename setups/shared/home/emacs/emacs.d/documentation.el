;; Marginalia adds annotations to the minibuffer.
(use-package marginalia
  ;; Bind `marginalia-cycle' locally in the minibuffer.  To make the binding
  ;; available in the *Completions* buffer, add it to the
  ;; `completion-list-mode-map'.
  :bind (:map minibuffer-local-map ("M-A" . marginalia-cycle))
  :init (marginalia-mode))

;; Use eldoc for documentation popups.
(use-package eldoc-box
  :bind ("C-h ;" . #'eldoc-box-help-at-point))

