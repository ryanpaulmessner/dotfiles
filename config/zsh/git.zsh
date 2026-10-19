# `gc` belongs to Gas City (brew gascity); git commit lives at gct,
# matching other environments. OMZ git plugin (zinit) defines gc first;
# this file loads after it via the .zshrc config loop.
unalias gc 2>/dev/null
alias gct='git commit --verbose'
