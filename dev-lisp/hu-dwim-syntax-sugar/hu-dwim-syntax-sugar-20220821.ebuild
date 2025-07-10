# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit common-lisp-3

COMMIT="0927cf2db26eac114e8a61f478ccdd01b37a4639"
MY_PN="${PN//-/.}"

DESCRIPTION="Framework to work with syntax sugars in Common Lisp"
HOMEPAGE="https://github.com/hu-dwim/hu.dwim.syntax-sugar"
SRC_URI="https://github.com/hu-dwim/${MY_PN//.sugar/-sugar}/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${MY_PN//.sugar/-sugar}-${COMMIT}"

LICENSE="MIT-0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc test"
REQUIRED_USE="doc? ( test )"
RESTRICT="!test? ( test )"

RDEPEND="dev-lisp/hu-dwim-asdf
	dev-lisp/hu-dwim-common
	dev-lisp/hu-dwim-walker
	doc? ( dev-lisp/hu-dwim-presentation )"
BDEPEND="test? ( dev-lisp/sbcl:*
		dev-lisp/hu-dwim-stefil
		dev-lisp/uiop )"

PATCHES=( "${FILESDIR}/${PN}"-20220821-test.patch )

src_test() {
	einfo "Running test suite:"
	sbcl --script "${FILESDIR}"/run-tests.lisp \
		|| die "test failed"
}
