setopt interactivecomments # VERY IMPORTANT LINE! Completions will be very bad without it

zstyle ':autocomplete:*' min-delay 0.5  # float 
zstyle ':autocomplete:*' min-input 2  # int
zstyle ':autocomplete:*' insert-unambiguous no

zinit ice as "autocomplete"
zinit light zsh-users/zsh-completions

zinit light marlonrichert/zsh-autocomplete

