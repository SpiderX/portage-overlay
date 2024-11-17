# Copyright 1999-2024 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://github.com/hu-dwim/hu.dwim.zlib.git"

inherit common-lisp-3 git-r3

DESCRIPTION="Common Lisp FFI wrapper for zlib"
HOMEPAGE="https://github.com/hu-dwim/hu.dwim.zlib"

LICENSE="BSD"
SLOT="0"
IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND="dev-lisp/alexandria
	dev-lisp/cffi
	dev-lisp/hu-dwim-asdf
	dev-lisp/hu-dwim-def
	dev-lisp/hu-dwim-syntax-sugar"
DEPEND="${RDEPEND}
	sys-libs/zlib:="
BDEPEND="test? ( dev-lisp/asdf
		dev-lisp/hu-dwim-stefil )"

src_test() {
	local -x CL_SOURCE_REGISTRY="${S}:${CLSYSTEMROOT}"
	common-lisp-export-impl-args "$(common-lisp-find-lisp-impl)"

	${CL_BINARY} "${CL_EVAL}" "(asdf:test-system :hu.dwim.zlib/test)" \
		|| die "test failed"
}
