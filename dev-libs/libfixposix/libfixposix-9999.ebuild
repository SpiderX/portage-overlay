# Copyright 1999-2024 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://github.com/sionescu/${PN}.git"

inherit autotools git-r3

DESCRIPTION="Thin wrapper over POSIX syscalls"
HOMEPAGE="https://github.com/sionescu/libfixposix"

LICENSE="Boost-1.0"
SLOT="0"
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
