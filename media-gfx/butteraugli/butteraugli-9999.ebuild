# Copyright 1999-2025 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3 toolchain-funcs

DESCRIPTION="A tool for measuring perceived differences between images"
HOMEPAGE="https://github.com/google/butteraugli"
EGIT_REPO_URI="https://github.com/google/${PN}.git"

LICENSE="Apache-2.0"
SLOT="0"

RDEPEND="media-libs/libjpeg-turbo:=
	media-libs/libpng:=
	sys-libs/zlib:="

src_compile() {
	cd butteraugli || die "faild to change dir"
	emake CXX="$(tc-getCXX)"
}

src_install() {
	einstalldocs
	dobin butteraugli/butteraugli
}
