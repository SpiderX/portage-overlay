# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://github.com/ggreer/the_silver_searcher.git"

inherit autotools bash-completion-r1 git-r3

DESCRIPTION="A code-searching tool with a focus on speed"
HOMEPAGE="https://github.com/ggreer/the_silver_searcher"
SRC_URI=""

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS=""

RDEPEND="app-arch/xz-utils
	dev-libs/libpcre:3[jit]
	sys-libs/zlib:0="
BDEPEND="virtual/pkgconfig"

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
