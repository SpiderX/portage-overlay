# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module

DESCRIPTION="Tail AWS CloudWatch Logs from your terminal"
HOMEPAGE="https://github.com/lucagrulla/cw"
SRC_URI="https://github.com/lucagrulla/${PN}/archive/v${PV}.tar.gz -> ${P}.gh.tar.gz
	https://github.com/SpiderX/portage-overlay/raw/deps/${P}-deps.tar.xz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"

src_compile() {
	ego build -o cw-tail
}

src_test() {
	ego test -work
}

src_install() {
	einstalldocs
	dobin cw-tail
}
