# Copyright 1999-2024 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://github.com/xach/${PN}.git"

inherit common-lisp-3 git-r3

DESCRIPTION="Access TrueType fonts with Common Lisp"
HOMEPAGE="https://github.com/xach/zpb-ttf"

LICENSE="BSD-2"
SLOT="0"

BDEPEND="dev-lisp/asdf" # tests not ready

src_test() {
	local -x CL_SOURCE_REGISTRY="${S}:${CLSYSTEMROOT}"
	common-lisp-export-impl-args "$(common-lisp-find-lisp-impl)"

	${CL_BINARY} "${CL_EVAL}" "(asdf:test-system :zpb-ttf)" \
		|| die "test failed"
}
