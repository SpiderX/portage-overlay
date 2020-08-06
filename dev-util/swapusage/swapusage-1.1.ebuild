# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit toolchain-funcs

DESCRIPTION="Amount of swapped memory for running processes"
HOMEPAGE="https://www.codesynthesis.com/hhoffstaette/swapusage"
SRC_URI="https://github.com/hhoffstaette/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

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
