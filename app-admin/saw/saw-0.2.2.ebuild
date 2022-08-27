# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module

COMMIT="1bb0b1b8cef90db82ee380339bcd1b3ce56d98d0"

DESCRIPTION="Fast, multi-purpose tool for AWS CloudWatch Logs"
HOMEPAGE="https://github.com/TylerBrock/saw"
SRC_URI="https://github.com/TylerBrock/${PN}/archive/${COMMIT}.tar.gz -> ${P}.gh.tar.gz
	https://github.com/SpiderX/portage-overlay/raw/deps/${P}-deps.tar.xz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

S="${WORKDIR}/${PN}-${COMMIT}"

DOCS=( {CHANGELOG,README}.md )

PATCHES=( "${FILESDIR}/${P}"-go.sum.patch )

src_compile() {
	ego build
}

src_test() {
	ego test -work
}

src_install() {
	einstalldocs
	dobin saw
}
