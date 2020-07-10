# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit toolchain-funcs

DESCRIPTION="A high-performance DNS stub resolver"
HOMEPAGE="https://github.com/blechschmidt/massdns"
SRC_URI="https://github.com/blechschmidt/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"
RESTRICT="!test? ( test )"

BDEPEND="test? ( app-misc/jq )"

src_prepare() {
	default

	sed -i '/$(CC) $(CFLAGS) -O3/s/ -O3//' Makefile \
		|| die "sed faild for Makefile"
}

src_compile() {
	emake CC="$(tc-getCC)"
}

src_test() {
	./tests/run-tests.sh || die "tests failed"
}

src_install() {
	einstalldocs
	dobin bin/massdns
	dodoc -r lists
}
