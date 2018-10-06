# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

MY_PV=$(ver_rs 1-2 '_')

inherit toolchain-funcs

DESCRIPTION="Ethernet NIC Queue stats viewer"
HOMEPAGE="https://github.com/isc-projects/ethq"
SRC_URI="https://github.com/isc-projects/ethq/archive/v${MY_PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MPL-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

DEPEND="sys-libs/ncurses:0"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${PN}-${MY_PV}"

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
