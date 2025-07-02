# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="An implementation of the TLS/SSL protocols"
HOMEPAGE="https://github.com/aws/s2n-tls"
SRC_URI="https://github.com/aws/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND="dev-libs/openssl:="
DEPEND="${RDEPEND}"

PATCHES=( "${FILESDIR}/${PN}"-1.5.21-ldflags.patch )

src_configure() {
	local mycmakeargs=(
		-DBUILD_TESTING="$(usex test)"
		-DUNSAFE_TREAT_WARNINGS_AS_ERRORS=OFF
	)
	cmake_src_configure
}
