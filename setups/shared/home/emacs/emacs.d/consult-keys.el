(require 'consult)
(require 'transient)

(transient-define-prefix consult-transient()
  "Transient for consult"
  ["Consult command"
   ("f" "consult-ripgrep" consult-ripgrep)
   ("l" "consult-line" consult-line)
   ("d" "consult-fd" consult-fd)
   ("q" "quit" transient-quit-one)])
