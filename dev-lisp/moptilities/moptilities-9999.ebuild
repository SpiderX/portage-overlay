# Copyright 1999-2024 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://github.com/hraban/${PN}.git"

inherit common-lisp-3 git-r3

DESCRIPTION="Compatibility layer for minor MOP implementation differences"
HOMEPAGE="https://github.com/hraban/moptilities"

LICENSE="MIT"
SLOT="0"
IUSE="test"
RESTRICT="!test? ( test )" # 37 tests run, 7 Failures

RDEPEND="dev-lisp/closer-mop"
BDEPEND="test? ( dev-lisp/lift )"

src_prepare() {
	default

	# fix default report
	sed -i '/test-results/s|name|full-pathname|' lift-standard.config \
		|| die "sed failed for lift-standard.config"
}

src_test() {
	local -x CL_SOURCE_REGISTRY="${S}:${CLSYSTEMROOT}"
	common-lisp-export-impl-args "$(common-lisp-find-lisp-impl)"

	${CL_BINARY} "${CL_EVAL}" "(asdf:test-system :moptilities)" \
		|| die "test failed"
}
