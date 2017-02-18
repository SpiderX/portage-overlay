# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit cmake-utils git-r3

DESCRIPTION="A versatile deduplicating backup tool"
HOMEPAGE="http://zbackup.org/ https://github.com/${PN}/${PN}"
SRC_URI=""
EGIT_REPO_URI="git://github.com/${PN}/${PN}.git"

LICENSE="GPL-2+-with-openssl-exception"
KEYWORDS=""
SLOT="0"
IUSE="libressl"

DEPEND="app-arch/lzma
	dev-libs/lzo:2
	<dev-libs/protobuf-3:0=
	sys-libs/libunwind:7
	sys-libs/zlib
	!libressl? ( dev-libs/openssl:0= )
	libressl? ( dev-libs/libressl:0= )"
RDEPEND="${DEPEND}"

src_configure() {
	cmake-utils_src_configure

	# Configure tartool
	mkdir ${BUILD_DIR%%_*}_tartool || die "mkdir for tartool failed"
	cd ${BUILD_DIR%%_*}_tartool || die "cd for tartool failed"
	cmake ${BUILD_DIR%%_*}/tools/tartool || die "cmake failed"
}

src_compile() {
	cmake-utils_src_compile

	# Compile tartool
	cd ${BUILD_DIR%%_*}_tartool || die "change dir for tartool failed"
	emake
}

src_install() {
	cmake-utils_src_install

	# Install tartool
	cd ${BUILD_DIR%%_*}_tartool || die "change directory for tartool failed"
	emake DESTDIR="${D}" install
}
