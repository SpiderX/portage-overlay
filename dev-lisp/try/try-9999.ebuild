# Copyright 1999-2024 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://github.com/melisgl/${PN}.git"

inherit common-lisp-3 git-r3

DESCRIPTION="Flexible bivalent streams for Common Lisp"
HOMEPAGE="https://github.com/melisgl/try"

LICENSE="MIT"
SLOT="0"
RESTRICT="test" # fails

RDEPEND="dev-lisp/alexandria
	dev-lisp/cl-ppcre
	dev-lisp/closer-mop
	dev-lisp/ieee-floats
	dev-lisp/mgl-pax
	dev-lisp/named-readtables
	dev-lisp/pythonic-string-reader
	dev-lisp/trivial-gray-streams
	dev-lisp/uiop"
BDEPEND="dev-lisp/asdf"

src_test() {
	local -x CL_SOURCE_REGISTRY="${S}:${CLSYSTEMROOT}"
	common-lisp-export-impl-args "$(common-lisp-find-lisp-impl)"

	${CL_BINARY} "${CL_EVAL}" "(asdf:test-system :try)" \
		|| die "test failed"
}

src_install() {
	einstalldocs
	common-lisp-install-sources -t all src test
	common-lisp-install-asdf
}
