# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=9

inherit git-r3 go-module shell-completion

DESCRIPTION="Interactive cheatsheets on the command-line"
HOMEPAGE="https://github.com/cheat/cheat"
EGIT_REPO_URI="https://github.com/cheat/${PN}.git"

LICENSE="MIT"
SLOT="0"

BDEPEND=">=dev-lang/go-1.26"

src_unpack() {
	git-r3_src_unpack
}

src_compile() {
	GOFLAGS="-v -x -mod=vendor" ego build ./cmd/...

	local completion
	for completion in bash zsh fish ; do
		edo ./cheat --completion "${completion}" > cheat."${completion}"
	done
}

src_test() {
	GOFLAGS="-v -x -mod=vendor" ego test ./...
}

src_install() {
	einstalldocs
	dobin cheat
	doman doc/cheat.1

	newbashcomp cheat.bash cheat
	newfishcomp cheat.fish cheat
	newzshcomp cheat.zsh _cheat
}
