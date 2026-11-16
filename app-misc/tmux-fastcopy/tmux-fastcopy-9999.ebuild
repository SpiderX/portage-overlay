# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=9

inherit git-r3 go-module

DESCRIPTION="Easymotion-style text copying for tmux"
HOMEPAGE="https://github.com/abhinav/tmux-fastcopy"
EGIT_REPO_URI="https://github.com/abhinav/${PN}.git"

LICENSE="GPL-2"
SLOT="0"

RDEPEND="app-misc/tmux"
BDEPEND=">=dev-lang/go-1.27.0"

src_unpack() {
	git-r3_src_unpack
	go-module_live_vendor
}

src_compile() {
	LDFLAGS="-w -X main._version=${PV}"
	ego build -ldflags "${LDFLAGS}"
}

src_test() {
	ego test ./...
}

src_install() {
	einstalldocs
	dobin tmux-fastcopy
	insinto /usr/share/tmux-plugins/tmux-fastcopy
	doins fastcopy.tmux
	fperms +x /usr/share/tmux-plugins/tmux-fastcopy/fastcopy.tmux
}
