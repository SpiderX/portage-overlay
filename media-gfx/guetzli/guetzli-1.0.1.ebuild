# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit toolchain-funcs

DESCRIPTION="Perceptual JPEG encoder"
HOMEPAGE="https://github.com/google/guetzli"
SRC_URI="https://github.com/google/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

RDEPEND="media-libs/libpng:0="
DEPEND="${RDEPEND}"
BDEPEND="virtual/pkgconfig"

src_prepare() {
	default

	sed -i 's/-O3 -g //' guetzli.make || die "sed failed"
}

src_compile() {
	emake CXX="$(tc-getCXX)" verbose=1 config="$(usex debug debug release '' '')"
}

src_install() {
	dobin bin/Release/guetzli
}
