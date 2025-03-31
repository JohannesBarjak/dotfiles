(require 'consult)
(require 'transient)

(transient-define-prefix consult-transient()
  "Transient for consult"
  ["Consult command"
   ("f" "consult-ripgrep" consult-ripgrep)
   ("l" "consult-line" consult-line)
   ("q" "quit" transient-quit-one)])
