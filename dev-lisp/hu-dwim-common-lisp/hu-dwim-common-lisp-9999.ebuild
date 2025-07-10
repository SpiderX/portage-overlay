# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit common-lisp-3 git-r3

DESCRIPTION="A redefinition of the standard Common Lisp package"
HOMEPAGE="https://github.com/hu-dwim/hu.dwim.common-lisp"
EGIT_REPO_URI="https://github.com/hu-dwim/hu.dwim.common-lisp.git"

LICENSE="MIT-0"
SLOT="0"
IUSE="doc"

RDEPEND="dev-lisp/hu-dwim-asdf
	doc? ( dev-lisp/hu-dwim-presentation )"
