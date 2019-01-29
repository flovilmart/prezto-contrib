
function k8s-info {
  local context
  local context_format
  local context_formatted

  local enabled
  local -A info_formats
  local info_format
  
  local REPLY
  unset k8s_info 
  typeset -gA k8s_info
  zstyle -s ':prezto:module:k8s:info' enable 'enabled'
  if ! is-true $enabled; then
    return 1
  fi
  
  if ! is-true "$(command kubectl config current-context 2> /dev/null)"; then
    k8s_info[prompt]="no context"
    return 1
  fi

  
  zstyle -s ':prezto:module:k8s:info:context' format 'context_format'
  if [[ -n "$context_format" ]]; then
    context=$(command kubectl config current-context 2> /dev/null);
    if [[ -n "$context" ]]; then
      zformat -f context_formatted "$context_format" "c:$context"
    fi
  fi

  # Format info.
  zstyle -a ':prezto:module:k8s:info:keys' format 'info_formats'
  for info_format in ${(k)info_formats}; do
    zformat -f REPLY "$info_formats[$info_format]" \
      "c:$context_formatted" 
      k8s_info[$info_format]="$REPLY"
  done

  unset REPLY

}

k8s-info "%@"

