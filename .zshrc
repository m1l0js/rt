# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/home/m1l0js/.oh-my-zsh"
ZSH_THEME="robbyrussell"
plugins=(git)
source ~/.zsh/zsh-vim/zsh-vi-mode.plugin.zsh
source $ZSH/oh-my-zsh.sh
source ~/.zsh/sudo/sudo.plugin.zsh
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.zsh/zsh-autocomplete/zsh-autocomplete.plugin.zsh

export PATH="$PATH:/home/m1l0js/.local/bin/:/home/m1l0js/.cargo/bin"
terraform -install-autocomplete

autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /usr/bin/terraform terraform
