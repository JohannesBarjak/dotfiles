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

