# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit cmake-utils

DESCRIPTION="A versatile deduplicating backup tool"
HOMEPAGE="http://zbackup.org/ https://github.com/${PN}/${PN}"
SRC_URI="https://github.com/${PN}/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2+-with-openssl-exception"
KEYWORDS="~amd64 ~x86"
SLOT="0"

DEPEND="app-arch/lzma
	dev-libs/lzo:2
	dev-libs/openssl:0=
	<dev-libs/protobuf-3:0=
	sys-libs/zlib"
RDEPEND="${DEPEND}"

src_configure() {
	cmake-utils_src_configure

	# Configure tartool
	mkdir ${BUILD_DIR%%_*}_tartool || die "mkdir for tartool failed"
	cd ${BUILD_DIR%%_*}_tartool || die "cd for tartool failed"
	cmake ${BUILD_DIR%%_*}/tartool || die "cmake failed"
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
