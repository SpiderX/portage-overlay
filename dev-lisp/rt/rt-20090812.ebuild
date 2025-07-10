# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit common-lisp-3

COMMIT="gita6a7503"

DESCRIPTION="Common Lisp regression tester from MIT"
HOMEPAGE="http://www.cliki.net/rt"
SRC_URI="mirror://debian/pool/main/c/cl-${PN}/cl-${PN}_${PV}.${COMMIT}.orig.tar.xz"
S="${WORKDIR}/cl-${P}.${COMMIT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"
RESTRICT="test" # 15 out of 30 total tests failed

BDEPEND="dev-lisp/asdf
	test? ( dev-lisp/sbcl:* )"

src_test() {
	sbcl --script "${FILESDIR}"/run-tests.lisp \
		|| die "test failed"
}
