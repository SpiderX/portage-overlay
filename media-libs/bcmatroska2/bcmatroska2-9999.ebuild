# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://gitlab.linphone.org/BC/public/${PN}.git"

inherit cmake git-r3

DESCRIPTION="Matroska media container support"
HOMEPAGE="https://gitlab.linphone.org/BC/public/bcmatroska2"

LICENSE="GPL-3"
SLOT="0"
IUSE="debug"

RDEPEND="net-libs/bctoolbox"

src_configure() {
	local mycmakeargs=(
		-DCMAKE_SHARED_LINKER_FLAGS="${LDFLAGS} -z muldefs"
		-DCONFIG_DEBUG_LEAKS="$(usex debug)"
	)

	cmake_src_configure
}
