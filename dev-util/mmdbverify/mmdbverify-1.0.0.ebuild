# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module

DESCRIPTION="Verifier for the MaxMind DB format"
HOMEPAGE="https://github.com/maxmind/mmdbverify"
SRC_URI="https://github.com/maxmind/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/SpiderX/portage-overlay/releases/download/${P}/${P}-deps.tar.xz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DOCS=( {CHANGELOG,README}.md )

src_compile() {
	ego build
}

src_install() {
	einstalldocs
	dobin mmdbverify
}
