(use-package emacs
  :init
  ;; Add smart open line, the idea and code came from this site:
  ;; https://emacsredux.com/blog/2013/03/26/smarter-open-line/.
  (defun smart-open-line ()
    "A smarter open line that inserts indentation."
    (interactive)
    (move-end-of-line nil)
    (newline-and-indent))

  ;; Scroll the text half a page up.
  (defun scroll-half-page-up (&optional arg)
    "Move half a page up. If an argument is supplied it is passed to 'scroll-up-command'."
    (interactive)
    (if arg
        (scroll-up-command arg)
        (scroll-up-command (/ (window-body-height) 2))))

  ;; Scroll the text half a page down.
  (defun scroll-half-page-down (&optional arg)
    "Move half a page down. If an argument is supplied it is passed to 'scroll-down-command'."
    (interactive)
    (if arg
      (scroll-down-command arg)
      (scroll-down-command (/ (window-body-height) 2))))

  :bind
  ("M-o" . smart-open-line)             ; Vim-like open line.

  ("C-v" . scroll-half-page-up)
  ("M-v" . scroll-half-page-down))

