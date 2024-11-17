# Copyright 1999-2024 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://gitlab.common-lisp.net/iterate/${PN}.git"
EGIT_SUBMODULES=()

inherit common-lisp-3 git-r3

DESCRIPTION="A common lisp ITERATE macro library"
HOMEPAGE="https://gitlab.common-lisp.net/iterate/iterate"

LICENSE="MIT"
SLOT="0"

BDEPEND="dev-lisp/asdf"

src_test() {
	local -x CL_SOURCE_REGISTRY="${S}:${CLSYSTEMROOT}"
	common-lisp-export-impl-args "$(common-lisp-find-lisp-impl)"

	${CL_BINARY} "${CL_EVAL}" "(asdf:test-system :iterate)" \
		|| die "test failed"
}
