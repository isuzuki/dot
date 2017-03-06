export LANG=ja_JP.UTF-8
export EDITOR=vim

# play
export PATH=/usr/local/opt/play-2.1.0:$PATH
# php
export PATH=$(brew --prefix homebrew/php/php70)/bin:$HOME/.composer/vendor/bin:$PATH
# go
export GOPATH=$HOME/dev
export PATH=$GOPATH/bin:$PATH

HISTFILE=$HOME/.zsh-history
HISTSIZE=100000
SAVEHIST=100000

# set key bind emacs
bindkey -e

autoload -Uz zmv

## alias
alias zmv='noglob zmv -W'
alias ctags='/usr/local/Cellar/ctags/5.8/bin/ctags'
alias rm='rm -i'
alias ls='ls -GF'
alias diff='colordiff'

## 補完機能の強化
autoload -U compinit
compinit

## プロンプトの設定
autoload -Uz add-zsh-hook
autoload -Uz vcs_info
autoload colors
colors

setopt prompt_subst      # 色を使う
setopt auto_cd           # ディレクトリ移動時cdコマンドを必要としない
setopt auto_list         # 補完候補を一覧表示
setopt auto_menu         # TAB で順に補完候補を切り替える
setopt auto_pushd        # cd時に自動でpushd
setopt pushd_ignore_dups # 同じディレクトリをpushdしない
setopt correct           # コマンドスペルチェック
setopt share_history     # ヒストリを共有

# from http://d.hatena.ne.jp/mollifier/20100906/p1
zstyle ':vcs_info:*' enable git svn hg bzr
zstyle ':vcs_info:*' formats '(%s)-[%b]'
zstyle ':vcs_info:*' actionformats '(%s)-[%b|%a]'
zstyle ':vcs_info:(svn|bzr):*' branchformat '%b:r%r'
zstyle ':vcs_info:bzr:*' use-simple true

autoload -Uz is-at-least
if is-at-least 4.3.10; then
	zstyle ':vcs_info:git:*' check-for-changes true
	zstyle ':vcs_info:git:*' stagedstr "+"
	zstyle ':vcs_info:git:*' unstagedstr "-"
	zstyle ':vcs_info:git:*' formats '(%s)-[%b] %c%u'
	zstyle ':vcs_info:git:*' actionformats '(%s)-[%b|%a] %c%u'
fi

function _update_vcs_info_msg() {
	psvar=()
	LANG=en_US.UTF-8 vcs_info
	[[ -n "$vcs_info_msg_0_" ]] && psvar[1]="$vcs_info_msg_0_"
}
add-zsh-hook precmd _update_vcs_info_msg

case ${UID} in
	0)
		PROMPT="[%{${fg[blue]}%}%n@%m%{${reset_color}%}] %{${fg[blue]}%}#%{${reset_color}%} "
		PROMPT2="%B%{${fg[blue]}%}%_#%{${reset_color}%}%b "
		SPROMPT="%B%{${fg[blue]}%}%r is correct? [n,y,a,e]:%{${reset_color}%}%b "
		RPROMPT="%{${fg[blue]}%}[%/]%{${reset_color}%}"
		;;
	*)
		PROMPT="[%n@%m] %1(v|%F{green}%1v%f|)
		%{${fg[blue]}%}#%{${reset_color}%} "
		PROMPT2="%B%{${fg[blue]}%}%_#%{${reset_color}%}%b "
		SPROMPT="%B%{${fg[blue]}%}%r is correct? [n,y,a,e]:%{${reset_color}%}%b "
		RPROMPT="%{${fg[blue]}%}[%/]%{${reset_color}%}"
		;;
esac

# alias
case $OSTYPE in
	darwin*)
		alias updatedb="sudo /usr/libexec/locate.updatedb"
		alias tpbcopy="perl -pe 's/\n//g' | pbcopy"
		;;
	linux*)
		;;
esac

# peco history search
function peco-select-history() {
	local tac
	if which tac > /dev/null; then
		tac="tac"
	else
		tac="tail -r"
	fi
	BUFFER=$(\history -n 1 | \
		eval $tac | \
		peco --query "$LBUFFER")
	CURSOR=$#BUFFER
	zle clear-screen
}
zle -N peco-select-history
bindkey '^r' peco-select-history

# install z
# mkdir -p; git clone git@github.com:rupa/z.git ~/.zsh.d
if [ -f "$HOME/.zsh.d/z.sh" ]; then
	source "$HOME/.zsh.d/z.sh"
fi

# peco z search
function peco-z-search() {
	which peco z > /dev/null
	if [ $? -ne 0 ]; then
		echo "Please install peco and z"
		return 1
	fi
	local res=$(z | sort -rn | cut -c 12- | peco)
	if [ -n "$res" ]; then
		BUFFER+="cd $res"
		zle accept-line
	else
		return 1
	fi
}
zle -N peco-z-search
bindkey '^f' peco-z-search

# nvm
NVM_DIR=`brew --prefix nvm`
if [ -d "$NVM_DIR" ]; then
	source $NVM_DIR/nvm.sh
fi

# Browsersync
alias bs="browser-sync start --server --files '**/*'"

# 各環境ごとの設定を記述
if [  -f "$HOME/.zshrc.local" ]; then
	source "$HOME/.zshrc.local"
fi
