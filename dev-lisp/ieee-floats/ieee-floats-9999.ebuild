# Copyright 1999-2024 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://github.com/marijnh/${PN}.git"

inherit common-lisp-3 git-r3

DESCRIPTION="Flexible bivalent streams for Common Lisp"
HOMEPAGE="https://github.com/marijnh/ieee-floats"

LICENSE="BSD"
SLOT="0"
IUSE="test"
RESTRICT="!test? ( test )"

BDEPEND="test? ( dev-lisp/asdf
		dev-lisp/fiveam )"

src_test() {
	local -x CL_SOURCE_REGISTRY="${S}:${CLSYSTEMROOT}"
	common-lisp-export-impl-args "$(common-lisp-find-lisp-impl)"

	${CL_BINARY} "${CL_EVAL}" "(asdf:test-system :ieee-floats)" \
		|| die "test failed"
}
