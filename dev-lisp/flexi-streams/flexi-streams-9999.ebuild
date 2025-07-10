# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit common-lisp-3 git-r3

DESCRIPTION="Flexible bivalent streams for Common Lisp"
HOMEPAGE="https://github.com/edicl/flexi-streams"
EGIT_REPO_URI="https://github.com/edicl/${PN}.git"

LICENSE="BSD-2"
SLOT="0"

RDEPEND="dev-lisp/trivial-gray-streams"
BDEPEND="dev-lisp/asdf"

DOCS=( CHANGELOG README.md )

src_test() {
	local -x CL_SOURCE_REGISTRY="${S}:${CLSYSTEMROOT}"
	common-lisp-export-impl-args "$(common-lisp-find-lisp-impl)"

	${CL_BINARY} "${CL_EVAL}" "(asdf:test-system :flexi-streams)" \
		|| die "test failed"
}
