# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://github.com/dstucrypt/${PN}.git"

inherit cmake git-r3

DESCRIPTION="OpenSSL engine for DSTU 4145"
HOMEPAGE="https://github.com/dstucrypt/dstu-engine"

LICENSE="Apache-2.0"
SLOT="0"
IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND="dev-libs/openssl:0/3"
DEPEND="${RDEPEND}"
BDEPEND="virtual/pkgconfig"

DOCS=( {ChangeLog,README}.md )

src_configure() {
	local mycmakeargs=(
		-DBUILD_TESTS="$(usex test)"
	)

	cmake_src_configure
}
