# Copyright 1999-2024 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit common-lisp-3

COMMIT="4d1208c8718712f5c88c8397c41c06fc80b2e8e8"

DESCRIPTION="Common Lisp Mustache Template Renderer"
HOMEPAGE="https://github.com/kanru/cl-mustache"
SRC_URI="https://github.com/kanru/${PN}/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}-${COMMIT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"
RESTRICT="test" # 36 of 194 tests failed

RDEPEND="dev-lisp/uiop"
BDEPEND="test? ( dev-lisp/sbcl:*
		dev-lisp/prove )"

PATCHES=( "${FILESDIR}/${PN}"-20240926-test.patch )

src_test() {
	einfo "Running test suite:"
	sbcl --script t/ci.lisp || die "test failed"
}

src_install() {
	common-lisp-3_src_install
	insinto /usr/share/common-lisp/source/cl-mustache
	doins {spec-,}version.lisp-expr
}
