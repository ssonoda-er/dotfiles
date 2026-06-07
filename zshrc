#
# zshrc
#

export LANG=en_US.UTF-8
export EDITOR=vim

export XDG_CACHE_HOME=$HOME/.cache
export XDG_CONFIG_HOME=$HOME/.config
export XDG_DATA_HOME=$HOME/.local/share
export XDG_STATE_HOME=$HOME/.local/state
export XDG_BIN_HOME=$HOME/.local/bin
case ":$PATH:" in
  *":$XDG_BIN_HOME:"*) ;;
  *) export PATH="$XDG_BIN_HOME:$PATH" ;;
esac

export HISTFILE=$HOME/.zhistory
export HISTSIZE=10000
export SAVEHIST=10000

zstyle ':completion:*' menu select
zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin /usr/sbin /usr/bin /sbin /bin

setopt ignoreeof
setopt no_beep
setopt notify
setopt share_history
setopt histignorealldups
setopt hist_reduce_blanks
setopt inc_append_history
setopt auto_cd
setopt auto_pushd
setopt list_packed
setopt correct
setopt auto_param_keys
setopt magic_equal_subst
setopt no_flow_control

PROMPT='%(?.🌲.🪾) %F{yellow}%*%f %F{cyan}%~%f %# '

# Homebrew
if [ -f /opt/homebrew/bin/brew ]; then eval "$(/opt/homebrew/bin/brew shellenv zsh)"; fi

# sheldon
if type sheldon >/dev/null; then eval "$(sheldon source)"; fi

# completion (must run after plugins that add to fpath, e.g. zsh-completions)
# compinit auto-generates/reuses the .zcompdump cache, and regenerates it
# only when needed (e.g. the set of completion functions changed).
autoload -Uz compinit && compinit

# mise
if type mise >/dev/null; then eval "$(mise activate zsh)"; fi

# Claude
export CLAUDE_CONFIG_DIR="$XDG_CONFIG_HOME/claude"

# LM Studio CLI
case ":$PATH:" in
  *":$HOME/.lmstudio/bin:"*) ;;
  *) export PATH="$PATH:$HOME/.lmstudio/bin" ;;
esac

# pnpm
export PNPM_HOME="$HOME/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME/bin:"*) ;;
  *) export PATH="$PNPM_HOME/bin:$PATH" ;;
esac
# pnpm end

# "open" command for WSL
if [[ "$(uname -r)" == *-microsoft-standard-WSL2 ]]; then
	function open() {
		explorer.exe "$(wslpath -w "$1")"
	}
fi

if [[ $OSTYPE == darwin* ]]; then
	alias ls='ls -G'
else
	alias ls='ls --color=auto'
fi

autoload -Uz colors && colors
