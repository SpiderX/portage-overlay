# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module

DESCRIPTION="Simple command-line snippet manager"
HOMEPAGE="https://github.com/mhausenblas/awsometag"
SRC_URI="https://github.com/mhausenblas/${PN}/archive/v${PV}.tar.gz -> ${P}.gh.tar.gz
	https://github.com/SpiderX/portage-overlay/raw/deps/${P}-deps.tar.xz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"

src_compile() {
	ego build
}

src_test() {
	ego test -work
}

src_install() {
	einstalldocs
	dobin awsometag
}
