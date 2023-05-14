# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://github.com/google/${PN}.git"

inherit git-r3 toolchain-funcs

DESCRIPTION="Perceptual JPEG encoder"
HOMEPAGE="https://github.com/google/guetzli"
SRC_URI=""

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS=""
IUSE="debug test"
RESTRICT="!test? ( test )"

RDEPEND="media-libs/libpng:0="
DEPEND="${RDEPEND}"
BDEPEND="virtual/pkgconfig
	test? ( media-libs/libjpeg-turbo
		media-libs/netpbm[png] )"

src_prepare() {
	default

	# Respect FLAGS
	sed -i 's/-O3 -g //' guetzli.make || die "sed failed"
}

src_compile() {
	emake CXX="$(tc-getCXX)" verbose=1 config="$(usex debug debug release '' '')"
}

src_test() {
	tests/smoke_test.sh bin/"$(usex debug Debug Release '' '')"/guetzli \
		|| die "test failed"
}

src_install() {
	dobin bin/"$(usex debug Debug Release '' '')"/guetzli
}
