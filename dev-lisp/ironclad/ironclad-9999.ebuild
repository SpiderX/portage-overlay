# Copyright 1999-2024 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://github.com/sharplispers/${PN}.git"

inherit common-lisp-3 git-r3

DESCRIPTION="A cryptographic toolkit written in Common Lisp"
HOMEPAGE="http://www.cliki.net/ironclad"

LICENSE="BSD"
SLOT="0"
IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND="dev-lisp/bordeaux-threads"
BDEPEND="dev-lisp/asdf
	test? ( dev-lisp/flexi-streams
		dev-lisp/rt )"

src_test() {
	local -x CL_SOURCE_REGISTRY="${S}:${CLSYSTEMROOT}"
	common-lisp-export-impl-args "$(common-lisp-find-lisp-impl)"

	${CL_BINARY} "${CL_EVAL}" "(asdf:test-system :ironclad)" \
		|| die "test failed"
}
