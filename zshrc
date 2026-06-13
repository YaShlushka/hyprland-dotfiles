export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME=""

plugins=(git
			zsh-autosuggestions
			zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

autoload -U promptinit; promptinit
zstyle :prompt:pure:path color blue
zstyle ':prompt:pure:prompt:*' color yellow
prompt pure

# User configuration
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=60"

export SDL_VIDEODRIVER=wayland,x11

export PATH="$HOME/.local/bin:$PATH"

