;; Put general org mode tweaks here.
(use-package org-mode
  :defer t
  :custom (org-hide-emphasis-markers t)
  :hook (org-mode-hook . visual-line-mode))

;; Superstar is a package for pretty org mode bullet points.
(use-package org-superstar
  :hook (org-mode))
