#! /bin/bash

# homebrewがインストール済みではない場合、インストールする
if test ! "$(which brew)"; then
	echo "Installing homebrew..."
	ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# Update homebrew
printf "Update? [Y/n]: " && read -r answer
if test "$answer" = "Y"; then
	brew update
fi

# Upgrade homebrew
printf "Upgrade? [Y/n]: " && read -r answer
if test "$answer" = "Y"; then
	brew upgrade
fi

# Add Repository
brew tap laurent22/massren

# Formulas
formulas=(

	# Shell
	zsh
	zsh-completions
	peco

	# Multiplexe
	tmux
	reattach-to-user-namespace

	# Tools
	ag
	nkf
	massren
	pstree
	tree
	wget

	# Git
	git

	# Languages
	go
	lua

	# Languages syntax
	shellcheck

	# Operations
	ansible
	docker
	docker-machine

)

echo "Installing formulas..."
brew install "${formulas[@]}" && brew cleanup

# Install Casks
brew install caskroom/cask/brew-cask

# Applications
applications=(

	# Chat
	slack

	# VM
	virtualbox
	vagrant
)

# Install apps to /Applications
echo "installing applications..."
brew cask install --appdir="/Applications" "${applications[@]}"
