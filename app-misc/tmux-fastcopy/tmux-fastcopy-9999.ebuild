# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://github.com/abhinav/${PN}.git"

inherit git-r3 go-module

DESCRIPTION="Easymotion-style text copying for tmux"
HOMEPAGE="https://github.com/abhinav/tmux-fastcopy"

LICENSE="GPL-2"
SLOT="0"

RDEPEND="app-misc/tmux"

src_unpack() {
	git-r3_src_unpack
	go-module_live_vendor
}

src_compile() {
	LDFLAGS="-s -w -X main._version=${PV}"
	ego build -buildmode=pie -ldflags "${LDFLAGS}" -trimpath
}

src_test() {
	ego test -work ./...
}

src_install() {
	einstalldocs
	dobin tmux-fastcopy
	insinto /usr/share/tmux-plugins/tmux-fastcopy
	doins fastcopy.tmux
	fperms +x /usr/share/tmux-plugins/tmux-fastcopy/fastcopy.tmux
}
