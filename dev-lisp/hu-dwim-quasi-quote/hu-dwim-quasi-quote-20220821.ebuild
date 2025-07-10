# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit common-lisp-3

COMMIT="2d8f6c88fc2cda3cb5068f4687a7af7a1ad4afb8"
MY_PN="${PN//-/.}"

DESCRIPTION="Quasi quoted domain specific languages and transformations"
HOMEPAGE="https://github.com/hu-dwim/hu.dwim.quasi-quote"
SRC_URI="https://github.com/hu-dwim/${MY_PN//.quote/-quote}/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${MY_PN//.quote/-quote}-${COMMIT}"

LICENSE="MIT-0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc test"
REQUIRED_USE="doc? ( test )"
RESTRICT="!test? ( test )"

PDEPEND="dev-lisp/hu-dwim-util"
RDEPEND="dev-lisp/babel
	dev-lisp/cffi
	dev-lisp/cl-ppcre
	dev-lisp/cxml
	dev-lisp/hu-dwim-asdf
	dev-lisp/hu-dwim-common
	dev-lisp/hu-dwim-defclass-star
	dev-lisp/hu-dwim-syntax-sugar
	dev-lisp/hu-dwim-walker
	doc? ( dev-lisp/hu-dwim-presentation )"
# dev-lang/spidermonkey:115
BDEPEND="test? ( dev-lisp/sbcl:*
		dev-lisp/hu-dwim-stefil
		dev-lisp/parse-number
		dev-lisp/uiop )"

PATCHES=( "${FILESDIR}/${PN}"-20220821-test-xml.patch )

src_prepare() {
	default

	sed -i '/js-executable-name/s|24|115|' test/js.lisp \
		|| die "sed failed for js.lisp"

	# remove js tests
	sed -i '/"js" :depends-on/d' hu.dwim.quasi-quote.test.asd \
		|| die "sed failed for js"
	rm test/js.lisp || die "rm failed"
}

src_test() {
	einfo "Running test suite:"
	sbcl --script "${FILESDIR}"/run-tests.lisp \
		|| die "test failed"
}
