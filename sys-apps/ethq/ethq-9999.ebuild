# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

EGIT_REPO_URI="https://github.com/isc-projects/${PN}.git"

inherit git-r3 toolchain-funcs

DESCRIPTION="Ethernet NIC Queue stats viewer"
HOMEPAGE="https://github.com/isc-projects/ethq"
SRC_URI=""

LICENSE="MPL-2.0"
SLOT="0"
KEYWORDS=""
IUSE="test"

DEPEND="sys-libs/ncurses:0"
RDEPEND="${DEPEND}"

src_prepare() {
	default

	# Respect FLAGS
	sed -i -e '/CXXFLAGS\t/s/= -O3/+=/' \
		-e '/LDFLAGS\t/s/=/+=/' Makefile || die "sed failed for Makefile"

	if ! use test ; then
		sed -i '/TARGETS\t\t=/s/ethq_test//' Makefile \
			|| die "sed faield for USE flag test"
	fi
}

src_compile() {
	emake CXX="$(tc-getCXX)"
}

src_test() {
	local driver
	for driver in "${S}"/tests/* ; do
		"${S}"/ethq_test "$(basename "$driver")" "${driver}" \
			|| die "test failed on ${driver}"
	done
}

src_install() {
	einstalldocs
	dobin ethq
}
