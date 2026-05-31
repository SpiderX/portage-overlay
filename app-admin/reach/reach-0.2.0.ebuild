# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module

DESCRIPTION="A static network verification tool for AWS"
HOMEPAGE="https://github.com/luhring/reach"
SRC_URI="https://github.com/luhring/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/SpiderX/portage-overlay/releases/download/${P}/${P}-deps.tar.xz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

PATCHES=( "${FILESDIR}/${PN}"-0.2.0-protocol.patch )

src_compile() {
	ego build -o ./bin/"${PN}"
}

src_test() {
	ego test -work ./...
}

src_install() {
	einstalldocs
	dobin bin/reach
}
