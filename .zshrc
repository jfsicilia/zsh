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
zinit snippet OMZP::docker
zinit snippet OMZP::docker-compose


# Load completions
autoload -Uz compinit && compinit

# Replays directory-change hooks so plugins that depend on cd behave correctly 
# at shell startup, without producing output.
zinit cdreplay -q

# Load the edit-command-line function
autoload -Uz edit-command-line
zle -N edit-command-line

# PATH =======================================================================
export GOPATH="$HOME/.go"
export GO_INSTALLED="/usr/local/go"
export PATH="$GOPATH/bin:$PATH"
export PATH="$GO_INSTALLED/bin:$PATH"

export CARGO_HOME="$HOME/.cargo"
export RUSTUP_HOME="$HOME/.rustup"
export PATH="$CARGO_HOME/bin:$PATH"

export PATH=$PATH:~/bin:~/.local/bin
typeset -U PATH # Force no duplicates in path.

# KEYBINDINGS ================================================================
# Enable emacs mode.
# bindkey -e
#
# Default emacs keybindings in zsh
##################################
#
# Ctrl+A  Move to beginning of line
# Ctrl+B  Move back one character
# Ctrl+C  Interrupt (SIGINT)
# Ctrl+D  Delete character / EOF (closes shell if line is empty)
# Ctrl+E  Move to end of line
# Ctrl+F  Move forward one character
# Ctrl+G  Abort
# Ctrl+H  Backspace
# Ctrl+I  Tab (completion)
# Ctrl+J  Newline (same as Enter)
# Ctrl+K  Kill from cursor to end of line
# Ctrl+L  Clear screen
# Ctrl+M  Enter
# Ctrl+N  Next history entry
# Ctrl+O  Accept line and show next history entry
# Ctrl+P  Previous history entry
# Ctrl+Q  Resume output (XON)
# Ctrl+R  Reverse incremental history search
# Ctrl+S  Suspend output (XOFF) / forward history search
# Ctrl+T  Transpose characters
# Ctrl+U  Kill entire line
# Ctrl+V  Insert next character literally
# Ctrl+W  Kill previous word
# Ctrl+X  Prefix for extended combos (Ctrl+X Ctrl+E, etc.)
# Ctrl+Y  Yank (paste last killed text)
# Ctrl+Z  Suspend process (SIGTSTP)
#
# Ctrl+X Ctrl+B  No default binding
# Ctrl+X Ctrl+E  Edit command line in $EDITOR
# Ctrl+X Ctrl+F  No default binding
# Ctrl+X Ctrl+G  No default binding
# Ctrl+X Ctrl+H  No default binding
# Ctrl+X Ctrl+I  No default binding
# Ctrl+X Ctrl+J  No default binding
# Ctrl+X Ctrl+K  No default binding
# Ctrl+X Ctrl+N  Infer next history word
# Ctrl+X Ctrl+O  No default binding
# Ctrl+X Ctrl+P  No default binding
# Ctrl+X Ctrl+R  History incremental search backward (alternate)
# Ctrl+X Ctrl+S  History incremental search forward (alternate)
# Ctrl+X Ctrl+U  Undo
# Ctrl+X Ctrl+V  Show zsh version
# Ctrl+X Ctrl+X  Exchange point and mark
#
# Practically free:
#   Ctrl+O  Rarely useful in modern terminals
#   Ctrl+S  Can be freed with: stty -ixon
#   Ctrl+Q  Can be freed with: stty -ixon
#   Ctrl+X  Only acts as prefix, does nothing alone

# In vi mode there are additional keymaps: `viins` for insert mode, `vicmd` for
# normal mode,`visual` for visual mode and `viopp` for oprator pending mode. 
# Insert mode (viins) is the default one, so `bindkey` and `bindkey -M viins` 
# are equivalent.
#
# To see insert mode keybindings run
#   $ bindkey
# Or
#   $ bindkey -M viins
#
# To see normal mode keybindings run
#   $ bindkey -M vicmd
#
# If you want to get info of a keybinding run: 
#   bindkey '^e'
# Or
#   bindkey -M viins "^e"
# Or
#   bindkey -M vicmd "^e"

# Enable vim mode.
bindkey -v

# Ctrl+p and Ctrl+n to move through context aware history.
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward
# Ctrl+space for autosuggestion completion
bindkey '^@' forward-char
# Ctrl+e edit line in editor.
bindkey '^e' edit-command-line
bindkey '^f' fzf-file-widget 
bindkey '^y' fzf-history-widget 
bindkey -M vicmd '^e' edit-command-line
bindkey -M vicmd 'H' beginning-of-line
bindkey -M vicmd 'L' end-of-line

# With my own key bindings and other added by different plugins this is the
# current keybindings in vim mode.
#
# ctrl+space -- Complete autosuggestion
# ctrl+y / ctrl+r -- View history
# ctrl+p -- Previous command in history.
# ctrl+n -- Next command in history.
# ctrl+s -- History incremental search.
# ctrl+f / ctrl+t -- Fuzzy file selection 
# tab / ctrl+i -- Open fuzzy completion.
# ctrl+o / ctrl+j / ctrl+m / Enter -- Run command.
# ctrl+e -- Edit command line in editor.
# ctrl+h -- Delete last character.
# ctrl+c -- Kill process.
# ctrl+b -- Back char.
# ctrl+w -- Delete last word.
# ctrl+u -- Delete whole prompt.
# ctrl+k -- Detele from cursor to end.
# ctrl+d -- Close terminal.
# ctrl+g -- Send break.
# ctrl+l -- Clears terminal.
# ctrl+shift+c -- Copy from terminal to clipboard.
# ctrl+shift+v -- Paste from clipboard to terminal. 
# Esc -- Sets command line vim-mode to normal.
# Esc+Esc -- Add sudo to command prompt.
# H (normal mode) -- Go to start of line
# L (normal mode) -- Go to end of line

# SHELL OPTIONS ==============================================================
setopt NO_BEEP # No bell: Hush zsh

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
setopt pushd_ignore_dups  # no duplicate entries
setopt pushd_silent       # no stack output on every cd

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
alias c=clear
alias open=xdg-open
alias _="cd ~/_"
alias today="fd --changed-within=1d -tf '.*' ~"
# alias tmux='tmux -S ~/.tmux-socket'
alias claude="titled 'Claude Code' claude"
alias '??'="claude -p"
unalias ls 2>/dev/null

# ENV VARIABLES ==============================================================
# Set default editor
export EDITOR=nvim
export VISUAL=nvim

# FUNCTIONS ==============================================================
function cd() {
  if [[ "$1" == (-|..|../*|./*|/*|~/*|~) ]]; then
    builtin pushd "$@" > /dev/null
  else
    builtin pushd -q . > /dev/null && __zoxide_z "$@"
  fi
}

function dirdiff() {
  nvim -c "DirDiff $1 $2"
}
function filediff() {
  nvim -d $1 $2
}

function titled() {
  local title="$1"; shift
  print -Pn "\e]0;${title}\a"
  "$@"
  print -Pn "\e]0;%~\a"
}

function ls() {
    # 1. Check if the user wants to show all files
    # The regex now detects 'a' or 'A' even in combined flags like -la or -rtah
    local show_all=0
    for arg in "$@"; do
        if [[ "$arg" =~ ^-[^-]*[aA] || "$arg" == "--all" || "$arg" == "--almost-all" ]]; then
            show_all=1
            break
        fi
    done

    # 2. If not showing all and a local .hidden file exists
    if [[ "$show_all" -eq 0 ]] && [[ -f ".hidden" ]]; then
        local ignore_args=()
        # Read .hidden file in an efficient way. 
        for line in ${(f)"$(< .hidden)"}; do
            [[ -z "${line// }" || "$line" =~ ^# ]] && continue
            ignore_args+=("--ignore-glob" "${line#"${line%%[![:space:]]*}"}") # Trim left
        done
        
        command lsd "${ignore_args[@]}" "$@"
    else
        # 3. Standard behavior if no .hidden file is found or -a is used
        command lsd "$@"
    fi
}

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

# This must be before _omp_create_widget 
zmodload zsh/zle

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
