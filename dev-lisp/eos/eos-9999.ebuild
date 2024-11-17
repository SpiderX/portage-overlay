# Copyright 1999-2024 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://github.com/adlai/${PN^}.git"

inherit common-lisp-3 git-r3

CLPACKAGE="${PN^}"

DESCRIPTION="A unit test library for Common Lisp"
HOMEPAGE="https://github.com/adlai/Eos"

LICENSE="MIT"
SLOT="0"
IUSE="test"
RESTRICT="!test? ( test )"

BDEPEND="dev-lisp/asdf"

src_test() {
	local -x CL_SOURCE_REGISTRY="${S}:${CLSYSTEMROOT}"
	common-lisp-export-impl-args "$(common-lisp-find-lisp-impl)"

	${CL_BINARY} "${CL_EVAL}" "(asdf:test-system :Eos)" \
		|| die "test failed"
}
