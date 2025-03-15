(require 'avy)
(require 'transient)

; Define avy keybingings using transient.
(transient-define-prefix avy-transient ()
  "Transient menu for avy commands"
  ["Avy command"
   ("c" "avy-goto-char" avy-goto-char)
   ("l" "avy-goto-line" avy-goto-line)
   ("r" "avy-resume" avy-resume)
   ("s" "avy-isearch" avy-isearch)
   ("f" "avy-goto-char-timer" avy-goto-char-timer)
   ("w" "avy-goto-subword-1" avy-goto-subword-1)
   ]
  )

; Use C-c prefix.
(global-set-key (kbd "C-z a") #'avy-transient)
