# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="BroadVoice 16 kbs codec"
HOMEPAGE="https://gitlab.linphone.org/BC/public/external/bv16-floatingpoint"
SRC_URI="https://gitlab.linphone.org/BC/public/external/${PN}/-/archive/${PV}/${P}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="static-libs"

src_configure() {
	local mycmakeargs=(
		-DENABLE_STATIC="$(usex static-libs)"
	)

	cmake_src_configure
}
