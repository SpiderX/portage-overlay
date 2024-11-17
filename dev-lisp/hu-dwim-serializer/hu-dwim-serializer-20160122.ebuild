# Copyright 1999-2024 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit common-lisp-3

COMMIT="d453f7687bb0db4dbd818419855faecda6eeb737"
MY_PN="${PN//-/.}"

DESCRIPTION="Generic serializer and deserializer for Common Lisp"
HOMEPAGE="https://github.com/hu-dwim/hu.dwim.serializer"
SRC_URI="https://github.com/hu-dwim/${MY_PN}/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${MY_PN}-${COMMIT}"

LICENSE="MIT-0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc test"
REQUIRED_USE="doc? ( test )"
RESTRICT="!test? ( test )"

PDEPEND="dev-lisp/hu-dwim-util"
RDEPEND="dev-lisp/babel
	dev-lisp/hu-dwim-asdf
	dev-lisp/hu-dwim-common
	dev-lisp/hu-dwim-def
	dev-lisp/hu-dwim-syntax-sugar
	doc? ( dev-lisp/hu-dwim-presentation )"
BDEPEND="test? ( dev-lisp/sbcl:*
		dev-lisp/asdf
		dev-lisp/hu-dwim-stefil
		dev-lisp/uiop )"

PATCHES=( "${FILESDIR}/${PN}"-20160122-test.patch )

src_test() {
	einfo "Running test suite:"
	sbcl --script "${FILESDIR}"/run-tests.lisp \
		|| die "test failed"
}
