# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit common-lisp-3 subversion

DESCRIPTION="ConfigParser Python module functionality in Common Lisp"
HOMEPAGE="https://tracker.debian.org/pkg/cl-py-configparser"
ESVN_REPO_URI="https://svn.common-lisp.net/py-configparser/trunk"

LICENSE="MIT"
SLOT="0"
IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND="dev-lisp/parse-number"
BDEPEND="dev-lisp/asdf
	test? ( dev-lisp/rt )"

src_test() {
	local -x CL_SOURCE_REGISTRY="${S}:${CLSYSTEMROOT}"
	common-lisp-export-impl-args "$(common-lisp-find-lisp-impl)"

	${CL_BINARY} "${CL_EVAL}" "(asdf:test-system :py-configparser)" \
		|| die "test failed"
}
