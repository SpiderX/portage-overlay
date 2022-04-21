# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit toolchain-funcs

DESCRIPTION="Amount of swapped memory for running processes"
HOMEPAGE="https://github.com/hhoffstaette/swapusage"
SRC_URI="https://github.com/hhoffstaette/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"

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
