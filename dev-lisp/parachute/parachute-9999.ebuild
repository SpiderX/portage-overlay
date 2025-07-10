# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit common-lisp-3 git-r3

DESCRIPTION="An extensible and cross-compatible testing framework"
HOMEPAGE="https://github.com/Shinmera/parachute"
EGIT_REPO_URI="https://github.com/Shinmera/${PN}.git"

LICENSE="ZLIB"
SLOT="0"

RDEPEND="dev-lisp/cl-ppcre
	dev-lisp/documentation-utils
	dev-lisp/form-fiddle
	dev-lisp/trivial-custom-debugger"

src_test() {
	local -x CL_SOURCE_REGISTRY="${S}:${CLSYSTEMROOT}"
	common-lisp-export-impl-args "$(common-lisp-find-lisp-impl)"

	${CL_BINARY} "${CL_EVAL}" "(asdf:test-system :parachute)" \
		|| die "test failed"
}
