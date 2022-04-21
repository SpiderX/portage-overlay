# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://github.com/hhoffstaette/${PN}.git"

inherit git-r3 toolchain-funcs

DESCRIPTION="Amount of swapped memory for running processes"
HOMEPAGE="https://github.com/hhoffstaette/swapusage"
SRC_URI=""

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS=""

src_prepare() {
	default

	sed -i  -e '/CXXFLAGS =/d' \
		-e '/LDFLAGS =/d' Makefile || die "sed failed"
}

src_compile() {
	emake CXX="$(tc-getCXX)"
}

src_install() {
	einstalldocs
	dobin swapusage
}
