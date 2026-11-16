# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=9

inherit go-module

DESCRIPTION="Tool for writing Linux pipes with instant live preview"
HOMEPAGE="https://github.com/akavel/up"
SRC_URI="https://github.com/akavel/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/SpiderX/portage-overlay/releases/download/${P}/${P}-deps.tar.xz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"

src_compile() {
	ego build
}

src_test() {
	ego test
}

src_install() {
	einstalldocs
	dobin up
}
