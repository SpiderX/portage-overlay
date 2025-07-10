# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit common-lisp-3 git-r3

DESCRIPTION="Time manipulation library for Common Lisp"
HOMEPAGE="https://github.com/dlowe-net/local-time"
EGIT_REPO_URI="https://github.com/dlowe-net/${PN}.git"

LICENSE="MIT"
SLOT="0"
IUSE="postgres test"
RESTRICT="!test? ( test )" # some tests failed

RDEPEND="dev-lisp/uiop
	postgres? ( dev-lisp/postmodern )"
BDEPEND="dev-lisp/asdf
	test? ( dev-lisp/fiasco )"

PATCHES=( "${FILESDIR}/${PN}"-20240817-system-zoneinfo.patch )

src_test() {
	local -x CL_SOURCE_REGISTRY="${S}:${CLSYSTEMROOT}"
	common-lisp-export-impl-args "$(common-lisp-find-lisp-impl)"

	${CL_BINARY} "${CL_EVAL}" "(asdf:test-system :local-time)" \
		|| die "test failed"
}
