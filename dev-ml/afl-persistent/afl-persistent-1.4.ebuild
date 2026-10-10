# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune edo

MY_PN="ocaml-${PN}"

DESCRIPTION="Persistent-mode afl-fuzz for ocaml OCaml"
HOMEPAGE="https://github.com/stedolan/ocaml-afl-persistent"
SRC_URI="https://github.com/stedolan/${MY_PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${MY_PN}-${PV}"

LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="~amd64"
IUSE="+ocamlopt test"
RESTRICT="!test? ( test )"

BDEPEND="test? ( app-forensics/afl )"

src_prepare() {
	default

	# AFL's default memory limit is too low for the OCaml 5 runtime
	sed -i '/afl-showmap/s|-q|-q -m none|' test/test.sh || die "sed failed for test.sh"
}

src_test() {
	edo pushd test
	edo ./test.sh
	edo popd
}
