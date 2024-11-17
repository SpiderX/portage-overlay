# Copyright 1999-2024 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://gitlab.common-lisp.net/cl-l10n/${PN}.git"

inherit common-lisp-3 git-r3

DESCRIPTION="Portable CL Locale Support"
HOMEPAGE="https://gitlab.common-lisp.net/cl-l10n/cl-l10n"

LICENSE="LGPL-2.1 MIT"
SLOT="0"
IUSE="test"
RESTRICT="!test? ( test )" # 2 failed assertions

RDEPEND="dev-lisp/alexandria
	dev-lisp/cl-fad
	dev-lisp/cl-l10n-cldr
	dev-lisp/closer-mop
	dev-lisp/cl-ppcre
	dev-lisp/cxml
	dev-lisp/flexi-streams
	dev-lisp/iterate
	dev-lisp/local-time
	dev-lisp/metabang-bind"
BDEPEND="dev-lisp/asdf
	test? ( dev-lisp/hu-dwim-stefil
		dev-lisp/parse-number )"

src_test() {
	local -x CL_SOURCE_REGISTRY="${S}:${CLSYSTEMROOT}"
	common-lisp-export-impl-args "$(common-lisp-find-lisp-impl)"

	${CL_BINARY} "${CL_EVAL}" "(asdf:test-system :cl-l10n)" \
		|| die "test failed"
}