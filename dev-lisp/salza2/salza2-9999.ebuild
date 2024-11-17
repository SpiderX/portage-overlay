# Copyright 1999-2024 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://github.com/xach/${PN}.git"

inherit common-lisp-3 git-r3

DESCRIPTION="Compressed data in the ZLIB, DEFLATE, or GZIP data formats"
HOMEPAGE="https://github.com/xach/salza2"

LICENSE="BSD-2"
SLOT="0"
IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND="dev-lisp/trivial-gray-streams"
BDEPEND="dev-lisp/asdf
	test? ( dev-lisp/chipz
		dev-lisp/flexi-streams
		dev-lisp/parachute )"

src_test() {
	local -x CL_SOURCE_REGISTRY="${S}:${CLSYSTEMROOT}"
	common-lisp-export-impl-args "$(common-lisp-find-lisp-impl)"

	${CL_BINARY} "${CL_EVAL}" "(asdf:test-system :salza2)" \
		|| die "test failed"
}
