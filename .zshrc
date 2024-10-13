# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"
# sonar-scanner
export PATH="${SONAR_SCANNER_HOME}/bin:${PATH}"  
export PATH="${SONAR_SCANNER_HOME}/bin:${PATH}" 
# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
# ZSH_THEME="agnoster"
ZSH_THEME="powerlevel10k/powerlevel10k"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"
#
# Disable substring matching
zstyle ':completion:*' matcher-list 'r:|=*' 'l:|=*'

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
 pass
 git 
 zsh-autosuggestions
 zsh-syntax-highlighting
 fast-syntax-highlighting
 zsh-autocomplete
)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

#aliases
source $HOME/.aliases

#vi mode in terminal
bindkey -v
bindkey -M viins jk vi-cmd-mode
# Yank to the system clipboard
function vi-yank-xclip {
    zle vi-yank
   echo "$CUTBUFFER" | xclip -i -selection clipboard

}

function vi-yank-wlclip {
    zle vi-yank
    echo "$CUTBUFFER" | wl-copy
}

zle -N vi-yank-wlclip
bindkey -M vicmd 'y' vi-yank-xclip

custom_jj_key() {
  zle reset-prompt
  zle accept-line
}

# Bind the custom widget to the key sequence 'jj' in normal mode (vicmd)
zle -N custom_jj_key
bindkey -M vicmd 'jj' custom_jj_key


historyFzf(){
  BUFFER="history | fzf\n"
  zle accept-line
}
zle -N historyFzf


#fzf
   # source /usr/share/fzf/key-bindings.zsh
   # source /usr/share/fzf/completion.zsh
bindkey -v
#export KEYTIMEOUT=1
bindkey -M vicmd " f" fzf-history-widget

#open terminal command in nvim buffer
autoload -z edit-command-line
zle -N edit-command-line
bindkey -M vicmd " e" edit-command-line

#menu movement
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -M menuselect 'k' vi-up-line-or-history

#syntax-highlighting
# source /home/achref/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

#neofetch
# if [ -z "$TMUX" ]; then
# echo -e "\n\n" ; 
# neofetch
# fi

#opening files in a file manager with xdg
export OPEN_COMMAND='ranger %f'

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

#zoxide cd improvement name of the binary is z
eval "$(zoxide init zsh)"

export ANDROID_HOME=$HOME/Android/Sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/platform-tools

export PYTHONPATH=$PYTHONPATH:/home/achref/Document/projects/sideProjects/pdfScrapping:/home/achref/Document/projects/sideProjects/majdi:/home/achref/Document/projects/sideProjects/inventoryMatcher:/home/achref/Document/projects/sideProjects/inventoryMatcher/src

#dotnet autocompletion
_dotnet_zsh_complete()
{
  local completions=("$(dotnet complete "$words")")

  # If the completion list is empty, just continue with filename selection
  if [ -z "$completions" ]
  then
    _arguments '*::arguments: _normal'
    return
  fi

  # This is not a variable assignment, don't remove spaces!
  _values = "${(ps:\n:)completions}"
}

compdef _dotnet_zsh_complete dotnet

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"



# Load Angular CLI autocompletion.
if [ -n "$(command -v ng)" ];then
  source <(ng completion script)
fi

# . "$HOME/.atuin/bin/env"
# 
if type lf &> /dev/null; then
    # Set up icons
    LF_ICONS=$(sed $HOME/.config/lf/icons \
                -e '/^[ \t]*#/d'         \
                -e '/^[ \t]*$/d'         \
                -e 's/[ \t]\+/=/g'       \
                -e 's/$/ /')
    LF_ICONS=${LF_ICONS//$'\n'/:}
    export LF_ICONS

    # Set up lfcd
    LFCD="$HOME/.config/lf/scripts/lfcd.sh"
    if [ -f "$LFCD" ]; then
        source "$LFCD"
        bindkey -s "^o" "lfcd\n"  # set up key-binding for zsh
        # bind '"\C-o":"lfcd\C-m"'  # set up key-binding for bash
        alias lf=lfcd  # overwrite lf with lfcd
    fi
fi
eval "$(atuin init zsh)"
export LOCALE_ARCHIVE=/usr/lib/locale/locale-archive
