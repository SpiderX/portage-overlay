# Copyright 1999-2024 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://github.com/melisgl/${PN}.git"

inherit common-lisp-3 git-r3

DESCRIPTION="Common Lisp documentation system"
HOMEPAGE="https://github.com/melisgl/mgl-pax"

LICENSE="MIT"
SLOT="0"
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
	insinto /usr/share/common-lisp/source/mgl-pax/test
	doins test/mgl-pax-tests.el
	insinto /usr/share/common-lisp/source/mgl-pax/src
	doins src/mgl-pax.el
}
