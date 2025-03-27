# Enable carapace autocomplete in elvish.
set-env CARAPACE_BRIDGES 'zsh,fish,bash,inshellisense' # optional
eval (carapace _carapace|slurp)

# Use starship for the prompt.
eval (starship init elvish)
