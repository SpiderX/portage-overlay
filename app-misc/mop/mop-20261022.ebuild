# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=9

inherit go-module

COMMIT="291ed09a07bfbeee728e8da89f86c4dc1878958f"

DESCRIPTION="Stock market tracker for hackers"
HOMEPAGE="https://github.com/mop-tracker/mop"
SRC_URI="https://github.com/mop-tracker/${PN}/archive/${COMMIT}.tar.gz -> ${P}.tar.gz
	https://github.com/SpiderX/portage-overlay/releases/download/${P}/${P}-deps.tar.xz"
S="${WORKDIR}/${PN}-${COMMIT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

src_compile() {
	ego build -o mop ./cmd/...
}

src_install() {
	einstalldocs
	dobin mop
}
