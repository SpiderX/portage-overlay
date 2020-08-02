# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit bash-completion-r1 go-module

DESCRIPTION="Interactive cheatsheets on the command-line"
HOMEPAGE="https://github.com/cheat/cheat"
SRC_URI="https://github.com/${PN}/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

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
	insinto /usr/share/zsh/site-functions
	newins scripts/cheat.zsh _cheat
	insinto /usr/share/fish/completion
	newins scripts/cheat.fish cheat
}
