# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools git-r3 shell-completion

DESCRIPTION="A code-searching tool with a focus on speed"
HOMEPAGE="https://github.com/ggreer/the_silver_searcher"
EGIT_REPO_URI="https://github.com/ggreer/the_silver_searcher.git"

LICENSE="Apache-2.0"
SLOT="0"
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
