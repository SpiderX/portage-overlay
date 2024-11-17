# Copyright 1999-2024 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://github.com/dimitri/${PN}.git"

inherit common-lisp-3 git-r3

DESCRIPTION="Common Lisp ABNF Parser Generator"
HOMEPAGE="https://github.com/dimitri/cl-abnf"

LICENSE="ISC"
SLOT="0"

RDEPEND="dev-lisp/cl-ppcre
	dev-lisp/esrap"
BDEPEND="dev-lisp/asdf"
