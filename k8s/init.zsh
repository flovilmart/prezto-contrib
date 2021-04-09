
# Load dependencies.
pmodload 'helper'

source <(kubectl completion zsh)

# Source module files.
source "${0:h}/alias.zsh"
complete -F __start_kubectl k

