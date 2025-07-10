# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="Thin wrapper over POSIX syscalls"
HOMEPAGE="https://github.com/sionescu/libfixposix"
SRC_URI="https://github.com/sionescu/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="Boost-1.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="static test"
RESTRICT="!test? ( test )"

BDEPEND="virtual/pkgconfig
	test? ( dev-libs/check )"

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	econf "$(use_enable static)" "$(use_enable test tests)"
}

src_install() {
	default
	find "${ED}" -name '*.la' -delete || die "find failed"
}
