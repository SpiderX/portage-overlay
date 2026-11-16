# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=9

inherit go-module

DESCRIPTION="Easymotion-style text copying for tmux"
HOMEPAGE="https://github.com/abhinav/tmux-fastcopy"
SRC_URI="https://github.com/abhinav/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/SpiderX/portage-overlay/releases/download/${P}/${P}-deps.tar.xz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="app-misc/tmux"
BDEPEND=">=dev-lang/go-1.27.0"

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
