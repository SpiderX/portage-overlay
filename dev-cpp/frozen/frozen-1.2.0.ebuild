# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="A header-only, constexpr alternative to gperf for C++14 users"
HOMEPAGE="https://github.com/serge-sans-paille/frozen"
SRC_URI="https://github.com/serge-sans-paille/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"
RESTRICT="!test? ( test )"

src_configure() {
	local mycmakeargs=(
		-DBUILD_TESTING="$(usex test)"
	)

	cmake_src_configure
}
