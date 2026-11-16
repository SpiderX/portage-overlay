# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=9

inherit git-r3 go-module

DESCRIPTION="Git in your tmux status bar"
HOMEPAGE="https://github.com/arl/gitmux"
EGIT_REPO_URI="https://github.com/arl/${PN}.git"

LICENSE="MIT"
SLOT="0"

RDEPEND="app-misc/tmux"

PATCHES=( "${FILESDIR}/${PN}"-0.11.5-tests.patch )

src_unpack() {
	git-r3_src_unpack
	go-module_live_vendor
}

src_compile() {
	LDFLAGS="-s -w -X main.version=${PV}"
	ego build -ldflags "${LDFLAGS}"
}

src_test() {
	ego test ./...
}

src_install() {
	einstalldocs
	dobin gitmux
}
