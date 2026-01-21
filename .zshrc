# PLUGINS ====================================================================

# Set the directory we want to sotre zinit and plugins
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Download Zinit, it it's not there yet
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"

# Source/Load zinit
source "${ZINIT_HOME}/zinit.zsh"

# Allows commands syntax highlighting.
zinit light zsh-users/zsh-syntax-highlighting
# Allows commands parameter completions.
zinit light zsh-users/zsh-completions 
# Ctrl + F is bound to complete suggestions based on history.
zinit light zsh-users/zsh-autosuggestions 
# Allows fuzzy find of command parameters using tab.
zinit light Aloxaf/fzf-tab 

# Add in snippets from Oh-My-Zsh
# zinit snippet OMZL::git.zsh
zinit snippet OMZP::git
zinit snippet OMZP::sudo
# zinit snippet OMZP::archlinux
# zinit snippet OMZP::aws
# zinit snippet OMZP::kubectl
# zinit snippet OMZP::kubectx
zinit snippet OMZP::command-not-found

# Load completions
autoload -Uz compinit && compinit

# Replays directory-change hooks so plugins that depend on cd behave correctly 
# at shell startup, without producing output.
zinit cdreplay -q

# PATH =======================================================================
export PATH=$PATH:~/bin:~/.cargo/bin
typeset -U PATH # Force no duplicates in path.

# KEYBINDINGS ================================================================
bindkey -e
# Ctrl+p and Ctrl+n to move through context aware history.
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward

# SHELL OPTIONS ==============================================================
setopt NO_BEEP # No bell: Shut up Zsh

# Command line history.
HISTSIZE=50000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space # If space prepended to cmd it won't go into history.
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}' # Ignore case in autocompletion.
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}" # Put colors in autocompletion.
zstyle ':completion:*' menu no # Beter uix for tab completion with fzf.
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath' # Open previews on tab completion.
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath' # zoxide preview

# SHELL INTEGRATIONS =========================================================
# Ctrl+r to fuzzy search history. Ctrl+t to fuzzy find files. Alt+c to fuzzy
# go to folders.
eval "$(fzf --zsh)"
eval "$(zoxide init --cmd cd zsh)"
eval "$(direnv hook zsh)"

# PROMPT MANAGER =============================================================
eval "$(oh-my-posh init zsh --config ~/.config/ohmyposh/config.toml)"

# ALIASES ====================================================================
alias vi=nvim
alias vim=nvim
alias cat=bat
alias ls=lsd
alias c=clear
alias open=xdg-open
alias _="cd ~/_"
alias today="fd --changed-within=1d -tf '.*' ~"

# OPTIONS ====================================================================


# Created by `pipx` on 2026-01-21 09:04:40
export PATH="$PATH:/home/juan/.local/bin"
