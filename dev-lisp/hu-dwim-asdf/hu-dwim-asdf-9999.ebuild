# Copyright 1999-2024 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://github.com/hu-dwim/hu.dwim.asdf.git"

inherit common-lisp-3 git-r3

DESCRIPTION="Common Lisp extensions to ASDF"
HOMEPAGE="https://github.com/hu-dwim/hu.dwim.asdf"

LICENSE="MIT-0"
SLOT="0"
IUSE="doc"

RDEPEND="dev-lisp/uiop
	doc? ( dev-lisp/hu-dwim-presentation )"
BDEPEND="dev-lisp/asdf"
