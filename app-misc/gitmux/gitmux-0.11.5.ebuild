# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=9

inherit go-module

DESCRIPTION="Git in your tmux status bar"
HOMEPAGE="https://github.com/arl/gitmux"
SRC_URI="https://github.com/arl/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/SpiderX/portage-overlay/releases/download/${P}/${P}-deps.tar.xz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="app-misc/tmux"

PATCHES=( "${FILESDIR}/${PN}"-0.11.5-tests.patch )

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
