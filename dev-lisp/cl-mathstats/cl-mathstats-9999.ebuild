# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit common-lisp-3 git-r3

DESCRIPTION="An unordered collection of mathematical routines"
HOMEPAGE="https://github.com/hraban/cl-mathstats"
EGIT_REPO_URI="https://github.com/hraban/${PN}.git"

LICENSE="MIT"
SLOT="0"
IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND="dev-lisp/cl-containers
	dev-lisp/metatilities-base"
BDEPEND="dev-lisp/asdf
	test? ( dev-lisp/lift )"

src_test() {
	local -x CL_SOURCE_REGISTRY="${S}:${CLSYSTEMROOT}"
	common-lisp-export-impl-args "$(common-lisp-find-lisp-impl)"

	${CL_BINARY} "${CL_EVAL}" "(asdf:test-system :cl-mathstats)" \
		|| die "test failed"
}
