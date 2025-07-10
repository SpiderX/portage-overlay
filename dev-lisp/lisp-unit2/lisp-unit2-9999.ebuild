# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit common-lisp-3 git-r3

DESCRIPTION="A Test Framework for Common Lisp in the style of JUnit"
HOMEPAGE="https://github.com/AccelerationNet/lisp-unit2"
EGIT_REPO_URI="https://github.com/AccelerationNet/${PN}.git"

LICENSE="MIT"
SLOT="0"

RDEPEND="dev-lisp/alexandria
	dev-lisp/cl-interpol
	dev-lisp/iterate
	dev-lisp/symbol-munger"
BDEPEND="dev-lisp/asdf"

src_test() {
	local -x CL_SOURCE_REGISTRY="${S}:${CLSYSTEMROOT}"
	common-lisp-export-impl-args "$(common-lisp-find-lisp-impl)"

	${CL_BINARY} "${CL_EVAL}" "(asdf:test-system :lisp-unit2)" \
		|| die "test failed"
}
