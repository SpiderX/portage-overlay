# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit common-lisp-3 git-r3

DESCRIPTION="The anaphoric macro collection from Hell"
HOMEPAGE="https://github.com/spwhitton/anaphora"
EGIT_REPO_URI="https://github.com/spwhitton/${PN}.git"

LICENSE="public-domain"
SLOT="0"
IUSE="test"
RESTRICT="!test? ( test )"

BDEPEND="test? ( dev-lisp/rt )"

src_test() {
	local -x CL_SOURCE_REGISTRY="${S}:${CLSYSTEMROOT}"
	common-lisp-export-impl-args "$(common-lisp-find-lisp-impl)"

	${CL_BINARY} "${CL_EVAL}" "(asdf:test-system :anaphora)" \
		|| die "test failed"
}
