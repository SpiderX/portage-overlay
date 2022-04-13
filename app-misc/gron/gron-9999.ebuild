# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://github.com/tomnomnom/${PN}.git"

inherit git-r3 go-module

DESCRIPTION="Make JSON greppable"
HOMEPAGE="https://github.com/tomnomnom/gron"
SRC_URI=""

LICENSE="MIT"
SLOT="0"
KEYWORDS=""

DOCS=( {ADVANCED,CHANGELOG,README}.mkd )

src_unpack() {
	git-r3_src_unpack
	go-module_live_vendor
}

src_compile() {
	LDFLAGS="-X main.gronVersion=${PV}"

	go build -ldflags "${LDFLAGS}" || die "build failed"
}

src_test() {
	go test -work ./... || die "test failed"
}

src_install() {
	einstalldocs
	dobin gron

	insinto /usr/share/fish/functions/
	doins completions/gron.fish
}
