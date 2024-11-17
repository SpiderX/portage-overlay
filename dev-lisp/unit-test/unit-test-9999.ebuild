# Copyright 1999-2024 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://github.com/hanshuebner/${PN}.git"

inherit common-lisp-3 git-r3

DESCRIPTION="Common Lisp unit-testing framework"
HOMEPAGE="https://github.com/hanshuebner/unit-test"

LICENSE="BSD"
SLOT="0"

BDEPEND="dev-lisp/asdf" # tests not ready

src_test() {
	local -x CL_SOURCE_REGISTRY="${S}:${CLSYSTEMROOT}"
	common-lisp-export-impl-args "$(common-lisp-find-lisp-impl)"

	${CL_BINARY} "${CL_EVAL}" "(asdf:test-system :unit-test)" \
		|| die "test failed"
}
