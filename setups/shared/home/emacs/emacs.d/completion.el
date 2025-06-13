;; Setup which key.
(use-package which-key
  :config
  (which-key-mode)                      ; Enable which-key
  (which-key-setup-side-window-bottom))

;; Add completion preview.
(use-package completion-preview
  :hook (after-init-hook . global-completion-preview-mode))

;; Use corfu for completion prompts.
(use-package corfu
  :custom
  (corfu-cycle t)
  (corfu-preselect 'prompt)

  (corfu-popupinfo-delay '(0.5 . 0))

  ;; Use tab to cycle completions.
  :bind (:map corfu-map
	      ("TAB"     . corfu-next)
	      ([tab]     . corfu-next)
	      ("S-TAB"   . corfu-previous)
	      ([backtab] . corfu-previous))

  :init
  (global-corfu-mode)
  (corfu-popupinfo-mode))

;; Vertico is a package for interactive completion.
(use-package vertico
  :custom (vertico--resize t)

  :init
  (vertico-mode)
  (vertico-multiform-mode)

  ;; Use grid for embark completion.
  (add-to-list 'vertico-multiform-categories '(embark-keybinding grid)))

;; Add orderless completion style.
(use-package orderless
  :custom
  (completion-styles '(orderless flex))
  (completion-category-defaults nil) ; Ensures that orderless is the only completion style used by default.
  (completion-category-overrides '((file (styles basic partial-completion)))))

