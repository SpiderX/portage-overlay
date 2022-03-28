# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://github.com/wernerd/${PN^^}.git"

inherit cmake git-r3

DESCRIPTION="VCard standard format manipulation library"
HOMEPAGE="https://github.com/wernerd/ZRTPCPP"
SRC_URI=""

LICENSE="GPL-3"
KEYWORDS=""
SLOT="0"
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

PATCHES=( "${FILESDIR}/${PN}"-4.7.0-CMakeLists.patch )

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
