# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools shell-completion

COMMIT="a61f1780b64266587e7bc30f0f5f71c6cca97c0f"

DESCRIPTION="A code-searching tool with a focus on speed"
HOMEPAGE="https://github.com/ggreer/the_silver_searcher"
SRC_URI="https://github.com/ggreer/the_silver_searcher/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/the_silver_searcher-${COMMIT}"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND="app-arch/xz-utils
	dev-libs/libpcre:3[jit]
	sys-libs/zlib:0="
BDEPEND="virtual/pkgconfig
	test? ( dev-util/cram )"

src_prepare() {
	default

	# don't install completion
	sed -i '/bashcompdir/,+4d' Makefile.am || die "sed failed"

	eautoreconf
}

src_test() {
	emake test
}

src_install() {
	default

	newbashcomp ag.bashcomp.sh ag
	newzshcomp _the_silver_searcher _ag
}
