# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit common-lisp-3 git-r3

DESCRIPTION="A Common Lisp library for computing differences between sequences"
HOMEPAGE="https://github.com/wiseman/cl-difflib"
EGIT_REPO_URI="https://github.com/wiseman/${PN}.git"

LICENSE="MIT"
SLOT="0"

BDEPEND="dev-lisp/asdf"

PATCHES=( "${FILESDIR}/${PN}"-20090602-tests.patch )

src_test() {
	local -x CL_SOURCE_REGISTRY="${S}:${CLSYSTEMROOT}"
	common-lisp-export-impl-args "$(common-lisp-find-lisp-impl)"

	${CL_BINARY} "${CL_EVAL}" "(asdf:test-system :cl-difflib)" \
		|| die "test failed"
}
