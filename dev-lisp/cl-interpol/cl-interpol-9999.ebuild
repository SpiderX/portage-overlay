# Copyright 1999-2024 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://github.com/edicl/${PN}.git"

inherit common-lisp-3 git-r3

DESCRIPTION="Common Lisp surface syntax niceties"
HOMEPAGE="https://github.com/edicl/cl-interpol"

LICENSE="BSD-2"
SLOT="0"
IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND="dev-lisp/cl-unicode
	dev-lisp/named-readtables"
BDEPEND="test? ( dev-lisp/flexi-streams )"

src_test() {
	local -x CL_SOURCE_REGISTRY="${S}:${CLSYSTEMROOT}"
	common-lisp-export-impl-args "$(common-lisp-find-lisp-impl)"

	${CL_BINARY} "${CL_EVAL}" "(asdf:test-system :cl-interpol)" \
		|| die "test failed"
}
