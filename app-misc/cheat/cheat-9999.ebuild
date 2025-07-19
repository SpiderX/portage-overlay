# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3 go-module shell-completion

DESCRIPTION="Interactive cheatsheets on the command-line"
HOMEPAGE="https://github.com/cheat/cheat"
EGIT_REPO_URI="https://github.com/cheat/${PN}.git"

LICENSE="MIT"
SLOT="0"

src_unpack() {
	git-r3_src_unpack
}

src_compile() {
	GOFLAGS="-v -x -mod=vendor" \
		go build ./cmd/... || die "build failed"
}

src_test() {
	GOFLAGS="-v -x -mod=vendor" \
		go test -work ./... || die "test failed"
}

src_install() {
	einstalldocs
	dobin cheat
	doman doc/cheat.1

	newbashcomp scripts/cheat.bash cheat
	newfishcomp scripts/cheat.fish cheat
	newzshcomp scripts/cheat.zsh _cheat
}
