# Copyright 1999-2024 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://github.com/jdz/${PN}.git"

inherit common-lisp-3 git-r3

DESCRIPTION="An implementation of RFC 2388 in Common Lisp"
HOMEPAGE="https://github.com/jdz/rfc2388"

LICENSE="BSD-2"
SLOT="0"

BDEPEND="dev-lisp/asdf"

src_test() {
	local -x CL_SOURCE_REGISTRY="${S}:${CLSYSTEMROOT}"
	common-lisp-export-impl-args "$(common-lisp-find-lisp-impl)"

	${CL_BINARY} "${CL_EVAL}" "(asdf:test-system :rfc2388)" \
		|| die "test failed"
}
