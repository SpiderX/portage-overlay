# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit common-lisp-3

COMMIT="18f1d93b962781f273d2362bd190ce1744c120c4"

DESCRIPTION="Common Lisp documentation system"
HOMEPAGE="https://github.com/melisgl/mgl-pax"
SRC_URI="https://github.com/melisgl/${PN}/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}-${COMMIT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"
RESTRICT="!test? ( test )" # run test without quickload

PDEPEND="dev-lisp/named-readtables"
RDEPEND="dev-lisp/3bmd
	dev-lisp/alexandria
	dev-lisp/hunchentoot
	dev-lisp/md5
	dev-lisp/pythonic-string-reader
	dev-lisp/slime
	dev-lisp/trivial-utf8"
BDEPEND="dev-lisp/asdf
	test? ( dev-lisp/try )"

src_test() {
	local -x CL_SOURCE_REGISTRY="${S}:${CLSYSTEMROOT}"
	common-lisp-export-impl-args "$(common-lisp-find-lisp-impl)"

	${CL_BINARY} "${CL_EVAL}" "(asdf:test-system :mgl-pax-test)" \
		|| die "test failed"
}

src_install() {
	common-lisp-3_src_install
	common-lisp-install-sources -t all version.lisp-expr
	insinto /usr/share/common-lisp/source/mgl-pax/test
	doins test/mgl-pax-tests.el
	insinto /usr/share/common-lisp/source/mgl-pax/src
	doins src/mgl-pax.el
}
