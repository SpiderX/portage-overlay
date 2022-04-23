# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit toolchain-funcs

DESCRIPTION="Minimize caching effects for applications"
HOMEPAGE="https://github.com/Feh/nocache"
SRC_URI="https://github.com/Feh/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

src_compile() {
	emake CC="$(tc-getCC)"
}

src_install() {
	einstalldocs
	emake DESTDIR="${D}" PREFIX="${EPREFIX}/usr/" LIBDIR="$(get_libdir)" install
}
