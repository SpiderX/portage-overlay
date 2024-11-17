# Copyright 1999-2024 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://github.com/tpapp/${PN}.git"

inherit common-lisp-3 git-r3

DESCRIPTION="Simple color library for Common Lisp"
HOMEPAGE="https://github.com/tpapp/cl-colors"

LICENSE="Boost-1.0"
SLOT="0"
IUSE="test"
RESTRICT="!test? ( test )" # tests not ready

RDEPEND="dev-lisp/alexandria
	dev-lisp/let-plus"
BDEPEND="test? ( dev-lisp/lift )"

src_test() {
	local -x CL_SOURCE_REGISTRY="${S}:${CLSYSTEMROOT}"
	common-lisp-export-impl-args "$(common-lisp-find-lisp-impl)"

	${CL_BINARY} "${CL_EVAL}" "(asdf:test-system :cl-colors)" \
		|| die "test failed"
}
