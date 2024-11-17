# Copyright 1999-2024 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://github.com/sharplispers/${PN}.git"

inherit common-lisp-3 git-r3

DESCRIPTION="Number parsing library"
HOMEPAGE="https://github.com/sharplispers/parse-number"

LICENSE="BSD"
SLOT="0"

src_test() {
	local -x CL_SOURCE_REGISTRY="${S}:${CLSYSTEMROOT}"
	common-lisp-export-impl-args "$(common-lisp-find-lisp-impl)"

	${CL_BINARY} "${CL_EVAL}" "(asdf:test-system :parse-number)" \
		|| die "test failed"
}

src_install() {
	common-lisp-3_src_install
	insinto /usr/share/common-lisp/source/parse-number
	doins version.sexp
}
