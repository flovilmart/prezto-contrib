chback_on_chdir () {
  test -f .nvmrc && VERSION=$(cat .nvmrc) && echo "Switching to node $VERSION" && n auto;
}

# add chback_on_chdir to chpwd_functions
add-zsh-hook chpwd chback_on_chdir

