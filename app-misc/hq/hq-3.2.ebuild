# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

DESCRIPTION="A HTML processor inspired by jq"
HOMEPAGE="https://github.com/coderobe/hq"
SRC_URI="https://github.com/coderobe/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="AGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-libs/libfmt:=
	dev-libs/modest"
BDEPEND="virtual/pkgconfig"

src_install() {
	default
	dobin "${S}"-build/hq
}
