# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://github.com/arl/${PN}.git"

inherit git-r3 go-module

DESCRIPTION="Git in your tmux status bar"
HOMEPAGE="https://github.com/arl/gitmux"

LICENSE="MIT"
SLOT="0"
RESTRICT="test" # fails

RDEPEND="app-misc/tmux"

src_unpack() {
	git-r3_src_unpack
	go-module_live_vendor
}

src_compile() {
	LDFLAGS="-s -w -X main.version=${PV}"
	ego build -ldflags "${LDFLAGS}" -trimpath
}

src_test() {
	ego test -work ./...
}

src_install() {
	einstalldocs
	dobin gitmux
}
