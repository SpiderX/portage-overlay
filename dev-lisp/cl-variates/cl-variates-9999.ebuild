# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit common-lisp-3 git-r3

DESCRIPTION="Portable Common Lisp Random Number Generation"
HOMEPAGE="https://gitlab.common-lisp.net/cl-variates/cl-variates"
EGIT_REPO_URI="https://gitlab.common-lisp.net/cl-variates/${PN}.git"

LICENSE="MIT"
SLOT="0"
IUSE="test"
RESTRICT="test" #Unhandled LOAD-SYSTEM-DEFINITION-ERROR

RDEPEND="dev-lisp/metacopy"
BDEPEND="test? ( dev-lisp/lift )"

src_test() {
	local -x CL_SOURCE_REGISTRY="${S}:${CLSYSTEMROOT}"
	common-lisp-export-impl-args "$(common-lisp-find-lisp-impl)"

	${CL_BINARY} "${CL_EVAL}" "(asdf:test-system :cl-variates)" \
		|| die "test failed"
}
