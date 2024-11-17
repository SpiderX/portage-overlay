# Copyright 1999-2024 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://github.com/sionescu/${PN}.git"

inherit common-lisp-3 git-r3

DESCRIPTION="Portable shared-state concurrency for Common Lisp"
HOMEPAGE="https://github.com/sionescu/bordeaux-threads"

LICENSE="MIT"
SLOT="0"
IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND="dev-lisp/alexandria
	dev-lisp/global-vars
	dev-lisp/trivial-features
	dev-lisp/trivial-garbage"
BDEPEND="dev-lisp/asdf
	test? ( dev-lisp/fiveam )"

src_test() {
	local -x CL_SOURCE_REGISTRY="${S}:${CLSYSTEMROOT}"
	common-lisp-export-impl-args "$(common-lisp-find-lisp-impl)"

	${CL_BINARY} "${CL_EVAL}" "(asdf:test-system ::bordeaux-threads)" \
		|| die "test failed"
}

src_install() {
	common-lisp-3_src_install
	insinto /usr/share/common-lisp/source/bordeaux-threads
	doins version.sexp
}
