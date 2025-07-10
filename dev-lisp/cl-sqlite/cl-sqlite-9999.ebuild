# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit common-lisp-3 git-r3

DESCRIPTION="Common Lisp binding for SQLite"
HOMEPAGE="https://github.com/TeMPOraL/cl-sqlite"
EGIT_REPO_URI="https://github.com/TeMPOraL/${PN}.git"

LICENSE="public-domain"
SLOT="0"
IUSE="test"
RESTRICT="!test? ( test )" #https://github.com/TeMPOraL/cl-sqlite/issues/2

RDEPEND="dev-db/sqlite:3
	dev-lisp/cffi
	dev-lisp/iterate"
BDEPEND="dev-lisp/asdf
	test? ( dev-lisp/fiveam
		dev-lisp/bordeaux-threads )"

src_test() {
	local -x CL_SOURCE_REGISTRY="${S}:${CLSYSTEMROOT}"
	common-lisp-export-impl-args "$(common-lisp-find-lisp-impl)"

	${CL_BINARY} "${CL_EVAL}" "(asdf:test-system :sqlite)" \
		|| die "test failed"
}
