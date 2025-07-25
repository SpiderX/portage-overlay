# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit common-lisp-3 git-r3

DESCRIPTION="Portable GC-related APIs for Common Lisp"
HOMEPAGE="https://github.com/trivial-garbage/trivial-garbage"
EGIT_REPO_URI="https://github.com/trivial-garbage/${PN}.git"

LICENSE="public-domain"
SLOT="0"
IUSE="test"
RESTRICT="!test? ( test )"

BDEPEND="dev-lisp/asdf
	test? ( dev-lisp/rt )"

src_test() {
	local -x CL_SOURCE_REGISTRY="${S}:${CLSYSTEMROOT}"
	common-lisp-export-impl-args "$(common-lisp-find-lisp-impl)"

	${CL_BINARY} "${CL_EVAL}" "(asdf:test-system :trivial-garbage)" \
		|| die "test failed"
}
