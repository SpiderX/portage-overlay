# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module

DESCRIPTION="AWS bulk tagging tool"
HOMEPAGE="https://github.com/mpostument/awstaghelper"
SRC_URI="https://github.com/mpostument/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/SpiderX/portage-overlay/releases/download/${P}/${P}-deps.tar.xz"

LICENSE="Apache-2.0 BSD BSD-2 MIT MPL-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"

src_compile() {
	ego build
}

src_test() {
	ego test ./...
}

src_install() {
	einstalldocs
	dobin awstaghelper
}
