# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="VCard standard format manipulation library"
HOMEPAGE="https://github.com/wernerd/ZRTPCPP"
SRC_URI="https://github.com/wernerd/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${P^^}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="axo +ccrtp core empty sdes sqlite sqlcipher tivi"
REQUIRED_USE="^^ ( ccrtp core tivi )
	empty? ( !sqlite !sqlcipher )
	sqlite? ( !sqlcipher )
	ccrtp? ( !axo !sdes )
	tivi? ( sdes sqlcipher )"

RDEPEND="dev-libs/ccrtp
	sqlcipher? ( dev-db/sqlcipher )"
DEPEND="${RDEPEND}"
BDEPEND="virtual/pkgconfig"

PATCHES=( "${FILESDIR}/${P}"-wrapper.patch
	"${FILESDIR}/${P}"-CMakeLists.patch )

src_configure() {
	local mycmakeargs=(
		-DAXO="$(usex axo)"
		-DCCRTP="$(usex ccrtp)"
		-DCORE_LIB="$(usex core)"
		-DNO_CACHE="$(usex empty)"
		-DSDES="$(usex sdes)"
		-DSQLCIPHER="$(usex sqlcipher)"
		-DSQLITE="$(usex sqlite)"
		-DTIVI="$(usex tivi)"
	)

	cmake_src_configure
}
