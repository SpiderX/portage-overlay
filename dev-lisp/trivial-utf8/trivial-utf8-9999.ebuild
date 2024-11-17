# Copyright 1999-2024 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://gitlab.common-lisp.net/trivial-utf-8/trivial-utf-8.git"

inherit common-lisp-3 git-r3

DESCRIPTION="Portable simple API to work with backtraces in Common Lisp"
HOMEPAGE="https://gitlab.common-lisp.net/trivial-utf-8/trivial-utf-8"

LICENSE="ZLIB"
SLOT="0"
RESTRICT="test" # WRITE-UTF-8-BYTES is undefined

RDEPEND="dev-lisp/mgl-pax"
BDEPEND="dev-lisp/asdf"

src_test() {
	local -x CL_SOURCE_REGISTRY="${S}:${CLSYSTEMROOT}"
	common-lisp-export-impl-args "$(common-lisp-find-lisp-impl)"

	${CL_BINARY} "${CL_EVAL}" "(asdf:test-system :trivial-utf-8/tests)" \
		|| die "test failed"
}
