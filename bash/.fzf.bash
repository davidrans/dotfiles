# Setup fzf
# ---------
if [[ ! "$PATH" == */home/david/.fzf/bin* ]]; then
  PATH="${PATH:+${PATH}:}/home/david/.fzf/bin"
fi

eval "$(fzf --bash)"
