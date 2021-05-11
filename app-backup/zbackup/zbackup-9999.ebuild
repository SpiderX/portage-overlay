# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

EGIT_REPO_URI="https://github.com/${PN}/${PN}.git"

inherit cmake git-r3

DESCRIPTION="A versatile deduplicating backup tool"
HOMEPAGE="https://github.com/zbackup/zbackup"
SRC_URI=""

LICENSE="GPL-2+-with-openssl-exception"
KEYWORDS=""
SLOT="0"
IUSE="tartool"

DEPEND="app-arch/lzma
	dev-libs/lzo:2
	dev-libs/openssl:0=
	dev-libs/protobuf:0=
	sys-libs/libunwind:=
	sys-libs/zlib:="
RDEPEND="${DEPEND}"

# Add tartool build
PATCHES=( "${FILESDIR}/${P}-tartool.patch" )

src_configure() {
	local mycmakeargs=(
		-DBUILD_TARTOOL="$(usex tartool)"
	)

	cmake_src_configure
}
