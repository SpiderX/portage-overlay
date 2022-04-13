# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools bash-completion-r1

COMMIT="a61f178"

DESCRIPTION="A code-searching tool with a focus on speed"
HOMEPAGE="https://github.com/ggreer/the_silver_searcher"
SRC_URI="https://api.github.com/repos/ggreer/the_silver_searcher/tarball/${COMMIT} -> ${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="app-arch/xz-utils
	dev-libs/libpcre:3[jit]
	sys-libs/zlib:0="
BDEPEND="virtual/pkgconfig"

S="${WORKDIR}/ggreer-the_silver_searcher-${COMMIT}"

src_prepare() {
	default

	# don't install completion
	sed -i '/bashcompdir/,+4d' Makefile.am \
		|| die "sed failed"

	eautoreconf
}

src_install() {
	default

	newbashcomp ag.bashcomp.sh ag
	insinto /usr/share/zsh/site-functions
	newins _the_silver_searcher _ag
}
