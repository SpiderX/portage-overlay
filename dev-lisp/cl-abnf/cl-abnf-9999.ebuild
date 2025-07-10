# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit common-lisp-3 git-r3

DESCRIPTION="Common Lisp ABNF Parser Generator"
HOMEPAGE="https://github.com/dimitri/cl-abnf"
EGIT_REPO_URI="https://github.com/dimitri/${PN}.git"

LICENSE="ISC"
SLOT="0"

RDEPEND="dev-lisp/cl-ppcre
	dev-lisp/esrap"
BDEPEND="dev-lisp/asdf"
