# Copyright 1999-2023 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://github.com/google/${PN}.git"

inherit git-r3 toolchain-funcs

DESCRIPTION="A tool for measuring perceived differences between images"
HOMEPAGE="https://github.com/google/butteraugli"
SRC_URI=""

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS=""

DEPEND="media-libs/libjpeg-turbo:=
	media-libs/libpng:0
	sys-libs/zlib:="
RDEPEND="${DEPEND}"

src_compile() {
	cd "${S}"/"${PN}" || die "faild to change dir"
	emake CXX="$(tc-getCXX)"
}

src_install() {
	einstalldocs
	dobin "${PN}"/"${PN}"
}
