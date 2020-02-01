# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

EGO_PN="github.com/junegunn/${PN}"
EGIT_REPO_URI="https://${EGO_PN}.git"

inherit git-r3 go-module

DESCRIPTION="A command-line fuzzy finder"
HOMEPAGE="https://github.com/junegunn/fzf"
SRC_URI=""

LICENSE="MIT"
SLOT="0"
KEYWORDS=""
IUSE="fish-completion neovim tmux vim"

RDEPEND="fish-completion? ( app-shells/fish )
	vim? ( app-editors/vim )
	tmux? ( app-misc/tmux )"

DOCS=( {CHANGELOG,README,README-VIM}.md )

src_unpack() {
	git-r3_src_unpack
	mkdir "${S}"/vendor || die "mkdir failed"
	go-module_live_vendor
}

src_compile() {
	export -n GOCACHE XDG_CACHE_HOME
	go build || die "build failed"
}

src_test() {
	go test -work || die "test failed"
}

src_install() {
	dobin fzf
	einstalldocs

	doman man/man1/fzf.1

	if use tmux ; then
		dobin bin/fzf-tmux
		doman man/man1/fzf-tmux.1
	fi

	insinto /usr/share/fzf
	doins shell/completion.bash shell/key-bindings.bash \
		shell/completion.zsh shell/key-bindings.zsh

	if use fish-completion ; then
		insinto /usr/share/fish/functions/
		newins shell/key-bindings.fish fzf.fish
	fi

	if use neovim ; then
		insinto /usr/share/nvim/runtime/plugin
		doins plugin/fzf.vim
	fi

	if use vim ; then
		insinto /usr/share/vim/vimfiles/plugin
		doins plugin/fzf.vim
	fi
}

pkg_postinst() {
	if has_version app-shells/bash-completion ; then
		einfo "You may source files in /usr/share/fzf from your .bashrc"
		einfo "to get completion for fzf"
	fi
	if has_version app-shells/zsh-completions ; then
		einfo "You may source files in /usr/share/fzf from your .zshrc"
		einfo "to get completion for fzf"
	fi
}
