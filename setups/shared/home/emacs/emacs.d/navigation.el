;; Use consult for better searching interfaces.
(use-package consult
  :bind
  ;; Buffer switching using consult.
  ("C-x b" . consult-buffer)            ; Orig. switch-to-buffer.

  ("M-y" . consult-yank-pop)            ; Orig. yank-pop.

  ("M-g f"   . consult-flymake)
  ("M-g M-g" . consult-goto-line)       ; Orig. goto-line.
  ("M-g g"   . consult-goto-line)       ; Orig. goto-line.
  ("M-g m"   . consult-mark)
  ("M-g i"   . consult-imenu)
  ("M-g I"   . consult-imenu-multi)

  ;; Seaching commands.
  ("M-s d" . consult-fd)
  ("M-s c" . consult-locate)
  ("M-s r" . consult-ripgrep)
  ("M-s l" . consult-line)
  ("M-s L" . consult-line-multi)
  ("M-s k" . consult-keep-lines)
  ("M-s u" . consult-focus-lines)

  ;; Commands for fast register access.
  ("M-#" . consult-register-load)
  ("M-'" . consult-register-store)
  ("C-M-#" . consult-register)

  ("C-c h" . consult-history)
  ("C-c K" . consult-kmacro)
  ("C-c i" . consult-info)

  (:map isearch-mode-map

  ;; These keybindings help consult-line detect isearch.
  ("M-s l" . consult-line)
  ("M-s L" . consult-line-multi)))

;; Avy allows for fast jumping in buffers.
(use-package avy
  :config
  ;; Define avy embark actions from https://karthinks.com/software/avy-can-do-anything/.
  (defun avy-action-embark (pt)
    (unwind-protect
        (save-excursion
          (goto-char pt)
          (embark-act))
      (select-window (cdr (ring-ref avy-ring 0))))
    t)

  (setf (alist-get ?. avy-dispatch-alist) 'avy-action-embark)

  :bind
  ("C-:" . avy-goto-char)
  ("C-'" . avy-goto-char-2)

  ("M-g e" . avy-goto-word-0)
  ("M-g w" . avy-goto-word-1)
  ("M-g l" . avy-goto-line)
  ("M-j" . avy-goto-char-timer)

  :custom (avy-timeout-seconds 0.3))

;; Enable package for automatic split resizing.
(use-package zoom
  :config (zoom-mode)
  :custom (zoom-size '(0.618 . 0.618)))

;; Puni allows for smarter parenthesis behavior.
(use-package puni
  :defer t
  :init (puni-global-mode)
  :bind
  ;; Useful puni actions.
  ("C-c d s" . puni-squeeze)
  ("C-c d r" . puni-raise)
  ("C-c d c" . puni-convolute)
  ("C-c d e" . puni-splice)
  ("C-c d l" . puni-split)
  ("C-c d t" . puni-transpose)

  ;; Commands to Wrap expressions.
  ("C-c w r" . puni-wrap-round)
  ("C-c w s"  . puni-wrap-square)
  ("C-c w c"  . puni-wrap-curly)
  ("C-c w a"  . puni-wrap-angle)

  ;; Add slurp and barf commands to Emacs.
  ("M-<right>" . puni-slurp-forward)
  ("M-<left>"  . puni-slurp-backward)
  ("M-<up>"    . puni-barf-forward)
  ("M-<down>"  . puni-barf-backward))

