# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit common-lisp-3 git-r3

DESCRIPTION="An XML parser written in Common Lisp"
HOMEPAGE="https://github.com/sharplispers/cxml"
EGIT_REPO_URI="https://github.com/sharplispers/${PN}.git"

LICENSE="LLGPL-2.1"
SLOT="0"

RDEPEND="dev-lisp/closure-common
	dev-lisp/puri
	dev-lisp/trivial-gray-streams"

src_test() {
	local -x CL_SOURCE_REGISTRY="${S}:${CLSYSTEMROOT}"
	common-lisp-export-impl-args "$(common-lisp-find-lisp-impl)"

	${CL_BINARY} "${CL_EVAL}" "(asdf:test-system :cxml)" \
		|| die "test failed"
}

src_install() {
	common-lisp-3_src_install
	insinto /usr/share/common-lisp/source/cxml
	doins catalog.dtd
}
