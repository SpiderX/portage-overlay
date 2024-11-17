# Copyright 1999-2024 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://github.com/nicklevine/${PN}.git"

inherit common-lisp-3 git-r3

DESCRIPTION="Common Lisp general purpose logging utility"
HOMEPAGE="https://www.cliki.net/cl-log"

LICENSE="public-domain"
SLOT="0"
IUSE="test"
RESTRICT="!test? ( test )" # tests not ready

BDEPEND="dev-lisp/asdf
	test? ( dev-lisp/eos )"

src_test() {
	local -x CL_SOURCE_REGISTRY="${S}:${CLSYSTEMROOT}"
	common-lisp-export-impl-args "$(common-lisp-find-lisp-impl)"

	${CL_BINARY} "${CL_EVAL}" "(asdf:test-system :cl-log-test)" \
		|| die "test failed"
}
