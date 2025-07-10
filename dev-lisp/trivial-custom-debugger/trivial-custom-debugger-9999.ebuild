# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit common-lisp-3 git-r3

DESCRIPTION="Allows arbitrary functions to become the standard Lisp debugger"
HOMEPAGE="https://github.com/phoe/trivial-custom-debugger"
EGIT_REPO_URI="https://github.com/phoe/${PN}.git"

LICENSE="BSD-2"
SLOT="0"
IUSE="test"
RESTRICT="!test? ( test )"

BDEPEND="dev-lisp/asdf
	test? ( dev-lisp/parachute )"

src_test() {
	local -x CL_SOURCE_REGISTRY="${S}:${CLSYSTEMROOT}"
	common-lisp-export-impl-args "$(common-lisp-find-lisp-impl)"

	${CL_BINARY} "${CL_EVAL}" "(asdf:test-system :trivial-custom-debugger)" \
		|| die "test failed"
}
