# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3 go-module shell-completion

DESCRIPTION="Make JSON greppable"
HOMEPAGE="https://github.com/tomnomnom/gron"
EGIT_REPO_URI="https://github.com/tomnomnom/${PN}.git"

LICENSE="MIT"
SLOT="0"

DOCS=( {ADVANCED,CHANGELOG,README}.mkd )

src_unpack() {
	git-r3_src_unpack
	go-module_live_vendor
}

src_compile() {
	LDFLAGS="-X main.gronVersion=${PV}"

	ego build -ldflags "${LDFLAGS}"
}

src_test() {
	ego test -work ./...
}

src_install() {
	einstalldocs
	dobin gron
	newfishcomp completions/gron.fish gron
}
