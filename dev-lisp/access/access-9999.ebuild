# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit common-lisp-3 git-r3

DESCRIPTION="A common lisp library to unify access to common data-structures"
HOMEPAGE="https://github.com/AccelerationNet/access"
EGIT_REPO_URI="https://github.com/AccelerationNet/${PN}.git"

LICENSE="BSD"
SLOT="0"
IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND="dev-lisp/alexandria
	dev-lisp/closer-mop
	dev-lisp/cl-ppcre
	dev-lisp/iterate"
BDEPEND="test? ( dev-lisp/lisp-unit2 )"

src_test() {
	local -x CL_SOURCE_REGISTRY="${S}:${CLSYSTEMROOT}"
	common-lisp-export-impl-args "$(common-lisp-find-lisp-impl)"

	${CL_BINARY} "${CL_EVAL}" "(asdf:test-system :access)" \
		|| die "test failed"
}
