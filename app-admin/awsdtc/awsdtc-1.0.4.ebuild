# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module

DESCRIPTION="AWS Data Transfer Cost Explorer"
HOMEPAGE="https://github.com/c1982/awsdtc"
SRC_URI="https://github.com/c1982/${PN}/archive/v${PV}.tar.gz -> ${P}.gh.tar.gz
	https://github.com/SpiderX/portage-overlay/raw/deps/${P}-deps.tar.xz"

LICENSE="Apache-2.0 MIT"
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
	dobin awsdtc
}
