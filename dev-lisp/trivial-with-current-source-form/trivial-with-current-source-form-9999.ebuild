# Copyright 1999-2024 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://github.com/scymtym/${PN}.git"

inherit common-lisp-3 git-r3

DESCRIPTION="Helps macro writers produce better errors for macro users"
HOMEPAGE="https://github.com/scymtym/trivial-with-current-source-form"

LICENSE="MIT"
SLOT="0"

RDEPEND="dev-lisp/alexandria"

src_install() {
	common-lisp-3_src_install
	insinto /usr/share/common-lisp/source/trivial-with-current-source-form
	doins version-string.sexp
}