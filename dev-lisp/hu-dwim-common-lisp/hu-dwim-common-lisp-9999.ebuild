# Copyright 1999-2024 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://github.com/hu-dwim/hu.dwim.common-lisp.git"

inherit common-lisp-3 git-r3

DESCRIPTION="A redefinition of the standard Common Lisp package"
HOMEPAGE="https://github.com/hu-dwim/hu.dwim.common-lisp"

LICENSE="MIT-0"
SLOT="0"
IUSE="doc"

RDEPEND="dev-lisp/hu-dwim-asdf
	doc? ( dev-lisp/hu-dwim-presentation )"
