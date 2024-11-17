# Copyright 1999-2024 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit common-lisp-3

COMMIT="bb47d2fef4eb24cc16badc1c9a73d73c3a7e18f5"

DESCRIPTION="A test framework for Common Lisp"
HOMEPAGE="https://github.com/joaotavora/fiasco"
SRC_URI="https://github.com/joaotavora/${PN}/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}-${COMMIT}"

LICENSE="MIT-0 public-domain"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND="dev-lisp/alexandria
	dev-lisp/trivial-gray-streams"
BDEPEND="dev-lisp/asdf
	test? ( dev-lisp/sbcl:*
		dev-lisp/uiop )"

src_test() {
	einfo "Running test suite:"
	sbcl --script "${FILESDIR}"/run-tests.lisp \
		|| die "test failed"
}
