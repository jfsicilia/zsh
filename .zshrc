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
export PATH=$PATH:~/bin:~/.cargo/bin:~/.local/bin
typeset -U PATH # Force no duplicates in path.

# KEYBINDINGS ================================================================
# Enable emacs mode.
# bindkey -e
# Enable vim mode.
bindkey -v
# Ctrl+p and Ctrl+n to move through context aware history.
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward
# Ctrl+space for autosuggestion completion
bindkey '^@' forward-char
# Some useful emacs keybindings
bindkey '^a' beginning-of-line
bindkey '^e' end-of-line
bindkey '^u' kill-whole-line
bindkey '^k' kill-line

# NOTE: Here are the current already bounded combos:
# If you want all the keybindings run:
#   bindkey
# If you want to get info of a keybinding run: 
#   bindkey '^e'
# To get information about ctrl+e.
# ctrl+r -- View history
# ctrl+p -- Previous command in history.
# ctrl+n -- Next command in history.
# ctrl+s -- History incremental search.
# ctrl+space -- Complete autosuggestion
# ctrl+t -- Fuzzy file selection 
# ctrl+i / Tab -- Open fuzzy completion.
# ctrl+o / ctrl+j / ctrl+m / Enter -- Run command.
# ctrl+a -- Go to start of prompt.
# ctrl+e -- Go to end of prompt.
# ctrl+h -- Delete last character.
# ctrl+b -- Back char.
# ctrl+w -- Delete last word.
# ctrl+u -- Delete whole prompt.
# ctrl+k -- Elimina desde el cursor actual hasta el final del command.
# ctrl+d -- Close terminal.
# ctrl+g -- Send break.
# ctrl+l -- Clears terminal.
# ctrl+shift+c -- Copy from terminal to clipboard.
# ctrl+shift+v -- Paste from clipboard to terminal. 
# Esc -- Sets command line vim-mode to normal.
# Esc+Esc -- Add sudo to command prompt.

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
zstyle ':fzf-tab:*' fzf-bindings enter:accept ctrl-j:down ctrl-k:up
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
alias nvim-lazy='NVIM_APPNAME="nvim-lazy" nvim'
alias nvim-astro='NVIM_APPNAME="nvim-astro" nvim'
# alias cat=bat
alias ls=lsd
alias c=clear
alias open=xdg-open
alias _="cd ~/_"
alias today="fd --changed-within=1d -tf '.*' ~"

# ENV VARIABLES ==============================================================
# Set default editor
export EDITOR=nvim
export VISUAL=nvim

# VI MODE for OH-MY-POSH =====================================================
redraw-prompt() {
  _omp_precmd
  zle .reset-prompt
}

vimode-cmd() {
  export VI_MODE="N"
  redraw-prompt
}

vimode-insert() {
  export VI_MODE="I"
  redraw-prompt
}

vimode-visual() {
  export VI_MODE="V"
  redraw-prompt
}

vimode-visual-line() {
  export VI_MODE="V"
  redraw-prompt
}

vimode-replace() {
  export VI_MODE="R"
  redraw-prompt
}

# CMD/Normal mode
_omp_create_widget vi-cmd-mode vimode-cmd
_omp_create_widget deactivate-region vimode-cmd

# Insert mode
_omp_create_widget vi-insert vimode-insert
_omp_create_widget vi-insert-bol vimode-insert
_omp_create_widget vi-add-eol vimode-insert
_omp_create_widget vi-add-next vimode-insert
_omp_create_widget vi-change vimode-insert
_omp_create_widget vi-change-eol vimode-insert
_omp_create_widget vi-change-whole-line vimode-insert
_omp_create_widget vi-open-line-above vimode-insert
_omp_create_widget vi-open-line-below vimode-insert

# Replace mode
_omp_create_widget vi-replace vimode-replace
_omp_create_widget vi-replace-chars vimode-replace

# Visual mode
_omp_create_widget visual-mode vimode-visual
_omp_create_widget visual-line-mode vimode-visual-line

# reset to default mode at the end of line input reading
line-finish() {
    export VI_MODE="I"
}
_omp_create_widget zle-line-finish line-finish

# Fix a bug when you C-c in CMD mode, you'd be prompted with CMD mode indicator
# while in fact you would be in INS mode.
# Fixed by catching SIGINT (C-c), set mode to INS and repropagate the SIGINT,
# so if anything else depends on it, we will not break it.
TRAPINT() {
  vimode-insert
  return $(( 128 + $1 ))
}

export VI_MODE="I"
