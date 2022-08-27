# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module

DESCRIPTION="Command line tool for Amazon Route 53"
HOMEPAGE="https://github.com/barnybug/cli53"
SRC_URI="https://github.com/barnybug/${PN}/archive/${PV}.tar.gz -> ${P}.gh.tar.gz
	https://github.com/SpiderX/portage-overlay/raw/deps/${P}-deps.tar.xz"

LICENSE="Apache-2.0 BSD BSD-2 MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DOCS=( {CHANGELOG,README}.md )

src_test() {
	ego test -work
}

src_install() {
	einstalldocs
	dobin "${HOME}"/go/bin/cli53
}
