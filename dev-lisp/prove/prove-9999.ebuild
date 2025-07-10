# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit common-lisp-3 git-r3

DESCRIPTION="Yet another unit testing framework for Common Lisp"
HOMEPAGE="https://github.com/fukamachi/prove"
EGIT_REPO_URI="https://github.com/fukamachi/${PN}.git"

LICENSE="MIT"
SLOT="0"

RDEPEND="dev-lisp/alexandria
	dev-lisp/cl-ansi-text
	dev-lisp/cl-colors
	dev-lisp/cl-ppcre
	dev-lisp/split-sequence
	dev-lisp/uiop"
BDEPEND="dev-lisp/asdf"

src_test() {
	local -x CL_SOURCE_REGISTRY="${S}:${CLSYSTEMROOT}"
	common-lisp-export-impl-args "$(common-lisp-find-lisp-impl)"

	${CL_BINARY} "${CL_EVAL}" "(asdf:test-system :prove)" \
		|| die "test failed"
}
