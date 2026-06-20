# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit common-lisp-3 edo git-r3

DESCRIPTION="CLOS extension for Context-oriented Programming"
HOMEPAGE="https://codeberg.org/pcostanza/contextl"
EGIT_REPO_URI="https://codeberg.org/pcostanza/${PN}.git"

LICENSE="MIT"
SLOT="0"
IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND="dev-lisp/closer-mop
	dev-lisp/lw-compat"
BDEPEND="dev-lisp/asdf
	test? ( dev-lisp/sbcl:* )"

src_test() {
	edo pushd test
	edo ./sbcl-runall
	edo popd
}
