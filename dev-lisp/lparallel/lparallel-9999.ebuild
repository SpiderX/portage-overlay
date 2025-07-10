# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit common-lisp-3 git-r3

DESCRIPTION="Parallelism for Common Lisp"
HOMEPAGE="https://github.com/lmj/lparallel"
EGIT_REPO_URI="https://github.com/lmj/${PN}.git"

LICENSE="BSD"
SLOT="0"

RDEPEND="dev-lisp/alexandria
	dev-lisp/bordeaux-threads
	dev-lisp/trivial-garbage"

src_test() {
	local -x CL_SOURCE_REGISTRY="${S}:${CLSYSTEMROOT}"
	common-lisp-export-impl-args "$(common-lisp-find-lisp-impl)"

	${CL_BINARY} "${CL_EVAL}" "(asdf:test-system :lparallel)" \
		|| die "test failed"
}
